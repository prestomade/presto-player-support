# /lookup-api -- REST API Endpoint Lookup

When the agent asks about a specific API endpoint or feature, follow these steps:

## Step 1: Identify the Resource

Determine which REST endpoint or feature the agent is asking about. Map it to the relevant route in `inc/Services/API/`.

## Step 2: Search Route Definitions

Search the REST controller files in `inc/Services/API/` for the route definition. Identify:
- HTTP method (GET/POST/PUT/DELETE)
- URL path
- Permission level
- Callback class and method

## Step 3: Search the Handler

Find the callback method in the controller class. Document:
- Required parameters
- Validation rules
- What the endpoint does
- What it returns (success and error responses)

## Step 4: Present in Plain English

Summarize the endpoint in a format like:

**Endpoint**: `GET /presto-player/v1/videos`
**Permission**: `upload_files` capability required
**Purpose**: Retrieves all video records
**Required fields**: None (optional pagination params)
**Returns**: Array of video objects
**Handler**: `RestVideosController::get_items()` in `inc/Services/API/RestVideosController.php`

Always include the file path and line number for the handler.
