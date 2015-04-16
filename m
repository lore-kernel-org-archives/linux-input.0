From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Simplify check for presence of single-finger touch
Date: Wed, 15 Apr 2015 17:22:32 -0700
Message-ID: <1429143752-5431-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32885 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbbDPAXi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 20:23:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

To determine if a touch is present in the single-touch case, we can
simply check if the BTN_TOUCH key is active or not. This will work for
both HID_GENERIC and other device types.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 69c7df7..2292d85 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1072,9 +1072,8 @@ static int wacom_wac_finger_count_touches(struct wacom_wac *wacom)
 	int count = 0;
 	int i;
 
-	/* non-HID_GENERIC single touch input doesn't call this routine */
-	if ((touch_max == 1) && (wacom->features.type == HID_GENERIC))
-		return wacom->hid_data.tipswitch &&
+	if (touch_max == 1)
+		return test_bit(BTN_TOUCH, input->key) &&
 		       !wacom->shared->stylus_in_proximity;
 
 	for (i = 0; i < input->mt->num_slots; i++) {
-- 
2.3.5

