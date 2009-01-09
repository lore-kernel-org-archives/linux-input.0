From: akpm@linux-foundation.org
Subject: [patch 01/17] drivers/input/touchscreen/ucb1400_ts.c needs GPIO
Date: Fri, 09 Jan 2009 12:19:40 -0800
Message-ID: <200901092019.n09KJfo3017101@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58791 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753440AbZAIUUr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 15:20:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, david-b@pacbell.net, marek.vasut@gmail.com, nico@marvell.com, rmk+kernel@arm.linux.org.uk, vsauder@inhand.com

From: Andrew Morton <akpm@linux-foundation.org>

ia64 allmodconfig:

include/asm-generic/gpio.h: In function `gpio_get_value_cansleep':
include/asm-generic/gpio.h:147: error: implicit declaration of function `gpio_get_value'
include/asm-generic/gpio.h: In function `gpio_set_value_cansleep':
include/asm-generic/gpio.h:153: error: implicit declaration of function `gpio_set_value'

recent linux-next breakage.  Not sure what caused it..

Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Vernon Sauder <vsauder@inhand.com>
Cc: Nicolas Pitre <nico@marvell.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/input/touchscreen/Kconfig~drivers-input-touchscreen-ucb1400_tsc-needs-gpio drivers/input/touchscreen/Kconfig
--- a/drivers/input/touchscreen/Kconfig~drivers-input-touchscreen-ucb1400_tsc-needs-gpio
+++ a/drivers/input/touchscreen/Kconfig
@@ -246,6 +246,7 @@ config TOUCHSCREEN_UCB1400
 	tristate "Philips UCB1400 touchscreen"
 	depends on AC97_BUS
 	depends on UCB1400_CORE
+	depends on GPIOLIB
 	help
 	  This enables support for the Philips UCB1400 touchscreen interface.
 	  The UCB1400 is an AC97 audio codec.  The touchscreen interface
_
