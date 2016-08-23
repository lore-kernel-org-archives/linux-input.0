From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH v2] input/mouse/elantech.c: Fix Lenovo version typo
Date: Mon, 22 Aug 2016 21:56:32 -0300
Message-ID: <1471913792-5767-1-git-send-email-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34010 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755263AbcHWA4x (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Aug 2016 20:56:53 -0400
Received: by mail-qk0-f194.google.com with SMTP id r128so9452777qkc.1
        for <linux-input@vger.kernel.org>; Mon, 22 Aug 2016 17:56:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, ulrik.debie-os@e2big.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Ulrik De Bie <ulrik.debie-os@e2big.org>

---
Just forgot to add the SoB in the first version.

 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 08e252a..1b51961 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1134,7 +1134,7 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
  * System76 Pangolin       0x250f01        ?               2 hw buttons
  * (*) + 3 trackpoint buttons
  * (**) + 0 trackpoint buttons
- * Note: Lenovo L430 and Lenovo L430 have the same fw_version/caps
+ * Note: Lenovo L430 and Lenovo L530 have the same fw_version/caps
  */
 static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
 {
-- 
2.7.4

