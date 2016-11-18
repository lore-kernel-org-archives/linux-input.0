From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] input/i8042: Fix typo from i8042_aux_close to i8042_port_close
Date: Fri, 18 Nov 2016 00:27:04 -0200
Message-ID: <1479436024-22869-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35512 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbcKRC1Z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Nov 2016 21:27:25 -0500
Received: by mail-qk0-f195.google.com with SMTP id n204so29501103qke.2
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2016 18:27:25 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/input/serio/i8042.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 89abfdb..62685a7 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -387,7 +387,7 @@ static int i8042_aux_write(struct serio *serio, unsigned char c)
 
 
 /*
- * i8042_aux_close attempts to clear AUX or KBD port state by disabling
+ * i8042_port_close attempts to clear AUX or KBD port state by disabling
  * and then re-enabling it.
  */
 
-- 
2.7.4

