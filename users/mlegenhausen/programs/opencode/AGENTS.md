# Review Delegation

Every work agent except the `review` agent must delegate code-review work to
the `review` subagent.

When a request asks to review code, a diff, commit, pull request,
configuration, infrastructure change, or implementation:

- Invoke the `review` subagent before responding.
- Pass it the requested scope, user criteria, and relevant context.
- Do not substitute General, Explore, or an independent review.
- Present the review agent's findings without changing their severity or
  omitting material concerns.
- If the review agent cannot be invoked, state that limitation instead of
  silently performing the review with another agent.

The `review` agent itself must perform the review directly and must not
delegate recursively.
