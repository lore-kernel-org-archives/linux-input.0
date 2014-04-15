From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv3 01/15] ARM: at91: sam9g45: remove unused platform_data
Date: Tue, 15 Apr 2014 12:27:56 +0200
Message-ID: <1397557690-5650-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397557690-5650-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397557690-5650-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-input@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
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
index dab362c06487..d186f474b83c 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -25,7 +25,6 @@
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
-#include <mach/at91_adc.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91sam9g45_matrix.h>
 #include <mach/at91_matrix.h>
@@ -1236,13 +1235,6 @@ static struct at91_adc_trigger at91_adc_triggers[] = {
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
@@ -1268,9 +1260,7 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
 	if (data->use_external_triggers)
 		at91_set_A_periph(AT91_PIN_PD28, 0);
 
-	data->num_channels = 8;
 	data->startup_time = 40;
-	data->registers = &at91_adc_register_g45;
 	data->trigger_number = 4;
 	data->trigger_list = at91_adc_triggers;
 
-- 
1.8.3.2
