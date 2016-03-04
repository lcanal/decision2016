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

type StateCount struct{
	SID   string
	Count  int16
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
	cidToCName := make(map[string]string)
	totalCommittedDelegates := make(map[string]int16)
	delegateCountByState := make(map[string][]StateCount)

	getJson(url, committedDelegatesInfo)

	c.Data["committedDelegates"] = committedDelegatesInfo.DelState.Del
	c.Data["cidToCName"] = cidToCName
	c.Data["totalCommittedDelegates"] = totalCommittedDelegates
	c.Data["delegateCountByState"] = delegateCountByState
	c.Data["year"] = "2016"

	for _, DelegatesByParty := range committedDelegatesInfo.DelState.Del {
		for _, CurState := range DelegatesByParty.State {
			for stateid, candidate := range CurState.Cand {
				candidateTotal, err := strconv.ParseInt(candidate.DTot, 0, 16)
				if err != nil {
					fmt.Printf("Error on CandidateID %s for State %s\n", candidate.CID, stateid)
					fmt.Println(err)
				}
				totalCommittedDelegates[candidate.CID] += int16(candidateTotal)

				if _,ok := cidToCName[candidate.CID]; !ok {
					cidToCName[candidate.CID] = candidate.CName
				}
				canStateCount := StateCount{CurState.SID,int16(candidateTotal)}
				delegateCountByState[candidate.CID] = append(delegateCountByState[candidate.CID],canStateCount )

			}
		}
	}
  delete(totalCommittedDelegates,"100004")
	c.TplName = "delegates.tpl"
}
