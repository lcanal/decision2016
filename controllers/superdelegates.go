package controllers

import (
	"fmt"
	"strconv"
	"github.com/astaxie/beego"
)

type SuperDelegates struct {
	beego.Controller
}

func (c *SuperDelegates) Get() {
  committedDelegatesInfo := new(SuperDelegateInfo)

	// This gets data on the fly..
	url := "https://interactives.ap.org/interactives/2016/delegate-tracker/live-data/data/delegates-delsuper.json"
	getJson(url, committedDelegatesInfo)

	// Use this when data won't change much..
	//fileLocation := "data/delegates-delstate.json"
	//getJsonFromDisk(fileLocation, committedDelegatesInfo)

	cidToCName := make(map[string]string)
	totalCommittedDelegates := make(map[string]int16)
	delegateCountByState := make(map[string][]StateCount)
  var superDelegateTotal int16

	c.Data["committedDelegates"] = committedDelegatesInfo.DelSuper.Del
	c.Data["cidToCName"] = cidToCName
	c.Data["totalCommittedDelegates"] = totalCommittedDelegates
	c.Data["delegateCountByState"] = delegateCountByState
	c.Data["year"] = "2016"

	for _, DelegatesByParty := range committedDelegatesInfo.DelSuper.Del {
		for _, CurState := range DelegatesByParty.State {
			for stateid, candidate := range CurState.Cand {
				candidateTotal, err := strconv.ParseInt(candidate.SDTot, 0, 16)
				if err != nil {
					fmt.Printf("Error on CandidateID %s for State %s\n", candidate.CID, stateid)
					fmt.Println(err)
				}
				totalCommittedDelegates[candidate.CID] += int16(candidateTotal)

				//Build Candidate ID to Name map.
				if _, ok := cidToCName[candidate.CID]; !ok {
					cidToCName[candidate.CID] = candidate.CName
				}
				//Also build a count by State, using candidate id as a key. Only count things not labeled as US
        if CurState.SID != "US" {
          canStateCount := StateCount{CurState.SID, int16(candidateTotal)}
          delegateCountByState[candidate.CID] = append(delegateCountByState[candidate.CID], canStateCount)
        }else {
          superDelegateTotal += int16(candidateTotal)
        }
			}
		}
	}
	delete(totalCommittedDelegates, "100004")
  c.Data["superDelegateTotal"] = superDelegateTotal
	c.TplName = "superdelegates.tpl"
}

type SuperDelegateInfo struct {
	DelSuper   SuperAPFormat
}

type SuperAPFormat struct {
	Test      string
	TimeStamp string
	Del       []SuperDelegatesByParty
}

type SuperDelegatesByParty struct {
	PID    string //Party ID
	DNeed  string //Delegates Needed
	DVotes string //Delegate Votes
	State  []SuperState
}

type SuperState struct {
	SID  string //stateid
	Cand []SuperCandidate
}

type SuperCandidate struct {
	CID      string
	CName    string
	DTot     string //total delegates
	SDTot    string //Super Delegate Total.
}
