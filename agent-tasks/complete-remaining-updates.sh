#!/bin/bash

echo "Completing remaining updates and fixing tracking..."

# First, let's finish updating any remaining task files that need manual updates
TASK_FILES=(
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/create-deep-research-prompt.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/create-next-story.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/create-brownfield-story.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/brownfield-create-story.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/brownfield-create-epic.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/review-story.md"
)

# Update remaining task files manually
for file in "${TASK_FILES[@]}"; do
  if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
    echo "Updating task file: $file"
    
    # Add rule at the beginning, after any YAML front matter
    if head -n 1 "$file" | grep -q "^---"; then
      # File has YAML front matter, add after it
      awk '
      BEGIN { in_yaml = 0; added_rule = 0 }
      /^---$/ { 
        if (!in_yaml) { in_yaml = 1; print; next }
        else { 
          in_yaml = 0; 
          print; 
          print ""
          print "## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE"
          print ""
          print "**CRITICAL**: Before executing this task for codebase-related work, system architecture, technical implementation, or development activities, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, process and understand the existing system, and apply that knowledge to your task execution."
          print ""
          added_rule = 1
          next 
        }
      }
      { print }
      ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    else
      # No YAML front matter, add at the top after title
      sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before executing this task for codebase-related work, system architecture, technical implementation, or development activities, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, process and understand the existing system, and apply that knowledge to your task execution.\\
' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    fi
    
    echo "  - Task file updated successfully"
  else
    echo "Task file already has rule or doesn't exist: $file"
  fi
done

echo "Task file updates completed!"

# Verify all agent files have the rule
echo "Verifying agent files..."
AGENT_COUNT_BMAD=$(grep -r "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" /home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/ | wc -l)
AGENT_COUNT_CLAUDE=$(grep -r "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" /home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/ | wc -l)

echo "Agent files with rule in .bmad-core/agents/: $AGENT_COUNT_BMAD"
echo "Agent files with rule in .claude/commands/BMad/agents/: $AGENT_COUNT_CLAUDE"

# Verify task files have the rule
TASK_COUNT=$(grep -r "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" /home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/ | wc -l)
echo "Task files with rule: $TASK_COUNT"

echo "Verification completed!"