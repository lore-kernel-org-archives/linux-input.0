From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] Input: i8042-x86ia64io.h - Comment else/endif of CONFIG_PNP
Date: Fri,  9 Dec 2016 21:55:09 -0200
Message-ID: <20161209235518.14465-1-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34836 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbcLIXzh (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 18:55:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Patrick Scheuring <patrick.scheuring.dev@gmail.com>, =?UTF-8?q?Aur=C3=A9lien=20Francillon?= <aurelien@francillon.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

As this define check if huge, this makes easier to read the code.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 While reviewing patches from Dmitry about presence of 8042, it makes it
 much easier to understand the ifdefs...

 drivers/input/serio/i8042-x86ia64io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 073246c..ddd3132 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -1131,10 +1131,10 @@ static int __init i8042_pnp_init(void)
 	return 0;
 }
 
-#else
+#else  /* !CONFIG_PNP */
 static inline int i8042_pnp_init(void) { return 0; }
 static inline void i8042_pnp_exit(void) { }
-#endif
+#endif /* CONFIG_PNP */
 
 static int __init i8042_platform_init(void)
 {
-- 
2.9.3

