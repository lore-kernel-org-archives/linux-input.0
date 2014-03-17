From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 01/15] ARM: at91: sam9g45: remove unused platform_data
Date: Mon, 17 Mar 2014 14:56:54 +0100
Message-ID: <1395064628-644-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-input@vger.kernel.org

num_channels and registers are not used anymore since they are defined inside
the at91_adc driver and assigned by matching the id_table.

Also, remove the mach/at91_adc.h include that is not necessary anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 arch/arm/mach-at91/at91sam9g45_devices.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 88554024eb2d..cd36009c3511 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -25,7 +25,6 @@
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
-#include <mach/at91_adc.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91sam9g45_matrix.h>
 #include <mach/at91_matrix.h>
@@ -1235,13 +1234,6 @@ static struct at91_adc_trigger at91_adc_triggers[] = {
 	},
 };
 
-static struct at91_adc_reg_desc at91_adc_register_g45 = {
-	.channel_base = AT91_ADC_CHR(0),
-	.drdy_mask = AT91_ADC_DRDY,
-	.status_register = AT91_ADC_SR,
-	.trigger_register = 0x08,
-};
-
 void __init at91_add_device_adc(struct at91_adc_data *data)
 {
 	if (!data)
@@ -1267,9 +1259,7 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
 	if (data->use_external_triggers)
 		at91_set_A_periph(AT91_PIN_PD28, 0);
 
-	data->num_channels = 8;
 	data->startup_time = 40;
-	data->registers = &at91_adc_register_g45;
 	data->trigger_number = 4;
 	data->trigger_list = at91_adc_triggers;
 
-- 
1.8.3.2
