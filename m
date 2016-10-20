From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 18/18] HID: input: Recognize ABS_WHEEL in hidinput_calc_abs_res
Date: Wed, 19 Oct 2016 18:03:54 -0700
Message-ID: <20161020010354.4049-18-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35598 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755704AbcJTBFX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:05:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id s8so3835585pfj.2
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:05:22 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

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
index fb9ace1..c4e935b5 100644
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

