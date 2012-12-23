From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] Input: gpio_keys_polled - defer probing if GPIO probing is deferred
Date: Sun, 23 Dec 2012 09:32:03 +0100
Message-ID: <1356251523-28359-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:35270 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741Ab2LWIcL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Dec 2012 03:32:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>, Gabor Juhos <juhosg@openwrt.org>, stable@vger.kernel.org

If GPIO probing is deferred, the driver tries to
claim an invalid GPIO line which leads to an error
message like this:

  gpio-keys-polled buttons.2: unable to claim gpio 4294966779, err=-22
  gpio-keys-polled: probe of buttons.2 failed with error -22

The patch ensures that 'gpio_keys_polled_get_devtree_pdata'
returns -EPROBE_DEFER if any of the GPIOs to register are
deferred.

Cc: <stable@vger.kernel.org>
Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index f686fd9..cfb54cc 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -120,6 +120,12 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 	if (nbuttons == 0)
 		return NULL;
 
+	for_each_child_of_node(node, pp) {
+		error = of_get_gpio(pp, 0);
+		if (error == -EPROBE_DEFER)
+			goto err_out;
+	}
+
 	pdata = kzalloc(sizeof(*pdata) + nbuttons * (sizeof *button),
 			GFP_KERNEL);
 	if (!pdata) {
-- 
1.7.10

