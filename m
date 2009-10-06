From: Jernej Turnsek <jernej.turnsek@gmail.com>
Subject: Re: [PATCH] Touchscreen driver for the DTS413
Date: Tue, 6 Oct 2009 09:44:03 +0200
Message-ID: <a57e67db0910060044g53ffd8a2s6db14c305bbf91df@mail.gmail.com>
References: <a57e67db0909280023q7d352f22ge5b5343dc0c79c65@mail.gmail.com>
	 <4AC1DAA4.4090508@simtec.co.uk>
	 <a57e67db0909290500k52bcd1faj28903a22cd2c91a5@mail.gmail.com>
	 <a57e67db0909290514r3097a97dtbb82e28a5176ac64@mail.gmail.com>
	 <20091006050640.GG27881@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f217.google.com ([209.85.219.217]:38324 "EHLO
	mail-ew0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbZJFHok convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2009 03:44:40 -0400
Received: by ewy17 with SMTP id 17so3607810ewy.39
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2009 00:44:03 -0700 (PDT)
In-Reply-To: <20091006050640.GG27881@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

I would like to thank you for taking time to review DTS413 driver, but
I am a little bit confused here. Regarding the comments I just
followed a Ben Dooks suggestions, but I agree that internal functions
shouldn't be commented in kernel doc style. Other thing is
ABS_PRESSURE reporting. At first I thought that this is not
neccessary, but when using driver with the Kdrive tiny X server
(Xfbdev), it won't work. Xfbdev gives me Segmentation Fault.

BR,

Jernej

On Tue, Oct 6, 2009 at 7:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Jernej,
>
> On Tue, Sep 29, 2009 at 02:14:25PM +0200, Jernej Turnsek wrote:
>> +
>> +/**
>> + * struct dts413 - device structure
>> + * @client: the i2c client,
>> + * @input: the input device,
>> + * @work: workqueue,
>> + * @irq: irq number.
>> + *
>> + * Structure for holding the internal context of a driver.
>> + */
>
> This is an internal driver structre, it does not form a public
> interface. I don't see the reason for it to be documented as such.
> This really applies to all comments in the driver.
>
>> +struct dts413 {
>> + =A0 =A0 =A0 struct i2c_client *client;
>> + =A0 =A0 =A0 struct input_dev *input;
>> + =A0 =A0 =A0 struct work_struct work;
>> + =A0 =A0 =A0 int irq;
>> +};
>> +
>> +/**
>> + * dts413_poscheck() - function for position checking
>> + * @work: workqueue.
>> + *
>> + * DTS413 report packet:
>> + * =A0 =A0 =A0 =A0MSB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 LSB
>> + * BYTE1:| 1 | R | R | R | R | R | R | S |
>> + * BYTE2:| 0 | 0 | 0 | 0 |A10| A9| A8| A7|
>> + * BYTE3:| 0 | A6| A5| A4| A3| A2| A1| A0|
>> + * BYTE4:| 0 | 0 | 0 | 0 |B10| B9| B8| B7|
>> + * BYTE5:| 0 | B6| B5| B4| B3| B2| B1| B0|
>> + * BYTE6:| 0 | P6| P5| P4| P3| P2| P1| P0|
>> + *
>> + * S - status
>> + * A10-A0 - 11 bits of 1st direction raw data
>> + * B10-B0 - 11 bits of 2st direction raw data
>> + * P6-P0 - 7 bits of finger pressure
>> + * Please be aware that A nad B just represent 2 resolution directi=
ons
>> + * of the touch panel. The reported coordinates are (0~2047,0-2047)=
,
>> + * the bottom left is (0,0).
>> + */
>> +static void dts413_poscheck(struct work_struct *work)
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv =3D container_of(work,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dts413,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 work);
>> + =A0 =A0 =A0 unsigned short xpos, ypos;
>> + =A0 =A0 =A0 u_int8_t event, speed;
>> + =A0 =A0 =A0 u_int8_t buf[6];
>> +
>> + =A0 =A0 =A0 memset(buf, 0, sizeof(buf));
>> +
>> + =A0 =A0 =A0 /* now do page read */
>> + =A0 =A0 =A0 if (i2c_master_recv(priv->client, buf, sizeof(buf)) !=3D=
 sizeof(buf)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&priv->client->dev, "Unable to=
 read i2c page\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 event =3D (buf[0] & 0x01) ? 1 : 0;
>> + =A0 =A0 =A0 xpos =3D (unsigned short)(buf[2] & 0x7f) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned short)(buf[=
1] & 0x0f) << 7);
>> + =A0 =A0 =A0 ypos =3D (unsigned short)(buf[4] & 0x7f) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((unsigned short)(buf[=
3] & 0x0f) << 7);
>> + =A0 =A0 =A0 speed =3D (buf[5] & 0x7f);
>> +
>> + =A0 =A0 =A0 if (event =3D=3D EVENT_PENDOWN) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(priv->input, BTN_TOUC=
H, 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_X, x=
pos);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_Y, 2=
048 - ypos);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_PRES=
SURE, 1);
>
> The device does not report pressure so don't fake it. BTN_TOUCH is
> enough.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(priv->input);
>> + =A0 =A0 =A0 } else if (event =3D=3D EVENT_PENUP) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(priv->input, BTN_TOUC=
H, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(priv->input, ABS_PRES=
SURE, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_sync(priv->input);
>> + =A0 =A0 =A0 }
>> + out:
>> + =A0 =A0 =A0 enable_irq(priv->irq);
>> +}
>> +
>> +/**
>> + * dts413_isr() - interrupt service routine
>> + * @irg: irq number.
>> + * @dev_id: dts413 device.
>> + *
>> + * The touch screen controller chip is hooked up to the cpu
>> + * using i2c and a single interrupt line. The interrupt line
>> + * is pulled low whenever someone taps the screen. To deassert
>> + * the interrupt line we need to acknowledge the interrupt by
>> + * communicating with the controller over the slow i2c bus.
>> + *
>> + * We can't acknowledge from interrupt context since the i2c
>> + * bus controller may sleep, so we just disable the interrupt
>> + * here and handle the acknowledge using delayed work.
>> + */
>> +static irqreturn_t dts413_isr(int irq, void *dev_id)
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv =3D dev_id;
>> +
>> + =A0 =A0 =A0 disable_irq_nosync(irq);
>> + =A0 =A0 =A0 schedule_work(&priv->work);
>> +
>> + =A0 =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int dts413_open(struct input_dev *dev)
>> +{
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static void dts413_close(struct input_dev *dev)
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv =3D input_get_drvdata(dev);
>> +
>> + =A0 =A0 =A0 disable_irq(priv->irq);
>> +
>> + =A0 =A0 =A0 cancel_work_sync(&priv->work);
>> +
>> + =A0 =A0 =A0 enable_irq(priv->irq);
>
>
> No, you can't do this. Unlike migor_ts driver that actually turns off
> the controller there is nothing that prevents the device to generate
> more interrupts (and schedule more work) after "closing" the device.
> This means that there is a chance that there is still work scheduled
> after you unregister device and free memory in remove(). This code mu=
st
> go there.
>
>> +}
>> +
>> +static int dts413_probe(struct i2c_client *client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_devic=
e_id *idp)
>
> __devinit
>
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv;
>> + =A0 =A0 =A0 struct input_dev *input;
>> + =A0 =A0 =A0 int error;
>> +
>> + =A0 =A0 =A0 priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!priv) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "failed to alloc=
ate driver data\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err0;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 dev_set_drvdata(&client->dev, priv);
>> +
>> + =A0 =A0 =A0 input =3D input_allocate_device();
>> + =A0 =A0 =A0 if (!input) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Failed to alloc=
ate input device.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 input->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS=
);
>> + =A0 =A0 =A0 input->keybit[BIT_WORD(BTN_TOUCH)] =3D BIT_MASK(BTN_TO=
UCH);
>> +
>> + =A0 =A0 =A0 input_set_abs_params(input, ABS_X, 0, MAX_11BIT, 0, 0)=
;
>> + =A0 =A0 =A0 input_set_abs_params(input, ABS_Y, 0, MAX_11BIT, 0, 0)=
;
>> + =A0 =A0 =A0 input_set_abs_params(input, ABS_PRESSURE, 0, 0, 0, 0);
>
> No pressure.
>
>> +
>> + =A0 =A0 =A0 input->name =3D client->name;
>> + =A0 =A0 =A0 input->id.bustype =3D BUS_I2C;
>> + =A0 =A0 =A0 input->dev.parent =3D &client->dev;
>> +
>> + =A0 =A0 =A0 input->open =3D dts413_open;
>> + =A0 =A0 =A0 input->close =3D dts413_close;
>> +
>> + =A0 =A0 =A0 input_set_drvdata(input, priv);
>> +
>> + =A0 =A0 =A0 priv->client =3D client;
>> + =A0 =A0 =A0 priv->input =3D input;
>> + =A0 =A0 =A0 INIT_WORK(&priv->work, dts413_poscheck);
>> + =A0 =A0 =A0 priv->irq =3D client->irq;
>> +
>> + =A0 =A0 =A0 error =3D input_register_device(input);
>> + =A0 =A0 =A0 if (error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> +
>> + =A0 =A0 =A0 error =3D request_irq(priv->irq, dts413_isr,
>> IRQF_TRIGGER_FALLING/*IRQF_TRIGGER_LOW*/,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->name, =
priv);
>> + =A0 =A0 =A0 if (error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&client->dev, "Unable to reque=
st touchscreen IRQ.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 device_init_wakeup(&client->dev, 1);
>> + =A0 =A0 =A0 return 0;
>> +
>> + err2:
>> + =A0 =A0 =A0 input_unregister_device(input);
>> + =A0 =A0 =A0 input =3D NULL; /* so we dont try to free it below */
>> + err1:
>> + =A0 =A0 =A0 input_free_device(input);
>> + =A0 =A0 =A0 kfree(priv);
>> + err0:
>> + =A0 =A0 =A0 dev_set_drvdata(&client->dev, NULL);
>> + =A0 =A0 =A0 return error;
>> +}
>> +
>> +static int dts413_remove(struct i2c_client *client)
>
> __devexit.
>
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv =3D dev_get_drvdata(&client->dev);
>> +
>> + =A0 =A0 =A0 free_irq(priv->irq, priv);
>> + =A0 =A0 =A0 input_unregister_device(priv->input);
>> + =A0 =A0 =A0 kfree(priv);
>> +
>> + =A0 =A0 =A0 dev_set_drvdata(&client->dev, NULL);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int dts413_suspend(struct i2c_client *client, pm_message_t m=
esg)
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv =3D dev_get_drvdata(&client->dev);
>> +
>> + =A0 =A0 =A0 if (device_may_wakeup(&client->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_irq_wake(priv->irq);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static int dts413_resume(struct i2c_client *client)
>> +{
>> + =A0 =A0 =A0 struct dts413 *priv =3D dev_get_drvdata(&client->dev);
>> +
>> + =A0 =A0 =A0 if (device_may_wakeup(&client->dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_irq_wake(priv->irq);
>> +
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +static struct i2c_device_id dts413_idtable[] =3D {
>> + =A0 =A0 =A0 { "dts413", 0 },
>> + =A0 =A0 =A0 { }
>> +};
>> +
>> +MODULE_DEVICE_TABLE(i2c, dts413_idtable);
>> +
>> +static struct i2c_driver dts413_driver =3D {
>> + =A0 =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "dts413"
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .id_table =A0 =A0 =A0 =3D dts413_idtable,
>> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D dts413_probe,
>> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(dts413_remove)=
,
>> + =A0 =A0 =A0 .suspend =3D dts413_suspend,
>> + =A0 =A0 =A0 .resume =3D dts413_resume,
>> +};
>> +
>> +static int __init dts413_init(void)
>> +{
>> + =A0 =A0 =A0 return i2c_add_driver(&dts413_driver);
>> +}
>> +
>> +static void __exit dts413_exit(void)
>> +{
>> + =A0 =A0 =A0 i2c_del_driver(&dts413_driver);
>> +}
>> +
>> +module_init(dts413_init);
>> +module_exit(dts413_exit);
>> +
>> +MODULE_AUTHOR("Jernej Turnsek <jernej.turnsek@iskraemeco.si>");
>> +MODULE_DESCRIPTION("DTS413 Touch Screen Controller driver");
>> +MODULE_LICENSE("GPL");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
