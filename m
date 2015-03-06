From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] RFT: HID: i2c-hid: Fix suspend/resume when already runtime suspended
Date: Fri,  6 Mar 2015 15:41:00 -0800
Message-ID: <1425685260-30128-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, mika.westerberg@linux.intel.com, borneo.antonio@gmail.com, jmaneyrol@invensense.com, archana.patni@linux.intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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
NOTE: this patch was developed and tested on a 3.14 kernel (with some
backports) where the driver is a bit different.  I unfortunately
don't have a good way to test this on an upstream kernel, so hopefully
someone out there can confirm that the problem still exists and that
this patch looks reasonable.

This patch does change the order slightly: namely
hid->driver->suspend() is called later in the suspend sequence.
Hopefully that's OK.

 drivers/hid/i2c-hid/i2c-hid.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index ab4dd95..8943ac0 100644
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
@@ -1110,6 +1113,10 @@ static int i2c_hid_resume(struct device *dev)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid = ihid->hid;
 
+	/* We'll resume to full power */
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+
 	enable_irq(ihid->irq);
 	ret = i2c_hid_hwreset(client);
 	if (ret)
@@ -1123,6 +1130,8 @@ static int i2c_hid_resume(struct device *dev)
 		return ret;
 	}
 
+	pm_runtime_enable(dev);
+
 	return 0;
 }
 #endif
-- 
2.2.0.rc0.207.ga3a616c
