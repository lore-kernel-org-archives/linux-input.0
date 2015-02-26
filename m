From: Jim Keir <jimkeir@oracledbadirect.com>
Subject: [PATCH] pidff driver should work correctly with more than one concurrent effect
Date: Thu, 26 Feb 2015 09:14:03 +0000
Message-ID: <0000014bc52a127f-0356eeb8-db7b-4e77-b285-0ab07359baf0-000000@email.amazonses.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a8-41.smtp-out.amazonses.com ([54.240.8.41]:51661 "EHLO
	a8-41.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753423AbbBZKvk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 05:51:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz
Cc: Jim Keir <jimkeir@oracledbadirect.com>

The PID driver (usbhid/hid-pidff.c) does not set the effect ID when
uploading an effect. The result is that the initial upload works but
subsequent uploads to modify effect parameters are all directed at the
last-created effect.

The targeted effect ID must be passed back to the device when effect
parameters are changed. This is done at the start of
"pidff_set_condition_report", "pidff_set_periodic_report" etc. based on
the value of "pidff->block_load[PID_EFFECT_
BLOCK_INDEX].value[0]".

This value is only ever set during pidff_request_effect_upload.
The result is stored in "pidff->pid_id[effect->id]" at the end of
pid_upload_effect, for later use. However, if an effect is modified and
re-sent then this identifier is not being copied back from
pidff->pid_id[effect->id] before sending the command to the device. The
fix is to do this at the start of pidff_upload_effect.

Signed-off-by: Jim Keir <jimkeir@oracledbadirect.com>
---
 drivers/hid/usbhid/hid-pidff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 0b531c6..1b3fa70 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -568,6 +568,12 @@ static int pidff_upload_effect(struct input_dev *dev, struct ff_effect *effect,
 	int type_id;
 	int error;
 
+	pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0] = 0;
+	if (old && effect) {
+		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0] =
+			pidff->pid_id[effect->id];
+	}
+
 	switch (effect->type) {
 	case FF_CONSTANT:
 		if (!old) {
-- 
1.9.1

