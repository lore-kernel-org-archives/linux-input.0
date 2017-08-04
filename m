From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Do not completely map WACOM_HID_WD_TOUCHRINGSTATUS usage
Date: Fri,  4 Aug 2017 15:35:14 -0700
Message-ID: <20170804223514.3080-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34487 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdHDWfd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 4 Aug 2017 18:35:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

The WACOM_HID_WD_TOUCHRINGSTATUS usage is a single bit which tells us
whether the touchring is currently in use or not. Because we need to
reset the axis value to 0 when the finger is removed, we call
'wacom_map_usage' to ensure that the required type/code values are
associated with the usage. The 'wacom_map_usage' also sets up the axis
range and resolution, however, which is not desired in this particular
case.

Although xf86-input-wacom doesn't do really do anything with the ring's
range or resolution, the libinput driver (for Wayland environments)
uses these values to provide proper angle indications to userspace.

Fixes: 60a2218698 ("HID: wacom: generic: add support for touchring")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 149bdff28d32..40d129f8d7e0 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1845,7 +1845,13 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_TOUCHRINGSTATUS:
-		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
+		/*
+		 * Only set up type/code association. Completely mapping
+		 * this usage may overwrite the axis resolution and range.
+		 */
+		usage->type = EV_ABS;
+		usage->code = ABS_WHEEL;
+		set_bit(EV_ABS, input->evbit);
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
 	case WACOM_HID_WD_BUTTONCONFIG:
-- 
2.13.4

