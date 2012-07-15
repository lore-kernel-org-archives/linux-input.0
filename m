From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 2/3] HID: picolcd: explicitly claim hid devices with HID_CLAIMED_OTHER
Date: Sun, 15 Jul 2012 20:21:48 +0200
Message-ID: <1342376509-7228-3-git-send-email-dh.herrmann@googlemail.com>
References: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37971 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2GOSWS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jul 2012 14:22:18 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so309295wgb.1
        for <linux-input@vger.kernel.org>; Sun, 15 Jul 2012 11:22:17 -0700 (PDT)
In-Reply-To: <1342376509-7228-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Instead of using an ugly workaround to make hid_hw_start() correctly
initialize the device, we now explicitely set HID_CLAIMED_OTHER before
initializing the hid device. This tells the hid-core to accept the device
even if no generic hid driver gets loaded.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-picolcd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 45c3433..36a11a8 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -2613,11 +2613,10 @@ static int picolcd_probe(struct hid_device *hdev,
 		goto err_cleanup_data;
 	}
 
-	/* We don't use hidinput but hid_hw_start() fails if nothing is
-	 * claimed. So spoof claimed input. */
-	hdev->claimed = HID_CLAIMED_INPUT;
+	/* Tell hid-core that we handle the device without the need of any
+	 * generic hid-driver by setting the HID_CLAIMED_OTHER flag. */
+	hdev->claimed |= HID_CLAIMED_OTHER;
 	error = hid_hw_start(hdev, 0);
-	hdev->claimed = 0;
 	if (error) {
 		hid_err(hdev, "hardware start failed\n");
 		goto err_cleanup_data;
-- 
1.7.11.2

