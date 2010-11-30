From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 1/8] input: gpio_keys_polled: add MODULE_ALIAS
Date: Tue, 30 Nov 2010 19:44:16 +0100
Message-ID: <1291142663-1011-2-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37497 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0K3So1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:27 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 6ed6910..1bd335b 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -258,3 +258,4 @@ module_exit(gpio_keys_polled_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
 MODULE_DESCRIPTION("Polled GPIO Buttons driver");
+MODULE_ALIAS("platform:" DRV_NAME)
-- 
1.7.2.1

