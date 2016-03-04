package controllers

import (
	"encoding/json"
	"fmt"
	"github.com/astaxie/beego"
	"net/http"
	"strconv"
)

type Delegates struct {
	beego.Controller
}

type DelegateInfo struct {
	DelState APFormat
}

type APFormat struct {
	Test      string
	TimeStamp string
	Del       []DelegatesByParty
}

type DelegatesByParty struct {
	PID    string //Party ID
	DNeed  string //Delegates Needed
	DVotes string //Delegate Votes
	State  []State
}

type State struct {
	SID  string //stateid
	Cand []Candidate
}

type Candidate struct {
	CID   string
	CName string
	DTot  string //total delegates
	D1    string //no idea...
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
	committedDelegatesInfo := new(DelegateInfo)

	getJson(url, committedDelegatesInfo)

	c.Data["committedDelegates"] = committedDelegatesInfo.DelState.Del
	c.Data["year"] = "2016"

	totalDelsByCand := make(map[string]int16)
	c.Data["totalDelsByCand"] = totalDelsByCand

	for _, DelegatesByParty := range committedDelegatesInfo.DelState.Del {
		for _, CurState := range DelegatesByParty.State {
			for stateid, candidate := range CurState.Cand {
				//println(stateid)
				candidateTotal, err := strconv.ParseInt(candidate.DTot, 0, 16)
				if err != nil {
					fmt.Printf("Error on CandidateID %s for State %s\n", candidate.CID, stateid)
					fmt.Println(err)
				}
				totalDelsByCand[candidate.CID] += int16(candidateTotal)
			}
		}
	}

	c.TplName = "delegates.tpl"
}
