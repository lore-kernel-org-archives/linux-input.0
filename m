From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 08/19] HID: wacom: generic: Add support for vendor-defined "Distance" usage
Date: Thu,  6 Oct 2016 14:22:20 -0700
Message-ID: <20161006212231.31440-9-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33380 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935190AbcJFVWx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:53 -0400
Received: by mail-qt0-f193.google.com with SMTP id m5so836214qtb.0
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:53 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The vendor-defined 0xFF0D01032 ("Distance") usage is nearly equivalent to
HID_GD_Z, except that the axis direction is inverted. Unlike HID_GD_Z which
increases in value as the pen-to-surface distance is decreased, this usage
decreases. Treat this usage as a special case to ensure we don't invert the
scale to be ABS_DISTANCE compatible like we do for HID_GD_Z.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 4 +++-
 drivers/hid/wacom_wac.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index edc2c14..aa51684 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1442,7 +1442,8 @@ static int wacom_equivalent_usage(int usage)
 		int subusage = (usage & 0xFF);
 
 		if (subpage == WACOM_HID_SP_DIGITIZER ||
-		    subpage == WACOM_HID_SP_DIGITIZERINFO) {
+		    subpage == WACOM_HID_SP_DIGITIZERINFO ||
+		    usage == WACOM_HID_WD_DISTANCE) {
 			return usage;
 		}
 
@@ -1502,6 +1503,7 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	case HID_GD_Y:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_Y, 4);
 		break;
+	case WACOM_HID_WD_DISTANCE:
 	case HID_GD_Z:
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_DISTANCE, 0);
 		break;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index c82233d..1ced6e4 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -88,6 +88,7 @@
 #define WACOM_HID_SP_DIGITIZER          0x000d0000
 #define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
+#define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
 #define WACOM_HID_UP_G9                 0xff090000
 #define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
-- 
2.10.0

