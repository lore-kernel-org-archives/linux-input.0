From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] input: improve usage of gpiod API
Date: Wed, 18 Feb 2015 11:47:13 +0100
Message-ID: <1424256433-8090-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37805 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbBRKrT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 05:47:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@linaro.org>

Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
which appeared in v3.17-rc1, the gpiod_get* functions take an additiona=
l
parameter that allows to specify direction and initial value for
output. Simplify drivers accordingly.

Note that in the case of the drv260x driver error checking is more
strict now because -ENOSYS is reported to the caller now. But this
should only be returned if GPIOLIB is disabled which shouldn't happen a=
s
the driver depends on GPIOLIB.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/keyboard/clps711x-keypad.c |  7 +------
 drivers/input/misc/drv260x.c             | 13 ++++---------
 drivers/input/misc/gpio-beeper.c         |  7 +------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/k=
eyboard/clps711x-keypad.c
index 27ef29f8fe6a..b637f1af842e 100644
--- a/drivers/input/keyboard/clps711x-keypad.c
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -120,14 +120,9 @@ static int clps711x_keypad_probe(struct platform_d=
evice *pdev)
 	for (i =3D 0; i < priv->row_count; i++) {
 		struct clps711x_gpio_data *data =3D &priv->gpio_data[i];
=20
-		data->desc =3D devm_gpiod_get_index(dev, "row", i);
-		if (!data->desc)
-			return -EINVAL;
-
+		data->desc =3D devm_gpiod_get_index(dev, "row", i, GPIOD_IN);
 		if (IS_ERR(data->desc))
 			return PTR_ERR(data->desc);
-
-		gpiod_direction_input(data->desc);
 	}
=20
 	err =3D of_property_read_u32(np, "poll-interval", &poll_interval);
diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.=
c
index 599578042ea0..e5d60ecd29a4 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -580,15 +580,10 @@ static int drv260x_probe(struct i2c_client *clien=
t,
 		return error;
 	}
=20
-	haptics->enable_gpio =3D devm_gpiod_get(&client->dev, "enable");
-	if (IS_ERR(haptics->enable_gpio)) {
-		error =3D PTR_ERR(haptics->enable_gpio);
-		if (error !=3D -ENOENT && error !=3D -ENOSYS)
-			return error;
-		haptics->enable_gpio =3D NULL;
-	} else {
-		gpiod_direction_output(haptics->enable_gpio, 1);
-	}
+	haptics->enable_gpio =3D devm_gpiod_get_optional(&client->dev, "enabl=
e",
+						       GPIOD_OUT_HIGH);
+	if (IS_ERR(haptics->enable_gpio))
+		return PTR_ERR(haptics->enable_gpio);
=20
 	haptics->input_dev =3D devm_input_allocate_device(&client->dev);
 	if (!haptics->input_dev) {
diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio=
-beeper.c
index 4817c5f0c3e4..16272fffeb7e 100644
--- a/drivers/input/misc/gpio-beeper.c
+++ b/drivers/input/misc/gpio-beeper.c
@@ -66,13 +66,12 @@ static int gpio_beeper_probe(struct platform_device=
 *pdev)
 {
 	struct gpio_beeper *beep;
 	struct input_dev *input;
-	int err;
=20
 	beep =3D devm_kzalloc(&pdev->dev, sizeof(*beep), GFP_KERNEL);
 	if (!beep)
 		return -ENOMEM;
=20
-	beep->desc =3D devm_gpiod_get(&pdev->dev, NULL);
+	beep->desc =3D devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
 	if (IS_ERR(beep->desc))
 		return PTR_ERR(beep->desc);
=20
@@ -92,10 +91,6 @@ static int gpio_beeper_probe(struct platform_device =
*pdev)
=20
 	input_set_capability(input, EV_SND, SND_BELL);
=20
-	err =3D gpiod_direction_output(beep->desc, 0);
-	if (err)
-		return err;
-
 	input_set_drvdata(input, beep);
=20
 	return input_register_device(input);
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
