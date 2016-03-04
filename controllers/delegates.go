package controllers

import (
	"github.com/astaxie/beego"
)

type Delegates struct {
	beego.Controller
}

func (c *Delegates) Get() {
	c.Data["year"] = "2016"
	c.TplName = "delegates.tpl"
}
