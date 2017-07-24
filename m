From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH 1/2] HID: multitouch: Support HID_GD_WIRELESS_RADIO_CTLS
Date: Mon, 24 Jul 2017 14:22:24 -0700
Message-ID: <20170724212225.3426-2-jprvita@endlessm.com>
References: <20170724212225.3426-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36124 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755332AbdGXVWq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 17:22:46 -0400
In-Reply-To: <20170724212225.3426-1-jprvita@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Some keyboard + touchpad devices have the Microsoft Win8 Wireless Radio
Controls extensions Usage Page define in the touchpad report descriptor,
so we need to support them in this driver.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/hid/hid-multitouch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index aff20f4b6d97..152d33120a55 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -922,7 +922,8 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	    field->application != HID_DG_PEN &&
 	    field->application != HID_DG_TOUCHPAD &&
 	    field->application != HID_GD_KEYBOARD &&
-	    field->application != HID_CP_CONSUMER_CONTROL)
+	    field->application != HID_CP_CONSUMER_CONTROL &&
+	    field->application != HID_GD_WIRELESS_RADIO_CTLS)
 		return -1;
 
 	/*
@@ -1133,6 +1134,9 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_CP_CONSUMER_CONTROL:
 			suffix = "Consumer Control";
 			break;
+		case HID_GD_WIRELESS_RADIO_CTLS:
+			suffix = "Wireless Radio Control";
+			break;
 		default:
 			suffix = "UNKNOWN";
 			break;
-- 
2.13.2

