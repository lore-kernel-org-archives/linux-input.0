From: Fabien Marteau <fabien.marteau@armadeus.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver
Date: Thu, 25 Nov 2010 11:10:58 +0100
Message-ID: <4CEE3632.6020502@armadeus.com>
References: <4CEBED7E.7010101@armadeus.com> <20101124195523.GF27368@core.coreip.homeip.net>
Reply-To: fabien.marteau@armadeus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 31.mail-out.ovh.net ([213.186.62.10]:55385 "HELO
	31.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751564Ab0KYKRp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Nov 2010 05:17:45 -0500
In-Reply-To: <20101124195523.GF27368@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for yours comments, it's my first kernel driver patch and you=
r advices
are really helpful.

On 24/11/2010 20:55, Dmitry Torokhov wrote:
> Hi Fabien,
>=20
> On Tue, Nov 23, 2010 at 05:36:14PM +0100, Fabien Marteau wrote:
>> Driver for EasyPoint AS5011 2 axis joystick chip. This chip is plugg=
ed
>> on an I2C bus. It as been tested on ARM processor (i.MX27).
>>
>=20
> Thank you for the patch. In addiitoon to comments you got from the ot=
her
> reviewers I'd recommend switching to threaded IRQ instead of using a
> separate workqueue, it greatly simplifies the code.

Ok I will see it.

>=20
>> +
>> +static irqreturn_t button_interrupt(int irq, void *dev_id)
>> +{
>> +	struct as5011_platform_data *plat_dat =3D
>> +		(struct as5011_platform_data *)dev_id;
>> +	int ret;
>> +
>> +	ret =3D gpio_get_value(plat_dat->button_gpio);
>> +	if (ret)
>> +		input_report_key(plat_dat->input_dev, BTN_JOYSTICK, 0);
>> +	else
>> +		input_report_key(plat_dat->input_dev, BTN_JOYSTICK, 1);
>> +	input_sync(plat_dat->input_dev);
>> +	return IRQ_HANDLED;
>=20
> That appears to be a hard IRQ; are you sure that gpio_get_value will =
not
> sleep?

=46or my platform, yes I'm sure =85 but if somebody else use this drive=
r with
gpio that can sleep, it can be a bad idea of course.
I did it because it's under an interrupt call, then we can't sleep.
I will see how to use  a threaded IRQ to avoid it.

>=20
>> +
>> +	plat_dat->input_dev->name =3D "Austria Microsystem as5011 joystick=
";
>> +	plat_dat->input_dev->uniq =3D "Austria0";
>> +	plat_dat->input_dev->id.bustype =3D BUS_I2C;
>> +	plat_dat->input_dev->phys =3D "/dev/input/event0";
>=20
> Phys is not the path in device tree but rather physical device
> connection path within the system. If there is not known connection p=
ath
> it is better just leave it as NULL.

Ok, done.

>=20
>> +	plat_dat->input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_A=
BS);
>> +	plat_dat->input_dev->keybit[BIT_WORD(BTN_JOYSTICK)] =3D
>> +					BIT_MASK(BTN_JOYSTICK);
>> +
>> +	input_set_abs_params(plat_dat->input_dev,
>> +			     ABS_X,
>> +			     AS5011_MIN_AXIS,
>> +			     AS5011_MAX_AXIS,
>> +			     AS5011_FUZZ,
>> +			     AS5011_FLAT);
>> +	input_set_abs_params(plat_dat->input_dev,
>> +			     ABS_Y,
>> +			     AS5011_MIN_AXIS,
>> +			     AS5011_MAX_AXIS,
>> +			     AS5011_FUZZ,
>> +			     AS5011_FLAT);
>> +
>> +	plat_dat->button_irq_name =3D
>> +		kmalloc(sizeof(unsigned char)*SIZE_NAME,
>> +					 GFP_KERNEL);
>=20
> Just why does it have to be separately allocated? I'd even stick with
> "as5011" for all IRQ names.

I thought that irq name should be different for each IRQ used under dev=
ice and
for each device used in system. I can use the same irq name if I've got=
 several
as5011 joystick in the same system ?

>=20
>> +
>> +	queue_work(plat_dat->workqueue, &plat_dat->update_axes_work);
>> +
>=20
> The device is quite likely not opened here so why do you want to send
> events?
It was a mistake.

>=20
> Thanks.
>=20

Thanks too.
=46abien
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
