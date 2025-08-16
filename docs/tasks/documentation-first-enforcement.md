# Documentation-First Enforcement Command

## Purpose
Enforce the mandatory documentation-first workflow for all NautilusTrader development tasks.

## Activation
This rule is automatically enforced for all AI assistants working on this repository through:
- `docs/data/documentation-first-rule.md`
- `.bmad-core/core-config.yaml`

## Workflow Checkpoint
Before any code modification, creation, or analysis task, the assistant must:

1. ✅ Read `docs/index.md` to understand documentation structure
2. ✅ Navigate to relevant documentation sections
3. ✅ Understand architectural patterns and existing implementations
4. ✅ Apply documented knowledge to the task

## Enforcement Actions
If this rule is violated:
- Stop current task immediately
- Reference this enforcement file
- Restart task following proper documentation-first workflow
- Document the violation and correction in development logs

## Rule Exceptions
**NONE** - This rule applies to ALL tasks without exception.