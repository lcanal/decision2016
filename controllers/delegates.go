package controllers

import (
	"encoding/json"
	//"fmt"
	//"io/ioutil"
	"github.com/astaxie/beego"
	"net/http"
)

type Delegates struct {
	beego.Controller
}

type DelegateInfo struct {
		DelState APFormat
}

type APFormat struct {
	Test 			 			string
	TimeStamp  		  string
	Del             []DelegatesByParty
}

type DelegatesByParty struct {
	Pid 						string   //Party ID
	DNeed  					string	//Delegates Needed
	DVotes 					string  //Delegate Votes
	State 					[]State
}

type State struct {
	SID       			string //stateid
	Cand						[]Candidate
}

type Candidate struct {
	CID						string
	CName 				string
	DTot 					string //total delegates
	D1						string //no idea...
}

func getJson(url string, target interface{}) error {
    r, err := http.Get(url)
    if err != nil {
        return err
    }
    defer r.Body.Close()

    return json.NewDecoder(r.Body).Decode(target)
}


func (c *Delegates) Get() {

	// This gets data on the fly..
	url := "https://interactives.ap.org/interactives/2016/delegate-tracker/live-data/data/delegates-delstate.json"
	//url := "https://api.ap.org/v2/elections/xplor"
	committedDelegates := new(DelegateInfo)

	getJson(url,committedDelegates)
	println(committedDelegates.DelState.Del[0].State[0].Cand[0].CName)

	c.Data["year"] = "2016"
	c.TplName = "delegates.tpl"
}
