From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 4/8] input: gpio_keys_polled: use DIV_ROUND_UP to compute the threshold value
Date: Tue, 30 Nov 2010 19:44:19 +0100
Message-ID: <1291142663-1011-5-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37524 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0K3So2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:28 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 9636c2f..c9e0d1c 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -75,9 +75,8 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_keys_button_data *bdata = &bdev->data[i];
 
-		threshold = round_up(button->debounce_interval,
-				pdata->poll_interval) /
-				pdata->poll_interval;
+		threshold = DIV_ROUND_UP(button->debounce_interval,
+					 pdata->poll_interval);
 		if (bdata->count < threshold)
 			bdata->count++;
 		else
-- 
1.7.2.1

