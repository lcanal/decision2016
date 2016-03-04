package routers

import (
	"decision2016/controllers"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{})
	beego.Router("/delegates", &controllers.Delegates{})
}
