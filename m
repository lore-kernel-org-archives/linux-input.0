From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v2] HID: i2c-hid: Fix suspend/resume when already runtime suspended
Date: Mon,  9 Mar 2015 12:44:47 -0700
Message-ID: <1425930287-4615-1-git-send-email-dianders@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36751 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbCITpB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 15:45:01 -0400
Received: by igkb16 with SMTP id b16so24255544igk.1
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2015 12:45:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, jmaneyrol@invensense.com, borneo.antonio@gmail.com, seth.forshee@canonical.com, archana.patni@linux.intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

If the i2c-hid device was runtime suspended and then the system
suspended itself we'd end up disabling interrupts twice (in
i2c_hid_runtime_suspend and i2c_hid_suspend) and not reenabling them
until later when the i2c-hid device was runtime resumed.
Unfortunately the i2c_hid_resume() calls i2c_hid_hwreset() and that
only works properly if interrupts are enabled.

We can fix this by taking the advice from "runtime_pm.txt".
Specifically we'll change i2c-hid to always resume to full power.
This only works if our parents are also resumed to full power, but
given the suggestion in "runtime_pm.txt" this seems a reasonable
assumption.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Note that this was tested on a 3.14 kernel with backports.  Any
testing that folks can do on ToT is appreciated.

Changes in v2:
- Move pm_runtime_enable() higher in resume

 drivers/hid/i2c-hid/i2c-hid.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ab4dd95..9e013f6 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1090,15 +1090,18 @@ static int i2c_hid_suspend(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int ret = 0;
 
-	disable_irq(ihid->irq);
-	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(ihid->irq);
+	if (!pm_runtime_suspended(dev)) {
+		/* Save some power */
+		i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+
+		disable_irq(ihid->irq);
+	}
 
 	if (hid->driver && hid->driver->suspend)
 		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
 
-	/* Save some power */
-	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(ihid->irq);
 
 	return ret;
 }
@@ -1110,6 +1113,11 @@ static int i2c_hid_resume(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 
+	/* We'll resume to full power */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	enable_irq(ihid->irq);
 	ret = i2c_hid_hwreset(client);
 	if (ret)
-- 
2.2.0.rc0.207.ga3a616c

