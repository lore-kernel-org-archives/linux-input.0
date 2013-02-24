From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: auo_pixcir_ts - add devicetree support
Date: Sun, 24 Feb 2013 00:00:15 -0800
Message-ID: <20130224080015.GA20590@core.coreip.homeip.net>
References: <201302231255.23772.heiko@sntech.de>
 <201302231258.16498.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59433 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab3BXIAT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Feb 2013 03:00:19 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so1147072pbc.11
        for <linux-input@vger.kernel.org>; Sun, 24 Feb 2013 00:00:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201302231258.16498.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Heiko,

On Sat, Feb 23, 2013 at 12:58:16PM +0100, Heiko St=FCbner wrote:
> +static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct dev=
ice *dev)
> +{
> +	struct auo_pixcir_ts_platdata *pdata =3D NULL;
> +
> +#ifdef CONFIG_OF
> +	struct device_node *np =3D dev->of_node;
> +
> +	if (!np)
> +		return NULL;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "failed to allocate platform data\n");
> +		return NULL;
> +	}

I disike #ifdefs in the middle of the code, also it would be nice if we
signal the proper error instead of always using -EINVAL when there are
issues with platform/DT data.

How about the version of the patch below?

Thanks.
--=20
Dmitry

Input: auo_pixcir_ts - add devicetree support

=46rom: Heiko St=FCbner <heiko@sntech.de>

Add the necessary code to create the needed platformdata from devicetre=
e
informations.

The interrupt mode of the chip is not set via devicetree, as it is not
a property of the hardware but instead only a preferred type of operati=
on.
This should probably be made settable via configfs in the future.
The option set as default is the mode the datasheet mentions as default=
=2E

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/touchscreen/auo_pixcir_ts.txt   |   30 ++++++++
 drivers/input/touchscreen/auo-pixcir-ts.c          |   74 ++++++++++++=
+++++++-
 2 files changed, 99 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/auo_pixcir_ts.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/auo_pi=
xcir_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/auo_p=
ixcir_ts.txt
new file mode 100644
index 0000000..f40f21c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/auo_pixcir_ts=
=2Etxt
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
+			compatible =3D "auo,auo_pixcir_ts";
+			reg =3D <0x5c>;
+			interrupts =3D <2 0>;
+
+			gpios =3D <&gpf 2 0 2>, /* INT */
+				<&gpf 5 1 0>; /* RST */
+
+			x-size =3D <800>;
+			y-size =3D <600>;
+		};
+
+		/* ... */
+	};
diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c b/drivers/input/=
touchscreen/auo-pixcir-ts.c
index c0a2483..dfa6d54 100644
--- a/drivers/input/touchscreen/auo-pixcir-ts.c
+++ b/drivers/input/touchscreen/auo-pixcir-ts.c
@@ -31,6 +31,8 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/input/auo-pixcir-ts.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
=20
 /*
  * Coordinate calculation:
@@ -479,19 +481,72 @@ unlock:
 }
 #endif
=20
-static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops, auo_pixcir_suspend,
-			 auo_pixcir_resume);
+static SIMPLE_DEV_PM_OPS(auo_pixcir_pm_ops,
+			 auo_pixcir_suspend, auo_pixcir_resume);
+
+#ifdef CONFIG_OF
+static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct devic=
e *dev)
+{
+	struct auo_pixcir_ts_platdata *pdata;
+	struct device_node *np =3D dev->of_node;
+
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "failed to allocate platform data\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pdata->gpio_int =3D of_get_gpio(np, 0);
+	if (!gpio_is_valid(pdata->gpio_int)) {
+		dev_err(dev, "failed to get interrupt gpio\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata->gpio_rst =3D of_get_gpio(np, 1);
+	if (!gpio_is_valid(pdata->gpio_rst)) {
+		dev_err(dev, "failed to get reset gpio\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "x-size", &pdata->x_max)) {
+		dev_err(dev, "failed to get x-size property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32(np, "y-size", &pdata->y_max)) {
+		dev_err(dev, "failed to get y-size property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* default to asserting the interrupt when the screen is touched */
+	pdata->int_setting =3D AUO_PIXCIR_INT_TOUCH_IND;
+
+	return pdata;
+}
+#else
+static struct auo_pixcir_ts_platdata *auo_pixcir_parse_dt(struct devic=
e *dev)
+{
+	return ERR_PTR(-EINVAL);
+}
+#endif
=20
 static int auo_pixcir_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
-	const struct auo_pixcir_ts_platdata *pdata =3D client->dev.platform_d=
ata;
+	const struct auo_pixcir_ts_platdata *pdata;
 	struct auo_pixcir_ts *ts;
 	struct input_dev *input_dev;
 	int ret;
=20
-	if (!pdata)
-		return -EINVAL;
+	pdata =3D dev_get_platdata(&client->dev);
+	if (!pdata) {
+		pdata =3D auo_pixcir_parse_dt(&client->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
=20
 	ts =3D kzalloc(sizeof(struct auo_pixcir_ts), GFP_KERNEL);
 	if (!ts)
@@ -647,11 +702,20 @@ static const struct i2c_device_id auo_pixcir_idta=
ble[] =3D {
 };
 MODULE_DEVICE_TABLE(i2c, auo_pixcir_idtable);
=20
+#ifdef CONFIG_OF
+static struct of_device_id auo_pixcir_ts_dt_idtable[] =3D {
+	{ .compatible =3D "auo,auo_pixcir_ts" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, auo_pixcir_ts_dt_idtable);
+#endif
+
 static struct i2c_driver auo_pixcir_driver =3D {
 	.driver =3D {
 		.owner	=3D THIS_MODULE,
 		.name	=3D "auo_pixcir_ts",
 		.pm	=3D &auo_pixcir_pm_ops,
+		.of_match_table	=3D of_match_ptr(auo_pixcir_ts_dt_idtable),
 	},
 	.probe		=3D auo_pixcir_probe,
 	.remove		=3D auo_pixcir_remove,
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
