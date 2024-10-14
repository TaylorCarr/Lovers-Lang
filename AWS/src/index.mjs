export const handler = async (event) => {
  let headers = event.headers
  let body = JSON.parse(event.body)
  let message = body.message

    // TODO implement
    const response = {
      statusCode: 200,
      headers: headers,
      body: JSON.stringify(message),
    };
    return response;
  };