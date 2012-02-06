From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Input: gpio_keys - Remove useless reinitialization of pdata->nbuttons
Date: Mon,  6 Feb 2012 18:30:20 +0100
Message-ID: <1328549420-7078-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:46927 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2BFRkb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Feb 2012 12:40:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

pdata is zeroed using memset just a few lines before, so there is no
need to set the nbuttons member to 0 again.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/keyboard/gpio_keys.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ed1ed46..eb57690 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -472,7 +472,6 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
 	/* First count the subnodes */
-	pdata->nbuttons = 0;
 	pp = NULL;
 	while ((pp = of_get_next_child(node, pp)))
 		pdata->nbuttons++;
-- 
1.7.5.4

