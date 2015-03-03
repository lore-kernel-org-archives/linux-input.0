From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 4/4] input: edt-ft5x06: Remove EV_SYN event report
Date: Tue,  3 Mar 2015 14:50:46 +0100
Message-ID: <1425390646-31196-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-input@vger.kernel.org

input_register_device already sets the EV_SYN event since all devices can
generate them.

Remove the redundant affectation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index cd8a7472266b..e6aef3e48bd9 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1035,7 +1035,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 
-	__set_bit(EV_SYN, input->evbit);
 	__set_bit(EV_KEY, input->evbit);
 	__set_bit(EV_ABS, input->evbit);
 	__set_bit(BTN_TOUCH, input->keybit);
-- 
2.3.0
