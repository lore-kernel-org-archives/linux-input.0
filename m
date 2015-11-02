From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/3] HID: wacom: Fix ABS_MISC reporting for Cintiq Companion 2
Date: Mon,  2 Nov 2015 15:41:13 -0800
Message-ID: <1446507673-4458-3-git-send-email-killertofu@gmail.com>
References: <1446507673-4458-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35635 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbKBXlw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Nov 2015 18:41:52 -0500
Received: by pasz6 with SMTP id z6so29560pas.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2015 15:41:50 -0800 (PST)
In-Reply-To: <1446507673-4458-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The pad handling code introduced for the Cintiq Companion 2 (f7acb55)
looks at the wrong bytes in the report when deciding whether ABS_MISC
should be sent. This does not cause any issues with the X driver now
that the pen and pad have been split to separate devices, but is
incorrect and has caused issues when backporting to distros with pre-
3.17 kernels.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 453da6d..9db6a8b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -966,7 +966,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_A, (data[2] & 0x80));  /* Down   */
 			input_report_key(input, BTN_0, (data[1] & 0x01));  /* Center */
 
-			if (data[4] | (data[3] & 0x01)) {
+			if (data[2] | (data[1] & 0x07)) {
 				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
 			} else {
 				input_report_abs(input, ABS_MISC, 0);
-- 
2.6.2

