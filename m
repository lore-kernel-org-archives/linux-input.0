From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] HID: i2c-hid: Call device suspend callback before disabling irq
Date: Tue,  7 Jul 2015 21:58:02 +0200
Message-ID: <1436299082-3526-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34172 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbbGGT6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2015 15:58:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: benjamin.tissoires@redhat.com, aduggan@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>

The irq is most likely required by the suspend callback, so disable it
only after the callback had been executed.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index f77469d..9ed69b5 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1092,13 +1092,13 @@ static int i2c_hid_suspend(struct device *dev)
 	struct hid_device *hid = ihid->hid;
 	int ret = 0;
 
+	if (hid->driver && hid->driver->suspend)
+		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
+
 	disable_irq(ihid->irq);
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(ihid->irq);
 
-	if (hid->driver && hid->driver->suspend)
-		ret = hid->driver->suspend(hid, PMSG_SUSPEND);
-
 	/* Save some power */
 	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
 
-- 
2.1.4

