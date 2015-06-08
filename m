From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/8] input: goodix: fix alignment issues
Date: Mon,  8 Jun 2015 17:37:46 +0300
Message-ID: <1433774273-23103-2-git-send-email-irina.tirdea@intel.com>
References: <1433774273-23103-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433774273-23103-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Fix alignment to match open parenthesis detected by
running checkpatch.pl --strict.

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Acked-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 0d93b1e..a65e4d9 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -69,7 +69,7 @@ static const unsigned long goodix_irq_flags[] = {
  * @len: length of the buffer to write
  */
 static int goodix_i2c_read(struct i2c_client *client,
-				u16 reg, u8 *buf, int len)
+			   u16 reg, u8 *buf, int len)
 {
 	struct i2c_msg msgs[2];
 	u16 wbuf = cpu_to_be16(reg);
@@ -78,7 +78,7 @@ static int goodix_i2c_read(struct i2c_client *client,
 	msgs[0].flags = 0;
 	msgs[0].addr  = client->addr;
 	msgs[0].len   = 2;
-	msgs[0].buf   = (u8 *) &wbuf;
+	msgs[0].buf   = (u8 *)&wbuf;
 
 	msgs[1].flags = I2C_M_RD;
 	msgs[1].addr  = client->addr;
@@ -199,8 +199,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	int error;
 
 	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
-			      config,
-			   GOODIX_CONFIG_MAX_LENGTH);
+				config,
+				GOODIX_CONFIG_MAX_LENGTH);
 	if (error) {
 		dev_warn(&ts->client->dev,
 			 "Error reading config (%d), using defaults\n",
@@ -297,9 +297,9 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 				  BIT_MASK(EV_ABS);
 
 	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
-				ts->abs_x_max, 0, 0);
+			     ts->abs_x_max, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
-				ts->abs_y_max, 0, 0);
+			     ts->abs_y_max, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
