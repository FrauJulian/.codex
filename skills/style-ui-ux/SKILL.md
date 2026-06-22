---
name: style-ui-ux
description: Use when designing or refining application UI/UX, visual hierarchy, layouts, components, forms, feedback states, responsive behavior, accessibility, and design-system consistency. Applies to web and desktop interfaces.
---

# UI and UX style

Create interfaces that are clear, coherent, accessible, responsive, and efficient rather than merely decorative.

## Workflow

1. Identify the primary user task, context, frequency, risk, and success criteria.
2. Inspect the existing product identity, design tokens, components, layouts, and accessibility conventions.
3. Map all required states: initial, loading, empty, partial, success, validation, disabled, offline, and failure.
4. Establish information hierarchy before visual styling.
5. Reuse existing patterns and tokens.
6. Validate keyboard flow, focus, contrast, content growth, localization, and responsive behavior.

## Hierarchy and layout

- Make the primary action and current state obvious.
- Group related information through spacing and alignment before adding borders or decoration.
- Use a consistent spacing scale.
- Keep line length and density appropriate to the task.
- Prefer predictable layouts over visually novel ones.
- Design for real content, long labels, errors, empty values, and localization.
- Use progressive disclosure for advanced or infrequent controls.
- Avoid modal dialogs when an inline flow is safer and clearer.
- Keep destructive actions separated and explicitly confirmed when consequences are hard to reverse.

## Typography and visual system

- Use a limited, consistent type scale.
- Preserve readable contrast, line height, and text size.
- Use weight and size to create hierarchy; do not rely on color alone.
- Use a restrained tokenized palette.
- Keep iconography consistent and pair ambiguous icons with labels.
- Avoid excessive shadows, gradients, borders, and decorative noise.
- Match the existing product style unless redesign is requested.

## Interaction

- Every interactive control must look interactive and have clear hover, focus, active, disabled, and loading behavior where relevant.
- Keep targets large enough and separated.
- Preserve user input after recoverable errors.
- Give immediate feedback for actions.
- Use optimistic UI only when failure can be reconciled safely.
- Prevent duplicate submissions.
- Make keyboard order follow visual and semantic order.
- Avoid hidden gestures as the sole access path.

## Forms

- Use persistent visible labels.
- Place validation near the affected field and explain how to fix it.
- Validate at an appropriate time; avoid punishing users while typing.
- Use correct input types, autocomplete, and formatting.
- Mark required and optional fields consistently.
- Group related fields and keep forms as short as the task allows.
- Never rely solely on placeholder text.

## Accessibility

- Meet applicable contrast requirements.
- Ensure full keyboard operation and visible focus.
- Use semantic structure before ARIA.
- Provide accessible names and error relationships.
- Do not communicate state only by color.
- Respect reduced-motion preferences.
- Support zoom, scaling, screen readers, and high-contrast modes appropriate to the platform.

## Responsive behavior

- Design from content constraints.
- Prioritize and reflow rather than merely shrink.
- Avoid horizontal scrolling except for intentionally scrollable data.
- Keep actions reachable and context visible.
- Test narrow, medium, and wide layouts with realistic content.

## Performance and restraint

- Avoid visual effects that trigger expensive layout or paint work without value.
- Keep animation short, purposeful, and interruptible.
- Avoid oversized media and unnecessary fonts.
- Do not add UI complexity that increases cognitive or maintenance cost without improving the task.
