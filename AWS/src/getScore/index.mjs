import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


export const handler = async (event) => {
  let headers = event.headers
  let userId = headers["userId"]
  console.log(headers);

  if (userId) {

    const command = new GetCommand({
      TableName: "loversLangUsers",
      Key: {
        userId: userId
      },
    });
  
    const response = await docClient.send(command);
    console.log(response);
    return response.score;
  }

    // TODO implement
    const response = {
      statusCode: 200,
      headers: headers,
      body: JSON.stringify(message),
    };
  
    return response;
  };