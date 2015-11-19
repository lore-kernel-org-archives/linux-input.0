From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v11 5/8] Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_send
Date: Thu, 19 Nov 2015 14:26:38 +0200
Message-ID: <1447936001-21420-6-git-send-email-irina.tirdea@intel.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Use goodix_i2c_write_u8 instead of i2c_master_send to simplify code.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Tested-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 0fd472d..9b7f2ad 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -275,16 +275,11 @@ static void goodix_process_events(struct goodix_ts_data *ts)
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
