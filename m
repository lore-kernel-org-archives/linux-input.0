From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH RESEND] input: gpio_keys_polled: convert to dt
Date: Mon, 25 Jun 2012 12:04:34 -0300
Message-ID: <CAAAP30G=egLCUJGvzVUQ2+zb1MAk-CoCDoZs2BfZiswKosSBKQ@mail.gmail.com>
References: <1340192062-10565-1-git-send-email-aletes.xgr@gmail.com>
	<4FE85CDC.1090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46947 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756393Ab2FYPEf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 11:04:35 -0400
In-Reply-To: <4FE85CDC.1090604@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, JJ Ding <dgdunix@gmail.com>, Roland Stigge <stigge@antcom.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Mon, Jun 25, 2012 at 9:43 AM, Rob Herring <robherring2@gmail.com> wr=
ote:
> On 06/20/2012 06:34 AM, Alexandre Pereira da Silva wrote:
>> Add device tree support to gpio_keys_polled.c
>>
>> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
>> Tested-by: Roland Stigge <stigge@antcom.de>
>> ---
>> =A0drivers/input/keyboard/gpio_keys_polled.c | =A0121 ++++++++++++++=
+++++++++++++--
>> =A01 file changed, 113 insertions(+), 8 deletions(-)
>
> Needs binding documentation.
>
>>
>> diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/inp=
ut/keyboard/gpio_keys_polled.c
>> index 20c8ab1..a64b361 100644
>> --- a/drivers/input/keyboard/gpio_keys_polled.c
>> +++ b/drivers/input/keyboard/gpio_keys_polled.c
>> @@ -25,6 +25,8 @@
>> =A0#include <linux/platform_device.h>
>> =A0#include <linux/gpio.h>
>> =A0#include <linux/gpio_keys.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_gpio.h>
>>
>> =A0#define DRV_NAME =A0 =A0 "gpio-keys-polled"
>>
>> @@ -38,7 +40,7 @@ struct gpio_keys_button_data {
>> =A0struct gpio_keys_polled_dev {
>> =A0 =A0 =A0 struct input_polled_dev *poll_dev;
>> =A0 =A0 =A0 struct device *dev;
>> - =A0 =A0 struct gpio_keys_platform_data *pdata;
>> + =A0 =A0 struct gpio_keys_platform_data pdata;
>> =A0 =A0 =A0 struct gpio_keys_button_data data[0];
>> =A0};
>>
>> @@ -67,11 +69,11 @@ static void gpio_keys_polled_check_state(struct =
input_dev *input,
>> =A0static void gpio_keys_polled_poll(struct input_polled_dev *dev)
>> =A0{
>> =A0 =A0 =A0 struct gpio_keys_polled_dev *bdev =3D dev->private;
>> - =A0 =A0 struct gpio_keys_platform_data *pdata =3D bdev->pdata;
>> + =A0 =A0 struct gpio_keys_platform_data *pdata =3D &bdev->pdata;
>> =A0 =A0 =A0 struct input_dev *input =3D dev->input;
>> =A0 =A0 =A0 int i;
>>
>> - =A0 =A0 for (i =3D 0; i < bdev->pdata->nbuttons; i++) {
>> + =A0 =A0 for (i =3D 0; i < pdata->nbuttons; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_keys_button_data *bdata =3D =
&bdev->data[i];
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bdata->count < bdata->threshold)
>> @@ -85,7 +87,7 @@ static void gpio_keys_polled_poll(struct input_pol=
led_dev *dev)
>> =A0static void gpio_keys_polled_open(struct input_polled_dev *dev)
>> =A0{
>> =A0 =A0 =A0 struct gpio_keys_polled_dev *bdev =3D dev->private;
>> - =A0 =A0 struct gpio_keys_platform_data *pdata =3D bdev->pdata;
>> + =A0 =A0 struct gpio_keys_platform_data *pdata =3D &bdev->pdata;
>>
>> =A0 =A0 =A0 if (pdata->enable)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->enable(bdev->dev);
>> @@ -94,23 +96,125 @@ static void gpio_keys_polled_open(struct input_=
polled_dev *dev)
>> =A0static void gpio_keys_polled_close(struct input_polled_dev *dev)
>> =A0{
>> =A0 =A0 =A0 struct gpio_keys_polled_dev *bdev =3D dev->private;
>> - =A0 =A0 struct gpio_keys_platform_data *pdata =3D bdev->pdata;
>> + =A0 =A0 struct gpio_keys_platform_data *pdata =3D &bdev->pdata;
>>
>> =A0 =A0 =A0 if (pdata->disable)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->disable(bdev->dev);
>> =A0}
>> +#ifdef CONFIG_OF
>> +static int gpio_keys_polled_get_devtree_pdata(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_keys_p=
latform_data *pdata)
>> +{
>> + =A0 =A0 struct device_node *node, *pp;
>> + =A0 =A0 int i;
>> + =A0 =A0 struct gpio_keys_button *buttons;
>> + =A0 =A0 u32 reg;
>> +
>> + =A0 =A0 node =3D dev->of_node;
>> + =A0 =A0 if (node =3D=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 memset(pdata, 0, sizeof *pdata);
>
> parentheses around *pdata.
>
>> +
>> + =A0 =A0 pdata->rep =3D !!of_get_property(node, "autorepeat", NULL)=
;
>> +
>> + =A0 =A0 if (of_property_read_u32(node, "poll-interval", &reg) =3D=3D=
 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->poll_interval =3D reg;
>
> You can just do this instead of the if:
>
> of_property_read_u32(node, "poll-interval", &pdata->poll_interval);
>
>
>> +
>> + =A0 =A0 /* First count the subnodes */
>> + =A0 =A0 pdata->nbuttons =3D 0;
>
> You already to this to 0.
>
>> + =A0 =A0 pp =3D NULL;
>> + =A0 =A0 while ((pp =3D of_get_next_child(node, pp)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons++;
>
> of_get_child_count()
>
>> +
>> + =A0 =A0 if (pdata->nbuttons =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 buttons =3D kzalloc(pdata->nbuttons * (sizeof *buttons), G=
=46P_KERNEL);
>> + =A0 =A0 if (!buttons)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 pp =3D NULL;
>> + =A0 =A0 i =3D 0;
>> + =A0 =A0 while ((pp =3D of_get_next_child(node, pp))) {
>
> for_each_child_of_node
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 enum of_gpio_flags flags;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!of_find_property(pp, "gpios", NULL)) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons--;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "Found butto=
n without gpios\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].gpio =3D of_get_gpio_flags(pp, =
0, &flags);
>> + =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].active_low =3D flags & OF_GPIO_=
ACTIVE_LOW;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(pp, "linux,code",=
 &reg)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Button witho=
ut keycode: 0x%x\n", buttons[i].gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_fail;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].code =3D reg;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].desc =3D of_get_property(pp, "l=
abel", NULL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(pp, "linux,input-=
type", &reg) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D reg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].type =3D EV_KEY=
;
>
> if (of_property_read_u32(pp, "linux,input-type", &buttons[i].type))
> =A0 =A0 =A0 =A0buttons[i].type =3D EV_KEY;
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].wakeup =3D !!of_get_property(pp=
, "gpio-key,wakeup", NULL);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (of_property_read_u32(pp, "debounce-int=
erval", &reg) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].debounce_interv=
al =3D reg;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buttons[i].debounce_interv=
al =3D 5;
>
> ditto
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 i++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pdata->buttons =3D buttons;
>> +
>> + =A0 =A0 return 0;
>> +
>> +out_fail:
>> + =A0 =A0 kfree(buttons);
>> + =A0 =A0 return -ENODEV;
>> +}
>> +
>> +static struct of_device_id gpio_keys_polled_of_match[] =3D {
>> + =A0 =A0 { .compatible =3D "gpio-keys-polled", },
>> + =A0 =A0 { },
>> +};
>> +MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
>> +#else
>> +
>> +static int gpio_keys_polled_get_devtree_pdata(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct gpio_keys_p=
latform_data *altp)
>> +{
>> + =A0 =A0 return -ENODEV;
>> +}
>> +
>> +#define gpio_keys_polled_of_match NULL
>> +
>> +#endif
>>
>> =A0static int __devinit gpio_keys_polled_probe(struct platform_devic=
e *pdev)
>> =A0{
>> =A0 =A0 =A0 struct gpio_keys_platform_data *pdata =3D pdev->dev.plat=
form_data;
>> =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
>> + =A0 =A0 struct gpio_keys_platform_data alt_pdata;
>> =A0 =A0 =A0 struct gpio_keys_polled_dev *bdev;
>> =A0 =A0 =A0 struct input_polled_dev *poll_dev;
>> =A0 =A0 =A0 struct input_dev *input;
>> =A0 =A0 =A0 int error;
>> =A0 =A0 =A0 int i;
>>
>> - =A0 =A0 if (!pdata || !pdata->poll_interval)
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 error =3D gpio_keys_polled_get_devtree_pdata(dev, =
&alt_pdata);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &alt_pdata;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!pdata->poll_interval)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> =A0 =A0 =A0 bdev =3D kzalloc(sizeof(struct gpio_keys_polled_dev) +
>> @@ -184,7 +288,7 @@ static int __devinit gpio_keys_polled_probe(stru=
ct platform_device *pdev)
>>
>> =A0 =A0 =A0 bdev->poll_dev =3D poll_dev;
>> =A0 =A0 =A0 bdev->dev =3D dev;
>> - =A0 =A0 bdev->pdata =3D pdata;
>> + =A0 =A0 bdev->pdata =3D *pdata;
>> =A0 =A0 =A0 platform_set_drvdata(pdev, bdev);
>>
>> =A0 =A0 =A0 error =3D input_register_polled_device(poll_dev);
>> @@ -217,7 +321,7 @@ err_free_bdev:
>> =A0static int __devexit gpio_keys_polled_remove(struct platform_devi=
ce *pdev)
>> =A0{
>> =A0 =A0 =A0 struct gpio_keys_polled_dev *bdev =3D platform_get_drvda=
ta(pdev);
>> - =A0 =A0 struct gpio_keys_platform_data *pdata =3D bdev->pdata;
>> + =A0 =A0 struct gpio_keys_platform_data *pdata =3D &bdev->pdata;
>> =A0 =A0 =A0 int i;
>>
>> =A0 =A0 =A0 input_unregister_polled_device(bdev->poll_dev);
>> @@ -239,6 +343,7 @@ static struct platform_driver gpio_keys_polled_d=
river =3D {
>> =A0 =A0 =A0 .driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D DRV_NAME,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D gpio_keys_polled_of_ma=
tch,
>> =A0 =A0 =A0 },
>> =A0};
>> =A0module_platform_driver(gpio_keys_polled_driver);

Thanks for reviewing. I will submit patches for both gpio-keys and
gpio-keys-polled to address those issues.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
