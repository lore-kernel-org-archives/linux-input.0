From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Input: parkbd - Drop bogus __init from parkbd_allocate_serio()
Date: Sat,  7 Nov 2015 16:53:23 +0100
Message-ID: <1446911603-21242-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:34098 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbKHIuq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Nov 2015 03:50:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

WARNING: vmlinux.o(.text+0x1056606): Section mismatch in reference from the function parkbd_attach() to the function .init.text:parkbd_allocate_serio()
The function parkbd_attach() references
the function __init parkbd_allocate_serio().
This is often because parkbd_attach lacks a __init
annotation or the annotation of parkbd_allocate_serio is wrong.

Commit 33ca8ab97cbb676d ("Input: parkbd - use parallel port device
model") dropped the __init attribute from the sole caller of
parkbd_allocate_serio(), but forgot to remove it from
parkbd_allocate_serio() itself.

Fixes: 33ca8ab97cbb676d ("Input: parkbd - use parallel port device model")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/serio/parkbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
index 74bb17270255439c..92c31b8f8fb489c3 100644
--- a/drivers/input/serio/parkbd.c
+++ b/drivers/input/serio/parkbd.c
@@ -164,7 +164,7 @@ static int parkbd_getport(struct parport *pp)
 	return 0;
 }
 
-static struct serio * __init parkbd_allocate_serio(void)
+static struct serio *parkbd_allocate_serio(void)
 {
 	struct serio *serio;
 
-- 
1.9.1

