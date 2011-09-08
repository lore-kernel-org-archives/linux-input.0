From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/2] input: samsung-keypad: Add device tree support
Date: Thu, 8 Sep 2011 10:01:46 +0530
Message-ID: <CAJuYYwSU3rZcynqf1sSYdSg=LErswgfDwdxrjjU8J2wuE6oZTQ@mail.gmail.com>
References: <1315317317-21873-1-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-2-git-send-email-thomas.abraham@linaro.org>
	<1315317317-21873-3-git-send-email-thomas.abraham@linaro.org>
	<20110907205032.GA8265@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:37436 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab1IHEbq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2011 00:31:46 -0400
In-Reply-To: <20110907205032.GA8265@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com

Hi Dmitry,

On 8 September 2011 02:20, Dmitry Torokhov <dmitry.torokhov@gmail.com> =
wrote:
> Hi Thomas,
>
> On Tue, Sep 06, 2011 at 07:25:17PM +0530, Thomas Abraham wrote:
>> =A0static int samsung_keypad_is_s5pv210(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct platform_device *pdev =3D to_platform_device(dev)=
;
>> - =A0 =A0 enum samsung_keypad_type type =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 platform_get_device_id(pdev)->driver_data;
>> + =A0 =A0 enum samsung_keypad_type type;
>>
>> +#ifdef CONFIG_OF
>> + =A0 =A0 if (dev->of_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return of_device_is_compatible(dev->of_nod=
e,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "samsung,s=
5pv210-keypad");
>> +#endif
>> + =A0 =A0 type =3D platform_get_device_id(pdev)->driver_data;
>> =A0 =A0 =A0 return type =3D=3D KEYPAD_TYPE_S5PV210;
>
> This function is called every time we scan keypad matrix, I do not th=
ink
> you want to scan DT bindings here. You need to cache the device type =
at
> probe time and use it.

Ok. As you suggested, this will be changed to cache the type in driver
private data during probe and use the cached copy when required.

>
>> =A0}
>>
>> @@ -235,6 +246,130 @@ static void samsung_keypad_close(struct input_=
dev *input_dev)
>> =A0 =A0 =A0 samsung_keypad_stop(keypad);
>> =A0}
>>
>> +#ifdef CONFIG_OF
>> +static
>> +struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct devi=
ce *dev)
>> +{
>> + =A0 =A0 struct samsung_keypad_platdata *pdata;
>> + =A0 =A0 struct matrix_keymap_data *keymap_data;
>> + =A0 =A0 uint32_t *keymap;
>> + =A0 =A0 struct device_node *np =3D dev->of_node, *key_np;
>> + =A0 =A0 unsigned int key_count =3D 0;
>> +
>> + =A0 =A0 pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory fo=
r platform data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>
> pdata is not used once probe() completes so it would be better to fre=
e
> it and not rely on devm_* facilities to free it for you once device
> unbinds from the driver.

Ok. That would be better. pdata will be freed after probe completes.

>
>> +
>> + =A0 =A0 of_property_read_u32(np, "samsung,keypad-num-rows", &pdata=
->rows);
>> + =A0 =A0 of_property_read_u32(np, "samsung,keypad-num-columns", &pd=
ata->cols);
>> + =A0 =A0 if (!pdata->rows || !pdata->cols) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "number of keypad rows/column=
s not specified\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 keymap_data =3D devm_kzalloc(dev, sizeof(*keymap_data), GF=
P_KERNEL);
>> + =A0 =A0 if (!keymap_data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory fo=
r keymap data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> + =A0 =A0 pdata->keymap_data =3D keymap_data;
>> +
>> + =A0 =A0 for_each_child_of_node(np, key_np)
>> + =A0 =A0 =A0 =A0 =A0 =A0 key_count++;
>> +
>> + =A0 =A0 keymap_data->keymap_size =3D key_count;
>> + =A0 =A0 keymap =3D devm_kzalloc(dev, sizeof(uint32_t) * key_count,=
 GFP_KERNEL);
>> + =A0 =A0 if (!keymap) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "could not allocate memory fo=
r keymap\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }
>> + =A0 =A0 keymap_data->keymap =3D keymap;
>> +
>> + =A0 =A0 for_each_child_of_node(np, key_np) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int row, col, key_code;
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "keypad,row",=
 &row);
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "keypad,colum=
n", &col);
>> + =A0 =A0 =A0 =A0 =A0 =A0 of_property_read_u32(key_np, "keypad,key-c=
ode", &key_code);
>> + =A0 =A0 =A0 =A0 =A0 =A0 *keymap++ =3D KEY(row, col, key_code);
>> + =A0 =A0 }
>
> THis seems like generic mechanism that could be used by other drivers=
=2E..
> Maybe move into matrix-keypad.c? You would also not need to allocate
> temporary buffer for intermediate keymap data.

Yes, this could be reused in other drivers as well. But, moving this
into matrix-keypad.c file means that KEYBOARD_MATRIX config option
would have to be selected for all platforms reusing this code. So, I
am not sure of the right place for this.

>
>> +
>> + =A0 =A0 if (of_get_property(np, "linux,input-no-autorepeat", NULL)=
)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->no_autorepeat =3D true;
>> + =A0 =A0 if (of_get_property(np, "linux,input-wakeup", NULL))
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata->wakeup =3D true;
>> +
>> + =A0 =A0 return pdata;
>> +}
>> +
>> +static void samsung_keypad_parse_dt_gpio(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sam=
sung_keypad *keypad)
>> +{
>> + =A0 =A0 struct device_node *np =3D dev->of_node;
>> + =A0 =A0 int gpio, ret, row, col;
>> +
>> + =A0 =A0 for (row =3D 0; row < keypad->rows; row++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D of_get_named_gpio(np, "row-gpios"=
, row);
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->row_gpios[row] =3D gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad row[%=
d]: invalid gpio %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 row, gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(gpio, "keypad-row");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad row[%=
d] gpio request failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 row);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for (col =3D 0; col < keypad->cols; col++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio =3D of_get_named_gpio(np, "col-gpios"=
, col);
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->col_gpios[col] =3D gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!gpio_is_valid(gpio)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad colum=
n[%d]: invalid gpio %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 col, gpio);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(col, "keypad-col");
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "keypad colum=
n[%d] gpio request failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 col);
>
> I think we should bail out if one of the calls fails.

I intended to continue even if some request fails because there could
a partially usable keyboard. If there is a failure, there is a error
message to indicate that keyboard might not be fully functional. If
you are not too strict on this one, I would like to retain it this
way.

>
>> + =A0 =A0 }
>> +}
>> +
>> +static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keyp=
ad)
>> +{
>> + =A0 =A0 int cnt;
>> +
>> + =A0 =A0 for (cnt =3D 0; cnt < keypad->rows; cnt++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(keypad->row_gpios[cnt]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(keypad->row_gpio=
s[cnt]);
>> +
>> + =A0 =A0 for (cnt =3D 0; cnt < keypad->cols; cnt++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (gpio_is_valid(keypad->col_gpios[cnt]))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(keypad->col_gpio=
s[cnt]);
>> +}
>> +#else
>> +static
>> +struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct devi=
ce *dev)
>> +{
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +static void samsung_keypad_parse_dt_gpio(struct device_node *np,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct samsung_keypad *keypad, unsigned in=
t rows,
>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int cols)
>> +{
>> +}
>> +
>> +static void samsung_keypad_dt_gpio_free(struct samsung_keypad *keyp=
ad)
>> +{
>> +}
>> +#endif
>> +
>> =A0static int __devinit samsung_keypad_probe(struct platform_device =
*pdev)
>> =A0{
>> =A0 =A0 =A0 const struct samsung_keypad_platdata *pdata;
>> @@ -246,7 +381,10 @@ static int __devinit samsung_keypad_probe(struc=
t platform_device *pdev)
>> =A0 =A0 =A0 unsigned int keymap_size;
>> =A0 =A0 =A0 int error;
>>
>> - =A0 =A0 pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 if (pdev->dev.of_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D samsung_keypad_parse_dt(&pdev->d=
ev);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D pdev->dev.platform_data;
>> =A0 =A0 =A0 if (!pdata) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no platform data de=
fined\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> @@ -303,6 +441,9 @@ static int __devinit samsung_keypad_probe(struct=
 platform_device *pdev)
>> =A0 =A0 =A0 keypad->cols =3D pdata->cols;
>> =A0 =A0 =A0 init_waitqueue_head(&keypad->wait);
>>
>> + =A0 =A0 if (pdev->dev.of_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung_keypad_parse_dt_gpio(&pdev->dev, k=
eypad);
>> +
>> =A0 =A0 =A0 input_dev->name =3D pdev->name;
>> =A0 =A0 =A0 input_dev->id.bustype =3D BUS_HOST;
>> =A0 =A0 =A0 input_dev->dev.parent =3D &pdev->dev;
>> @@ -349,6 +490,7 @@ err_free_irq:
>> =A0 =A0 =A0 free_irq(keypad->irq, keypad);
>> =A0err_put_clk:
>> =A0 =A0 =A0 clk_put(keypad->clk);
>> + =A0 =A0 samsung_keypad_dt_gpio_free(keypad);
>> =A0err_unmap_base:
>> =A0 =A0 =A0 iounmap(keypad->base);
>> =A0err_free_mem:
>> @@ -374,6 +516,7 @@ static int __devexit samsung_keypad_remove(struc=
t platform_device *pdev)
>> =A0 =A0 =A0 free_irq(keypad->irq, keypad);
>>
>> =A0 =A0 =A0 clk_put(keypad->clk);
>> + =A0 =A0 samsung_keypad_dt_gpio_free(keypad);
>>
>> =A0 =A0 =A0 iounmap(keypad->base);
>> =A0 =A0 =A0 kfree(keypad);
>> @@ -447,6 +590,17 @@ static const struct dev_pm_ops samsung_keypad_p=
m_ops =3D {
>> =A0};
>> =A0#endif
>>
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id samsung_keypad_dt_match[] =3D {
>> + =A0 =A0 { .compatible =3D "samsung,s3c6410-keypad" },
>> + =A0 =A0 { .compatible =3D "samsung,s5pv210-keypad" },
>> + =A0 =A0 {},
>> +};
>> +MODULE_DEVICE_TABLE(of, samsung_keypad_dt_match);
>> +#else
>> +#define samsung_keypad_dt_match NULL
>> +#endif
>> +
>> =A0static struct platform_device_id samsung_keypad_driver_ids[] =3D =
{
>> =A0 =A0 =A0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "samsung-k=
eypad",
>> @@ -465,6 +619,7 @@ static struct platform_driver samsung_keypad_dri=
ver =3D {
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "samsung-keypad",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D samsung_keypad_dt_matc=
h,
>> =A0#ifdef CONFIG_PM
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &samsung_keypad_pm_ops,
>> =A0#endif
>> --
>> 1.6.6.rc2
>>
>
> Thanks.
>
> --
> Dmitry
>

Thanks for your review and comments.

Regards,
Thomas.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
