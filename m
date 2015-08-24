From: Peng Fan <van.freenix@gmail.com>
Subject: [PATCH] input: gpio-keys: report error when invalid key number
Date: Mon, 24 Aug 2015 20:07:44 +0800
Message-ID: <1440418064-15971-1-git-send-email-van.freenix@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36408 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834AbbHXMHq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2015 08:07:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linus.walleij@linaro.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, van.freenix@gmail.com, Alexander Stein <alexander.stein@systec-electronic.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wolfram Sang <wsa@the-dreams.de>, Fabio Estevam <fabio.estevam@freescale.com>

When the input key number is not valid one of
'/sys/devices/soc0/gpio-keys/keys', need to report
an error, but not continue.

See the following example:
root@yocto:/sys/devices/soc0/gpio-keys# cat keys
114-116
root@yocto:/sys/devices/soc0/gpio-keys# echo 77 > keys
root@yocto:/sys/devices/soc0/gpio-keys#

we want 'echo 77 > keys' to report an error, but not
silence to give us an fake illusion that all is 'ok'.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/gpio_keys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ddf4045..b98f3b4 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -239,6 +239,11 @@ static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
 		}
 	}
 
+	if (i == ddata->pdata->nbuttons) {
+		error = -EINVAL;
+		goto out;
+	}
+
 	mutex_lock(&ddata->disable_lock);
 
 	for (i = 0; i < ddata->pdata->nbuttons; i++) {
-- 
1.8.4.5

