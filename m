From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 05/11] Input: synaptics-rmi4 - f03: grab data passed by transport device
Date: Thu, 18 Aug 2016 11:24:43 +0200
Message-ID: <1471512289-10648-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471512289-10648-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lyude Paul <thatslyude@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

First check if there are data available passed by the transport device.
If data available use these data. If there are no data available
try to read the rmi block if dsata are passed this way.

This is the way the other rmi function handlers will do this.
That why apply this to f03 as well.

This will fix corrupted or missing data issues.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_f03.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 9945512..daae1c95 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -158,6 +158,7 @@ static int rmi_f03_config(struct rmi_function *fn)
 
 static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
 {
+	struct rmi_device *rmi_dev = fn->rmi_dev;
 	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
 	u16 data_addr = fn->fd.data_base_addr;
 	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
@@ -166,16 +167,32 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	u8 ob_data;
 	unsigned int serio_flags;
 	int i;
-	int retval;
-
-	/* Grab all of the data registers, and check them for data */
-	retval = rmi_read_block(fn->rmi_dev, data_addr + RMI_F03_OB_OFFSET,
-				&obs, ob_len);
-	if (retval) {
-		dev_err(&fn->dev, "%s: Failed to read F03 output buffers.\n",
-			__func__);
-		serio_interrupt(f03->serio, 0, SERIO_TIMEOUT);
-		return retval;
+	int ret;
+
+	if (!rmi_dev || !rmi_dev->xport)
+		return -ENODEV;
+
+	if (rmi_dev->xport->attn_data) {
+		/* First grab the data passed by the transport device */
+		if (rmi_dev->xport->attn_size < ob_len) {
+			dev_warn(&fn->dev, "F03 interrupted, but data is missing!\n");
+			return 0;
+		}
+
+		memcpy(obs, rmi_dev->xport->attn_data, ob_len);
+
+		rmi_dev->xport->attn_data += ob_len;
+		rmi_dev->xport->attn_size -= ob_len;
+	} else {
+		/* Grab all of the data registers, and check them for data */
+		ret = rmi_read_block(fn->rmi_dev, data_addr + RMI_F03_OB_OFFSET,
+				     &obs, ob_len);
+		if (ret) {
+			dev_err(&fn->dev, "%s: Failed to read F03 output buffers.\n",
+				__func__);
+			serio_interrupt(f03->serio, 0, SERIO_TIMEOUT);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < ob_len; i += RMI_F03_OB_SIZE) {
-- 
2.5.5
