From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/5] ARM: davinci: Switch DA850EVM to use GPIO descriptors
Date: Fri, 24 Nov 2017 10:30:43 +0100
Message-ID: <20171124093045.5961-4-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39681 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdKXJa4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 04:30:56 -0500
Received: by mail-lf0-f66.google.com with SMTP id x76so20102268lfb.6
        for <linux-input@vger.kernel.org>; Fri, 24 Nov 2017 01:30:55 -0800 (PST)
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

To get rid of the global GPIO numberspace we need to move
to using descriptor tables with local offsets on the GPIO
chip to reference the GPIO lines used by kernel drivers.

This moves the DaVinci DA850EVM board over to using GPIO
descriptors for passing GPIOs to the GPIO keys.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-davinci/board-da850-evm.c | 57 ++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index cbde0030c092..3792d760020f 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -404,11 +404,9 @@ static const char * const da850_evm_ui_exp[] = {
 static struct gpio_keys_button da850_evm_ui_keys[] = {
 	[0 ... DA850_N_UI_PB - 1] = {
 		.type			= EV_KEY,
-		.active_low		= 1,
 		.wakeup			= 0,
 		.debounce_interval	= DA850_KEYS_DEBOUNCE_MS,
 		.code			= -1, /* assigned at runtime */
-		.gpio			= -1, /* assigned at runtime */
 		.desc			= NULL, /* assigned at runtime */
 	},
 };
@@ -427,6 +425,29 @@ static struct platform_device da850_evm_ui_keys_device = {
 	},
 };
 
+static struct gpiod_lookup_table da850_evm_ui_keys_gpios_table = {
+	.dev_id = "gpio-keys-polled",
+	.table = {
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB8,
+			    "pb8", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB7,
+			    "pb7", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB6,
+			    "pb6", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB5,
+			    "pb5", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB4,
+			    "pb4", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB3,
+			    "pb3", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB2,
+			    "pb2", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-20", DA850_EVM_UI_EXP_PB1,
+			    "pb1", GPIO_ACTIVE_LOW),
+
+	},
+};
+
 static void da850_evm_ui_keys_init(unsigned gpio)
 {
 	int i;
@@ -436,8 +457,8 @@ static void da850_evm_ui_keys_init(unsigned gpio)
 		button = &da850_evm_ui_keys[i];
 		button->code = KEY_F8 - i;
 		button->desc = da850_evm_ui_exp[DA850_EVM_UI_EXP_PB8 + i];
-		button->gpio = gpio + DA850_EVM_UI_EXP_PB8 + i;
 	}
+	gpiod_add_lookup_table(&da850_evm_ui_keys_gpios_table);
 }
 
 #ifdef CONFIG_DA850_UI_SD_VIDEO_PORT
@@ -572,21 +593,17 @@ static const char * const da850_evm_bb_exp[] = {
 static struct gpio_keys_button da850_evm_bb_keys[] = {
 	[0] = {
 		.type			= EV_KEY,
-		.active_low		= 1,
 		.wakeup			= 0,
 		.debounce_interval	= DA850_KEYS_DEBOUNCE_MS,
 		.code			= KEY_PROG1,
 		.desc			= NULL, /* assigned at runtime */
-		.gpio			= -1, /* assigned at runtime */
 	},
 	[1 ... DA850_N_BB_USER_SW] = {
 		.type			= EV_SW,
-		.active_low		= 1,
 		.wakeup			= 0,
 		.debounce_interval	= DA850_KEYS_DEBOUNCE_MS,
 		.code			= -1, /* assigned at runtime */
 		.desc			= NULL, /* assigned at runtime */
-		.gpio			= -1, /* assigned at runtime */
 	},
 };
 
@@ -604,6 +621,30 @@ static struct platform_device da850_evm_bb_keys_device = {
 	},
 };
 
+static struct gpiod_lookup_table da850_evm_bb_keys_gpios_table = {
+	.dev_id = "gpio-keys-polled",
+	.table = {
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_PB1,
+			    "user_pb1", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW1,
+			    "user_sw1", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW2,
+			    "user_sw2", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW3,
+			    "user_sw3", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW4,
+			    "user_sw4", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW5,
+			    "user_sw5", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW6,
+			    "user_sw6", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW7,
+			    "user_sw7", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("tca6416-21", DA850_EVM_BB_EXP_USER_SW8,
+			    "user_sw8", GPIO_ACTIVE_LOW),
+	},
+};
+
 static void da850_evm_bb_keys_init(unsigned gpio)
 {
 	int i;
@@ -617,8 +658,8 @@ static void da850_evm_bb_keys_init(unsigned gpio)
 		button = &da850_evm_bb_keys[i + 1];
 		button->code = SW_LID + i;
 		button->desc = da850_evm_bb_exp[DA850_EVM_BB_EXP_USER_SW1 + i];
-		button->gpio = gpio + DA850_EVM_BB_EXP_USER_SW1 + i;
 	}
+	gpiod_add_lookup_table(&da850_evm_bb_keys_gpios_table);
 }
 
 #define DA850_N_BB_USER_LED	2
-- 
2.14.3

