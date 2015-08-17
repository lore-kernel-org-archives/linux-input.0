From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: input: gpio_keys_polled: Request GPIO pin as input.
Date: Mon, 17 Aug 2015 23:29:32 +0200
Message-ID: <db83f62157864df33d254c9ac6050d42c53f9949.1439846897.git.plr.vincent@gmail.com>
References: <1439846972-32323-1-git-send-email-plr.vincent@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32860 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbHQV3u (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2015 17:29:50 -0400
Received: by wijp15 with SMTP id p15so85121738wij.0
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2015 14:29:49 -0700 (PDT)
In-Reply-To: <1439846972-32323-1-git-send-email-plr.vincent@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, aaron.lu@intel.com

Flag was lost in:
Commit 633a21d80b4a("input: gpio_keys_polled: Add support for GPIO
descriptors").

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 drivers/input/keyboard/gpio_keys_polled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 097d721..c6dc644 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -246,7 +246,7 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 		 * convert it to descriptor.
 		 */
 		if (!button->gpiod && gpio_is_valid(button->gpio)) {
-			unsigned flags = 0;
+			unsigned flags = GPIOF_IN;
 
 			if (button->active_low)
 				flags |= GPIOF_ACTIVE_LOW;
-- 
2.5.0

