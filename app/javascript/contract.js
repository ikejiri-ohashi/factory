const buildHTML = (XHR) => {
  const item = XHR.response.contract;
  const html = `
  <div class="mb-2">
    <div class="flex rounded-md border-2 border-green-500">
      <span class="material-icons">done</span><p class="mx-2">募集を終了しました</p>
    </div>
  </div>`;
  return html;
};

function job (){
  const submit = document.getElementById("contract_submit");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById("contract_form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    var job_id = document.getElementById("hidden_job_id").value;
    XHR.open("POST", "/jobs/" + job_id + "/contracts" , true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const list = document.getElementById("contract_list");
      // const formText = document.getElementById("content");
      list.insertAdjacentHTML("afterend", buildHTML(XHR));
      // formText.value = "";
    };
  });
 };
 
 window.addEventListener('load', job);