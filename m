From: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 9/9] input: goodix: use goodix_i2c_write_u8 instead of i2c_master_send
Date: Thu, 28 May 2015 15:47:45 +0300
Message-ID: <1432817265-23891-10-git-send-email-irina.tirdea@intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Use goodix_i2c_write_u8 instead of i2c_master_send to simplify code.

Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/input/touchscreen/goodix.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index a41d17b..0b3e5aa 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -226,16 +226,11 @@ static void goodix_process_events(struct goodix_ts_data *ts)
  */
 static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 {
-	static const u8 end_cmd[] = {
-		GOODIX_READ_COOR_ADDR >> 8,
-		GOODIX_READ_COOR_ADDR & 0xff,
-		0
-	};
 	struct goodix_ts_data *ts = dev_id;
 
 	goodix_process_events(ts);
 
-	if (i2c_master_send(ts->client, end_cmd, sizeof(end_cmd)) < 0)
+	if (goodix_i2c_write_u8(ts->client, GOODIX_READ_COOR_ADDR, 0) < 0)
 		dev_err(&ts->client->dev, "I2C write end_cmd error\n");
 
 	return IRQ_HANDLED;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
