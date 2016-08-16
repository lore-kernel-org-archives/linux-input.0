From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v2 4/4] Input: xpad - fix Xbox One rumble stopping after 2.5 secs
Date: Mon, 15 Aug 2016 21:10:16 -0700
Message-ID: <1471320616-13110-5-git-send-email-aicommander@gmail.com>
References: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33112 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcHPEKW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2016 00:10:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so4772344pfe.0
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2016 21:10:21 -0700 (PDT)
In-Reply-To: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

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
 drivers/input/joystick/xpad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 42723ba..8954643 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1078,9 +1078,9 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
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
2.7.4

