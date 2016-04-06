From: zengzhaoxiu@163.com
Subject: [PATCH v2 16/30] input: use parity32 in grip_mp
Date: Wed,  6 Apr 2016 17:43:16 +0800
Message-ID: <1459935796-7684-1-git-send-email-zengzhaoxiu@163.com>
References: <57031D9D.801@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:33266 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933798AbcDFJni (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Apr 2016 05:43:38 -0400
In-Reply-To: <57031D9D.801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 drivers/input/joystick/grip_mp.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/input/joystick/grip_mp.c b/drivers/input/joystick/grip_mp.c
index 573191d..3e29eb1 100644
--- a/drivers/input/joystick/grip_mp.c
+++ b/drivers/input/joystick/grip_mp.c
@@ -112,20 +112,6 @@ static const int axis_map[] = { 5, 9, 1, 5, 6, 10, 2, 6, 4, 8, 0, 4, 5, 9, 1, 5
 static int register_slot(int i, struct grip_mp *grip);
 
 /*
- * Returns whether an odd or even number of bits are on in pkt.
- */
-
-static int bit_parity(u32 pkt)
-{
-	int x = pkt ^ (pkt >> 16);
-	x ^= x >> 8;
-	x ^= x >> 4;
-	x ^= x >> 2;
-	x ^= x >> 1;
-	return x & 1;
-}
-
-/*
  * Poll gameport; return true if all bits set in 'onbits' are on and
  * all bits set in 'offbits' are off.
  */
@@ -235,7 +221,7 @@ static int mp_io(struct gameport* gameport, int sendflags, int sendcode, u32 *pa
 		pkt = (pkt >> 2) | 0xf0000000;
 	}
 
-	if (bit_parity(pkt) == 1)
+	if (parity32(pkt))
 		return IO_RESET;
 
 	/* Acknowledge packet receipt */
-- 
2.5.0


