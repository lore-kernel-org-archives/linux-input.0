From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RFC, PATCH 1/2] HID: usbhid, new quirk to force out reports on the control ep
Date: Wed, 13 Oct 2010 22:57:37 +0200
Message-ID: <1287003458-3791-2-git-send-email-ospite@studenti.unina.it>
References: <4CA9DD89.2010106@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp204.alice.it ([82.57.200.100]:48535 "EHLO smtp204.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab0JMU6d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:58:33 -0400
In-Reply-To: <4CA9DD89.2010106@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Alan Ott <alan@signal11.us>, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?UTF-8?q?Mikko=20Virkkil=C3=A4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

Some non compliant usb devices, like the Sony Sixaxis (PS3 Controller) need
output reports to be sent on the control endpoint rather than on the interrupt
endpoint like the standard would say.

Add a new quirk to handle this case in usbhid_output_raw_report().

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 include/linux/hid.h           |    1 +
 drivers/hid/usbhid/hid-core.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 1b95b0b..936b7a3 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -313,6 +313,7 @@ struct hid_item {
 #define HID_QUIRK_MULTI_INPUT			0x00000040
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
+#define HID_QUIRK_FORCE_OUT_CONTROL_EP		0x00020000
 #define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
 #define HID_QUIRK_NO_INIT_REPORTS		0x20000000
 #define HID_QUIRK_NO_IGNORE			0x40000000
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index df80532..81dadf8 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -841,7 +841,8 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
 	struct usb_host_interface *interface = intf->cur_altsetting;
 	int ret;
 
-	if (usbhid->urbout && report_type != HID_FEATURE_REPORT) {
+	if (usbhid->urbout && report_type != HID_FEATURE_REPORT &&
+			!(hid->quirks & HID_QUIRK_FORCE_OUT_CONTROL_EP)) {
 		int actual_length;
 		int skipped_report_id = 0;
 		if (buf[0] == 0x0) {
-- 
1.7.1

