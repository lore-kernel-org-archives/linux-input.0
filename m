From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/7] input: atmel_mxt_ts: drop unused MXT_VER_ from atmel_mxt_ts driver
Date: Thu,  7 Feb 2013 15:17:42 +0100
Message-ID: <1360246668-2291-2-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47036 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758236Ab3BGOSA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:00 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

not used, and not clear what it is used for

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 1df2396..fc52dc5 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -21,11 +21,6 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 
-/* Version */
-#define MXT_VER_20		20
-#define MXT_VER_21		21
-#define MXT_VER_22		22
-
 /* Slave addresses */
 #define MXT_APP_LOW		0x4a
 #define MXT_APP_HIGH		0x4b
-- 
1.7.9.5

