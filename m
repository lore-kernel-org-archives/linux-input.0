From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] Input: mt: only perform pointer emulation on drivers desiring this functionality
Date: Thu, 27 Oct 2016 14:31:13 -0700
Message-ID: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36174 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcJ0Vbn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 17:31:43 -0400
Received: by mail-qk0-f174.google.com with SMTP id o68so64252060qkf.3
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2016 14:31:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The input-mt driver pointer emulation from 'input_mt_sync_frame' regardless
of the flags passed in to 'input_mt_init_slots' by device drivers.

Pointer emulation is undesired on drivers, which didn't request this
capability like the hid-sony driver for the Dualshock 4. This gamepad already
reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
inject touchpad values into these sticks, which is undesired.

This patch checks the flags INPUT_MT_POINTER / INPUT_MT_DIRECT from within
input_mt_sync_frame to only allow pointer emulation when the feature was
requested by the driver as the flags were set in input_mt_init_slots.
---
 drivers/input/input-mt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index a1bbec9..30c8128 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -305,7 +305,8 @@ void input_mt_sync_frame(struct input_dev *dev)
 	if ((mt->flags & INPUT_MT_POINTER) && !(mt->flags & INPUT_MT_SEMI_MT))
 		use_count = true;
 
-	input_mt_report_pointer_emulation(dev, use_count);
+	if (mt->flags & (INPUT_MT_POINTER | INPUT_MT_DIRECT))
+		input_mt_report_pointer_emulation(dev, use_count);
 
 	mt->frame++;
 }
-- 
2.7.4

