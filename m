From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 12/15] ARM: at91: remove atmel_tsadcc platform_data
Date: Mon, 17 Mar 2014 14:57:05 +0100
Message-ID: <1395064628-644-13-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395064628-644-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395064628-644-1-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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
index cea9f70133c5..4b452c6a2f7b 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -86,13 +86,6 @@ struct atmel_uart_data {
 	struct serial_rs485	rs485;		/* rs485 settings */
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
