From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v3] HID: Allow drivers to be their own listener
Date: Fri, 20 Jul 2012 11:49:09 +0200
Message-ID: <1342777749-31457-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36748 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab2GTJtC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 05:49:02 -0400
Received: by wibhq12 with SMTP id hq12so357012wib.1
        for <linux-input@vger.kernel.org>; Fri, 20 Jul 2012 02:49:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, rydberg@euromail.se, David Herrmann <dh.herrmann@googlemail.com>

hid-picolcd and hid-wiimote do not allow any of hidinput, hiddev or hidraw
to claim the device but still want to remain on the bus. Hence, if a
driver uses the raw_event callback but no other listener claimed the
device, we still leave it on the bus as the driver handles everything by
itself. It thus becomes its own listener.

Under some circumstances (eg., hidinput_connect() fails and raw_event set)
a device may be left on the bus even though it requires external
listeners. But then if hidinput_connect() fails there are bigger issues
than a device that is left unhandled. So we can safely use this heuristic
to avoid adding another flag for special devices like hid-picolcd and
hid-wiimote.

This also removes the ugly hack from hid-picolcd as this is no longer
required.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
Sorry for the delay. I had two exams this week that got into my way. Anyway, I
hope this time the patch looks ok.

Thanks to Henrik for reviewing it the previous times.

 drivers/hid/hid-core.c    | 6 ++++--
 drivers/hid/hid-picolcd.c | 4 ----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9cdc74e..925774a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1373,8 +1373,10 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
 		hdev->claimed |= HID_CLAIMED_HIDRAW;
 
-	if (!hdev->claimed) {
-		hid_err(hdev, "claimed by neither input, hiddev nor hidraw\n");
+	/* Drivers with the ->raw_event callback set are not required to connect
+	 * to any other listener. */
+	if (!hdev->claimed && !hdev->driver->raw_event) {
+		hid_err(hdev, "device has no listeners, quitting\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 45c3433..74c388d 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -2613,11 +2613,7 @@ static int picolcd_probe(struct hid_device *hdev,
 		goto err_cleanup_data;
 	}
 
-	/* We don't use hidinput but hid_hw_start() fails if nothing is
-	 * claimed. So spoof claimed input. */
-	hdev->claimed = HID_CLAIMED_INPUT;
 	error = hid_hw_start(hdev, 0);
-	hdev->claimed = 0;
 	if (error) {
 		hid_err(hdev, "hardware start failed\n");
 		goto err_cleanup_data;
-- 
1.7.11.2

