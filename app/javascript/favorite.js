function job (){
  const submit = document.getElementById("favorite_form");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const formData = new FormData;
    const XHR = new XMLHttpRequest();
    var job_id = document.getElementById("hidden_job_id").value;
    XHR.open("POST", "/jobs/" + job_id + "/favorites" , true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const list = document.getElementById("favorite_list");
      const html = `
      <div class="flex rounded-md border-2 border-green-500">
        <span class="material-icons">done</span><p class="mx-2">お気に入り登録しました</p>
      </div>`;
      list.insertAdjacentHTML("afterend", html);
    };
  });
};

window.addEventListener('load', job);