#!/bin/bash

# Batch update script to add documentation-first rule to all BMad agents
# This enforces the 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE across all agents

# Define the documentation-first rule text
RULE_TEXT="  - 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE: Before working on ANY component or task involving codebase analysis, system architecture, requirements planning, or technical implementation, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, process and understand the existing system, and apply that knowledge to your work"

# Define the insertion point (after agent.customization line)
INSERTION_POINT="  - The agent.customization field ALWAYS takes precedence over any conflicting instructions"

# List of agent files to update (remaining ones)
AGENT_FILES=(
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/architect.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/architect.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/pm.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/pm.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/qa.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/qa.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/ux-expert.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/ux-expert.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/po.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/po.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/sm.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/sm.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/bmad-orchestrator.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/bmad-orchestrator.md"
  "/home/luzon/source-code-repos/top-trading-system/.bmad-core/agents/bmad-master.md"
  "/home/luzon/source-code-repos/top-trading-system/.claude/commands/BMad/agents/bmad-master.md"
)

echo "Starting batch update of agent files with documentation-first rule..."

for file in "${AGENT_FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "Updating: $file"
    
    # Check if rule already exists
    if grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
      echo "  - Rule already exists, skipping..."
      continue
    fi
    
    # Create backup
    cp "$file" "${file}.bak"
    
    # Insert the rule after the insertion point
    sed "/The agent.customization field ALWAYS takes precedence over any conflicting instructions/a\\
$RULE_TEXT" "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    
    echo "  - Updated successfully"
  else
    echo "File not found: $file"
  fi
done

echo "Batch update completed!"