From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] I8042: Use SGI_HAS_I8042 to select SGI i8042 handlinig
Date: Mon, 18 Feb 2008 22:42:44 +0100 (CET)
Message-ID: <20080218214244.9DD55C2AE3@solo.franken.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:48732 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069AbYBRVmu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2008 16:42:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, akpm@linux-foundation.org

Use SGI_HAS_I8042 to select SGI i8042 handling

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

This is the only patch for SGO IP28 support, which didn't make it in the 
merge window. I hope this is patch is small enough to still get it in 
the 2.6.25-rc cycle.

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
