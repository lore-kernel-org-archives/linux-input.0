From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 09/19] HID: logitech-hidpp: handle battery events in hidpp_raw_hidpp_event()
Date: Mon, 27 Mar 2017 16:59:29 +0200
Message-ID: <20170327145939.29824-10-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753596AbdC0PAp (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:45 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Battery events are reported through HID++, so we need to be sure
the report ID is the HID++ one.

Without this, we might receive keyboard events that looks just like
battery events with wrong data and which will confuse user space.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v3
---
 drivers/hid/hid-logitech-hidpp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 81ebded..3e2f716 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2250,6 +2250,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	struct hidpp_report *question = hidpp->send_receive_buf;
 	struct hidpp_report *answer = hidpp->send_receive_buf;
 	struct hidpp_report *report = (struct hidpp_report *)data;
+	int ret;
 
 	/*
 	 * If the mutex is locked then we have a pending answer from a
@@ -2283,6 +2284,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		return 1;
 	}
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
+		ret = hidpp20_battery_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -2325,12 +2332,6 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	if (ret != 0)
 		return ret;
 
-	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
-		ret = hidpp20_battery_event(hidpp, data, size);
-		if (ret != 0)
-			return ret;
-	}
-
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
-- 
2.9.3

