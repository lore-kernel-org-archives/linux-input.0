From: Rostislav Pehlivanov <atomnuker@gmail.com>
Subject: [PATCH] HID: hid-sony: Fix DS4 controller reporting rate issues
Date: Tue, 28 Jul 2015 08:38:47 +0100
Message-ID: <1438069127-24710-1-git-send-email-atomnuker@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37736 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbG1Hjd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 03:39:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rostislav Pehlivanov <atomnuker@gmail.com>

 This commit removes the cap on the DualShock 4 controller reporting
rate when connected using Bluetooth. The previous value of '0xB0'
capped the rate to only 20.83 Hz which many userspace utilities
mistook as a sign of a bad signal. Since a 'B' and an '8' can look
similar it's possible that someone mistook the one for another.
The new value of '0x80' enables the full 1000 Hz peak reporting
rate that the controller is capable of.

Signed-off-by: Rostislav Pehlivanov <atomnuker@gmail.com>
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index ed2f008..3a6b6a9 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1836,7 +1836,7 @@ static void dualshock4_state_worker(struct work_struct *work)
 	} else {
 		memset(buf, 0, DS4_REPORT_0x11_SIZE);
 		buf[0] = 0x11;
-		buf[1] = 0xB0;
+		buf[1] = 0x80;
 		buf[3] = 0x0F;
 		offset = 6;
 	}
-- 
2.5.0.rc2.392.g76e840b

