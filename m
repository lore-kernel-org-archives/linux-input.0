From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Report full pressure range for Intuos, Cintiq 13HD Touch
Date: Thu, 15 Oct 2015 10:17:06 -0700
Message-ID: <1444929426-1723-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35589 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbbJORRl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2015 13:17:41 -0400
Received: by pabur7 with SMTP id ur7so10848063pab.2
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2015 10:17:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The new Intuos tablets added in eda01da and the Cintiq 13HD Touch added
in b4bf212 are capable of reporting 2048 levels of pressure. Although the
kernel reports the correct range to userspace, an oversight has resulted
in the driver ingoring the 11th pressure bit and only sending pressures
of 0 through 1023.

We could fix this issue by expanding the type check to include these
devices, but it makes much more sense to just have the driver look at
the device's maximum pressure when determining if it should read the
11th bit.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e0b9320..ddee08d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -765,7 +765,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 	/* general pen packet */
 	if ((data[1] & 0xb8) == 0xa0) {
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
-		if (features->type >= INTUOS4S && features->type <= CINTIQ_COMPANION_2) {
+		if (features->pressure_max == 2047) {
 			t = (t << 1) | (data[1] & 1);
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
-- 
2.6.1

