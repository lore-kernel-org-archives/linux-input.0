From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH] generic driver for rotary encoders on GPIOs
Date: Thu, 26 Feb 2009 22:18:40 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901348F62@mi8nycmail19.Mi8.com>
References: <1235671228-29552-1-git-send-email-daniel@caiaq.de> <1235673764-5540-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:54892 "HELO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753900AbZB0DTb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2009 22:19:31 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1235673764-5540-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Thursday, February 26, 2009 11:43 AM, Daniel Mack wrote:
> This patch adds a generic driver for rotary encoders connected
> to GPIO pins of a system. It relies on gpiolib and generic
> hardware irqs. The documentation that also comes with this patch
> explains the concept and how to use the driver.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

+
+/* board support file example */
+
+#define GPIO_ROTARY_A 1
+#define GPIO_ROTARY_B 2
+
+static struct resource rotary_encoder_resources[] = {
+	[0] = {
+		.flags = IORESOURCE_IRQ,
+		.start = IRQ_GPIO(GPIO_ROTARY_A)
+	},
+	[1] = {
+		.flags = IORESOURCE_IRQ,
+		.start = IRQ_GPIO(GPIO_ROTARY_B)
+	}
+};
+
+static struct rotary_encoder_platform_data my_rotary_encoder_info = {
+	.steps = 24,
+	.gpio_a = GPIO_ROTARY_A,
+	.gpio_b = GPIO_ROTARY_B,
+	.inverted_a = 0,
+	.inverted_b = 0,
+};
+
+static struct platform_device rotary_encoder_device = {
+	.name		= "rotary-encoder",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(rotary_encoder_resources),
+	.resource	= rotary_encoder_resources,
+	.dev		= {
+		.platform_data = &my_rotary_encoder_info,
+	}
+};
+

IRQ_GPIO appears to be only defined for mach-imx and mach-pxa.

Why not just use the platform_data information to get the irq for the
gpio at runtime with gpio_to_irq()?

+#include <linux/rotary-encoder.h>

This file is missing in the patch.

Regards,
Hartley
