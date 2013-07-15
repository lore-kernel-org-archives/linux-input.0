From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 1/8] HID: usbhid: make usbhid_set_leds() static
Date: Mon, 15 Jul 2013 19:10:10 +0200
Message-ID: <1373908217-16748-2-git-send-email-dh.herrmann@gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:44753 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3GORKg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:36 -0400
Received: by mail-ee0-f47.google.com with SMTP id e49so7624670eek.20
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:34 -0700 (PDT)
In-Reply-To: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

usbhid_set_leds() is only used inside of usbhid/hid-core.c so no need to
export it.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/usbhid/hid-core.c | 3 +--
 include/linux/hid.h           | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 9941828..5482bf4 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -857,7 +857,7 @@ static int hid_find_field_early(struct hid_device *hid, unsigned int page,
 	return -1;
 }
 
-void usbhid_set_leds(struct hid_device *hid)
+static void usbhid_set_leds(struct hid_device *hid)
 {
 	struct hid_field *field;
 	int offset;
@@ -867,7 +867,6 @@ void usbhid_set_leds(struct hid_device *hid)
 		usbhid_submit_report(hid, field->report, USB_DIR_OUT);
 	}
 }
-EXPORT_SYMBOL_GPL(usbhid_set_leds);
 
 /*
  * Traverse the supplied list of reports and find the longest
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 0c48991..b8058c5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -989,7 +989,6 @@ int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);
 int usbhid_quirks_init(char **quirks_param);
 void usbhid_quirks_exit(void);
-void usbhid_set_leds(struct hid_device *hid);
 
 #ifdef CONFIG_HID_PID
 int hid_pidff_init(struct hid_device *hid);
-- 
1.8.3.2

