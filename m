From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 7/8] input: gpio_keys_polled: remove a local variable
Date: Tue, 30 Nov 2010 19:44:22 +0100
Message-ID: <1291142663-1011-8-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37546 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0K3So2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:28 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

The 'button' variable is used only once in the gpio_keys_polled_poll
routine. Remove that and use the '&pdata->buttons[i]' value directly
instead.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 7b6a333..61e1a92 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -73,14 +73,13 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 	int i;
 
 	for (i = 0; i < bdev->pdata->nbuttons; i++) {
-		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_keys_button_data *bdata = &bdev->data[i];
 
 		if (bdata->count < bdata->threshold)
 			bdata->count++;
 		else
-			gpio_keys_polled_check_state(input, button, bdata);
-
+			gpio_keys_polled_check_state(input, &pdata->buttons[i],
+						     bdata);
 	}
 }
 
-- 
1.7.2.1

