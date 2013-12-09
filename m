From: <michael.hennerich@analog.com>
Subject: [PATCH] drivers/input/misc/adxl34x: Fix bug in definition of ADXL346_2D_ORIENT
Date: Mon, 9 Dec 2013 12:35:10 +0100
Message-ID: <1386588910-4604-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:38775
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752783Ab3LILmG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Dec 2013 06:42:06 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Coverity report pointet out by Dmitry

Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/adxl34x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 0735de3..1cb1da2 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -158,7 +158,7 @@
 
 /* ORIENT ADXL346 only */
 #define ADXL346_2D_VALID		(1 << 6)
-#define ADXL346_2D_ORIENT(x)		(((x) & 0x3) >> 4)
+#define ADXL346_2D_ORIENT(x)		(((x) & 0x30) >> 4)
 #define ADXL346_3D_VALID		(1 << 3)
 #define ADXL346_3D_ORIENT(x)		((x) & 0x7)
 #define ADXL346_2D_PORTRAIT_POS		0	/* +X */
-- 
1.7.9.5


