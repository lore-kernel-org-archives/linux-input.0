From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH 2/3] Input: gpio-keys - simplify argument list for report_event
Date: Thu, 31 Jul 2008 21:04:22 +0200
Message-ID: <1217531063-2472-3-git-send-email-Uwe.Kleine-Koenig@digi.com>
References: <1217531063-2472-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
 <1217531063-2472-2-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail161.messagelabs.com ([216.82.253.115]:14771 "EHLO
	mail161.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188AbYGaTE3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2008 15:04:29 -0400
In-Reply-To: <1217531063-2472-2-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

=46or now this only saves a few instructions (for gpio_keys_report_even=
t,
gpio_keys_isr and gpio_check_button one instraction each on ARM using
arm-linux-gnu-gcc 4.2.3---I assume this is similar for other arch/compi=
ler
combinations).

Looking on the next patch this prepares having the same argument list f=
or
some more helper functions which saves a few more.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
 drivers/input/keyboard/gpio_keys.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index 3835892..0394b6d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -37,9 +37,10 @@ struct gpio_keys_drvdata {
 	struct gpio_button_data data[0];
 };
=20
-static void gpio_keys_report_event(struct gpio_keys_button *button,
-				   struct input_dev *input)
+static void gpio_keys_report_event(struct gpio_button_data *bdata)
 {
+	struct gpio_keys_button *button =3D bdata->button;
+	struct input_dev *input =3D bdata->input;
 	unsigned int type =3D button->type ?: EV_KEY;
 	int state =3D (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active=
_low;
=20
@@ -51,7 +52,7 @@ static void gpio_check_button(unsigned long _data)
 {
 	struct gpio_button_data *data =3D (struct gpio_button_data *)_data;
=20
-	gpio_keys_report_event(data->button, data->input);
+	gpio_keys_report_event(data);
 }
=20
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
@@ -66,7 +67,7 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_i=
d)
 				jiffies +
 				msecs_to_jiffies(button->debounce_interval));
 	else
-		gpio_keys_report_event(button, bdata->input);
+		gpio_keys_report_event(bdata);
=20
 	return IRQ_HANDLED;
 }
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
