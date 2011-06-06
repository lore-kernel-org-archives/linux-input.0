From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] Input: gpio_keys.c: Simplify platform_device ->
 device casting
Date: Mon, 6 Jun 2011 09:26:54 -0600
Message-ID: <BANLkTinF=PqHmRjwJ=_kRe56au8QASg23g@mail.gmail.com>
References: <1307373155-29470-1-git-send-email-david@protonic.nl> <1307373155-29470-2-git-send-email-david@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49497 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab1FFP1O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 11:27:14 -0400
Received: by pwi15 with SMTP id 15so2151366pwi.19
        for <linux-input@vger.kernel.org>; Mon, 06 Jun 2011 08:27:14 -0700 (PDT)
In-Reply-To: <1307373155-29470-2-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david@protonic.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Jun 6, 2011 at 9:12 AM, David Jander <david@protonic.nl> wrote:
> This patch factors out the use of struct platform_device *pdev in mos=
t
> places.
>
> Signed-off-by: David Jander <david@protonic.nl>

Looks right.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0drivers/input/keyboard/gpio_keys.c | =A0 46 ++++++++++++++++------=
-------------
> =A01 files changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keybo=
ard/gpio_keys.c
> index 6e6145b..987498e 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -251,8 +251,7 @@ static ssize_t gpio_keys_show_##name(struct devic=
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
> @@ -278,8 +277,7 @@ static ssize_t gpio_keys_store_##name(struct devi=
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
> @@ -364,12 +362,11 @@ static irqreturn_t gpio_keys_isr(int irq, void =
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
> =A0 =A0 =A0 =A0const char *desc =3D button->desc ? button->desc : "gp=
io_keys";
> - =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0unsigned long irqflags;
> =A0 =A0 =A0 =A0int irq, error;
>
> @@ -447,9 +444,9 @@ static void gpio_keys_close(struct input_dev *inp=
ut)
>
> =A0static int __devinit gpio_keys_probe(struct platform_device *pdev)
> =A0{
> - =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> =A0 =A0 =A0 =A0struct gpio_keys_drvdata *ddata;
> =A0 =A0 =A0 =A0struct device *dev =3D &pdev->dev;
> + =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D dev->platform=
_data;
> =A0 =A0 =A0 =A0struct input_dev *input;
> =A0 =A0 =A0 =A0int i, error;
> =A0 =A0 =A0 =A0int wakeup =3D 0;
> @@ -470,12 +467,12 @@ static int __devinit gpio_keys_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0ddata->disable =3D pdata->disable;
> =A0 =A0 =A0 =A0mutex_init(&ddata->disable_lock);
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, ddata);
> + =A0 =A0 =A0 dev_set_drvdata(dev, ddata);
> =A0 =A0 =A0 =A0input_set_drvdata(input, ddata);
>
> =A0 =A0 =A0 =A0input->name =3D pdata->name ? : pdev->name;
> =A0 =A0 =A0 =A0input->phys =3D "gpio-keys/input0";
> - =A0 =A0 =A0 input->dev.parent =3D &pdev->dev;
> + =A0 =A0 =A0 input->dev.parent =3D dev;
> =A0 =A0 =A0 =A0input->open =3D gpio_keys_open;
> =A0 =A0 =A0 =A0input->close =3D gpio_keys_close;
>
> @@ -496,7 +493,7 @@ static int __devinit gpio_keys_probe(struct platf=
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
> @@ -506,7 +503,7 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
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
> @@ -525,12 +522,12 @@ static int __devinit gpio_keys_probe(struct pla=
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
> @@ -540,7 +537,7 @@ static int __devinit gpio_keys_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->buttons[i].gpio);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 dev_set_drvdata(dev, NULL);
> =A0fail1:
> =A0 =A0 =A0 =A0input_free_device(input);
> =A0 =A0 =A0 =A0kfree(ddata);
> @@ -550,14 +547,15 @@ static int __devinit gpio_keys_probe(struct pla=
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
> @@ -577,11 +575,10 @@ static int __devexit gpio_keys_remove(struct pl=
atform_device *pdev)
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
> @@ -596,15 +593,14 @@ static int gpio_keys_suspend(struct device *dev=
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
