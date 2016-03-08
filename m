From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3] HID: i2c-hid: Fix suspend/resume when already runtime
 suspended
Date: Tue, 8 Mar 2016 15:03:23 -0800
Message-ID: <20160308230323.GA4382@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35034 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbcCHXD1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2016 18:03:27 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, Benson Leung <bleung@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On ACPI-based systems ACPI power domain code runtime resumes device before
calling suspend method, which ensures that i2c-hid suspend code starts with
device not in low-power state and with interrupts enabled.

On other systems, especially if device is not a part of any power domain,
we may end up calling driver's system-level suspend routine while the
device is runtime-suspended (with controller in presumably low power state
and interrupts disabled). This will result in interrupts being essentially
disabled twice, and we will only re-enable them after both system resume
and runtime resume methods complete. Unfortunately i2c_hid_resume() calls
i2c_hid_hwreset() and that only works properly if interrupts are enabled.

Also if device is runtime-suspended driver's suspend code may fail if it
tries to issue I/O requests.

Let's fix it by runtime-resuming the device if we need to run HID driver's
suspend code and also disabling interrupts only if device is not already
runtime-suspended. Also on resume we mark the device as running at full
power (since that is what resetting will do to it).

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---

This is an uprev of a patch that Doug sent a year ago (see
https://patchwork.kernel.org/patch/5970731/), adjusted to the latest
mainline. The change from v2 is that we runtime-resume the device before
calling into HID driver's suspend callback.


 drivers/hid/i2c-hid/i2c-hid.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b921693..1f62751 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1108,13 +1108,30 @@ static int i2c_hid_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
-	int ret = 0;
+	int ret;
 	int wake_status;
 
-	if (hid->driver && hid->driver->suspend)
+	if (hid->driver && hid->driver->suspend) {
+		/*
+		 * Wake up the device so that IO issues in
+		 * HID driver's suspend code can succeed.
+		 */
+		ret = pm_runtime_resume(dev);
+		if (ret < 0)
+			return ret;
+
 		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!pm_runtime_suspended(dev)) {
+		/* Save some power */
+		i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+
+		disable_irq(ihid->irq);
+	}
 
-	disable_irq(ihid->irq);
 	if (device_may_wakeup(&client->dev)) {
 		wake_status = enable_irq_wake(ihid->irq);
 		if (!wake_status)
@@ -1124,10 +1141,7 @@ static int i2c_hid_suspend(struct device *dev)
 				wake_status);
 	}
 
-	/* Save some power */
-	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
-
-	return ret;
+	return 0;
 }
 
 static int i2c_hid_resume(struct device *dev)
@@ -1138,11 +1152,6 @@ static int i2c_hid_resume(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int wake_status;
 
-	enable_irq(ihid->irq);
-	ret = i2c_hid_hwreset(client);
-	if (ret)
-		return ret;
-
 	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
 		wake_status = disable_irq_wake(ihid->irq);
 		if (!wake_status)
@@ -1152,6 +1161,16 @@ static int i2c_hid_resume(struct device *dev)
 				wake_status);
 	}
 
+	/* We'll resume to full power */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	enable_irq(ihid->irq);
+	ret = i2c_hid_hwreset(client);
+	if (ret)
+		return ret;
+
 	if (hid->driver && hid->driver->reset_resume) {
 		ret = hid->driver->reset_resume(hid);
 		return ret;
-- 
2.7.0.rc3.207.g0ac5344


-- 
Dmitry
