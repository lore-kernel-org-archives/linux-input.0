From: Michael Poole <mdpoole@troilus.org>
Subject: [PATCH v2] hid-magicmouse: Fix oops after device removal.
Date: Tue, 09 Mar 2010 06:47:35 -0500
Message-ID: <87iq951zu0.fsf_-_@troilus.org>
References: <87aaui2usx.fsf@troilus.org>
	<20100309074820.GD17288@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42643 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754460Ab0CILrj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 06:47:39 -0500
Received: by qyk40 with SMTP id 40so3676914qyk.23
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 03:47:38 -0800 (PST)
In-Reply-To: <20100309074820.GD17288@core.coreip.homeip.net> (Dmitry
	Torokhov's message of "Mon, 8 Mar 2010 23:48:20 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <tissoire@tls.cena.fr>, Stephane Chatty <chatty@enac.fr>

>From 7466c15f196621c44b01e3e1f8abd61099e48989 Mon Sep 17 00:00:00 2001
From: Michael Poole <mdpoole@troilus.org>
Date: Tue, 9 Mar 2010 06:46:09 -0500
Subject: [PATCH v2] hid-magicmouse: Fix oops after device removal.

Ask the HID core not to register an input device for the mouse.
Fix an oops after removing the device, due to leaving the new
input device registered.

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 4a3a94f..c174b64 100644
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
@@ -409,8 +409,11 @@ err_free:
 
 static void magicmouse_remove(struct hid_device *hdev)
 {
+	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
 	hid_hw_stop(hdev);
-	kfree(hid_get_drvdata(hdev));
+	input_unregister_device(msc->input);
+	kfree(msc);
 }
 
 static const struct hid_device_id magic_mice[] = {
-- 
1.7.0.2

