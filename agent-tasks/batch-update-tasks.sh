#!/bin/bash

# Batch update script to add documentation-first rule to relevant task files
# This enforces the 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE across key tasks

echo "Starting batch update of task files with documentation-first rule..."

# Update facilitate-brainstorming-session.md
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/facilitate-brainstorming-session.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add rule after the "Facilitate interactive brainstorming sessions" line
  sed '/Facilitate interactive brainstorming sessions with users. Be creative and adaptive in applying techniques./a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: For brainstorming sessions involving technical topics, codebase analysis, system architecture, or any software development subjects, you MUST ALWAYS start by reading docs/index.md to identify relevant documentation, navigate to specific documentation sections, and understand the existing system before facilitating the brainstorming process. This ensures all ideas are grounded in actual system capabilities and constraints.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

# Update create-deep-research-prompt.md
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/create-deep-research-prompt.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add rule at the beginning after any existing header
  sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before creating research prompts involving codebase analysis, system architecture, technical implementation, or software development topics, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, process and understand the existing system, and apply that knowledge to create informed research prompts that are grounded in actual system capabilities and patterns.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

# Update create-next-story.md
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/create-next-story.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add rule at the beginning after any existing header
  sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before creating development stories that involve codebase modifications, system enhancements, or technical implementation, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, process and understand existing system architecture, patterns, and constraints, and apply that knowledge to create stories that align with established system design and capabilities.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

# Update create-brownfield-story.md  
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/create-brownfield-story.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add rule at the beginning after any existing header
  sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before creating brownfield stories for existing codebases, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, process and understand the existing system architecture, current implementation patterns, technical debt, and constraints, and apply that knowledge to create stories that work within the reality of the existing system.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

# Update brownfield-create-story.md
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/brownfield-create-story.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add rule at the beginning after any existing header  
  sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before creating brownfield development stories, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, understand existing system architecture and implementation patterns, and apply that knowledge to create stories that respect existing system constraints and leverage established patterns.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

# Update brownfield-create-epic.md
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/brownfield-create-epic.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add rule at the beginning after any existing header
  sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before creating brownfield epics for existing systems, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, understand the complete system architecture, existing capabilities, technical constraints, and implementation patterns, and apply that knowledge to create epics that align with system realities and leverage existing infrastructure.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

# Update review-story.md
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/review-story.md"
if [ -f "$file" ] && ! grep -q "🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file" 
  cp "$file" "${file}.bak"
  
  # Add rule at the beginning after any existing header
  sed '1a\\
\\
## 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE\\
\\
**CRITICAL**: Before reviewing stories that involve codebase changes or technical implementation, you MUST ALWAYS start with docs/index.md to identify relevant documentation, navigate to specific documentation sections, understand existing system patterns and constraints, and validate that story requirements align with documented system architecture and capabilities.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"  
fi

# Update document-project.md with stronger enforcement reference
file="/home/luzon/source-code-repos/top-trading-system/.bmad-core/tasks/document-project.md"
if [ -f "$file" ] && ! grep -q "This task enforces the 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE" "$file"; then
  echo "Updating: $file"
  cp "$file" "${file}.bak"
  
  # Add stronger reference after the purpose section
  sed '/## Purpose/a\\
\\
**NOTE**: This task enforces the 🔒 UNBREAKABLE DOCUMENTATION-FIRST RULE by systematically analyzing existing documentation before creating new documentation, ensuring comprehensive understanding of the current system state.' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
  
  echo "  - Updated successfully"
fi

echo "Batch task file update completed!"