From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: input: gpio_keys_polled: Request GPIO pin as input.
Date: Thu, 20 Aug 2015 19:50:00 +0200
Message-ID: <7d70142c2f6133128c26cc1ca3a883d8cadbce64.1440092849.git.plr.vincent@gmail.com>
References: <20150818120756.GI1552@lahna.fi.intel.com>
 <1440093000-16946-1-git-send-email-plr.vincent@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36080 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbHTRue (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 13:50:34 -0400
Received: by wicja10 with SMTP id ja10so151713984wic.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 10:50:33 -0700 (PDT)
In-Reply-To: <1440093000-16946-1-git-send-email-plr.vincent@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, aaron.lu@intel.com

GPIOF_IN flag was lost in:
Commit 633a21d80b4a("input: gpio_keys_polled: Add support for GPIO
descriptors").

Without this flag, legacy code path (for non-descriptor GPIO declarations)
would configure GPIO as output (0 meaning GPIOF_DIR_OUT | GPIOF_INIT_LOW).

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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

