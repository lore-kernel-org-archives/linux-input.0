From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH RESENT] [RFC] gpio-keys: let platform code specify the trigger type
Date: Thu, 10 Jul 2008 10:58:44 +0200
Message-ID: <1215680324-32164-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
References: <1215070080-13755-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:55182 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbYGJI6s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jul 2008 04:58:48 -0400
In-Reply-To: <1215070080-13755-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, David Brownell <dbrownell@users.sourceforge.net>, Dmitry Torokhov <dtor@mail.ru>, Herbert Valerio Riedel <hvr@gnu.org>

The intend for this change is that not all platform's irqs support
triggering on both edges.  Examples are ns9xxx[1] and txx9[2], and I
expect that there are more.

Provided that the platform data is initialized with zeros there is no
change in behavior if the new struct member 'trigger' isn't set in
platform code.

open points:
 - if only one trigger direction is used it should match active_low suc=
h
   that the button press generates the irq.
 - poll for button release instead of generate the release event
   directly after the press?
 - is it correct to input_sync() between press and release event?
 - sanitize button->trigger &=3D IRQF_TRIGGER_EDGE in gpio_keys_probe
   before passing it to request_irq?
 - a comment describing the trigger member of struct gpio_keys_button

I'd like to have polling support in this driver.  This could use
button->trigger =3D=3D 0, so it might be sensible to add a
WARN_ON(!button->trigger) for now and wait some time before implementin=
g
it.

[There is no MAINTAINER entry for gpio-keys, so I Cc: the last
contributors.]

[1] The code to show that isn't in vanilla yet.  Basic machine support
    is in arch/arm/mach-ns9xxx.
[2] see txx9_irq_set_type in arch/mips/kernel/irq_txx9.c

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Herbert Valerio Riedel <hvr@gnu.org>

---
Hello,

I already sent this mail a week ago, so far without any feedback.  So I=
 just
start a new try.

Best regards
Uwe

 drivers/input/keyboard/gpio_keys.c |   15 +++++++++++++--
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index bbd00c3..43a4c0c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -26,6 +26,10 @@
=20
 #include <asm/gpio.h>
=20
+#ifndef IRQF_TRIGGER_EDGE
+#define IRQF_TRIGGER_EDGE (IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)
+#endif
+
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
 	int i;
@@ -43,6 +47,11 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_=
id)
=20
 			input_event(input, type, button->code, !!state);
 			input_sync(input);
+
+			if (~button->trigger & IRQF_TRIGGER_EDGE) {
+				input_event(input, type, button->code, !state);
+				input_sync(input);
+			}
 			return IRQ_HANDLED;
 		}
 	}
@@ -105,9 +114,11 @@ static int __devinit gpio_keys_probe(struct platfo=
rm_device *pdev)
 			goto fail;
 		}
=20
+		if (!button->trigger)
+			button->trigger =3D IRQF_TRIGGER_EDGE;
+
 		error =3D request_irq(irq, gpio_keys_isr,
-				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
+				    IRQF_SAMPLE_RANDOM | button->trigger,
 				    button->desc ? button->desc : "gpio_keys",
 				    pdev);
 		if (error) {
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index c6d3a9d..afe9d5d 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -9,6 +9,7 @@ struct gpio_keys_button {
 	char *desc;
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
+	unsigned long trigger;
 };
=20
 struct gpio_keys_platform_data {
--=20
1.5.6

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
