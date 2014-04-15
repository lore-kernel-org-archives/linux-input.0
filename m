From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv3 14/15] ARM: at91: remove atmel_tsadcc platform_data
Date: Tue, 15 Apr 2014 12:28:09 +0200
Message-ID: <1397557690-5650-15-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397557690-5650-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397557690-5650-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/board.h          | 3 ---
 include/linux/platform_data/atmel.h | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-at91/board.h b/arch/arm/mach-at91/board.h
index 6c08b341167d..4e773b55bc2d 100644
--- a/arch/arm/mach-at91/board.h
+++ b/arch/arm/mach-at91/board.h
@@ -118,9 +118,6 @@ struct isi_platform_data;
 extern void __init at91_add_device_isi(struct isi_platform_data *data,
 		bool use_pck_as_mck);
 
- /* Touchscreen Controller */
-extern void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data);
-
 /* CAN */
 extern void __init at91_add_device_can(struct at91_can_data *data);
 
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index e26b0c14edea..1466443797d7 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -87,13 +87,6 @@ struct atmel_uart_data {
 	int			rts_gpio;	/* optional RTS GPIO */
 };
 
- /* Touchscreen Controller */
-struct at91_tsadcc_data {
-	unsigned int    adc_clock;
-	u8		pendet_debounce;
-	u8		ts_sample_hold_time;
-};
-
 /* CAN */
 struct at91_can_data {
 	void (*transceiver_switch)(int on);
-- 
1.8.3.2
