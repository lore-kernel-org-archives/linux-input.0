From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 2/3] input: as5011: avoid using __set_bit() for capabilities
Date: Sat, 31 Mar 2018 13:21:41 +0200
Message-ID: <20180331112143.18768-2-marcus.folkesson@gmail.com>
References: <20180331112143.18768-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180331112143.18768-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

input_set_capability() and input_set_abs_param() will do it for you.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/as5011.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 005d852a06e9..f051993c568e 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -269,9 +269,7 @@ static int as5011_probe(struct i2c_client *client,
 	input_dev->id.bustype = BUS_I2C;
 	input_dev->dev.parent = &client->dev;
 
-	__set_bit(EV_KEY, input_dev->evbit);
-	__set_bit(EV_ABS, input_dev->evbit);
-	__set_bit(BTN_JOYSTICK, input_dev->keybit);
+	input_set_capability(input_dev, EV_KEY, BTN_JOYSTICK);
 
 	input_set_abs_params(input_dev, ABS_X,
 		AS5011_MIN_AXIS, AS5011_MAX_AXIS, AS5011_FUZZ, AS5011_FLAT);
-- 
2.16.2
