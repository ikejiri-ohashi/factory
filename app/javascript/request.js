const buildHTML = (XHR) => {
  const html = `
  <div class="mb-2">
    <div class="flex rounded-md border-2 border-green-500">
      <span class="material-icons">done</span><p class="mx-2">リクエストを送信しました</p>
    </div>
  </div>`;
  return html;
};

function job (){
  const submit = document.getElementById("request_submit");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById("request_form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    var job_id = document.getElementById("hidden_job_id").value;
    XHR.open("POST", "/jobs/" + job_id + "/requests" , true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const list = document.getElementById("request_list");
      list.insertAdjacentHTML("afterend", buildHTML(XHR));
    };
  });
 };
 
 window.addEventListener('load', job);