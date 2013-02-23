From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 4/4] Input: auo_pixcir_ts - add devicetree support
Date: Sat, 23 Feb 2013 12:58:16 +0100
Message-ID: <201302231258.16498.heiko@sntech.de>
References: <201302231255.23772.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201302231255.23772.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Add the necessary code to create the needed platformdata from devicetree
informations.

The interrupt mode of the chip is not set via devicetree, as it is not
a property of the hardware but instead only a preferred type of operation.
This should probably be made settable via configfs in the future.
The option set as default is the mode the datasheet mentions as default.

Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 .../bindings/input/touchscreen/auo_pixcir_ts.txt   |   30 ++++++++++
 drivers/input/touchscreen/auo-pixcir-ts.c          |   59 ++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt
new file mode 100644
index 0000000..f40f21c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts.txt
@@ -0,0 +1,30 @@
+* AUO in-cell touchscreen controller using Pixcir sensors
+
+Required properties:
+- compatible: must be "auo,auo_pixcir_ts"
+- reg: I2C address of the chip
+- interrupts: interrupt to which the chip is connected
+- gpios: gpios the chip is connected to
+  first one is the interrupt gpio and second one the reset gpio
+- x-size: horizontal resolution of touchscreen
+- y-size: vertical resolution of touchscreen
+
+Example:
+
+	i2c@00000000 {
+		/* ... */
+
+		auo_pixcir_ts@5c {
+			compatible = "auo,auo_pixcir_ts";
+			reg = <0x5c>;
+			interrupts = <2 0>;
+
+			gpios = <&gpf 2 0 2>, /* INT */
+				<&gpf 5 1 0>; /* RST */
+
+			x-size = <800>;
+			y-size = <600>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/touchscreen/auo-pixcir-ts.c
index c0a2483..6d1f8c1 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -31,6 +31,8 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/input/auo-pixcir-ts.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 /*
  * Coordinate calculation:
@@ -479,6 +481,51 @@ unlock:
 }
 #endif
 
+static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct device *dev)
+{
+	struct auo_pixcir_ts_platdata *pdata = NULL;
+
+#ifdef CONFIG_OF
+	struct device_node *np = dev->of_node;
+
+	if (!np)
+		return NULL;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "failed to allocate platform data\n");
+		return NULL;
+	}
+
+	pdata->gpio_int = of_get_gpio(np, 0);
+	if (!gpio_is_valid(pdata->gpio_int)) {
+		dev_err(dev, "failed to get interrupt gpio\n");
+		return NULL;
+	}
+
+	pdata->gpio_rst = of_get_gpio(np, 1);
+	if (!gpio_is_valid(pdata->gpio_rst)) {
+		dev_err(dev, "failed to get reset gpio\n");
+		return NULL;
+	}
+
+	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
+		dev_err(dev, "failed to get x-size property\n");
+		return NULL;
+	};
+
+	if (of_property_read_u32(np, "y-size", &pdata->y_max)) {
+		dev_err(dev, "failed to get y-size property\n");
+		return NULL;
+	};
+
+	/* default to asserting the interrupt when the screen is touched */
+	pdata->int_setting = AUO_PIXCIR_INT_TOUCH_IND;
+#endif
+
+	return pdata;
+}
+
 static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops, auo_pixcir_suspend,
 			 auo_pixcir_resume);
 
@@ -491,6 +538,9 @@ static int auo_pixcir_probe(struct i2c_client *client,
 	int ret;
 
 	if (!pdata)
+		pdata = auo_pixcir_parse_dt(&client->dev);
+
+	if (!pdata)
 		return -EINVAL;
 
 	ts = kzalloc(sizeof(struct auo_pixcir_ts), GFP_KERNEL);
@@ -647,11 +697,20 @@ static const struct i2c_device_id auo_pixcir_idtable[] = {
 };
 MODULE_DEVICE_TABLE(i2c, auo_pixcir_idtable);
 
+#ifdef CONFIG_OF
+static struct of_device_id auo_pixcir_ts_dt_idtable[] = {
+	{ .compatible = "auo,auo_pixcir_ts" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, auo_pixcir_ts_dt_idtable);
+#endif
+
 static struct i2c_driver auo_pixcir_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "auo_pixcir_ts",
 		.pm	= &auo_pixcir_pm_ops,
+		.of_match_table	= of_match_ptr(auo_pixcir_ts_dt_idtable),
 	},
 	.probe		= auo_pixcir_probe,
 	.remove		= auo_pixcir_remove,
-- 
1.7.2.3
