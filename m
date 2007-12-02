From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] I8042: Use SGI_HAS_I8042 to select SGI i8042 handlinig
Date: Sun,  2 Dec 2007 12:55:19 +0100 (CET)
Message-ID: <20071202115519.85F91C2EB6@solo.franken.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:58700 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbXLBMA6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Dec 2007 07:00:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-mips@linux-mips.org
Cc: dmitry.torokhov@gmail.com

Use SGI_HAS_I8042 to select SGI i8042 handling

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Please apply for 2.6.25.

 drivers/input/serio/i8042.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index dd22d91..c972e5d 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -16,7 +16,7 @@
 
 #if defined(CONFIG_MACH_JAZZ)
 #include "i8042-jazzio.h"
-#elif defined(CONFIG_SGI_IP22)
+#elif defined(CONFIG_SGI_HAS_I8042)
 #include "i8042-ip22io.h"
 #elif defined(CONFIG_PPC)
 #include "i8042-ppcio.h"
