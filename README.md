# km-shortman
Link shortener

## Endpoints
Endpoints delegated between web and API applications which is running on separate ports.

### Shortlink Endpoint
Shortlink will return a permanent redirect with status code 301 

```
GET <hostname>:4000/<hashId>
```

### API
WIP

#### Create new link

##### Request
```
POST <hostname>/api/1.0/links
```
```
Content-Type: application/json
```

##### Required Parameters

```
{"link": {
  "url": "https://google.com/"
}}
```

### Response
```
{
 Response "data": {
    "hashid": "8EjZ6r4jyn",
    "hits": 0,
    "id": 10538,
    "short_url": "http://localhost:4000/8EjZ6r4jyn",
    "url": "https://google.com/"
  }
}
