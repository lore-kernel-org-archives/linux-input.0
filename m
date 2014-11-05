From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 3/3] input: ft5x06: Allow to set the maximum axes value through the DT
Date: Wed,  5 Nov 2014 16:07:50 +0100
Message-ID: <1415200070-19346-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1415200070-19346-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415200070-19346-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-input@vger.kernel.org

Currently the driver relies on some obscure and undocumented register to set
the maximum axis value.

The reported value is way too high to be meaningful, which confuses some
userspace tools like QT's evdevtouch plugin which try to scale the reported
events to the maximum values.

Use the values from the DT to set meaningful values.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ee3434f1e949..3ebc1a7e46c5 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -37,6 +37,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/input/edt-ft5x06.h>
 
 #define MAX_SUPPORT_POINTS		5
@@ -1042,6 +1043,10 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 			     0, tsdata->num_x * 64 - 1, 0, 0);
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
+
+	if (!pdata)
+		touchscreen_parse_of_params(input);
+
 	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, 0);
 	if (error) {
 		dev_err(&client->dev, "Unable to init MT slots.\n");
-- 
2.1.1
