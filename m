From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/8] input: gpio_keys_polled: avoid possible division by zero
Date: Tue, 30 Nov 2010 19:44:18 +0100
Message-ID: <1291142663-1011-4-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37508 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471Ab0K3So2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:28 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

The poll_interval field is used as a divider in the computation of
the threshold value. Check the passed value in the probe routine,
and return -EINVAL if it has not been set in the platform data.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 5275c9e..9636c2f 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -114,8 +114,8 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 	int error;
 	int i;
 
-	if (!pdata)
-		return -ENXIO;
+	if (!pdata || !pdata->poll_interval)
+		return -EINVAL;
 
 	bdev = kzalloc(sizeof(struct gpio_keys_polled_dev) +
 		       pdata->nbuttons * sizeof(struct gpio_keys_button_data),
-- 
1.7.2.1

