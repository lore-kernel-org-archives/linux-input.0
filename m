From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: st1232: set INPUT_PROP_DIRECT property
Date: Fri,  5 Oct 2018 10:14:07 +0200
Message-ID: <20181005081407.15376-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, geert+renesas@glider.be
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

This is how userspace checks for touchscreen devices most reliably.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/touchscreen/st1232.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d5dfa4053bbf..b71673911aac 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -195,6 +195,7 @@ static int st1232_ts_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
+	__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
 	__set_bit(EV_SYN, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(EV_ABS, input_dev->evbit);
-- 
2.19.0
