From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 5/5] hid: huion: Handle tablets with UC-Logic vendor ID
Date: Wed, 23 Jul 2014 15:42:58 +0300
Message-ID: <1406119378-24551-6-git-send-email-spbnick@gmail.com>
References: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:50368 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbaGWMna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 08:43:30 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so1086505wgh.10
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 05:43:25 -0700 (PDT)
In-Reply-To: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Nikolai Kondrashov <spbnick@gmail.com>

Add handling of Huion tablets with UC-Logic vendor ID, but the same
product ID to hid-huion driver. A Huion H580 was seen using it.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
---
 drivers/hid/hid-huion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index e6f5338..1006c2a 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -247,6 +247,7 @@ static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 static const struct hid_device_id huion_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_HUION_TABLET) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, huion_devices);
-- 
2.0.1

