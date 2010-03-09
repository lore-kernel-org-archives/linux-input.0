From: Michael Poole <mdpoole@troilus.org>
Subject: [PATCH 1/1] hid-magicmouse: Fix oops after device removal.
Date: Mon, 08 Mar 2010 19:38:38 -0500
Message-ID: <87aaui2usx.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:56833 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753884Ab0CIAil (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 19:38:41 -0500
Received: by mail-qy0-f175.google.com with SMTP id 5so811659qyk.13
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 16:38:40 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <tissoire@tls.cena.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

>From 57c6af4c2dadcce71566995baa15593103ab33aa Mon Sep 17 00:00:00 2001
From: Michael Poole <mdpoole@troilus.org>
Date: Mon, 8 Mar 2010 19:09:26 -0500
Subject: [PATCH 1/1] hid-magicmouse: Fix oops after device removal.

Ask the HID core not to register an input device for the mouse.
Fix an oops after removing the device, due to leaving the new
input device registered.

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 4a3a94f..2e7d701 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -353,7 +353,7 @@ static int magicmouse_probe(struct hid_device *hdev,
 		goto err_free;
 	}
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_HIDINPUT);
 	if (ret) {
 		dev_err(&hdev->dev, "magicmouse hw start failed\n");
 		goto err_free;
@@ -409,7 +409,10 @@ err_free:
 
 static void magicmouse_remove(struct hid_device *hdev)
 {
+	struct magicmouse_sc *msc;
+	msc = hid_get_drvdata(hdev);
 	hid_hw_stop(hdev);
+	input_unregister_device(msc->input);
 	kfree(hid_get_drvdata(hdev));
 }
 
-- 
1.7.0.2
