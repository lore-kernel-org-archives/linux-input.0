From: Phil Sutter <n0-1@freewrt.org>
Subject: [PATCH 1/2] MIPS: rb532: prepare board support for rb532-button
Date: Thu, 22 Jan 2009 20:12:07 +0100
Message-ID: <20090122191219.4B109400E123@mail.nwl.cc>
References: <1232651528-19870-1-git-send-email-n0-1@freewrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([91.121.169.95]:56128 "EHLO mail.nwl.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897AbZAVTMU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2009 14:12:20 -0500
In-Reply-To: <1232651528-19870-1-git-send-email-n0-1@freewrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>

Add a macro containing the S1 button GPIO pin index, as done for NAND
and CompactFlash GPIO pins. Also remove gpio-keys specific device code
and rename the button device to mach it's driver.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/include/asm/mach-rc32434/gpio.h |    3 +++
 arch/mips/rb532/devices.c                 |   19 +------------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/mips/include/asm/mach-rc32434/gpio.h b/arch/mips/include/asm/mach-rc32434/gpio.h
index 3cb50d1..12ee8d5 100644
--- a/arch/mips/include/asm/mach-rc32434/gpio.h
+++ b/arch/mips/include/asm/mach-rc32434/gpio.h
@@ -80,6 +80,9 @@ struct rb532_gpio_reg {
 /* Compact Flash GPIO pin */
 #define CF_GPIO_NUM		13
 
+/* S1 button GPIO (shared with UART0_SIN) */
+#define GPIO_BTN_S1		1
+
 extern void rb532_gpio_set_ilevel(int bit, unsigned gpio);
 extern void rb532_gpio_set_istat(int bit, unsigned gpio);
 extern void rb532_gpio_set_func(unsigned gpio);
diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 4a5f05b..7b585de 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -200,26 +200,9 @@ static struct platform_device rb532_led = {
 	.id = -1,
 };
 
-static struct gpio_keys_button rb532_gpio_btn[] = {
-	{
-		.gpio = 1,
-		.code = BTN_0,
-		.desc = "S1",
-		.active_low = 1,
-	}
-};
-
-static struct gpio_keys_platform_data rb532_gpio_btn_data = {
-	.buttons = rb532_gpio_btn,
-	.nbuttons = ARRAY_SIZE(rb532_gpio_btn),
-};
-
 static struct platform_device rb532_button = {
-	.name 	= "gpio-keys",
+	.name 	= "rb532-button",
 	.id	= -1,
-	.dev	= {
-		.platform_data = &rb532_gpio_btn_data,
-	}
 };
 
 static struct resource rb532_wdt_res[] = {
-- 
1.5.6.4

