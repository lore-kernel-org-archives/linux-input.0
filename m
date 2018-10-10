From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v2] Input: elants_i2c - Use DMA safe i2c when possible
Date: Wed, 10 Oct 2018 13:00:17 -0700
Message-ID: <20181010200017.255874-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-input@vger.kernel.org

This irq handler is always reading bytes from the device into a
kmalloced buffer, so it's safe to mark this transaction as DMA safe.
This avoids bouncing the buffer when an i2c controller decides to use
DMA for a transaction.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Moved buf to end of structure to keep it cacheline aligned and DMA
   safe

 drivers/input/touchscreen/elants_i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..f2cb23121833 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -147,10 +147,11 @@ struct elants_data {
 	u8 cmd_resp[HEADER_SIZE];
 	struct completion cmd_done;
 
-	u8 buf[MAX_PACKET_SIZE];
-
 	bool wake_irq_enabled;
 	bool keep_power_in_suspend;
+
+	/* Must be last to be used for DMA operations */
+	u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
 };
 
 static int elants_i2c_send(struct i2c_client *client,
@@ -863,7 +864,7 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
 	int i;
 	int len;
 
-	len = i2c_master_recv(client, ts->buf, sizeof(ts->buf));
+	len = i2c_master_recv_dmasafe(client, ts->buf, sizeof(ts->buf));
 	if (len < 0) {
 		dev_err(&client->dev, "%s: failed to read data: %d\n",
 			__func__, len);
-- 
Sent by a computer through tubes
