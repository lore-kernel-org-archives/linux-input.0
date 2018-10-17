From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 7/8] Input: sx8654 - use common of_touchscreen functions
Date: Wed, 17 Oct 2018 14:51:15 +0200
Message-ID: <20181017125116.20077-8-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

of_touchscreen.c provides a common interface for a axis invertion and
swapping of touchscreens. Therefore use it in the sx8654 driver.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/input/touchscreen/sx8654.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/sx8654.c b/drivers/input/touchscreen/sx8654.c
index 4939863efbef..b7b263ed52af 100644
--- a/drivers/input/touchscreen/sx8654.c
+++ b/drivers/input/touchscreen/sx8654.c
@@ -35,6 +35,7 @@
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/input/touchscreen.h>
 
 /* register addresses */
 #define I2C_REG_TOUCH0			0x00
@@ -101,6 +102,7 @@ struct sx8654 {
 
 	spinlock_t		lock; /* for input reporting from irq/timer */
 	struct timer_list	timer;
+	struct touchscreen_properties props;
 
 	const struct sx865x_data *data;
 };
@@ -178,8 +180,7 @@ static irqreturn_t sx8650_irq(int irq, void *handle)
 				 chdata);
 	}
 
-	input_report_abs(ts->input, ABS_X, x);
-	input_report_abs(ts->input, ABS_Y, y);
+	touchscreen_report_pos(ts->input, &ts->props, x, y, false);
 	input_report_key(ts->input, BTN_TOUCH, 1);
 	input_sync(ts->input);
 	dev_dbg(dev, "point(%4d,%4d)\n", x, y);
@@ -226,8 +227,8 @@ static irqreturn_t sx8654_irq(int irq, void *handle)
 		x = ((data[0] & 0xf) << 8) | (data[1]);
 		y = ((data[2] & 0xf) << 8) | (data[3]);
 
-		input_report_abs(sx8654->input, ABS_X, x);
-		input_report_abs(sx8654->input, ABS_Y, y);
+		touchscreen_report_pos(sx8654->input, &sx8654->props, x, y,
+				       false);
 		input_report_key(sx8654->input, BTN_TOUCH, 1);
 		input_sync(sx8654->input);
 
@@ -377,6 +378,8 @@ static int sx8654_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_X, 0, MAX_12BIT, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, MAX_12BIT, 0, 0);
 
+	touchscreen_parse_properties(input, false, &sx8654->props);
+
 	sx8654->client = client;
 	sx8654->input = input;
 
-- 
2.11.0
