From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Mon, 4 Jul 2011 10:28:06 -0700
Message-ID: <20110704172806.GE8144@core.coreip.homeip.net>
References: <1308823455-14446-1-git-send-email-david@protonic.nl>
 <1308823455-14446-2-git-send-email-david@protonic.nl>
 <BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
 <20110623133908.5c85eb3c@lxorguk.ukuu.org.uk>
 <BANLkTim3S+LP2UfS5Uy4rV6oZcDgom6DPg@mail.gmail.com>
 <20110623180121.GA14950@core.coreip.homeip.net>
 <20110704082939.6da4aaeb@archvile>
 <94bc67c6-6a34-43f0-b88f-8a4278115730@email.android.com>
 <20110704085651.6408dcbc@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49040 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab1GEEgk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:36:40 -0400
Received: by mail-iw0-f174.google.com with SMTP id 6so4900484iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:36:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110704085651.6408dcbc@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Mon, Jul 04, 2011 at 08:56:51AM +0200, David Jander wrote:
> On Mon, 04 Jul 2011 10:52:55 +0400
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>=20
> > David Jander <david.jander@protonic.nl> wrote:
> >=20
> > >On Thu, 23 Jun 2011 11:01:22 -0700
> > >Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > >> On Thu, Jun 23, 2011 at 07:25:37AM -0600, Grant Likely wrote:
> > >> > On Thu, Jun 23, 2011 at 6:39 AM, Alan Cox
> > ><alan@lxorguk.ukuu.org.uk> wrote:
> > >> > >> > + =A0 =A0 =A0 - gpios: OF devcie-tree gpio specificatin.
> > >> > >> > + =A0 =A0 =A0 - label: Descriptive name of the key.
> > >> > >> > + =A0 =A0 =A0 - linux,code: Keycode to emit.
> > >> > >>
> > >> > >> The fact that this is the Linux internal keycode definition=
s
> > >still
> > >> > >> makes me nervous. =A0Is there no existing standard for keyc=
odes
> > >emitted
> > >> > >> by keyboard devices?
> > >> > >
> > >> > > There is but no standard lookup table. For Intel MID we do a
> > >translation
> > >> > > between Linux key names in the firmware and keycodes but the=
re
> > >isn't a
> > >> > > generic helper for it.
> > >> >=20
> > >> > I suppose the Linux keycodes are exported out to userspace, an=
d are
> > >> > therefore an ABI which will not change.  Okay.
> > >>=20
> > >> Right, keycodes form ABI that will not change.
> > >>=20
> > >> Another option would be to use codes from HID usage tables but t=
hen
> > >> they would have to be translated to Linux ones.
> > >
> > >Dmitry, will you accept this patch also?
> > >Until now, part 2/2 is in your tree, thanks for that, but I'd like=
 to
> > >know if
> > >this part (1/2) will also be accepted?
> > >
> >=20
> > Yes, I will since there was no more discussion about hid codes and =
I do
> > believe that using linux definitions is fine.
>=20
> Ok, thanks.
>=20

Noticed that we leaked dynamically allocated button data in case when
gpio_keys_probe() fails. Also removed changelog from copyright notice
(we have SCM for it) and got rid of a warning in case of !CONFIG_OF.

Could you please tell me if the patch below still work for you?

Grant, can I get your formal Ack for OF bindings?

Thanks.

--=20
Dmitry


Input: gpio_keys - add support for device-tree platform data

=46rom: David Jander <david@protonic.nl>

This patch enables fetching configuration data, which is normally provi=
ded
via platform_data, from the device-tree instead.

If the device is configured from device-tree data, the platform_data st=
ruct
is not used, and button data needs to be allocated dynamically. Big par=
t of
this patch deals with confining pdata usage to the probe function, to m=
ake
this possible.

Signed-off-by: David Jander <david@protonic.nl>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 .../devicetree/bindings/gpio/gpio_keys.txt         |   36 +++++
 drivers/input/keyboard/gpio_keys.c                 |  148 ++++++++++++=
++++++--
 2 files changed, 168 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.tx=
t


diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/Doc=
umentation/devicetree/bindings/gpio/gpio_keys.txt
new file mode 100644
index 0000000..7190c99
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
@@ -0,0 +1,36 @@
+Device-Tree bindings for input/gpio_keys.c keyboard driver
+
+Required properties:
+	- compatible =3D "gpio-keys";
+
+Optional properties:
+	- autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem.
+
+Each button (key) is represented as a sub-node of "gpio-keys":
+Subnode properties:
+
+	- gpios: OF devcie-tree gpio specificatin.
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+
+Optional subnode-properties:
+	- linux,input-type: Specify event type this button/key generates.
+	  If not specified defaults to <1> =3D=3D EV_KEY.
+	- debounce-interval: Debouncing interval time in milliseconds.
+	  If not specified defaults to 5.
+	- gpio-key,wakeup: Boolean, button can wake-up the system.
+
+Example nodes:
+
+	gpio_keys {
+			compatible =3D "gpio-keys";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			autorepeat;
+			button@21 {
+				label =3D "GPIO Key UP";
+				linux,code =3D <103>;
+				gpios =3D <&gpio1 0 1>;
+			};
+			...
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboar=
d/gpio_keys.c
index 97bada4..ad11e86 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -2,6 +2,7 @@
  * Driver for keys on GPIO lines capable of generating interrupts.
  *
  * Copyright 2005 Phil Blundell
+ * Copyright 2010, 2011 David Jander <david@protonic.nl>
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -25,6 +26,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
=20
 struct gpio_button_data {
 	struct gpio_keys_button *button;
@@ -445,15 +448,120 @@ static void gpio_keys_close(struct input_dev *in=
put)
 		ddata->disable(input->dev.parent);
 }
=20
+/*
+ * Handlers for alternative sources of platform_data
+ */
+#ifdef CONFIG_OF
+/*
+ * Translate OpenFirmware node properties into platform_data
+ */
+static int gpio_keys_get_devtree_pdata(struct device *dev,
+			    struct gpio_keys_platform_data *pdata)
+{
+	struct device_node *node, *pp;
+	int i;
+	struct gpio_keys_button *buttons;
+	const u32 *reg;
+	int len;
+
+	node =3D dev->of_node;
+	if (node =3D=3D NULL)
+		return -ENODEV;
+
+	memset(pdata, 0, sizeof *pdata);
+
+	pdata->rep =3D !!of_get_property(node, "autorepeat", &len);
+
+	/* First count the subnodes */
+	pdata->nbuttons =3D 0;
+	pp =3D NULL;
+	while ((pp =3D of_get_next_child(node, pp)))
+		pdata->nbuttons++;
+
+	if (pdata->nbuttons =3D=3D 0)
+		return -ENODEV;
+
+	buttons =3D kzalloc(pdata->nbuttons * (sizeof *buttons), GFP_KERNEL);
+	if (!buttons)
+		return -ENODEV;
+
+	pp =3D NULL;
+	i =3D 0;
+	while ((pp =3D of_get_next_child(node, pp))) {
+		enum of_gpio_flags flags;
+
+		if (!of_find_property(pp, "gpios", NULL)) {
+			pdata->nbuttons--;
+			dev_warn(dev, "Found button without gpios\n");
+			continue;
+		}
+		buttons[i].gpio =3D of_get_gpio_flags(pp, 0, &flags);
+		buttons[i].active_low =3D flags & OF_GPIO_ACTIVE_LOW;
+
+		reg =3D of_get_property(pp, "linux,code", &len);
+		if (!reg) {
+			dev_err(dev, "Button without keycode: 0x%x\n", buttons[i].gpio);
+			goto out_fail;
+		}
+		buttons[i].code =3D be32_to_cpup(reg);
+
+		buttons[i].desc =3D of_get_property(pp, "label", &len);
+
+		reg =3D of_get_property(pp, "linux,input-type", &len);
+		buttons[i].type =3D reg ? be32_to_cpup(reg) : EV_KEY;
+
+		buttons[i].wakeup =3D !!of_get_property(pp, "gpio-key,wakeup", NULL)=
;
+
+		reg =3D of_get_property(pp, "debounce-interval", &len);
+		buttons[i].debounce_interval =3D reg ? be32_to_cpup(reg) : 5;
+
+		i++;
+	}
+
+	pdata->buttons =3D buttons;
+
+	return 0;
+
+out_fail:
+	kfree(buttons);
+	return -ENODEV;
+}
+
+static struct of_device_id gpio_keys_of_match[] =3D {
+	{ .compatible =3D "gpio-keys", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
+
+#else
+
+static int gpio_keys_get_devtree_pdata(struct device *dev,
+			    struct gpio_keys_platform_data *altp)
+{
+	return -ENODEV;
+}
+
+#define gpio_keys_of_match NULL
+
+#endif
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
 	struct device *dev =3D &pdev->dev;
+	struct gpio_keys_platform_data alt_pdata;
 	struct input_dev *input;
 	int i, error;
 	int wakeup =3D 0;
=20
+	if (!pdata) {
+		error =3D gpio_keys_get_devtree_pdata(dev, &alt_pdata);
+		if (error)
+			return error;
+		pdata =3D &alt_pdata;
+	}
+
 	ddata =3D kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
@@ -544,13 +652,15 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
  fail1:
 	input_free_device(input);
 	kfree(ddata);
+	/* If we have no platform_data, we allocated buttons dynamically. */
+	if (!pdev->dev.platform_data)
+		kfree(pdata->buttons);
=20
 	return error;
 }
=20
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata =3D platform_get_drvdata(pdev);
 	struct input_dev *input =3D ddata->input;
 	int i;
@@ -559,32 +669,39 @@ static int __devexit gpio_keys_remove(struct plat=
form_device *pdev)
=20
 	device_init_wakeup(&pdev->dev, 0);
=20
-	for (i =3D 0; i < pdata->nbuttons; i++) {
-		int irq =3D gpio_to_irq(pdata->buttons[i].gpio);
+	for (i =3D 0; i < ddata->n_buttons; i++) {
+		int irq =3D gpio_to_irq(ddata->data[i].button->gpio);
 		free_irq(irq, &ddata->data[i]);
 		if (ddata->data[i].timer_debounce)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
-		gpio_free(pdata->buttons[i].gpio);
+		gpio_free(ddata->data[i].button->gpio);
 	}
=20
 	input_unregister_device(input);
+
+	/*
+	 * If we had no platform_data, we allocated buttons dynamically, and
+	 * must free them here. ddata->data[0].button is the pointer to the
+	 * beginning of the allocated array.
+	 */
+	if (!pdev->dev.platform_data)
+		kfree(ddata->data[0].button);
+
 	kfree(ddata);
=20
 	return 0;
 }
=20
-
 #ifdef CONFIG_PM
 static int gpio_keys_suspend(struct device *dev)
 {
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev);
 	int i;
=20
-	if (device_may_wakeup(&pdev->dev)) {
-		for (i =3D 0; i < pdata->nbuttons; i++) {
-			struct gpio_keys_button *button =3D &pdata->buttons[i];
+	if (device_may_wakeup(dev)) {
+		for (i =3D 0; i < ddata->n_buttons; i++) {
+			struct gpio_keys_button *button =3D ddata->data[i].button;
 			if (button->wakeup) {
 				int irq =3D gpio_to_irq(button->gpio);
 				enable_irq_wake(irq);
@@ -597,15 +714,13 @@ static int gpio_keys_suspend(struct device *dev)
=20
 static int gpio_keys_resume(struct device *dev)
 {
-	struct platform_device *pdev =3D to_platform_device(dev);
-	struct gpio_keys_drvdata *ddata =3D platform_get_drvdata(pdev);
-	struct gpio_keys_platform_data *pdata =3D pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev);
 	int i;
=20
-	for (i =3D 0; i < pdata->nbuttons; i++) {
+	for (i =3D 0; i < ddata->n_buttons; i++) {
=20
-		struct gpio_keys_button *button =3D &pdata->buttons[i];
-		if (button->wakeup && device_may_wakeup(&pdev->dev)) {
+		struct gpio_keys_button *button =3D ddata->data[i].button;
+		if (button->wakeup && device_may_wakeup(dev)) {
 			int irq =3D gpio_to_irq(button->gpio);
 			disable_irq_wake(irq);
 		}
@@ -632,6 +747,7 @@ static struct platform_driver gpio_keys_device_driv=
er =3D {
 #ifdef CONFIG_PM
 		.pm	=3D &gpio_keys_pm_ops,
 #endif
+		.of_match_table =3D gpio_keys_of_match,
 	}
 };
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
