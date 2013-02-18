From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: [PATCH 2/3] HID: Fix logitech-dj: Allow incoming packets during probe().
Date: Mon, 18 Feb 2013 09:20:22 -0800
Message-ID: <1361208023-11500-3-git-send-email-andrew-vger@gizmolabs.org>
References: <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz>
 <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:65434 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab3BRRUg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 12:20:36 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so1769447pbc.9
        for <linux-input@vger.kernel.org>; Mon, 18 Feb 2013 09:20:35 -0800 (PST)
In-Reply-To: <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Andrew de los Reyes <adlr@chromium.org>

From: Andrew de los Reyes <adlr@chromium.org>

Historically, logitech-dj communicated with the device during probe()
to query the list of devices attached. Later, a change was introduced
to hid-core that prevented incoming packets for a device during
probe(), as many drivers are unable to handle such input. That change
broke the device enumeration in logitech-dj, so commit
596264082f10dd4a56 was introduced to workaround that by waiting for
normal input before enumerating devices.

Now that drivers can opt-in to receive input during probe, this patch
changes logitech-dj to do that, so that it can successfully complete
enumeration of devices during probe().

Signed-off-by: Andrew de los Reyes <adlr@chromium.org>

Change-Id: I2dca10a5c64f6c3e90ffb00547b47eaf94546eb6
---
 drivers/hid/hid-logitech-dj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 9500f2f..bf647ef 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -803,6 +803,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 		goto llopen_failed;
 	}
 
+	/* Allow incoming packets to arrive: */
+	hid_device_io_start(hdev);
+
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
 	if (retval < 0) {
 		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
-- 
1.8.1.3

