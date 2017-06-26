From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] i8042: add missing include
Date: Mon, 26 Jun 2017 16:50:28 +0200
Message-ID: <dc606f040c0f3195f910aaefd8558fe7f2dad7f2.1498488297.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [91.227.64.183] ([91.227.64.183]:34990 "EHLO rere.qmqm.pl"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751302AbdFZOuc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2017 10:50:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

linux/i8042.h include requires ENODEV defined for
!IS_ENABLED(CONFIG_SERIO_I8042) case.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/i8042.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i8042.h b/include/linux/i8042.h
index d98780ca9604..76c09949d881 100644
--- a/include/linux/i8042.h
+++ b/include/linux/i8042.h
@@ -7,6 +7,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/errno.h>
 #include <linux/types.h>
 
 /*
-- 
2.11.0

