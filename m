From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] INPUT: gpio_keys.c: Added OF support and enabled use with
 I2C GPIO expanders
Date: Thu, 2 Jun 2011 07:30:21 -0600
Message-ID: <BANLkTikt2iLXqOeO0ba0jK1+WiNRVBAESw@mail.gmail.com>
References: <-3144470533789149426@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47706 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1FBNam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Jun 2011 09:30:42 -0400
Received: by pzk9 with SMTP id 9so388071pzk.19
        for <linux-input@vger.kernel.org>; Thu, 02 Jun 2011 06:30:41 -0700 (PDT)
In-Reply-To: <-3144470533789149426@unknownmsgid>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: y@protonic.xs4all.nl
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

On Wed, Jun 1, 2011 at 3:07 AM,  <y@protonic.xs4all.nl> wrote:
> From: David Jander <david@protonic.nl>
>
> Signed-off-by: David Jander <david@protonic.nl>

There are a lot of unrelated changes being made in this patch.  Can
you split it up please into logical changes.  For example, adding
device tree support is one discrete change, reworking the handling of
struct device pointers is another, changing the initcall is another,
etc.

> ---
> =A0drivers/input/keyboard/gpio_keys.c | =A0192 ++++++++++++++++++++++=
++++++++------
> =A01 files changed, 161 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index eb30063..34e4174 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -3,6 +3,9 @@
> =A0*
> =A0* Copyright 2005 Phil Blundell
> =A0*
> + * Added OF support and enabled use with I2C GPIO expanders:
> + * Copyright 2010 David Jander <david@protonic.nl>
> + *
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> =A0* published by the Free Software Foundation.
> @@ -25,6 +28,10 @@
> =A0#include <linux/gpio_keys.h>
> =A0#include <linux/workqueue.h>
> =A0#include <linux/gpio.h>
> +#ifdef CONFIG_OF
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#endif

The #ifdef CONFIG_OF is not required around these headers

>
> =A0struct gpio_button_data {
> =A0 =A0 =A0 =A0struct gpio_keys_button *button;
> @@ -42,6 +49,7 @@ struct gpio_keys_drvdata {
> =A0 =A0 =A0 =A0int (*enable)(struct device *dev);
> =A0 =A0 =A0 =A0void (*disable)(struct device *dev);
> =A0 =A0 =A0 =A0struct gpio_button_data data[0];
> + =A0 =A0 =A0 struct gpio_keys_platform_data *dyn_pdata;

If you make this a copy of the gpio_keys_platform_data instead of a
pointer, then you can avoid kzallocing a pdata structure, and avoid
the messy question about when to free it.

> =A0};
>
> =A0/*
> @@ -251,8 +259,7 @@ static ssize_t gpio_keys_show_##name(struct devic=
e *dev, =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct device_attribute *attr, =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 char *buf) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0\
> - =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
); =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D platform_get_drvdat=
a(pdev); =A0 \
> + =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev=
); =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> =A0 =A0 =A0 =A0return gpio_keys_attr_show_helper(ddata, buf, =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0type, only_disabled); =A0 =A0 =A0 =A0 \
> @@ -278,8 +285,7 @@ static ssize_t gpio_keys_store_##name(struct devi=
ce *dev, =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0const char *buf, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0size_t count) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0\
> - =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
); =A0 =A0 =A0 =A0 \
> - =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D platform_get_drvdat=
a(pdev); =A0 \
> + =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev=
); =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0ssize_t error; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> =A0 =A0 =A0 =A0error =3D gpio_keys_attr_store_helper(ddata, buf, type=
); =A0 =A0 =A0 =A0 =A0\
> @@ -359,12 +365,11 @@ static irqreturn_t gpio_keys_isr(int irq, void =
*dev_id)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> -static int __devinit gpio_keys_setup_key(struct platform_device *pde=
v,
> +static int __devinit gpio_keys_setup_key(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct gpio_button_data *bdata,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct gpio_keys_button *button)
> =A0{
> =A0 =A0 =A0 =A0char *desc =3D button->desc ? button->desc : "gpio_key=
s";
> - =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0unsigned long irqflags;
> =A0 =A0 =A0 =A0int irq, error;
>
> @@ -410,8 +415,8 @@ static int __devinit gpio_keys_setup_key(struct p=
latform_device *pdev,
> =A0 =A0 =A0 =A0if (!button->can_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irqflags |=3D IRQF_SHARED;
>
> - =A0 =A0 =A0 error =3D request_any_context_irq(irq, gpio_keys_isr, i=
rqflags, desc, bdata);
> - =A0 =A0 =A0 if (error < 0) {
> + =A0 =A0 =A0 error =3D request_threaded_irq(irq, NULL, gpio_keys_isr=
, irqflags, desc, bdata);
> + =A0 =A0 =A0 if (error) {

You need to explain why you are making this change.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Unable to claim irq %d; =
error %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq, error);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;
> @@ -440,18 +445,133 @@ static void gpio_keys_close(struct input_dev *=
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
> +static struct gpio_keys_platform_data *
> +gpio_keys_get_alt_pdata(struct device *dev)

=46unction name should reflect what it does.  In this case, something
like gpio_keys_get_devtree_pdata() would be more appropriate.

> +{
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata;
> + =A0 =A0 =A0 struct device_node *node, *pp;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 struct gpio_keys_button *buttons;
> + =A0 =A0 =A0 const u32 *reg;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 node =3D dev->of_node;
> + =A0 =A0 =A0 if (node =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(struct gpio_keys_platform_data=
), GFP_KERNEL);
> + =A0 =A0 =A0 if (pdata =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Unable to allocate platfo=
rm_data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 reg =3D of_get_property(node, "linux,autorepeat", &len)=
;

You're creating a new binding.  You must also document it in
Documentation/devicetree/bindings.

> + =A0 =A0 =A0 if (reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->rep =3D reg[0];
> +
> + =A0 =A0 =A0 /* First count the subnodes */
> + =A0 =A0 =A0 pdata->nbuttons =3D 0;
> + =A0 =A0 =A0 pp =3D NULL;
> + =A0 =A0 =A0 while ((pp =3D of_get_next_child(node, pp)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons++;
> +
> + =A0 =A0 =A0 if (pdata->nbuttons =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 buttons =3D kzalloc(pdata->nbuttons * sizeof(*buttons),=
 GFP_KERNEL);
> + =A0 =A0 =A0 if (!buttons)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 pp =3D NULL;
> + =A0 =A0 =A0 i =3D 0;
> + =A0 =A0 =A0 while ((pp =3D of_get_next_child(node, pp))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *lbl;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "reg", &len=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("Found button wi=
thout reg\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].gpio =3D reg[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,code=
", &len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!reg) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Button wi=
thout keycode: 0x%x\n", buttons[i].gpio);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].code =3D reg[0];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lbl =3D of_get_property(pp, "label", &l=
en);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].desc =3D (char *)lbl;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].active_low =3D !!of_get_prop=
erty(pp, "linux,active_low", NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,inpu=
t_type", &len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D reg=
[0];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D EV_=
KEY;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].wakeup =3D !!of_get_property=
(pp, "linux,wakeup", NULL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D of_get_property(pp, "linux,debo=
unc_interval", &len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].debounce_int=
erval =3D reg[0];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].debounce_int=
erval =3D 5;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].can_disable =3D (bool)!!of_g=
et_property(pp, "linux,can_disable", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pdata->buttons =3D buttons;
> +
> + =A0 =A0 =A0 return pdata;
> +}
> +#else
> +static struct gpio_keys_platform_data *
> +gpio_keys_get_alt_pdata(struct device *dev)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +#endif
> +
> =A0static int __devinit gpio_keys_probe(struct platform_device *pdev)
> =A0{
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> =A0 =A0 =A0 =A0struct gpio_keys_drvdata *ddata;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *dyn_pdata =3D NULL;
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int i, error;
> =A0 =A0 =A0 =A0int wakeup =3D 0;
>
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D gpio_keys_get_alt_pdata(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pdata)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Unlike normal platform_data, this =
is allocated
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* dynamically and must be freed in t=
he driver
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->platform_data =3D pdata;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dyn_pdata =3D pdata;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ddata =3D kzalloc(sizeof(struct gpio_keys_drvdata) +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->nbuttons * size=
of(struct gpio_button_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> +
> + =A0 =A0 =A0 ddata->dyn_pdata =3D dyn_pdata;
> +
> =A0 =A0 =A0 =A0input =3D input_allocate_device();
> =A0 =A0 =A0 =A0if (!ddata || !input) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "failed to allocate state=
\n");
> @@ -465,12 +585,12 @@ static int __devinit gpio_keys_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0ddata->disable =3D pdata->disable;
> =A0 =A0 =A0 =A0mutex_init(&ddata->disable_lock);
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, ddata);
> + =A0 =A0 =A0 dev_set_drvdata(dev, ddata);
> =A0 =A0 =A0 =A0input_set_drvdata(input, ddata);
>
> - =A0 =A0 =A0 input->name =3D pdev->name;
> + =A0 =A0 =A0 input->name =3D "GPIO_keyboard";
> =A0 =A0 =A0 =A0input->phys =3D "gpio-keys/input0";
> - =A0 =A0 =A0 input->dev.parent =3D &pdev->dev;
> + =A0 =A0 =A0 input->dev.parent =3D dev;
> =A0 =A0 =A0 =A0input->open =3D gpio_keys_open;
> =A0 =A0 =A0 =A0input->close =3D gpio_keys_close;
>
> @@ -491,7 +611,7 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata->input =3D input;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bdata->button =3D button;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D gpio_keys_setup_key(pdev, bda=
ta, button);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D gpio_keys_setup_key(dev, bdat=
a, button);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail2;
>
> @@ -501,13 +621,12 @@ static int __devinit gpio_keys_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_capability(input, type, butt=
on->code);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 error =3D sysfs_create_group(&pdev->dev.kobj, &gpio_key=
s_attr_group);
> + =A0 =A0 =A0 error =3D sysfs_create_group(&dev->kobj, &gpio_keys_att=
r_group);
> =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Unable to export keys/sw=
itches, error: %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail2;
> =A0 =A0 =A0 =A0}
> -
> =A0 =A0 =A0 =A0error =3D input_register_device(input);
> =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Unable to register input=
 device, error: %d\n",
> @@ -520,12 +639,12 @@ static int __devinit gpio_keys_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_keys_report_event(&ddata->data[i]=
);
> =A0 =A0 =A0 =A0input_sync(input);
>
> - =A0 =A0 =A0 device_init_wakeup(&pdev->dev, wakeup);
> + =A0 =A0 =A0 device_init_wakeup(dev, wakeup);
>
> =A0 =A0 =A0 =A0return 0;
>
> =A0fail3:
> - =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_gro=
up);
> + =A0 =A0 =A0 sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
> =A0fail2:
> =A0 =A0 =A0 =A0while (--i >=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(gpio_to_irq(pdata->buttons[i]=
=2Egpio), &ddata->data[i]);
> @@ -535,7 +654,7 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->buttons[i].gpio);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 dev_set_drvdata(dev, NULL);
> =A0fail1:
> =A0 =A0 =A0 =A0input_free_device(input);
> =A0 =A0 =A0 =A0kfree(ddata);
> @@ -545,14 +664,15 @@ static int __devinit gpio_keys_probe(struct pla=
tform_device *pdev)
>
> =A0static int __devexit gpio_keys_remove(struct platform_device *pdev=
)
> =A0{
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> - =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D platform_get_drvdat=
a(pdev);
> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> + =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev=
);
> =A0 =A0 =A0 =A0struct input_dev *input =3D ddata->input;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_gro=
up);
> + =A0 =A0 =A0 sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
>
> - =A0 =A0 =A0 device_init_wakeup(&pdev->dev, 0);
> + =A0 =A0 =A0 device_init_wakeup(dev, 0);
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int irq =3D gpio_to_irq(pdata->buttons=
[i].gpio);
> @@ -562,21 +682,29 @@ static int __devexit gpio_keys_remove(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cancel_work_sync(&ddata->data[i].work)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->buttons[i].gpio);
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 if (ddata->dyn_pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata->buttons);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0input_unregister_device(input);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static struct of_device_id gpio_keys_of_match[] =3D {
> + =A0 =A0 =A0 { .compatible =3D "linux,gpio-keys", .data =3D NULL, },
> + =A0 =A0 =A0 { .compatible =3D "gpio-keys", .data =3D NULL, },

Drop the ".data =3D NULL" bit.

> + =A0 =A0 =A0 {},
> +};
>
> =A0#ifdef CONFIG_PM
> =A0static int gpio_keys_suspend(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (device_may_wakeup(&pdev->dev)) {
> + =A0 =A0 =A0 if (device_may_wakeup(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++=
) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_keys_butto=
n *button =3D &pdata->buttons[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (button->wakeup) {
> @@ -591,15 +719,14 @@ static int gpio_keys_suspend(struct device *dev=
)
>
> =A0static int gpio_keys_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev=
);
> - =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D platform_get_drvdat=
a(pdev);
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct gpio_keys_drvdata *ddata =3D dev_get_drvdata(dev=
);
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0for (i =3D 0; i < pdata->nbuttons; i++) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct gpio_keys_button *button =3D &p=
data->buttons[i];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (button->wakeup && device_may_wakeup=
(&pdev->dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (button->wakeup && device_may_wakeup=
(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int irq =3D gpio_to_ir=
q(button->gpio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_irq_wake(irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -617,6 +744,8 @@ static const struct dev_pm_ops gpio_keys_pm_ops =3D=
 {
> =A0};
> =A0#endif
>
> +MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
> +
> =A0static struct platform_driver gpio_keys_device_driver =3D {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D gpio_keys_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D __devexit_p(gpio_keys_remo=
ve),
> @@ -626,6 +755,7 @@ static struct platform_driver gpio_keys_device_dr=
iver =3D {
> =A0#ifdef CONFIG_PM
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D &gpio_keys_pm_ops,
> =A0#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D gpio_keys_of_match,
> =A0 =A0 =A0 =A0}
> =A0};
>
> @@ -639,10 +769,10 @@ static void __exit gpio_keys_exit(void)
> =A0 =A0 =A0 =A0platform_driver_unregister(&gpio_keys_device_driver);
> =A0}
>
> -module_init(gpio_keys_init);
> +late_initcall(gpio_keys_init);
> =A0module_exit(gpio_keys_exit);
>
> =A0MODULE_LICENSE("GPL");
> =A0MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
> -MODULE_DESCRIPTION("Keyboard driver for CPU GPIOs");
> +MODULE_DESCRIPTION("Keyboard driver for GPIOs");
> =A0MODULE_ALIAS("platform:gpio-keys");
> --
> 1.7.4.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
