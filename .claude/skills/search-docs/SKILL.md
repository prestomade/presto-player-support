# /search-docs -- Documentation Search

When the agent needs to find information, follow these steps:

## Step 1: Understand the Query

Parse the agent's question to identify key terms, feature names, or error messages.

## Step 2: Search in Order

Search these sources in order, stopping when you find a good answer:

1. **Wiki runbooks** (`wiki/`) -- Check troubleshooting guides and reference docs first
2. **Reference files** (`references/`) -- Check architecture, API, and playback flow docs
3. **CLAUDE.md** -- Check the product overview and troubleshooting table
4. **Plugin source code** -- Search for relevant classes, functions, and comments
5. **Inline documentation** -- Look for PHPDoc blocks and code comments

## Step 3: Compile Answer

Present the answer with:
- A clear, concise explanation
- Source citations (file path, line number, or wiki page)
- Related information the agent might need
- Links to relevant wiki pages for further reading
