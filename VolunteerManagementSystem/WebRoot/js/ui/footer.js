/*网站访问次数*/
function saveLocalStorage() {

}

function loadLocalStorage() {

}

var local_num = localStorage.getItem('NVaule') ? localStorage.getItem('NVaule') : 0;
document.getElementById("local_num").innerHTML = local_num;
localStorage.setItem('NVaule', +local_num + 1);