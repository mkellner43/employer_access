// Keep a reference to the original fetch function
const originalFetch = window.fetch;

window.fetch = async function (...args) {
  // Call the original fetch function
  const response = await originalFetch.apply(this, args);

  // Get the URL of the request
  const url = args[0];
  console.log("url:", url.url);
  const targetUrl = 'urlhere'

  // Check if the URL matches the specific path you're interested in
  // if (url.includes('/')) {
  // Clone the response so that it doesn't get consumed
  const clone = response.clone();
  console.log("clone:", clone);
  console.log(
    "includes /youtubei/v1/player",
    url.url.includes(targetUrl)
  );

  // Check if the response is JSON and has a body
  if (response.headers.get("content-type").includes("application/json")) {
    // If it's JSON, parse it
    const data = await clone.json();

    // Now you can use the data
    console.log("mydata:", data);

    // You can also display the data on your webpage
    // let element = document.createElement('pre');
    // element.innerText = JSON.stringify(data, null, 2);
    // document.body.appendChild(element);
  }
  //}

  // Return the original response
  return response;
};
