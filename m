From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH] Input: byd: don't wipe dynamically allocated memory twice
Date: Thu, 21 Apr 2016 22:58:17 +0300
Message-ID: <1461268697-30735-1-git-send-email-vz@mleia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:56892 "EHLO mail.mleia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbcDUT6X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Apr 2016 15:58:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Pospesel <pospeselr@gmail.com>, Chris Diamand <chris@diamand.org>
Cc: linux-input@vger.kernel.org

Since memory for a private data is allocated by kzalloc() there is no
need to fill it with zeroes immediately after the allocation.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/input/mouse/byd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index fdc243c..ec73f75 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -473,9 +473,8 @@ int byd_init(struct psmouse *psmouse)
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	memset(priv, 0, sizeof(*priv));
 	setup_timer(&priv->timer, byd_clear_touch, (unsigned long) psmouse);
 
 	psmouse->private = priv;
 	psmouse->disconnect = byd_disconnect;
-- 
2.1.4

