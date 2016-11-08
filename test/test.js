/**
 * Created by pncity on 2016/11/06.
 */
const key = "name";
let obj = {
  key: "hoge" //keyがkeyになる
};

let obj2 = {
  [key]: "fuga" //keyが展開されて"name"になる
}

console.log(obj);
console.log(obj2);
