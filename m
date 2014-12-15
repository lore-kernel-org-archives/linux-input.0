From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/2] Input: atmel_mxt_ts - Split out touchpad initialisation logic
Date: Mon, 15 Dec 2014 11:39:07 +0100
Message-ID: <1418639947-28765-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:37522 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLOKjb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2014 05:39:31 -0500
In-Reply-To: <1418639947-28765-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Nick Dyer <nick.dyer@itdev.co.uk>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

If the "linux,gpio-keymap" DT property is defined, the T19 keys are configured
and the device is setup as a touchpad rather than a touchscreen. The logic is
part of the input device initialization routine but it can be factored out to
its own function to simplify the former.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
[javier: Adapt to latest driver changes and modify commit message accordingly]
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 48 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index aaa9e07..01fda60 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1756,15 +1756,40 @@ static int mxt_read_t100_config(struct mxt_data *data)
 static int mxt_input_open(struct input_dev *dev);
 static void mxt_input_close(struct input_dev *dev);
 
+static bool mxt_initialize_t19(struct input_dev *input_dev,
+			       struct mxt_data *data)
+{
+	const struct mxt_platform_data *pdata = data->pdata;
+	int i;
+
+	if (pdata->t19_num_keys) {
+		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
+
+		for (i = 0; i < pdata->t19_num_keys; i++)
+			if (pdata->t19_keymap[i] != KEY_RESERVED)
+				input_set_capability(input_dev, EV_KEY,
+						     pdata->t19_keymap[i]);
+
+		input_abs_set_res(input_dev, ABS_X, MXT_PIXELS_PER_MM);
+		input_abs_set_res(input_dev, ABS_Y, MXT_PIXELS_PER_MM);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_X,
+				  MXT_PIXELS_PER_MM);
+		input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
+				  MXT_PIXELS_PER_MM);
+
+		input_dev->name = "Atmel maXTouch Touchpad";
+		return true;
+	}
+	return false;
+}
+
 static int mxt_initialize_input_device(struct mxt_data *data, int multitouch)
 {
 	struct device *dev = &data->client->dev;
-	const struct mxt_platform_data *pdata = data->pdata;
 	struct input_dev *input_dev;
 	int error;
 	unsigned int num_mt_slots;
 	unsigned int mt_flags = 0;
-	int i;
 
 	switch (multitouch) {
 	case MXT_TOUCH_MULTI_T9:
@@ -1800,26 +1825,9 @@ static int mxt_initialize_input_device(struct mxt_data *data, int multitouch)
 	set_bit(EV_ABS, input_dev->evbit);
 	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
-	if (pdata->t19_num_keys) {
-		__set_bit(INPUT_PROP_BUTTONPAD, input_dev->propbit);
-
-		for (i = 0; i < pdata->t19_num_keys; i++)
-			if (pdata->t19_keymap[i] != KEY_RESERVED)
-				input_set_capability(input_dev, EV_KEY,
-						     pdata->t19_keymap[i]);
-
+	if (mxt_initialize_t19(input_dev, data))
 		mt_flags |= INPUT_MT_POINTER;
 
-		input_abs_set_res(input_dev, ABS_X, MXT_PIXELS_PER_MM);
-		input_abs_set_res(input_dev, ABS_Y, MXT_PIXELS_PER_MM);
-		input_abs_set_res(input_dev, ABS_MT_POSITION_X,
-				  MXT_PIXELS_PER_MM);
-		input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
-				  MXT_PIXELS_PER_MM);
-
-		input_dev->name = "Atmel maXTouch Touchpad";
-	}
-
 	/* For single touch */
 	input_set_abs_params(input_dev, ABS_X,
 			     0, data->max_x, 0, 0);
-- 
2.1.3

