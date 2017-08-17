From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] hid: Fix system-control buttons on a multitouch interface not working
Date: Thu, 17 Aug 2017 12:48:48 +0200
Message-ID: <20170817104848.4347-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752412AbdHQKsw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 06:48:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
interface as a hid-multitouch touch-pad.

This commit fixes these buttons not working.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-multitouch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0a8689bb08e9..53d1413cd435 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -930,6 +930,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_DG_PEN &&
 	    field->application != HID_DG_TOUCHPAD &&
 	    field->application != HID_GD_KEYBOARD &&
+	    field->application != HID_GD_SYSTEM_CONTROL &&
 	    field->application != HID_CP_CONSUMER_CONTROL &&
 	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
 	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
-- 
2.13.4

