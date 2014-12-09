From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] Input: gpio_keys - fix warning regarding uninitialized  'button' variable
Date: Tue, 9 Dec 2014 12:44:12 -0200
Message-ID: <1418136252-14365-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0102.outbound.protection.outlook.com ([65.55.169.102]:28256
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752465AbaLIOo2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Dec 2014 09:44:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>

Commit af906faabcf91eb1 ("Input: gpio_keys - fix warning regarding uninitialized
'irq' variable") introduced the following build warning:

drivers/input/keyboard/gpio_keys.c:625:16: warning: 'button' may be used uninitialized in this function [-Wmaybe-uninitialized]

Move the 'button' initialization to a proper location to avoid such warning.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/gpio_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index fb8256f..28ac922 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -621,6 +621,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		int gpio = -1;
 		enum of_gpio_flags flags;
 
+		button = &pdata->buttons[i++];
+
 		if (!of_find_property(pp, "gpios", NULL)) {
 			button->irq = irq_of_parse_and_map(pp, 0);
 			if (button->irq == 0) {
@@ -640,8 +642,6 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			}
 		}
 
-		button = &pdata->buttons[i++];
-
 		button->gpio = gpio;
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
-- 
1.9.1

