import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import {Typeahead} from 'react-bootstrap-typeahead'

const LEVEL_DESCRIPTIONS = {
  "1": {title: "Familiarity", subtitle: "Needs mentorship", description: "Generally 0-1 years of professional experience"},
  "2": {title: "Gaining Competency", subtitle: "Occasionally needs mentorship", description: "Generally 1-3 years of professional experience"},
  "3": {title: "Individual Competency", subtitle: "No longer needs daily mentorship", description: "Generally 3-5 years of professional experience"},
  "4": {title: "Strong Competency", subtitle: "Could mentor others", description: "5+ years of professional experience"},
  "5": {title: "Leadership", subtitle: "Has lead or managed a team in this subject", description: "Expert competency"},
}

const RangeLevel = ({level}) => {
  const {title, subtitle, description} = LEVEL_DESCRIPTIONS[`${level}`] || {};
  if (!title) return null;
  return <div><h5>{title}</h5><p>{subtitle}</p><p>{description}</p></div>;
}

class FormSkill extends Component {

  constructor(props) {
    super(props);
    this.state = {
      competences: props.competences,
      skills: props.devskills,
      impliedSkills: {},
      suggestedSkills: {},
      skillLevel: 1,
      selectedValue: [],
      valuesLevels: ["1", "2", "3", "4", "5"],
      error: "",
    }
  }

  addImplicationsOrSuggestions = (prop, skill, currentIorS) => {
    const newSkills = currentIorS;
    const newIorS = skill[prop];

    newIorS.forEach(i => {
      if (!this.state.skills.find(s => s.competence_id === i.id) ||
          Object.keys(currentIorS).includes(i.id.toString())) {
        if (typeof newSkills[i.id] === 'undefined') {
          newSkills[i.id] = {};
        }
        newSkills[i.id][skill.skill.competence_id] = skill.skill;
      }
    });

    return newSkills;
  }

  addImplications = (skill, currentImplications) =>
    this.addImplicationsOrSuggestions("implications", skill, currentImplications);

  addSuggestions = (skill, currentSuggestions) =>
    this.addImplicationsOrSuggestions("suggestions", skill, currentSuggestions);

  upsertSkillInState = (skill) => {
    const newImpliedSkills =
      this.addImplications(skill, this.state.impliedSkills);
    const newSuggestedSkills =
      this.addSuggestions(skill, this.state.suggestedSkills);
    const newSkills = this.state.skills.find(s =>
      s.competence_id === skill.skill.competence_id) ?
      this.state.skills : [ ...this.state.skills, skill.skill ];
    this.setState({
      skills: newSkills,
      impliedSkills: newImpliedSkills,
      suggestedSkills: newSuggestedSkills,
      skillLevel: 1,
      selectedValue: [],
      error: ""
    });
  }

  add() {
    const competenceId = this.state.selectedValue[0].id;
    const skillName = this.state.selectedValue[0].value;
    const skillValue = this.state.skillLevel;
    const skillObj = { skill: {
                         competence_id: competenceId, name: skillName,
                         level: skillValue
                       },
                       implications: [],
                       suggestions: [] };

    if (this.props.resource === "developers" && this.state.skills.length >= 30) {
      this.setState({ error: "Max 10 skills allowed!"})
      return;
    }

    if (this.props.resource === "jobs" && this.state.skills.length >= 2) {
      this.setState({ error: "Max 2 skills allowed!"})
      return;
    }

    if (this.state.skills.filter(e => e.name === skillName).length > 0) {
      this.setState({ error: "You already have this skill, please remove it before adding it to the list."})
      return;
    }

    this.upsertSkillInState(skillObj);

    this.postSkill(skillObj)
        .then(updatedSkills => {
           const skill = { skill: skillObj.skill,
                           implications: updatedSkills.implications,
                           suggestions: updatedSkills.suggestions };
           this.upsertSkillInState(skill);
           updatedSkills.implications.forEach(i =>
             this.upsertSkillInState({
               skill: {
                 name: i.value, competence_id: i.id, level: skill.skill.level
               },
               implications: [],
               suggestions: []
             })
           );
        });
  }

  postSkill = (skill) =>
    fetch(`/api/${this.props.resource}/${this.props.id}/skills`,{
      method: 'POST',
      body: JSON.stringify(skill),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    })
    .then(this.handleErrors)
    .then(res => res.json())
    .catch(error => console.log(error));

  newListCompetences = (value) => {
    return this.state.competences.filter(function( obj ) {
        return obj.value !== value;
    })
  }

  onSelectSkill = (val) => {
    if(!val.length) return;
    this.setState({ selectedValue: val  });
  }

  removeImplicationsOrSuggestions = (toRemove, iors) => {
    var newSkills = iors;

    for (const id in iors) {
      const k = toRemove.competence_id.toString();
      if (Object.keys(newSkills[id]).includes(k)) {
        delete newSkills[id][k];
        if (Object.keys(newSkills[id]).length === 0) {
          delete newSkills[id];
        }
      }
    }

    return newSkills;
  }

  remove(i) {
    const toRemove = this.state.skills[i];
    const newSkills = [...this.state.skills.slice(0,i), ...this.state.skills.slice(i+1)];
    const newImpliedSkills =
      this.removeImplicationsOrSuggestions(toRemove, this.state.impliedSkills);
    const newSuggestedSkills =
      this.removeImplicationsOrSuggestions(toRemove, this.state.suggestedSkills);

    this.setState({
      skills: newSkills,
      impliedSkills: newImpliedSkills,
      suggestedSkills: newSuggestedSkills,
      error: ""
    });
    this.deleteSkill(toRemove.name);
  }

  deleteSkill = (skill) => {
    let skillName = encodeURIComponent(skill);
    fetch(`/api/${this.props.resource}/${this.props.id}/skills/${skillName}`, {
      method: 'DELETE',
      headers: new Headers({ 'Content-Type': 'application/json' })
    })
    .catch(error => console.error('Error:', error))
  }

  onChangeLevel = (e) => {
    this.setState({skillLevel: e.target.value});
  }

  render() {
    const { error, skills, impliedSkills, suggestedSkills, competences,
            skillLevel, selectedSkill, selectedValue, valuesLevels }
          = this.state;

    const listOfSkills = skills.map((el, i) => {
      const implied = impliedSkills[el.competence_id];
      const impliedList = implied ?
        Object.values(implied)
              .map((s, i) =>
                <span key={s.competence_id} className="skill-form-name">
                  {s.name}
                </span>)
              .reduce((list, el) => {
                return list === null ? [el] : [...list, ', ', el];
              }, null) : [];
      return(
        <div className="skill-form-list d-flex justify-content-between" key={i}>
          <div className="skill-form-icon">
            <i className={`devicon-${el.name}-plain colored`}></i>
            <span className="skill-form-name">{el.name}</span> - {el.level}
            {implied &&
              <span className="skill-form-implied-list">
                &nbsp;(implied by {impliedList})
              </span>
            }
          </div>
          <button className="btn btn-sm btn-outline-warning" onClick={(e) => this.remove(i)}>remove</button>
        </div>
    )});

    const rangeValues = valuesLevels.map((el, i) => (
      <div key={i}>
        {el}
      </div>
    ));

    return(
      <div>
        <div className="mt-3 form-group">
          {error.length > 0 &&
            <div className="alert alert-danger" role="alert">
              {error}
            </div>
          }
          <Typeahead
            labelKey="value"
            options={competences}
            placeholder="Select a skill..."
            paginate={false}
            onChange={this.onSelectSkill}
            selected={selectedValue}
            className="skills-select"
            renderMenuItemChildren={(option, props, index) => {
               return (<p><i className={`devicon-${option.value}-plain colored`}></i> {option.value}</p>)
             }}
          />
        </div>
        {selectedValue.length > 0 &&
        <div>
          <div className="form-group p-3 my-2 bg-white rounded text-center">
            <p className="mb-2">Please select your {selectedValue[0].value} level:</p>
            <input id="skill-level" className="form-control-range" type="range" min="1" max="5" value={skillLevel} onInput={this.onChangeLevel} onChange={this.onChangeLevel} />
            <div className="d-flex justify-content-between">
              {rangeValues}
            </div>
            <div className="my-2"><RangeLevel level={skillLevel}/></div>
            <button className="btn btn btn-outline-primary" onClick={(e) => this.add(e)}>Add to your skills</button>
          </div>
        </div>
        }
        {listOfSkills}
      </div>
    )
  }

}

const initFormSkill = document.addEventListener('DOMContentLoaded', () => {
  const el = document.getElementById('form-skills');
  if (!el) return;

  const competences =  JSON.parse(el.dataset.competences);
  const devSkills =  JSON.parse(el.dataset.devskills);
  const resource =  el.dataset.resource;
  const id = el.dataset.id;

  ReactDOM.render(
    <FormSkill competences={competences} devskills={devSkills} id={id}
      resource={resource} />, document.getElementById('form-skills')
  )
})

export {initFormSkill};
