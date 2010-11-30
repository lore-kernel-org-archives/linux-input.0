From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 6/8] input: gpio_keys_polled: use tabs instead of spaces for indentation
Date: Tue, 30 Nov 2010 19:44:21 +0100
Message-ID: <1291142663-1011-7-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37540 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700Ab0K3So3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:29 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 5af0be9..7b6a333 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -44,8 +44,8 @@ struct gpio_keys_polled_dev {
 };
 
 static void gpio_keys_polled_check_state(struct input_dev *input,
-				      struct gpio_keys_button *button,
-				      struct gpio_keys_button_data *bdata)
+					 struct gpio_keys_button *button,
+					 struct gpio_keys_button_data *bdata)
 {
 	int state;
 
-- 
1.7.2.1

