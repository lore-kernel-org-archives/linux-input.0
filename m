From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH] input: add mpr121 capacitive touchkey driver
Date: Wed, 13 Apr 2011 09:23:47 +0800
Message-ID: <BANLkTinj4ivh58PBbnqzmm30aYwRqp8nfA@mail.gmail.com>
References: <1302541337-2934-1-git-send-email-kzjeef@gmail.com> <20110412061825.GC1854@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64954 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932158Ab1DMBYI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Apr 2011 21:24:08 -0400
Received: by pvg12 with SMTP id 12so53434pvg.19
        for <linux-input@vger.kernel.org>; Tue, 12 Apr 2011 18:24:07 -0700 (PDT)
In-Reply-To: <20110412061825.GC1854@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Zhang Jiejing <jiejing.zhang@freescale.com>

Hi Dmitry,

2011/4/12 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Jiejing,
>
> On Tue, Apr 12, 2011 at 01:02:17AM +0800, Jiejing Zhang wrote:
>> From: Zhang Jiejing <jiejing.zhang@freescale.com>
>>
>> This touchkey driver is based on Freescale mpr121 capacitive
>> touch sensor controller.
>>
>> It can support up to 12 keys, it use i2c interface.
>>
>> The product infomation(data sheet, application notes) can
>> be found under this link:
>> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMPR=
121
>>
>
> MOstly reasonable. In addition to Christoph's comments:
>
>> +
>> +static struct mpr121_init_register init_reg_table[] =3D {
>
> const? And also __devinitconst?
will do.
>
>> + =A0 =A0 {MHD_RISING_ADDR, =A0 =A0 =A0 0x1},
>> + =A0 =A0 {NHD_RISING_ADDR, =A0 =A0 =A0 0x1},
>> + =A0 =A0 {MHD_FALLING_ADDR, =A0 =A0 =A00x1},
>> + =A0 =A0 {NHD_FALLING_ADDR, =A0 =A0 =A00x1},
>> + =A0 =A0 {NCL_FALLING_ADDR, =A0 =A0 =A00xff},
>> + =A0 =A0 {FDL_FALLING_ADDR, =A0 =A0 =A00x02},
>> + =A0 =A0 {FILTER_CONF_ADDR, =A0 =A0 =A00x04},
>> + =A0 =A0 {AFE_CONF_ADDR, =A0 =A0 =A0 =A0 0x0b},
>> + =A0 =A0 {AUTO_CONFIG_CTRL_ADDR, 0x0b},
>> +};
>> +
>> +static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct mpr121_touchkey_data *data =3D dev_id;
>> + =A0 =A0 struct i2c_client *client =3D data->client;
>> + =A0 =A0 struct input_dev *input =3D data->input_dev;
>> + =A0 =A0 unsigned int key_num, pressed;
>> + =A0 =A0 int reg;
>> +
>> + =A0 =A0 reg =3D i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_=
1_ADDR);
>> + =A0 =A0 if (reg < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c read error [%d]=
\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 reg <<=3D 8;
>> + =A0 =A0 reg |=3D i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS=
_0_ADDR);
>> + =A0 =A0 if (reg < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "i2c read error [%d]=
\n", reg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 reg &=3D TOUCH_STATUS_MASK;
>> + =A0 =A0 /* use old press bit to figure out which bit changed */
>> + =A0 =A0 key_num =3D ffs(reg ^ data->statusbits) - 1;
>> + =A0 =A0 /* use the bit check the press status */
>> + =A0 =A0 pressed =3D (reg & (1 << (key_num))) >> key_num;
>
> No need to shift by key_num, input_report_key normalizes to 'bool'.
>
yes, will change.
>> + =A0 =A0 data->statusbits =3D reg;
>> + =A0 =A0 data->key_val =3D data->keycodes[key_num];
>> +
>> + =A0 =A0 input_event(input, EV_MSC, MSC_SCAN, data->key_val);
>
> sScancode is not data->key_val as it is KEY_XXX value but rather key_=
num.
>
thanks for point out, will change to key_num.

>> + =A0 =A0 input_report_key(input, data->key_val, pressed);
>> + =A0 =A0 input_sync(input);
>> +
>> + =A0 =A0 dev_dbg(&client->dev, "key %d %d %s\n", key_num, data->key=
_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 pressed ? "pressed" : "released");
>> +
>> +out:
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int mpr121_phys_init(
>
> __devinit
will do.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mpr121_=
platform_data *pdata,
>
> pdata should be const.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mpr121_touc=
hkey_data *data,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_client =
*client)
>> +{
>> + =A0 =A0 struct mpr121_init_register *reg;
>> + =A0 =A0 unsigned char usl, lsl, tl;
>> + =A0 =A0 int i, t, vdd, ret;
>> +
>> + =A0 =A0 /* setup touch/release threshold for ele0-ele11 */
>> + =A0 =A0 for (i =3D 0; i <=3D MPR121_MAX_KEY_COUNT; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 t =3D ELE0_TOUCH_THRESHOLD_ADDR + (i * 2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, =
t, TOUCH_THRESHOLD);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, =
t + 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 RELEASE_THRESHOLD);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
>> + =A0 =A0 }
>> + =A0 =A0 /* setup init register */
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(init_reg_table); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg =3D &init_reg_table[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, =
reg->addr, reg->val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
>> + =A0 =A0 }
>> + =A0 =A0 /* setup auto-register by vdd,the formula please ref: AN38=
89
>> + =A0 =A0 =A0* These register *must* set acrodding your VDD voltage =
supply
>> + =A0 =A0 =A0* to the chip*/
>> + =A0 =A0 vdd =3D pdata->vdd_uv / 1000;
>> + =A0 =A0 usl =3D ((vdd - 700) * 256) / vdd;
>> + =A0 =A0 lsl =3D (usl * 65) / 100;
>> + =A0 =A0 tl =3D (usl * 90) / 100;
>> + =A0 =A0 ret =3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_USL_=
ADDR, usl);
>> + =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_LSL=
_ADDR, lsl);
>> + =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, AUTO_CONFIG_TL_=
ADDR, tl);
>> + =A0 =A0 ret |=3D i2c_smbus_write_byte_data(client, ELECTRODE_CONF_=
ADDR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->keycount);
>> + =A0 =A0 if (ret !=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_write;
>> +
>> + =A0 =A0 dev_info(&client->dev, "mpr121: config as enable %x of ele=
ctrode.\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0data->keycount);
>
> Does it have to be dev_info? dev_dbg maybe?
>
will change to dev_dbg.
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_i2c_write:
>> + =A0 =A0 dev_err(&client->dev, "i2c write error: %d\n", ret);
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devinit mpr_touchkey_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct i2c_device_id *id)
>> +{
>> + =A0 =A0 struct mpr121_platform_data *pdata;
>
> const.
will do.
>
>> + =A0 =A0 struct mpr121_touchkey_data *data;
>> + =A0 =A0 struct input_dev *input_dev;
>> + =A0 =A0 int error;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 pdata =3D client->dev.platform_data;
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "no platform data de=
fined\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!client->irq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "The irq number shou=
ld not be zero\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 data =3D kzalloc(sizeof(struct mpr121_touchkey_data), GFP_=
KERNEL);
>> + =A0 =A0 input_dev =3D input_allocate_device();
>> + =A0 =A0 if (!data || !input_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Falied to allocate =
memory\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 data->client =3D client;
>> + =A0 =A0 data->input_dev =3D input_dev;
>> + =A0 =A0 data->keycount =3D pdata->keycount;
>> +
>> + =A0 =A0 if (data->keycount > MPR121_MAX_KEY_COUNT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Too many key define=
d\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 error =3D mpr121_phys_init(pdata, data, client);
>> + =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to init regi=
ster\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 i2c_set_clientdata(client, data);
>
> You should do this at the very end, before returning success (0).
> Actually, you do do this, so just remove this instance.
>
will remove.
>> +
>> + =A0 =A0 input_dev->name =3D "FSL MPR121 Touchkey";
>> + =A0 =A0 input_dev->id.bustype =3D BUS_I2C;
>> + =A0 =A0 input_dev->dev.parent =3D &client->dev;
>> + =A0 =A0 input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REP=
);
>> + =A0 =A0 input_dev->keycode =3D pdata->matrix;
>
> No, you are assigning pointer to the platform data, instead of pointe=
r
> to the data in device structure. That is why I'd rather you renamed
> 'struct mpr121_touchkey_data' to 'struct mpr121_touchkey' and 'data' =
to
> 'mpr121' so as to avoid confusion with platform data.
>
I've changed all struct mpr121_touchkey_data to struct mpr121_touchkey.
and change the "data" to mpr121.

I'm truly confuse with platform data.

>> + =A0 =A0 input_dev->keycodesize =3D sizeof(pdata->matrix[0]);
>> + =A0 =A0 input_dev->keycodemax =3D data->keycount;
>> +
>> + =A0 =A0 for (i =3D 0; i < input_dev->keycodemax; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(pdata->matrix[i], input_dev->key=
bit);
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->keycodes[i] =3D pdata->matrix[i];
>> + =A0 =A0 }
>> +
>> + =A0 =A0 input_set_capability(input_dev, EV_MSC, MSC_SCAN);
>> + =A0 =A0 input_set_drvdata(input_dev, data);
>> +
>> + =A0 =A0 error =3D request_threaded_irq(client->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mpr_touchkey_interrupt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
IRQF_TRIGGER_FALLING,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
client->dev.driver->name, data);
>> + =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to register =
interrupt\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 error =3D input_register_device(input_dev);
>> + =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
>> + =A0 =A0 i2c_set_clientdata(client, data);
>> + =A0 =A0 device_init_wakeup(&client->dev, pdata->wakeup);
>> + =A0 =A0 dev_info(&client->dev, "Mpr121 touch keyboard init success=
=2E\n");
>
> No need for having this message. You can see the device bound to the
> driver in sysfs. The boot is noisy enough.
ok, will do.
>
>> + =A0 =A0 return 0;
>> +
>> +err_free_irq:
>> + =A0 =A0 free_irq(client->irq, data);
>> +err_free_mem:
>> + =A0 =A0 input_free_device(input_dev);
>> + =A0 =A0 kfree(data);
>> + =A0 =A0 return error;
>> +}
>> +
>> +static int __devexit mpr_touchkey_remove(struct i2c_client *client)
>> +{
>> + =A0 =A0 struct mpr121_touchkey_data *data =3D i2c_get_clientdata(c=
lient);
>> +
>> + =A0 =A0 free_irq(client->irq, data);
>> + =A0 =A0 input_unregister_device(data->input_dev);
>> + =A0 =A0 kfree(data);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int mpr_suspend(struct device *dev)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> +
>> + =A0 =A0 if (device_may_wakeup(&client->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(client->irq);
>> +
>> + =A0 =A0 i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x0=
0);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int mpr_resume(struct device *dev)
>> +{
>> + =A0 =A0 struct i2c_client *client =3D to_i2c_client(dev);
>> + =A0 =A0 struct mpr121_touchkey_data *data =3D i2c_get_clientdata(c=
lient);
>> +
>> + =A0 =A0 if (device_may_wakeup(&client->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(client->irq);
>> +
>> + =A0 =A0 i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, dat=
a->keycount);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +#endif
>> +
>> +static const struct i2c_device_id mpr121_id[] =3D {
>> + =A0 =A0 {"mpr121_touchkey", 0},
>> + =A0 =A0 { }
>> +};
>> +
>> +static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_r=
esume);
>> +
>> +static struct i2c_driver mpr_touchkey_driver =3D {
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "mpr121",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &mpr121_touchkey_pm_ops,
>> + =A0 =A0 },
>> + =A0 =A0 .id_table =A0 =A0 =A0 =3D mpr121_id,
>> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D mpr_touchkey_probe,
>> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(mpr_touchkey_remov=
e),
>> +};
>> +
>> +static int __init mpr_touchkey_init(void)
>> +{
>> + =A0 =A0 return i2c_add_driver(&mpr_touchkey_driver);
>> +}
>> +
>> +static void __exit mpr_touchkey_exit(void)
>> +{
>> + =A0 =A0 i2c_del_driver(&mpr_touchkey_driver);
>> +}
>> +
>> +module_init(mpr_touchkey_init);
>> +module_exit(mpr_touchkey_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
>> +MODULE_DESCRIPTION("Touch Key driver for FSL MPR121 Chip");
>> diff --git a/include/linux/i2c/mpr.h b/include/linux/i2c/mpr.h
>> new file mode 100644
>> index 0000000..52d6e33
>> --- /dev/null
>> +++ b/include/linux/i2c/mpr.h
>> @@ -0,0 +1,64 @@
>> +/* mpr.h - Header file for Freescale mpr121 capacitive touch sensor
>> + * controllor */
>> +
>> +#ifndef MPR_H
>> +#define MPR_H
>> +
>> +/* Register definitions */
>> +#define ELE_TOUCH_STATUS_0_ADDR =A0 =A0 =A00x0
>> +#define ELE_TOUCH_STATUS_1_ADDR =A0 =A0 =A00X1
>> +#define MHD_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2b
>> +#define NHD_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2c
>> +#define NCL_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2d
>> +#define FDL_RISING_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x2e
>> +#define MHD_FALLING_ADDR =A0 =A0 0x2f
>> +#define NHD_FALLING_ADDR =A0 =A0 0x30
>> +#define NCL_FALLING_ADDR =A0 =A0 0x31
>> +#define FDL_FALLING_ADDR =A0 =A0 0x32
>> +#define ELE0_TOUCH_THRESHOLD_ADDR =A0 =A00x41
>> +#define ELE0_RELEASE_THRESHOLD_ADDR =A00x42
>> +/* ELE0...ELE11's threshold will set in a loop */
>> +#define AFE_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x5c
>> +#define FILTER_CONF_ADDR =A0 =A0 =A0 =A0 =A0 =A0 0x5d
>> +
>> +/* ELECTRODE_CONF: this register is most important register, it
>> + * control how many of electrode is enabled. If you set this regist=
er
>> + * to 0x0, it make the sensor going to suspend mode. Other value(lo=
w
>> + * bit is non-zero) will make the sensor into Run mode. =A0This reg=
ister
>> + * should be write at last.
>
> Hmm, most of the comments require proper grammar. If you need help wi=
th
> it - let the list know, we'll try to help.
>
>> + */
>> +#define ELECTRODE_CONF_ADDR =A0 =A0 =A0 =A0 =A00x5e
>> +#define AUTO_CONFIG_CTRL_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x7b
>> +/* AUTO_CONFIG_USL: Upper Limit for auto baseline search, this
>> + * register is related to VDD supplied on your board, the value of
>> + * this register is calc by EQ: `((VDD-0.7)/VDD) * 256`.
>> + * AUTO_CONFIG_LSL: Low Limit of auto baseline search. This is 65% =
of
>> + * USL AUTO_CONFIG_TL: The Traget Level of auto baseline search, Th=
is
>> + * is 90% of USL =A0*/
>> +#define AUTO_CONFIG_USL_ADDR =A0 =A0 =A0 =A0 0x7d
>> +#define AUTO_CONFIG_LSL_ADDR =A0 =A0 =A0 =A0 0x7e
>> +#define AUTO_CONFIG_TL_ADDR =A0 =A0 =A0 =A0 =A00x7f
>> +
>> +/* Threshold of touch/release trigger */
>> +#define TOUCH_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
0x0f
>> +#define RELEASE_THRESHOLD =A0 =A0 =A0 =A0 =A0 =A00x0a
>> +/* Mask Button bits of STATUS_0 & STATUS_1 register */
>> +#define TOUCH_STATUS_MASK =A0 =A0 =A0 =A0 =A0 =A00xfff
>> +/* MPR121 have 12 electrodes */
>> +#define MPR121_MAX_KEY_COUNT =A0 =A0 =A0 =A0 12
>> +
>> +
>> +/**
>> + * @keycount: how many key maped
>> + * @vdd_uv: voltage of vdd supply the chip in uV
>> + * @matrix: maxtrix of keys
>> + * @wakeup: can key wake up system.
>> + */
>> +struct mpr121_platform_data {
>> + =A0 =A0 u16 keycount;
>> + =A0 =A0 u16 *matrix;
>
> If this device is indeed organized as a matrix (lookslike this) maybe
> you should look at definitions provided by
> include/linux/input/matrix_keypad.h

OK, will change platform data to use matrix_keypad_data structure, I
will convert them into an array into struct mpr121_touchkey: u16
keycodes[12]. The reason is it's will more similar to controller's
register map.

>
>> + =A0 =A0 int wakeup;
>
> bool?
wiil do.
>
>> + =A0 =A0 int vdd_uv;
>> +};
>> +
>> +#endif
>
> Thanks.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
