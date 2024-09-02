const request = require("supertest");
const lambdaFunctionURL = require("./secrets.js");

describe("Test Visit Count Lambda Function URL", () => {
  it("should return 200 OK", async () => {
    const response = await request(lambdaFunctionURL).get("/");

    expect(response.status).toBe(200);
  });
});
