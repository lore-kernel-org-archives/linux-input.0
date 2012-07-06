From: Keng-Yu Lin <kengyu@canonical.com>
Subject: [PATCH] Input: hid-input: Add suport for the brightness control keys on HP keyboards
Date: Fri,  6 Jul 2012 18:06:11 +0800
Message-ID: <1341569171-12990-1-git-send-email-kengyu@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36032 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab2GFKGT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jul 2012 06:06:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Keng-Yu Lin <kengyu@canonical.com>

The keys are found on the keyboards bundled with HP All-In-One machines
with USB VID/PID of 04ca:004d and 04f2:1061.

Signed-off-by: Keng-Yu Lin <kengyu@canonical.com>
---
 drivers/hid/hid-input.c |    9 +++++++++
 include/linux/hid.h     |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index f333139..ecb8e48 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -648,6 +648,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		}
 		break;
 
+	case HID_UP_HPVENDOR2:
+		set_bit(EV_REP, input->evbit);
+		switch (usage->hid & HID_USAGE) {
+		case 0x003: map_key_clear(KEY_BRIGHTNESSDOWN);	break;
+		case 0x004: map_key_clear(KEY_BRIGHTNESSUP);	break;
+		default:    goto ignore;
+		}
+		break;
+
 	case HID_UP_MSVENDOR:
 		goto ignore;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index c235e4e..4365959 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -198,6 +198,7 @@ struct hid_item {
 #define HID_UP_DIGITIZER	0x000d0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_HPVENDOR         0xff7f0000
+#define HID_UP_HPVENDOR2        0xff010000
 #define HID_UP_MSVENDOR		0xff000000
 #define HID_UP_CUSTOM		0x00ff0000
 #define HID_UP_LOGIVENDOR	0xffbc0000
-- 
1.7.9.5

