import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


export const handler = async (event) => {
  console.log(event);
  let message = event.message;
  let email = message.email;
  let userId = message.userId;
  console.log(email);
  console.log(typeof email);
  console.log(userId);
  console.log(typeof userId);

  if (email && userId) {
    const command = new GetCommand({
      TableName: "loversLangUsers",
      Key: {
        "username": email,
        "userId": userId
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