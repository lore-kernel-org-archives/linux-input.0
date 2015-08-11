From: yalin wang <yalin.wang2010@gmail.com>
Subject: [PATCH] joystick/zhenhua: remove zhenhua_bitreverse()
Date: Tue, 11 Aug 2015 13:49:34 +0800
Message-ID: <A2697706-7925-4923-B024-3E6F01117AF2@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36387 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbbHKFti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2015 01:49:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

This change remove zhenhua_bitreverse() function, use generic
bitrev8() function instead.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/input/joystick/zhenhua.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/zhenhua.c b/drivers/input/joystick/zhenhua.c
index 30af2e8..4a8258b 100644
--- a/drivers/input/joystick/zhenhua.c
+++ b/drivers/input/joystick/zhenhua.c
@@ -47,6 +47,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/bitrev.h>
 #include <linux/input.h>
 #include <linux/serio.h>
 
@@ -72,16 +73,6 @@ struct zhenhua {
 	char phys[32];
 };
 
-
-/* bits in all incoming bytes needs to be "reversed" */
-static int zhenhua_bitreverse(int x)
-{
-	x = ((x & 0xaa) >> 1) | ((x & 0x55) << 1);
-	x = ((x & 0xcc) >> 2) | ((x & 0x33) << 2);
-	x = ((x & 0xf0) >> 4) | ((x & 0x0f) << 4);
-	return x;
-}
-
 /*
  * zhenhua_process_packet() decodes packets the driver receives from the
  * RC transmitter. It updates the data accordingly.
@@ -120,7 +111,7 @@ static irqreturn_t zhenhua_interrupt(struct serio *serio, unsigned char data, un
 		return IRQ_HANDLED;	/* wrong MSB -- ignore this byte */
 
 	if (zhenhua->idx < ZHENHUA_MAX_LENGTH)
-		zhenhua->data[zhenhua->idx++] = zhenhua_bitreverse(data);
+		zhenhua->data[zhenhua->idx++] = bitrev8(data);
 
 	if (zhenhua->idx == ZHENHUA_MAX_LENGTH) {
 		zhenhua_process_packet(zhenhua);
-- 
1.9.1
