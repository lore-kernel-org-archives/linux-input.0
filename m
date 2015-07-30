From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v2] HID: i2c-hid: Only disable irq wake if it was successfully enabled during suspend
Date: Thu, 30 Jul 2015 14:49:00 -0700
Message-ID: <1438292940-26711-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:60897 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751906AbbG3VtI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 17:49:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Enabling irq wake could potentially fail and calling disable_irq_wake
after a failed call to enable_irq_wake could result in an unbalanced irq
warning. This patch warns if enable_irq_wake fails and avoids other
potential issues caused by calling disable_irq_wake on resume after
enable_irq_wake failed during suspend.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
This patch is based on Jiri's for-4.3/i2c-hid and needs Gabriele Mazzotta's
patch which moves where the HID driver's suspend callback call to apply
cleanly.

 drivers/hid/i2c-hid/i2c-hid.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 9ed69b5..2871f3c 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -149,6 +149,8 @@ struct i2c_hid {
 	int			irq;
 
 	struct i2c_hid_platform_data pdata;
+
+	bool			irq_wake_enabled;
 };
 
 static int __i2c_hid_command(struct i2c_client *client,
@@ -1091,13 +1093,20 @@ static int i2c_hid_suspend(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 	int ret = 0;
+	int wake_status;
 
 	if (hid->driver && hid->driver->suspend)
 		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
 
 	disable_irq(ihid->irq);
-	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(ihid->irq);
+	if (device_may_wakeup(&client->dev)) {
+		wake_status = enable_irq_wake(ihid->irq);
+		if (!wake_status)
+			ihid->irq_wake_enabled = true;
+		else
+			hid_warn(hid, "Failed to enable irq wake: %d\n",
+				wake_status);
+	}
 
 	/* Save some power */
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
@@ -1111,14 +1120,21 @@ static int i2c_hid_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
+	int wake_status;
 
 	enable_irq(ihid->irq);
 	ret = i2c_hid_hwreset(client);
 	if (ret)
 		return ret;
 
-	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(ihid->irq);
+	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
+		wake_status = disable_irq_wake(ihid->irq);
+		if (!wake_status)
+			ihid->irq_wake_enabled = false;
+		else
+			hid_warn(hid, "Failed to disable irq wake: %d\n",
+				wake_status);
+	}
 
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
-- 
2.1.4

