From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 1/2] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Thu, 23 Jun 2011 06:29:46 -0600
Message-ID: <BANLkTinbnsVc9a=ZTUFutEvZ_vPagTqhOA@mail.gmail.com>
References: <1308823455-14446-1-git-send-email-david@protonic.nl> <1308823455-14446-2-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43019 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab1FWMaH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 08:30:07 -0400
Received: by ywe9 with SMTP id 9so690127ywe.19
        for <linux-input@vger.kernel.org>; Thu, 23 Jun 2011 05:30:06 -0700 (PDT)
In-Reply-To: <1308823455-14446-2-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Thu, Jun 23, 2011 at 4:04 AM, David Jander <david@protonic.nl> wrote=
:
> This patch enables fetching configuration data which is normally prov=
ided via
> platform_data from the device-tree instead.
> If the device is configured from device-tree data, the platform_data =
struct
> is not used, and button data needs to be allocated dynamically.
> Big part of this patch deals with confining pdata usage to the probe =
function,
> to make this possible.
>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
> =A0.../devicetree/bindings/gpio/gpio_keys.txt =A0 =A0 =A0 =A0 | =A0 3=
7 +++++
> =A0drivers/input/keyboard/gpio_keys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0146 ++++++++++++++++++--
> =A02 files changed, 168 insertions(+), 15 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/gpio/gpio_key=
s.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/D=
ocumentation/devicetree/bindings/gpio/gpio_keys.txt
> new file mode 100644
> index 0000000..a0fed97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> @@ -0,0 +1,37 @@
> +Device-Tree bindings for input/gpio_keys.c keyboard driver
> +
> +Required properties:
> + =A0 =A0 =A0 - compatible =3D "gpio-keys";
> +
> +Optional properties:
> + =A0 =A0 =A0 - autorepeat: Boolean, Enable auto repeat feature of Li=
nux input
> + =A0 =A0 =A0 =A0 subsystem.
> +
> +Each button (key) is represented as a sub-node of "gpio-keys":
> +Subnode properties:
> +
> + =A0 =A0 =A0 - gpios: OF devcie-tree gpio specificatin.
> + =A0 =A0 =A0 - label: Descriptive name of the key.
> + =A0 =A0 =A0 - linux,code: Keycode to emit.

The fact that this is the Linux internal keycode definitions still
makes me nervous.  Is there no existing standard for keycodes emitted
by keyboard devices?

> +
> +Optional subnode-properties:
> + =A0 =A0 =A0 - linux,input-type: Specify event type this button/key =
generates.
> + =A0 =A0 =A0 =A0 Default if unspecified is <1> =3D=3D EV_KEY.
> + =A0 =A0 =A0 - debounce-interval: Debouncing interval time in millis=
econds.
> + =A0 =A0 =A0 =A0 Default if unspecified is 5.
> + =A0 =A0 =A0 - gpio-key,wakeup: Boolean, button can wake-up the syst=
em.
> +
> +Example nodes:
> +
> + =A0 =A0 =A0 gpio_keys {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "gpio-ke=
ys";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 autorepeat;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 button@21 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D=
 "GPIO Key UP";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,c=
ode =3D <103>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpios =3D=
 <&gpio1 0 1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> +
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index 6e6145b..2db7db2 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -3,6 +3,9 @@
> =A0*
> =A0* Copyright 2005 Phil Blundell
> =A0*
> + * Added OF support:
> + * Copyright 2010, 2011 David Jander <david@protonic.nl>
> + *
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> =A0* published by the Free Software Foundation.
> @@ -25,6 +28,8 @@
> =A0#include <linux/gpio_keys.h>
> =A0#include <linux/workqueue.h>
> =A0#include <linux/gpio.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
>
> =A0struct gpio_button_data {
> =A0 =A0 =A0 =A0struct gpio_keys_button *button;
> @@ -445,15 +450,111 @@ static void gpio_keys_close(struct input_dev *=
input)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ddata->disable(input->dev.parent);
> =A0}
>
> +/*
> + * Handlers for alternative sources of platform_data
> + */
> +#ifdef CONFIG_OF
> +/*
> + * Translate OpenFirmware node properties into platform_data
> + */
> +static int gpio_keys_get_devtree_pdata(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_key=
s_platform_data *pdata)
> +{
> + =A0 =A0 =A0 struct device_node *node, *pp;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct gpio_keys_button *buttons;
> + =A0 =A0 =A0 const u32 *reg;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 node =3D dev->of_node;
> + =A0 =A0 =A0 if (node =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 memset(pdata, 0, sizeof *pdata);
> +
> + =A0 =A0 =A0 pdata->rep =3D !!of_get_property(node, "autorepeat", &l=
en);
> +
> + =A0 =A0 =A0 /* First count the subnodes */
> + =A0 =A0 =A0 pdata->nbuttons =3D 0;
> + =A0 =A0 =A0 pp =3D NULL;
> + =A0 =A0 =A0 while ((pp =3D of_get_next_child(node, pp)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons++;
> +
> + =A0 =A0 =A0 if (pdata->nbuttons =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 buttons =3D kzalloc(pdata->nbuttons * (sizeof *buttons)=
, GFP_KERNEL);
> + =A0 =A0 =A0 if (!buttons)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 pp =3D NULL;
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 while ((pp =3D of_get_next_child(node, pp))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *lbl;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum of_gpio_flags flags;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!of_find_property(pp, "gpios", NULL=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "Found bu=
tton without gpios\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].gpio =3D of_get_gpio_flags(p=
p, 0, &flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].active_low =3D !!(flags & OF=
_GPIO_ACTIVE_LOW);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,code=
", &len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Button wi=
thout keycode: 0x%x\n", buttons[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fail;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].code =3D be32_to_cpup(reg);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lbl =3D of_get_property(pp, "label", &l=
en);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].desc =3D (char *)lbl;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,inpu=
t-type", &len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D reg ? be32_to_cpup(=
reg) : EV_KEY;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].wakeup =3D !!of_get_property=
(pp, "gpio-key,wakeup", NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "debounce-i=
nterval", &len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].debounce_interval =3D reg ? =
be32_to_cpup(reg) : 5;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pdata->buttons =3D buttons;
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_fail:
> + =A0 =A0 =A0 kfree(buttons);
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +#else
> +static int gpio_keys_get_devtree_pdata(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_key=
s_platform_data *altp)
> +{
> + =A0 =A0 =A0 return -ENODEV;
> +}
> +#endif
> +
> =A0static int __devinit gpio_keys_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct gpio_keys_platform_data *pdata =3D pdev->dev.pl=
atform_data;
> =A0 =A0 =A0 =A0struct gpio_keys_drvdata *ddata;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct gpio_keys_platform_data alt_pdata;
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int i, error;
> =A0 =A0 =A0 =A0int wakeup =3D 0;
>
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D gpio_keys_get_devtree_pdata(d=
ev, &alt_pdata);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &alt_pdata;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ddata =3D kzalloc(sizeof(struct gpio_keys_drvdata) +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->nbuttons * size=
of(struct gpio_button_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> @@ -550,7 +651,6 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
>
> =A0static int __devexit gpio_keys_remove(struct platform_device *pdev=
)
> =A0{
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> =A0 =A0 =A0 =A0struct gpio_keys_drvdata *ddata =3D platform_get_drvda=
ta(pdev);
> =A0 =A0 =A0 =A0struct input_dev *input =3D ddata->input;
> =A0 =A0 =A0 =A0int i;
> @@ -559,31 +659,42 @@ static int __devexit gpio_keys_remove(struct pl=
atform_device *pdev)
>
> =A0 =A0 =A0 =A0device_init_wakeup(&pdev->dev, 0);
>
> - =A0 =A0 =A0 for (i =3D 0; i < pdata->nbuttons; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq =3D gpio_to_irq(pdata->buttons[=
i].gpio);
> + =A0 =A0 =A0 for (i =3D 0; i < ddata->n_buttons; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq =3D gpio_to_irq(ddata->data[i].=
button->gpio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(irq, &ddata->data[i]);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ddata->data[i].timer_debounce)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0del_timer_sync(&ddata-=
>data[i].timer);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cancel_work_sync(&ddata->data[i].work)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->buttons[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ddata->data[i].button->gpio);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If we had no platform_data, we allocated buttons d=
ynamically, and
> + =A0 =A0 =A0 =A0* must free them here. ddata->data[0].button is the =
pointer to the
> + =A0 =A0 =A0 =A0* beginning of the allocated array.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!pdev->dev.platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(ddata->data[0].button);
> +
> =A0 =A0 =A0 =A0input_unregister_device(input);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static struct of_device_id gpio_keys_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "gpio-keys", },
> + =A0 =A0 =A0 {},
> +};

This gpio_keys_of_match[]...

> @@ -622,6 +731,12 @@ static const struct dev_pm_ops gpio_keys_pm_ops =
=3D {
> =A0};
> =A0#endif
>
> +#ifdef CONFIG_OF
> +MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
> +#else
> +#define gpio_keys_of_match NULL
> +#endif

=2E..belongs inside this #ifdef CONFIG_OF block.

In fact, there should only need to be one #ifdef CONFIG_OF/#else block
in this .c file.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
