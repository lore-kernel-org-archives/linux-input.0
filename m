From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sharp c-3000 aka spitz: fix warn_on introduced in 2.6.32-rc1
Date: Thu, 29 Apr 2010 15:08:52 +0200
Message-ID: <20100429130852.GC1661@ucw.cz>
References: <20100106071026.GD1382@ucw.cz>
	<f17812d71001052317h2bf25fady6bd729b35ef6db63@mail.gmail.com>
	<20100107065230.GA1303@ucw.cz>
	<f17812d71001062333y2e49fa21scf91718da9ae3091@mail.gmail.com>
	<20100305092338.GA32433@atrey.karlin.mff.cuni.cz>
	<f17812d71003072135wcc7165m31a302b7da75c36e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f17812d71003072135wcc7165m31a302b7da75c36e@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, thommycheck@gmail.com, dbaryshkov@gmail.com, dtor@mail.ru, arminlitzel@web.de, kernel list <linux-kernel@vger.kernel.org>, Cyril Hrubis <metan@ucw.cz>, Dirk@opfer-online.de, utx@penguin.cz, lenz@cs.wisc.edu, rpurdie@rpsys.net, omegamoon@gmail.com, linux-input@vger.kernel.org, zaurus-devel@lists.linuxtogo.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

Hi!

Okay, maybe this is better fix for the regression?

Simplify irq wakeup code, and fix ugly warning during resume on spitz
as a result.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- ./drivers/input/keyboard/pxa27x_keypad.c	2010-04-15 07:50:34.000000000 +0200
+++ ./drivers/input/keyboard/pxa27x_keypad.c	2010-04-27 15:38:02.000000000 +0200
@@ -33,6 +33,8 @@
 
 #include <mach/hardware.h>
 #include <mach/pxa27x_keypad.h>
+#include <mach/mfp-pxa2xx.h>
+
 /*
  * Keypad Controller registers
  */
@@ -412,7 +416,7 @@
 	clk_disable(keypad->clk);
 
 	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(keypad->irq);
+		keypad_set_wake(1);
 
 	return 0;
 }
@@ -424,7 +428,7 @@
 	struct input_dev *input_dev = keypad->input_dev;
 
 	if (device_may_wakeup(&pdev->dev))
-		disable_irq_wake(keypad->irq);
+		keypad_set_wake(0);
 
 	mutex_lock(&input_dev->mutex);
 
--- ./arch/arm/mach-pxa/mfp-pxa2xx.c	2009-09-10 00:13:59.000000000 +0200
+++ ./arch/arm/mach-pxa/mfp-pxa2xx.c	2010-04-27 15:22:42.000000000 +0200
@@ -34,7 +34,6 @@
 struct gpio_desc {
 	unsigned	valid		: 1;
 	unsigned	can_wakeup	: 1;
-	unsigned	keypad_gpio	: 1;
 	unsigned	dir_inverted	: 1;
 	unsigned int	mask; /* bit mask in PWER or PKWR */
 	unsigned int	mux_mask; /* bit mask of muxed gpio bits, 0 if no mux */
@@ -178,9 +177,6 @@
 	if (!d->valid)
 		return -EINVAL;
 
-	if (d->keypad_gpio)
-		return -EINVAL;
-
 	mux_taken = (PWER & d->mux_mask) & (~d->mask);
 	if (on && mux_taken)
 		return -EBUSY;
@@ -291,7 +288,6 @@
 	for (i = 0; i < ARRAY_SIZE(pxa27x_pkwr_gpio); i++) {
 		gpio = pxa27x_pkwr_gpio[i];
 		gpio_desc[gpio].can_wakeup = 1;
-		gpio_desc[gpio].keypad_gpio = 1;
 		gpio_desc[gpio].mask = 1 << i;
 	}
 
--- ./arch/arm/mach-pxa/pxa27x.c	2010-03-21 22:09:12.000000000 +0100
+++ ./arch/arm/mach-pxa/pxa27x.c	2010-04-27 07:43:30.000000000 +0200
@@ -342,9 +342,6 @@
 	if (gpio >= 0 && gpio < 128)
 		return gpio_set_wake(gpio, on);
 
-	if (irq == IRQ_KEYPAD)
-		return keypad_set_wake(on);
-
 	switch (irq) {
 	case IRQ_RTCAlrm:
 		mask = PWER_RTC;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
