From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] Input: gpio_keys - Return proper error code
Date: Wed, 27 Jul 2011 11:10:47 +0200
Message-ID: <1311757847-23132-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.zhaw.ch ([160.85.104.50]:56034 "EHLO mx1.zhaw.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318Ab1G0JUF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2011 05:20:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Return -ENOMEM if kzalloc fails in gpio_keys_get_devtree_pdata.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/keyboard/gpio_keys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ce281d1..67df91a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -483,7 +483,7 @@ static int gpio_keys_get_devtree_pdata(struct device *dev,
 
 	buttons = kzalloc(pdata->nbuttons * (sizeof *buttons), GFP_KERNEL);
 	if (!buttons)
-		return -ENODEV;
+		return -ENOMEM;
 
 	pp = NULL;
 	i = 0;
-- 
1.7.5.4

