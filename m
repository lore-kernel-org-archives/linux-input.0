From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] HID: i2c-hid: Only disable irq wake if it was successfully enabled during suspend
Date: Mon, 27 Jul 2015 17:08:06 -0700
Message-ID: <1438042086-9827-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:32351 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754497AbbG1AIQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 20:08:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On at least one platform the kernel prints a warning on resume saying
"Unbalanced IRQ 37 wake disable". This is because enable_irq_wake in the
suspend function is failing. This patch checks to see if the call to
enable_irq_wake succeeded before calling disable_irq_wake.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
This patch based on Jiri's for-4.3/i2c-hid and needs Gabriele Mazzotta's
patch which moves where the HID driver's suspend callback call to apply
cleanly.

 drivers/hid/i2c-hid/i2c-hid.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 9ed69b5..1605fbe 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -149,6 +149,8 @@ struct i2c_hid {
 	int			irq;
 
 	struct i2c_hid_platform_data pdata;
+
+	bool			irq_wake_enabled;
 };
 
 static int __i2c_hid_command(struct i2c_client *client,
@@ -1096,8 +1098,8 @@ static int i2c_hid_suspend(struct device *dev)
 		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
 
 	disable_irq(ihid->irq);
-	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(ihid->irq);
+	if (device_may_wakeup(&client->dev) && !enable_irq_wake(ihid->irq))
+		ihid->irq_wake_enabled = true;
 
 	/* Save some power */
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
@@ -1117,8 +1119,10 @@ static int i2c_hid_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (device_may_wakeup(&client->dev))
+	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
 		disable_irq_wake(ihid->irq);
+		ihid->irq_wake_enabled = false;
+	}
 
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
-- 
2.1.4

