package controllers

import (
	"github.com/astaxie/beego"
)

type MainController struct {
	beego.Controller
}

func (c *MainController) Get() {
	c.Data["year"] = "2016"
	c.Data["Email"] = "cluchomucho@gmail.com"
	c.TplName = "index.tpl"
}
