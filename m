From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH 1/3] Input: gpio-keys - optimize interrupt handler
Date: Thu, 31 Jul 2008 21:04:21 +0200
Message-ID: <1217531063-2472-2-git-send-email-Uwe.Kleine-Koenig@digi.com>
References: <1217531063-2472-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail51.messagelabs.com ([216.82.244.179]:29292 "EHLO
	mail51.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757480AbYGaTEa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2008 15:04:30 -0400
In-Reply-To: <1217531063-2472-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

By passing a gpio_button_data structure to the handler instead of the
whole platform_device the search for the right button can go away.

Signed-off-by: Uwe Kleine-K=C3=B6nig <Uwe.Kleine-Koenig@digi.com>
---
 drivers/input/keyboard/gpio_keys.c |   36 +++++++++++++---------------=
--------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index 3f48279..3835892 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -56,29 +56,19 @@ static void gpio_check_button(unsigned long _data)
=20
 static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 {
-	struct platform_device *pdev =3D dev_id;
-	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
-	struct gpio_keys_drvdata *ddata =3D platform_get_drvdata(pdev);
-	int i;
+	struct gpio_button_data *bdata =3D dev_id;
+	struct gpio_keys_button *button =3D bdata->button;
=20
-	for (i =3D 0; i < pdata->nbuttons; i++) {
-		struct gpio_keys_button *button =3D &pdata->buttons[i];
+	BUG_ON(irq !=3D gpio_to_irq(button->gpio));
=20
-		if (irq =3D=3D gpio_to_irq(button->gpio)) {
-			struct gpio_button_data *bdata =3D &ddata->data[i];
-
-			if (button->debounce_interval)
-				mod_timer(&bdata->timer,
-					  jiffies +
-					  msecs_to_jiffies(button->debounce_interval));
-			else
-				gpio_keys_report_event(button, bdata->input);
-
-			return IRQ_HANDLED;
-		}
-	}
+	if (button->debounce_interval)
+		mod_timer(&bdata->timer,
+				jiffies +
+				msecs_to_jiffies(button->debounce_interval));
+	else
+		gpio_keys_report_event(button, bdata->input);
=20
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
=20
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
@@ -152,7 +142,7 @@ static int __devinit gpio_keys_probe(struct platfor=
m_device *pdev)
 				    IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_RISING |
 					IRQF_TRIGGER_FALLING,
 				    button->desc ? button->desc : "gpio_keys",
-				    pdev);
+				    bdata);
 		if (error) {
 			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
 				irq, error);
@@ -179,7 +169,7 @@ static int __devinit gpio_keys_probe(struct platfor=
m_device *pdev)
=20
  fail2:
 	while (--i >=3D 0) {
-		free_irq(gpio_to_irq(pdata->buttons[i].gpio), pdev);
+		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
@@ -204,7 +194,7 @@ static int __devexit gpio_keys_remove(struct platfo=
rm_device *pdev)
=20
 	for (i =3D 0; i < pdata->nbuttons; i++) {
 		int irq =3D gpio_to_irq(pdata->buttons[i].gpio);
-		free_irq(irq, pdev);
+		free_irq(irq, &ddata->data[i]);
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
 		gpio_free(pdata->buttons[i].gpio);
--=20
1.5.6.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
