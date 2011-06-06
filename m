From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] Input: gpio_keys.c: Added support for device-tree
 platform data
Date: Mon, 6 Jun 2011 09:52:31 -0600
Message-ID: <BANLkTik1D6KXSupz5L54DhAy5tSLxV=OVA@mail.gmail.com>
References: <1307373155-29470-1-git-send-email-david@protonic.nl> <1307373155-29470-3-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58688 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757675Ab1FFPwv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 11:52:51 -0400
Received: by pwi15 with SMTP id 15so2165939pwi.19
        for <linux-input@vger.kernel.org>; Mon, 06 Jun 2011 08:52:51 -0700 (PDT)
In-Reply-To: <1307373155-29470-3-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Jun 6, 2011 at 9:12 AM, David Jander <david@protonic.nl> wrote:
> Signed-off-by: David Jander <david@protonic.nl>
> ---
> =A0.../devicetree/bindings/gpio/gpio_keys.txt =A0 =A0 =A0 =A0 | =A0 4=
9 ++++++++
> =A0drivers/input/keyboard/gpio_keys.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0131 ++++++++++++++++++++
> =A02 files changed, 180 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/devicetree/bindings/gpio/gpio_key=
s.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/D=
ocumentation/devicetree/bindings/gpio/gpio_keys.txt
> new file mode 100644
> index 0000000..ff8ba2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
> @@ -0,0 +1,49 @@
> +Device-Tree bindings for input/gpio_keys.c keyboard driver
> +
> +Required properties:
> + =A0 =A0 =A0 - compatible =3D "linux,gpio-keys", "gpio-keys";

Drop linux,gpio-keys

> +
> +Optional properties:
> + =A0 =A0 =A0 - linux,autorepeat: Boolean, Enable auto repeat feature=
 of Linux input
> + =A0 =A0 =A0 =A0 subsystem.

Drop the linux specific bits.  Define the properties you need to
describe the behaviour or the keypad without making it linux-specific.
 The binding should make sense regardless of either future changes to
the driver, or when using a different OS.


> +
> +Each button (key) is represented as a sub-node of "gpio-keys":
> +Subnode properties:
> +
> + =A0 =A0 =A0 - reg: GPIO number the key is bound to.
> + =A0 =A0 =A0 - label: Descriptive name of the key.
> + =A0 =A0 =A0 - linux,code: Keycode to emit.

Hmm, is there an OS-neutral way to specify this?  There may not be,
but if there is then it should be looked at seriously.

> +
> +Optional subnode-properties:
> + =A0 =A0 =A0 - linux,active_low: Boolean flag to specify active-low =
GPIO input.

This isn't really a linux-specific thing.  Perhaps use the name
"key-active-low".

Also, use '-' instead of '_' in property names.

> + =A0 =A0 =A0 - linux,input_type: Specify event type this button/key =
generates.
> + =A0 =A0 =A0 =A0 Default if unspecified is <1> =3D=3D EV_KEY.


> + =A0 =A0 =A0 - linux,debounc_interval: Debouncing interval time in m=
illiseconds.
> + =A0 =A0 =A0 =A0 Default if unspecified is 5.

Debounce is spelled with 2 'e's.  :-)  Also not linux specific.
Should be renamed.  It would probably make sense to also allow a
debounce intervale property in the parent node.  I suspect that a
single debounce interval value will simply be used by all keys in a
gpio-keys block.

> + =A0 =A0 =A0 - linux,can_disable: Boolean, specify if key can be dis=
abled via
> + =A0 =A0 =A0 =A0 module parameter.

Is this really needed?  Or even a good idea?  It looks to be encoding
a driver-specific implementation detail that could potentially change
in the future.

> + =A0 =A0 =A0 - linux,wakeup: Boolean, button can wake-up the system.

Again, not linux-specific.

> +
> +Example nodes:
> +
> + =A0 =A0 =A0 gpio_keys {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "linux,g=
pio-keys", "gpio-keys";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,autorepeat;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 button@20 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D=
 "GPIO Key ESC";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,c=
ode =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D=
 <0x20>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,a=
ctive_low;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,i=
nput_type =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 button@21 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D=
 "GPIO Key UP";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,c=
ode =3D <103>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D=
 <0x21>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,a=
ctive_low;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,i=
nput_type =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> +
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index 987498e..4efd067 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -3,6 +3,9 @@
> =A0*
> =A0* Copyright 2005 Phil Blundell
> =A0*
> + * Added OF support:
> + * Copyright 2010 David Jander <david@protonic.nl>
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
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>
> =A0struct gpio_button_data {
> =A0 =A0 =A0 =A0struct gpio_keys_button *button;
> @@ -42,6 +47,7 @@ struct gpio_keys_drvdata {
> =A0 =A0 =A0 =A0int (*enable)(struct device *dev);
> =A0 =A0 =A0 =A0void (*disable)(struct device *dev);
> =A0 =A0 =A0 =A0struct gpio_button_data data[0];
> + =A0 =A0 =A0 struct gpio_keys_platform_data *dyn_pdata;
> =A0};
>
> =A0/*
> @@ -442,18 +448,131 @@ static void gpio_keys_close(struct input_dev *=
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
> +gpio_keys_get_devtree_pdata(struct device *dev)
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
> + =A0 =A0 =A0 pdata->rep =3D !!of_get_property(node, "linux,autorepea=
t", &len);
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

You need to do an endian conversion on device tree data.  be32_to_cpup(=
reg);

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
> +gpio_keys_get_devtree_pdata(struct device *dev)
> +{
> + =A0 =A0 =A0 return NULL;
> +}
> +#endif
> +
> =A0static int __devinit gpio_keys_probe(struct platform_device *pdev)
> =A0{
> =A0 =A0 =A0 =A0struct gpio_keys_drvdata *ddata;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0struct gpio_keys_platform_data *pdata =3D dev->platfor=
m_data;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *dyn_pdata =3D NULL;
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int i, error;
> =A0 =A0 =A0 =A0int wakeup =3D 0;
>
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D gpio_keys_get_devtree_pdata(d=
ev);
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
> @@ -565,12 +684,21 @@ static int __devexit gpio_keys_remove(struct pl=
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
> + =A0 =A0 =A0 { .compatible =3D "linux,gpio-keys", },
> + =A0 =A0 =A0 { .compatible =3D "gpio-keys", },

You don't need both values here.  "gpio-keys" is fine.

> + =A0 =A0 =A0 {},
> +};
>
> =A0#ifdef CONFIG_PM
> =A0static int gpio_keys_suspend(struct device *dev)
> @@ -618,6 +746,8 @@ static const struct dev_pm_ops gpio_keys_pm_ops =3D=
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
> @@ -627,6 +757,7 @@ static struct platform_driver gpio_keys_device_dr=
iver =3D {
> =A0#ifdef CONFIG_PM
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D &gpio_keys_pm_ops,
> =A0#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D gpio_keys_of_match,
> =A0 =A0 =A0 =A0}
> =A0};
>
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
