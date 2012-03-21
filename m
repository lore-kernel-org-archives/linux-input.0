From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 08/11] input/amijoy: Add missing platform check
Date: Wed, 21 Mar 2012 10:51:52 +0100
Message-ID: <1332323515-7314-8-git-send-email-geert@linux-m68k.org>
References: <1332323515-7314-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from juliette.telenet-ops.be ([195.130.137.74]:48913 "EHLO
	juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757611Ab2CUJwJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Mar 2012 05:52:09 -0400
In-Reply-To: <1332323515-7314-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On multi-platform kernels, the Amiga joystick driver may be initialized
when running on Amiga only. Else it may crash later.
Fortunately this driver is almost always compiled as a module (to avoid
conflicts with the mouse driver), so it needs an explicit insmod to
trigger a crash.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/joystick/amijoy.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/amijoy.c b/drivers/input/joystick/amijoy.c
index 0bc8620..3aa93bf 100644
--- a/drivers/input/joystick/amijoy.c
+++ b/drivers/input/joystick/amijoy.c
@@ -108,6 +108,9 @@ static int __init amijoy_init(void)
 	int i, j;
 	int err;
 
+	if (!MACH_IS_AMIGA)
+		return -ENODEV;
+
 	for (i = 0; i < 2; i++) {
 		if (!amijoy[i])
 			continue;
-- 
1.7.0.4

