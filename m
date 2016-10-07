From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 18/18] HID: input: Recognize ABS_WHEEL in hidinput_calc_abs_res
Date: Fri,  7 Oct 2016 15:16:53 -0700
Message-ID: <20161007221653.26941-18-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161007221653.26941-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35881 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757443AbcJGWSB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 18:18:01 -0400
Received: by mail-qt0-f196.google.com with SMTP id y38so1649649qta.3
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 15:17:30 -0700 (PDT)
In-Reply-To: <20161007221653.26941-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The "Steering" usage (HID_UP_SIMULATION | 0xc8) is defined in HUT 1.12 as
follows:

"A steering wheel is a single degree-of-freedom device that rotates about
an axis. The zero position is always the neutral or 'straight ahead'
position, with positive values turning clockwise and negative values
turning counterclockwise. If the Coordinate Values Wrap attribute is
set, the steering wheel can be turned past 360 degrees."

The hidinput_configure_usage function canonically maps this usage to the
ABS_WHEEL axis, but hidinput_calc_abs_res does not recognize this axis
as one for which it can calculate a resolution. This effectively prevents
wheels from being assigned a proper resolution that userspace can use
to determine the precise angle of input.

This commit adds ABS_WHEEL as a rotational axis to hidinput_calc_abs_res.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bcfaf32..81d35e9 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -253,6 +253,7 @@ __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 	case ABS_RX:
 	case ABS_RY:
 	case ABS_RZ:
+	case ABS_WHEEL:
 	case ABS_TILT_X:
 	case ABS_TILT_Y:
 		if (field->unit == 0x14) {		/* If degrees */
-- 
2.10.0

