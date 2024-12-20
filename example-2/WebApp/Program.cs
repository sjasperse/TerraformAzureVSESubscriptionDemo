using Azure.Identity;
using Microsoft.Azure.Cosmos;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var azureCredential = new DefaultAzureCredential();
var configuration = app.Services.GetRequiredService<IConfiguration>();

// var cosmosClient = new CosmosClient(configuration.GetConnectionString("Cosmos"));
var cosmosClient = new CosmosClient(configuration.GetConnectionString("CosmosEndpoint"), azureCredential);

var stuffContainer = cosmosClient.GetContainer("Main", "Stuff");

await stuffContainer.UpsertItemAsync(new CosmosMessageRecord(id: "message", pk: "misc", message: "Hello World" ));

app.MapGet("/", async () => {
    var response = await stuffContainer.ReadItemAsync<CosmosMessageRecord>("message", new PartitionKey("misc"));

    return Results.Ok(response.Resource);
});

app.Run();

record CosmosMessageRecord(
    string id, 
    string pk, 
    string message, 
    long? _ts = null,
    string? _etag = null,
    string? _self = null
);
