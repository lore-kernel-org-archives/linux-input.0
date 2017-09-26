From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Input: ALPS - remove redundant unlikely()
Date: Tue, 26 Sep 2017 11:29:51 +0200
Message-ID: <20170926092951.26721-1-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:46568 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965142AbdIZJe4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 05:34:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

IS_ERR_OR_NULL() already implies unlikely(), so it can be omitted.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 850b00e3ad8e..2aaceb1e9d4f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1486,7 +1486,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
 		dev2 = psmouse->dev;
-	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+	} else if (IS_ERR_OR_NULL(priv->dev3)) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
 			psmouse_queue_work(psmouse, &priv->dev3_register_work,
-- 
2.13.0


