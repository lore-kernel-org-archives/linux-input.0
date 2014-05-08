From: Archana Patni <archana.patni@linux.intel.com>
Subject: [PATCH] HID: i2c-hid: Support batch read of input events from fifo
Date: Thu,  8 May 2014 09:32:09 -0400
Message-ID: <1399555929-10870-1-git-send-email-archana.patni@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21348 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbaEHIYe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 May 2014 04:24:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: jic23@kernel.org, linux-input@vger.kernel.org, mika.westerberg@intel.com, srinivas.pandruvada@intel.com, Archana Patni <archana.patni@linux.intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

Some i2c_hid devices like a sensor hub have built-in fifos which
can accumulate input events in their buffers and trigger an interrupt
at end of a user defined event like fifo full or a timeout. The current
implementation reads one event at a time in the IRQ handler leading to
several hundred interrupts being necessary to flush the fifo.

This patch changes the threaded IRQ handler to keep input events until
there are no input events left to read. In the normal case, this will
invoke one additional call to fetch an input event to check for no pending
events and terminate the loop.

Signed-off-by: Archana Patni <archana.patni@intel.com>
Signed-off-by: Subramony Sesha <subramony.sesha@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/hid/i2c-hid/i2c-hid.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 21aafc8..3f09a50 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -52,6 +52,7 @@
 static bool debug;
 module_param(debug, bool, 0444);
 MODULE_PARM_DESC(debug, "print a lot of debug information");
+#define MAX_INPUT_EVENT_READ 100
 
 #define i2c_hid_dbg(ihid, fmt, arg...)					  \
 do {									  \
@@ -366,7 +367,7 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 	return 0;
 }
 
-static void i2c_hid_get_input(struct i2c_hid *ihid)
+static int i2c_hid_get_input(struct i2c_hid *ihid)
 {
 	int ret, ret_size;
 	int size = le16_to_cpu(ihid->hdesc.wMaxInputLength);
@@ -374,11 +375,11 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 	ret = i2c_master_recv(ihid->client, ihid->inbuf, size);
 	if (ret != size) {
 		if (ret < 0)
-			return;
+			return ret;
 
 		dev_err(&ihid->client->dev, "%s: got %d data instead of %d\n",
 			__func__, ret, size);
-		return;
+		return -EIO;
 	}
 
 	ret_size = ihid->inbuf[0] | ihid->inbuf[1] << 8;
@@ -387,13 +388,13 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		/* host or device initiated RESET completed */
 		if (test_and_clear_bit(I2C_HID_RESET_PENDING, &ihid->flags))
 			wake_up(&ihid->wait);
-		return;
+		return 0;
 	}
 
 	if (ret_size > size) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
-		return;
+		return -EIO;
 	}
 
 	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
@@ -402,17 +403,22 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
 				ret_size - 2, 1);
 
-	return;
+	return 1;
 }
 
 static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
 {
 	struct i2c_hid *ihid = dev_id;
+	int ret;
+	int count = 0;
 
 	if (test_bit(I2C_HID_READ_PENDING, &ihid->flags))
 		return IRQ_HANDLED;
+	do {
+		count++;
+		ret = i2c_hid_get_input(ihid);
 
-	i2c_hid_get_input(ihid);
+	} while (count < MAX_INPUT_EVENT_READ && ret > 0);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.9.5

