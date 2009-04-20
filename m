From: Ben Nizette <bn@niasdigital.com>
Subject: [PATCH] ads7846: Allow both-edge interrupt mode
Date: Mon, 20 Apr 2009 12:06:18 +1000
Message-ID: <1240193178.24329.24.camel@linux-51e8.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752595AbZDTCHG@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "imre.deak" <imre.deak@nokia.com>, "Egtvedt, Hans-Christian" <Hans-Christian.Egtvedt@atmel.com>, "haavard.skinnemoen" <haavard.skinnemoen@atmel.com>, kernel <kernel@avr32linux.org>
List-Id: linux-input@vger.kernel.org


Some interrupt controllers (especially ones which can be used for
gpio as well) only support a limited number of interrupt modes.
Specifically, the AVR32 AT32AP7000's gpio interrupts only allow
both-edge triggering.

The ads7846 driver's interrupt handler can already deal with being
called for both edges of the interrupt, this patch adds the
ability for the platform to explicitly ask that the irq be
both-edge triggered to allow connection to a greater range of
interrupt controllers.

Also wire up the favr-32 board which requires this feature.

Tested on the favr-32 based ezLCD+101 from EarthLCD.

Signed-off-by: Ben Nizette <bn@niasdigital.com>
---
 arch/avr32/boards/favr-32/setup.c   |    6 ++++++
 drivers/input/touchscreen/ads7846.c |   10 +++++++++-
 include/linux/spi/ads7846.h         |    3 +++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/boards/favr-32/setup.c b/arch/avr32/boards/favr-32/setup.c
index 46c9b0a..58203d1 100644
--- a/arch/avr32/boards/favr-32/setup.c
+++ b/arch/avr32/boards/favr-32/setup.c
@@ -72,6 +72,12 @@ static struct ads7846_platform_data ads7843_data = {
 	.debounce_max		= 20,
 	.debounce_rep		= 4,
 	.debounce_tol		= 5,
+
+	/* The ads7843 pendown irq is just connected to regular
+	 * gpio and therefore can only trigger interrupts on
+	 * both edges, not the falling-only mode which is the
+	 * driver default */
+	.force_irq_bothedge	= true,
 };
 
 static struct spi_board_info __initdata spi1_board_info[] = {
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 2b01e56..231f5d0 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -875,6 +875,7 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	struct spi_transfer		*x;
 	int				vref;
 	int				err;
+	int				irqflags;
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
@@ -1139,7 +1140,14 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 
 	ts->last_msg = m;
 
-	if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FALLING,
+	/* We only *need* falling edge interrupts but, if the
+	 * platform requests it, we can deal with both-edge too
+	 */
+	irqflags = IRQF_TRIGGER_FALLING;
+	if (pdata->force_irq_bothedge)
+		irqflags |= IRQF_TRIGGER_RISING;
+	
+	if (request_irq(spi->irq, ads7846_irq, irqflags,
 			spi->dev.driver->name, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 2ea2032..dce814f 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -17,6 +17,9 @@ struct ads7846_platform_data {
 	u16	vref_mv;		/* external vref value, milliVolts */
 	bool	keep_vref_on;		/* set to keep vref on for differential
 					 * measurements as well */
+	bool	force_irq_bothedge;	/* Set if the interrupt to which the
+					 * ads7846 is connected only supports
+					 * both-edge triggering */
 
 	/* Settling time of the analog signals; a function of Vcc and the
 	 * capacitance on the X/Y drivers.  If set to non-zero, two samples
-- 
1.6.0.2
