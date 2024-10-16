import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand, PutCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


export const handler = async (event) => {
  let headers = event.headers
  let body = JSON.parse(event.body)
  let message = body.message
  // headers["3rdHeader"] = "greetings"
  console.log(message);

  if (message.name && message.email && message.userId && message.score) {
    let name = message.name
    let email = message.email
    let userId = message.userId
    let score = JSON.parse(message.score)

    const command = new PutCommand({
      TableName: "loversLangUsers",
      Item: {
        username: { S: email },
        userId: { S: userId},
        name: {S: name},
        score: {M: score}
      },
    });
  
    const response = await docClient.send(command);
    console.log(response);
    return response;
  }

    // TODO implement
    const response = {
      statusCode: 200,
      headers: headers,
      body: JSON.stringify(message),
    };
  
    return response;
  };