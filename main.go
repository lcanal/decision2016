package main

import (
	_ "decision2016/routers"
	"github.com/astaxie/beego"
	"net/http"
	"encoding/json"
)

func checkJSON(url string,target interface{}) error {
	r, err := http.Get(url)
	if err != nil {
		return err
	}
	defer r.Body.Close()

	return json.NewDecoder(r.Body).Decode(target)
}

func main() {
  //go checkJSON(jsonURL,json)
	beego.Run()
}
