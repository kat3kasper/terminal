const listParams = () => {
  document.addEventListener("DOMContentLoaded", function() {
    if (document.querySelector("#dashboard-container") != null) {
      let checkboxes = document.querySelectorAll("input[type=checkbox]");
      for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener('change', function() {
          let container = document.getElementById('params-container');
          let params = document.querySelectorAll(".params");
          if (checkboxes[i].checked) {
            container.insertAdjacentHTML("beforeend", `<div class="params" id="${checkboxes[i].value}">${checkboxes[i].dataset.string}<span data-value="${checkboxes[i].value}" class="close-params">x<span></div>`)
          } else if (!checkboxes[i].checked) {
            let element = document.getElementById(`${checkboxes[i].value}`);
            if (element != null) element.remove();
          }
        });
      }
    }
  });
}

const uncheckFilter = () => {
  document.addEventListener("DOMContentLoaded", function() {
    if (document.querySelector("#dashboard-container") != null) {
      let checkboxes = document.querySelectorAll("input[type=checkbox]");
      for (let i = 0; i < checkboxes.length; i++) {
        checkboxes[i].addEventListener("change", function() {
          let closeParams = document.querySelectorAll(".close-params")
          for (let i = 0; i < closeParams.length; i++) {
            closeParams[i].addEventListener("click", function() {
              let paramsDiv = document.getElementById(`${closeParams[i].dataset.value}`);
              paramsDiv.remove()
              for (let x = 0; x < checkboxes.length; x++) {
                if (checkboxes[x].value == closeParams[i].dataset.value) {
                  checkboxes[x].checked = false
                  let event = document.createEvent("HTMLEvents");
                  event.initEvent('change', false, true);
                  checkboxes[x].dispatchEvent(event);
                }
              }
            })
          }
        })
      }

    }
  })
}

export {
  uncheckFilter
}
export {
  listParams
}
