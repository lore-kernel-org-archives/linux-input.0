From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v3 2/2] Input: xpad - fix Xbox One rumble stopping after 2.5 secs
Date: Fri, 25 Nov 2016 14:18:35 -0800
Message-ID: <0c07f12f63b5bf21374eb35a84a160bffc4f97e4.1480111549.git.aicommander@gmail.com>
References: <cover.1480111549.git.aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34984 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbcKYWTZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 17:19:25 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so6461573pga.2
        for <linux-input@vger.kernel.org>; Fri, 25 Nov 2016 14:18:52 -0800 (PST)
In-Reply-To: <cover.1480111549.git.aicommander@gmail.com>
In-Reply-To: <cover.1480111549.git.aicommander@gmail.com>
References: <cover.1480111549.git.aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

Unlike previous Xbox pads, the Xbox One pad doesn't have
"sticky" rumble packets. The duration is encoded into
the command and expiration is handled by the pad firmware.

ff-memless needs pseudo-sticky behavior for rumble effects
to behave properly for long duration effects. We already
specify the maximum rumble on duration in the command
packets, but it's still only good for about 2.5 seconds
of rumble. This is easily reproducable running fftest's
sine vibration test.

It turns out there's a repeat count encoded in the rumble
command. We can abuse that to get the pseudo-sticky behavior
needed for rumble to behave as expected for effects with long
duration.

By my math, this change should allow a single ff_effect to
rumble for 10 minutes straight, which should be more than
enough for most needs.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
No changes in v3.

---
 drivers/input/joystick/xpad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 19886db..6d94996 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1045,9 +1045,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 		packet->data[7] = 0x00;
 		packet->data[8] = strong / 512;	/* left actuator */
 		packet->data[9] = weak / 512;	/* right actuator */
-		packet->data[10] = 0xFF;
-		packet->data[11] = 0x00;
-		packet->data[12] = 0x00;
+		packet->data[10] = 0xFF; /* on period */
+		packet->data[11] = 0x00; /* off period */
+		packet->data[12] = 0xFF; /* repeat count */
 		packet->len = 13;
 		packet->pending = true;
 		break;
-- 
2.9.3

