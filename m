From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Override incorrect logical maximum contact identifier
Date: Wed, 19 Apr 2017 14:47:24 -0700
Message-ID: <20170419214724.16959-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35886 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764221AbdDSVrl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Apr 2017 17:47:41 -0400
Received: by mail-qk0-f196.google.com with SMTP id v75so5246023qkb.3
        for <linux-input@vger.kernel.org>; Wed, 19 Apr 2017 14:47:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

It apears that devices designed around Wacom's G11 chipset (e.g. Lenovo
ThinkPad Yoga 260, Lenovo ThinkPad X1 Yoga, Dell XPS 12 9250, Dell Venue
8 Pro 5855, etc.) suffer from a common issue in their HID descriptors.
The logical maximum is not updated for the "Contact Identifier" usage,
leaving it as just "1" despite these devices being capable of tracking
far more touches.

Commit 60a221869803 began ignoring usages with out-of-range values,
causing problems for devices based on this chipset. Touches after
the first will have an out-of-range Contact Identifier, and ignoring
that usage will cause the kernel to incorrectly slot each finger's
events (along with all the knock-on userspace effects that entails).

This commit checks for these buggy descriptors and updates the maximum
where required. Prior chipsets have used "255" as the maximum (and the
G11, at least, doesn't seem to actually use IDs outside the range of
1..CONTACTMAX) so continue using this value.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri, please add this to your 'for-4.11/upstream-fixes' branch since
commit 60a221869803 was introduced in 4.11 and leaving this unaddressed
could impact a wide variety of tablet PCs.

 drivers/hid/wacom_wac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 603f7fcd8df6..c68ac65db7ff 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2176,6 +2176,16 @@ static void wacom_wac_finger_usage_mapping(struct hid_device *hdev,
 		wacom_wac->hid_data.cc_index = field->index;
 		wacom_wac->hid_data.cc_value_index = usage->usage_index;
 		break;
+	case HID_DG_CONTACTID:
+		if ((field->logical_maximum - field->logical_minimum) < touch_max) {
+			/*
+			 * The HID descriptor for G11 sensors leaves logical
+			 * maximum set to '1' despite it being a multitouch
+			 * device. Override to a sensible number.
+			 */
+			field->logical_maximum = 255;
+		}
+		break;
 	}
 }
 
-- 
2.12.2

