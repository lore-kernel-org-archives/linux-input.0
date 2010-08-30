From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 1/6] HID: magicmouse: don't allow hidinput to initialize
Date: Mon, 30 Aug 2010 13:20:53 -0400
Message-ID: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:57639 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756022Ab0H3RVC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 13:21:02 -0400
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1Oq82W-00070M-2w
	for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 18:21:00 +0100
Received: from cpe-75-180-27-10.columbus.res.rr.com ([75.180.27.10] helo=canonical.com)
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <chase.douglas@canonical.com>)
	id 1Oq82V-0006Dd-QF
	for linux-input@vger.kernel.org; Mon, 30 Aug 2010 18:21:00 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

From: Chase Douglas <chase.douglas@ubuntu.com>

The driver listens only for raw events from the device. If we allow
the hidinput layer to initialize, we can hit NULL pointer dereferences
in the hidinput layer because disconnecting only removes the input
devices from the hid device while leaving the hid fields around.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index ee78787..2d8532d 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -404,15 +404,13 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	/* we are handling the input ourselves */
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW | HID_CONNECT_HIDDEV);
 	if (ret) {
 		dev_err(&hdev->dev, "magicmouse hw start failed\n");
 		goto err_free;
 	}
 
-	/* we are handling the input ourselves */
-	hidinput_disconnect(hdev);
-
 	report = hid_register_report(hdev, HID_INPUT_REPORT, TOUCH_REPORT_ID);
 	if (!report) {
 		dev_err(&hdev->dev, "unable to register touch report\n");
-- 
1.7.1

