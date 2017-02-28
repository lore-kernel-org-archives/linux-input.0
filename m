From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 02/10] Input: eeti_ts - use BIT(n)
Date: Tue, 28 Feb 2017 14:46:24 -0800
Message-ID: <20170228224632.3401-2-dmitry.torokhov@gmail.com>
References: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36606 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbdB1XNz (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 18:13:55 -0500
In-Reply-To: <20170228224632.3401-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Use idiomatic BIT(n) to form single-bit masks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 74d57ef68663..26b52496748a 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -54,10 +54,10 @@ struct eeti_ts {
 #define EETI_TS_BITDEPTH	(11)
 #define EETI_MAXVAL		((1 << (EETI_TS_BITDEPTH + 1)) - 1)
 
-#define REPORT_BIT_PRESSED	(1 << 0)
-#define REPORT_BIT_AD0		(1 << 1)
-#define REPORT_BIT_AD1		(1 << 2)
-#define REPORT_BIT_HAS_PRESSURE	(1 << 6)
+#define REPORT_BIT_PRESSED	BIT(0)
+#define REPORT_BIT_AD0		BIT(1)
+#define REPORT_BIT_AD1		BIT(2)
+#define REPORT_BIT_HAS_PRESSURE	BIT(6)
 #define REPORT_RES_BITS(v)	(((v) >> 1) + EETI_TS_BITDEPTH)
 
 static inline int eeti_ts_irq_active(struct eeti_ts *eeti)
-- 
2.11.0.483.g087da7b7c-goog

