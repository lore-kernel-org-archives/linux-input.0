From: Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH] input: atmel_mxt_ts: detect touchpad from devicetree
Date: Wed,  4 Oct 2017 21:35:31 +0200
Message-ID: <20171004193531.9038-1-kernel@esmil.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>
List-Id: linux-input@vger.kernel.org

The Samsung Chromebook Plus (rk3399-gru-kevin) has two of
these controllers. One for the touchscreen and one for
the touchpad. However the touchpad doesn't have any
associated gpio buttons, so it shows up as another
touchscreen.

This patch fixes it by matching the "atmel,atmel_mxt_tp"
compatibility string in the device tree.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/input/touchscreen/atmel_mxt_ts.c   | 8 ++++++--
 include/linux/platform_data/atmel_mxt_ts.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db..4ea06f447d15 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1945,8 +1945,7 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 		input_set_abs_params(input_dev, ABS_PRESSURE, 0, 255, 0, 0);
 	}
 
-	/* If device has buttons we assume it is a touchpad */
-	if (pdata->t19_num_keys) {
+	if (pdata->touchpad) {
 		mxt_set_up_as_touchpad(input_dev, data);
 		mt_flags |= INPUT_MT_POINTER;
 	} else {
@@ -2936,6 +2935,9 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
+	if (of_device_is_compatible(np, "atmel,atmel_mxt_tp"))
+		pdata->touchpad = true;
+
 	if (of_find_property(np, "linux,gpio-keymap", &proplen)) {
 		pdata->t19_num_keys = proplen / sizeof(u32);
 
@@ -2986,6 +2988,7 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
 		.pdata	= {
 			.t19_num_keys	= ARRAY_SIZE(samus_touchpad_buttons),
 			.t19_keymap	= samus_touchpad_buttons,
+			.touchpad	= true,
 		},
 	},
 	{
@@ -3011,6 +3014,7 @@ static struct mxt_acpi_platform_data chromebook_platform_data[] = {
 		.pdata	= {
 			.t19_num_keys	= ARRAY_SIZE(chromebook_tp_buttons),
 			.t19_keymap	= chromebook_tp_buttons,
+			.touchpad	= true,
 		},
 	},
 	{
diff --git a/include/linux/platform_data/atmel_mxt_ts.h b/include/linux/platform_data/atmel_mxt_ts.h
index 695035a8d7fb..acb595bba02d 100644
--- a/include/linux/platform_data/atmel_mxt_ts.h
+++ b/include/linux/platform_data/atmel_mxt_ts.h
@@ -24,6 +24,7 @@ enum mxt_suspend_mode {
 struct mxt_platform_data {
 	unsigned long irqflags;
 	u8 t19_num_keys;
+	u8 touchpad;
 	const unsigned int *t19_keymap;
 	enum mxt_suspend_mode suspend_mode;
 };
-- 
2.14.2
