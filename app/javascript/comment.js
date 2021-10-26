const buildHTML = (XHR) => {
  const item = XHR.response.comment;
  const html = `
  <div class="flex">
  <div class="py-2 h-auto divide-y divide-gray-400">
    <div class="flex justify-between my-4">
      <div class="flex display-start items-center">
        <div class="flex rounded-md border-2 border-green-500">
          <span class="material-icons">done</span><p class="mx-2">コメントを投稿しました</p>
        </div>
      </div>
    </div>
    ${item.content}
  </div>`;
  return html;
};

function job (){
  const submit = document.getElementById("comment_submit");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById("form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    var job_id = document.getElementById("hidden_job_id").value;
    XHR.open("POST", "/jobs/" + job_id + "/comments" , true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const list = document.getElementById("comment_list");
      const formText = document.getElementById("content");
      list.insertAdjacentHTML("afterend", buildHTML(XHR));
      formText.value = "";
    };
  });
 };
 
 window.addEventListener('load', job);