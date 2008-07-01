From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] hid: gyration remote support
Date: Tue,  1 Jul 2008 09:24:11 -0700
Message-ID: <1214929451-14515-1-git-send-email-dwalker@mvista.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:27459 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751429AbYGAQY6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 12:24:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

This adds in a quirk for the additional un-mapped buttons on the
gyration MCE remote.

Defines are now alphabetical.

Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/hid/hid-input-quirks.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input-quirks.c b/drivers/hid/hid-input-quirks.c
index 4c2052c..e6a937a 100644
--- a/drivers/hid/hid-input-quirks.c
+++ b/drivers/hid/hid-input-quirks.c
@@ -89,6 +89,29 @@ static int quirk_logitech_ultrax_remote(struct hid_usage *usage, struct input_de
 	return 1;
 }
 
+static int quirk_gyration_remote(struct hid_usage *usage, struct input_dev *input,
+			      unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_LOGIVENDOR)
+		return 0;
+
+	set_bit(EV_REP, input->evbit);
+	switch(usage->hid & HID_USAGE) {
+		/* Reported on Gyration MCE Remote */
+		case 0x00d: map_key_clear(KEY_HOME);		break;
+		case 0x024: map_key_clear(KEY_DVD);		break;
+		case 0x025: map_key_clear(KEY_PVR);		break;
+		case 0x046: map_key_clear(KEY_MEDIA);		break;
+		case 0x047: map_key_clear(KEY_MP3);		break;
+		case 0x049: map_key_clear(KEY_CAMERA);		break;
+		case 0x04a: map_key_clear(KEY_VIDEO);		break;
+
+		default:
+			return 0;
+	}
+	return 1;
+}
+
 static int quirk_chicony_tactical_pad(struct hid_usage *usage, struct input_dev *input,
 			      unsigned long **bit, int *max)
 {
@@ -303,6 +326,9 @@ static int quirk_sunplus_wdesktop(struct hid_usage *usage, struct input_dev *inp
 #define VENDOR_ID_EZKEY				0x0518
 #define DEVICE_ID_BTC_8193			0x0002
 
+#define VENDOR_ID_GYRATION			0x0c16
+#define DEVICE_ID_GYRATION_REMOTE		0x0002
+
 #define VENDOR_ID_LOGITECH			0x046d
 #define DEVICE_ID_LOGITECH_RECEIVER		0xc101
 #define DEVICE_ID_S510_RECEIVER			0xc50c
@@ -337,6 +363,8 @@ static const struct hid_input_blacklist {
 
 	{ VENDOR_ID_EZKEY, DEVICE_ID_BTC_8193, quirk_btc_8193 },
 
+	{ VENDOR_ID_GYRATION, DEVICE_ID_GYRATION_REMOTE, quirk_gyration_remote },
+
 	{ VENDOR_ID_LOGITECH, DEVICE_ID_LOGITECH_RECEIVER, quirk_logitech_ultrax_remote },
 	{ VENDOR_ID_LOGITECH, DEVICE_ID_S510_RECEIVER, quirk_logitech_wireless },
 	{ VENDOR_ID_LOGITECH, DEVICE_ID_S510_RECEIVER_2, quirk_logitech_wireless },
-- 
1.5.5.1.1.g0dfaf8


