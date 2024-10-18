import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, GetCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


export const handler = async (event) => {
  console.log(event);
  console.log(event.headers);
  let email = event.headers["X-User-Email"];
  let userId = event.headers["X-User-Id"];
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
    return JSON.stringify(response.Item);
  } else {
    let errorMessage = {
        message: "User not found"
    }
    const response = {
        statusCode: 404,
        headers: headers,
        body: JSON.stringify(errorMessage),
      };

      return response;
  }
};