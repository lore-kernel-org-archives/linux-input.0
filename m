From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/5 v3] Input: bu21013_ts - Add support for Device Tree
 booting
Date: Tue, 27 Nov 2012 11:38:48 +0000
Message-ID: <20121127113848.GD2013@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51352 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab2K0Lix (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 06:38:53 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5069253bkw.19
        for <linux-input@vger.kernel.org>; Tue, 27 Nov 2012 03:38:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1352900837-20759-4-git-send-email-lee.jones@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Author: Lee Jones <lee.jones@linaro.org>
Date:   Fri Sep 28 14:35:43 2012 +0100

    Input: bu21013_ts - Add support for Device Tree booting
   =20
    Now we can register the BU21013_ts touch screen when booting with
    Device Tree enabled. Here we parse all the necessary components
    previously expected to be passed from platform data.
   =20
    Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Cc: linux-input@vger.kernel.org
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Linus Walleij <linus.walleij@linaro.org>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu2101=
3.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
new file mode 100644
index 0000000..ca5a2c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
@@ -0,0 +1,28 @@
+* Rohm BU21013 Touch Screen
+
+Required properties:
+ - compatible              : "rohm,bu21013_tp"
+ - reg                     :  I2C device address
+
+Optional properties:
+ - touch-gpio              : GPIO pin registering a touch event
+ - <supply_name>-supply    : Phandle to a regulator supply
+ - rohm,touch-max-x        : Maximum outward permitted limit in the X =
axis
+ - rohm,touch-max-y        : Maximum outward permitted limit in the Y =
axis
+ - rohm,flip-x             : Flip touch coordinates on the X axis
+ - rohm,flip-y             : Flip touch coordinates on the Y axis
+
+Example:
+
+	i2c@80110000 {
+		bu21013_tp@0x5c {
+			compatible =3D "rohm,bu21013_tp";
+			reg =3D <0x5c>;
+			touch-gpio =3D <&gpio2 20 0x4>;
+			avdd-supply =3D <&ab8500_ldo_aux1_reg>;
+
+			rohm,touch-max-x =3D <384>;
+			rohm,touch-max-y =3D <704>;
+			rohm,flip-y;
+		};
+	};
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/tou=
chscreen/bu21013_ts.c
index 16f29d6..07335ac 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -15,6 +15,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
=20
 #define PEN_DOWN_INTR	0
 #define MAX_FINGERS	2
@@ -473,13 +475,30 @@ static void bu21013_free_irq(struct bu21013_ts_da=
ta *bu21013_data)
  * This function used to initializes the i2c-client touchscreen
  * driver and returns integer.
  */
+static void __devinit bu21013_of_probe(struct device_node *np,
+				struct bu21013_platform_device *pdata)
+{
+	pdata->y_flip =3D pdata->x_flip =3D false;
+
+	pdata->x_flip =3D of_property_read_bool(np, "rohm,flip-x");
+	pdata->y_flip =3D of_property_read_bool(np, "rohm,flip-y");
+
+	of_property_read_u32(np, "rohm,touch-max-x", &pdata->touch_x_max);
+	of_property_read_u32(np, "rohm,touch-max-y", &pdata->touch_y_max);
+
+	pdata->touch_pin =3D of_get_named_gpio(np, "touch-gpio", 0);
+	pdata->cs_pin =3D of_get_named_gpio(np, "reset-gpio", 0);
+
+	pdata->ext_clk =3D false;
+}
+
 static int __devinit bu21013_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
 	struct bu21013_ts_data *bu21013_data;
 	struct input_dev *in_dev;
-	const struct bu21013_platform_device *pdata =3D
-					client->dev.platform_data;
+	struct device_node *np =3D client->dev.of_node;
+	struct bu21013_platform_device *pdata =3D client->dev.platform_data;
 	int error;
=20
 	if (!i2c_check_functionality(client->adapter,
@@ -489,8 +508,17 @@ static int __devinit bu21013_probe(struct i2c_clie=
nt *client,
 	}
=20
 	if (!pdata) {
-		dev_err(&client->dev, "platform data not defined\n");
-		return -EINVAL;
+		if (np) {
+			pdata =3D devm_kzalloc(&client->dev, sizeof(*pdata),
+					GFP_KERNEL);
+			if (!pdata)
+				return -ENOMEM;
+
+			bu21013_of_probe(np, pdata);
+		} else {
+			dev_err(&client->dev, "no device tree or platform data\n");
+			return -EINVAL;
+		}
 	}
=20
 	pdata->irq =3D gpio_to_irq(pdata->touch_pin);

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
