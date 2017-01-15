From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] Input: cyapa_gen3: use msleep() for long delay
Date: Sun, 15 Jan 2017 12:13:07 +0100
Message-ID: <1484478787-13178-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:45395 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbdAOLL7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 06:11:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Dudley Du <dudl@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

ulseep_range() uses hrtimers and provides no advantage over msleep()
for larger delays. Fix up the 50ms delays here to use msleep() and
reduce the load on the hrtimer subsystem. 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem found by coccinelle script

As the needed delay is specified in the comment as being "at least 50ms"
the msleep(50) should be fine here. 

Note that cyapa_gen3_bl_exit() is returning -EAGAIN in cases where it was
not yet ready to process the request, but the calling side 
cyapa_gen3_do_operational_check() does not check for -EAGAIN so in case of
the noted increased delay "...can take up to an additional 2 seconds. If 
the device power is running low, this may take even longer", maybe
cyapa_gen3_do_operational_check() may need a retry loop on -EAGAIN ?

Patch was compile tested with: x86_64_defconfig + CONFIG_MOUSE_CYAPA=m

Patch is against 4.10-rc3 (localversion-next is next-20170113)

 drivers/input/mouse/cyapa_gen3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index f9600753..6e9ecb0 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -562,7 +562,7 @@ static int cyapa_gen3_bl_exit(struct cyapa *cyapa)
 	 * Wait for bootloader to exit, and operation mode to start.
 	 * Normally, this takes at least 50 ms.
 	 */
-	usleep_range(50000, 100000);
+	msleep(50);
 	/*
 	 * In addition, when a device boots for the first time after being
 	 * updated to new firmware, it must first calibrate its sensors, which
-- 
2.1.4

