From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 4/4] input: edt-ft5x06: Remove EV_SYN event report
Date: Thu, 13 Nov 2014 15:06:58 +0100
Message-ID: <1415887618-29844-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1415887618-29844-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415887618-29844-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: linux-input@vger.kernel.org

input_register_device already sets the EV_SYN event since all devices can
generate them.

Remove the redundant affectation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 3ebc1a7e46c5..a87f0d50f45c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1033,7 +1033,6 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input->id.bustype = BUS_I2C;
 	input->dev.parent = &client->dev;
 
-	__set_bit(EV_SYN, input->evbit);
 	__set_bit(EV_KEY, input->evbit);
 	__set_bit(EV_ABS, input->evbit);
 	__set_bit(BTN_TOUCH, input->keybit);
-- 
2.1.1
