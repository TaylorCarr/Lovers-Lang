import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, UpdateCommand } from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);


export const handler = async (event) => {
    console.log(event);
  let headers = event.headers
//   let body = JSON.parse(event.body)
  let message = event.message
  // headers["3rdHeader"] = "greetings"
  console.log(message);

  if (message.userId && message.partnerId && message.partnerUsername) {
    let userId = message.userId
    let partnerId = message.partnerId
    let partnerUsername = message.partnerUsername

    const command = new UpdateCommand({
        TableName: "loversLangUsers",
        Key: {
            "userId": userId,
        },
        UpdateExpression:
            'set #partnerId = :v_partnerId, #partnerUsername = v_partnerUsername',
        ExpressionAttributeNames: {
            '#partnerId': 'partnerId',
            '#partnerUsername': 'partnerUsername'
        },
        ExpressionAttributeValues: {
            ':v_partnerUsername': partnerUsername,
            ':v_partnerId': partnerId
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