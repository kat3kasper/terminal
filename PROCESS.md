# Process

1. Pick a story from Waffle. Move the card to "In Progress" and assign yourself to it. If you have any questions about the story move it back to the Inbox and ask the product owner (Kate) about it.

    Example:

    > #123 Search for jobs in multiple cities, not just one

2. Create a local branch in your development environment to work on the story. Start the branch name with the Github Issue number.

    Example:
        $ git fetch
        $ git branch 123-multi-city-search origin/master
        $ git checkout 123-multi-city-search

4. Implement your feature and write/satisfy relevant test(s).

    Notes:
    - Follow the [Ruby Style Guide](https://github.com/rubocop-hq/ruby-style-guide).
    You can use rubocop to see style errors `rubocop app/`

    - Use bullet to check for n+1 queries. In `config/environments/test.rb` uncomment `Bullet.raise = true` and run the test suite

6. Run the entire test suite.

    Make sure your changes don't break anything else. Fix anything broken.

5. Commit and push your branch to GitHub using a graphical git utility such as GitX, Tower, or Github Desktop.

6. Create a pull request using the template.

    Use `master` as the root branch

    See [PULL_REQUEST_TEMPLATE.md](PULL_REQUEST_TEMPLATE.md)

    Merge master into branch and resolve conflicts as needed before PR review if
    it is not automatically mergeable without conflicts.

7. Ask someone to review your code.

8. Make any necessary changes.

    Address PR review comments. Any ignored comments should be discussed.

9. Repeat 7 and 8 as needed.

10. Request code merge.

    Ask Wes to merge your branch.
