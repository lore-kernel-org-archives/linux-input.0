From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v3] Input: ad7879: support auxiliary
	GPIOs via gpiolib
Date: Mon, 18 Jan 2010 01:48:14 -0500
Message-ID: <8bd0f97a1001172248n531973ai8be0bf48926724ad@mail.gmail.com>
References: <20100113025456.GA2301@core.coreip.homeip.net>
	<1263742602-22250-1-git-send-email-vapier@gentoo.org> <20100118063507.GA5012@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38431 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab0ARGsj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 01:48:39 -0500
Received: by yxe17 with SMTP id 17so3229363yxe.33
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2010 22:48:38 -0800 (PST)
In-Reply-To: <20100118063507.GA5012@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Mon, Jan 18, 2010 at 01:35, Dmitry Torokhov wrote:
> On Sun, Jan 17, 2010 at 10:36:42AM -0500, Mike Frysinger wrote:
>> +#ifdef CONFIG_GPIOLIB
>> +int ad7879_gpio_direction_input(struct gpio_chip *chip, unsigned gp=
io)
>> =C2=A0{
>
> Sparse recommends making this static and it seems like a good idea. T=
he
> same goes for the 3 new fucntions below.

yep

>> +static inline int ad7879_gpio_add(struct device *dev)
>
> Why inline? Let's compiler decide, it's certainly not a hot path.

ad7879_gpio_remove needed to be inlined because it's called from both
the probe (__devinit) and the remove (__devexit) functions.  might
able to write a smaller version though for the probe function to avoid
this.

ad7879_gpio_add is fine to remove the "inline" as long as "__devinit" i=
s added.

>> +{
>> + =C2=A0 =C2=A0 struct ad7879 *ts =3D dev_get_drvdata(dev);
>> + =C2=A0 =C2=A0 struct ad7879_platform_data *pdata =3D dev->platform=
_data;
>> + =C2=A0 =C2=A0 int ret =3D 0;
>> +
>> + =C2=A0 =C2=A0 if (pdata->gpio_export) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.direction_input =3D=
 ad7879_gpio_direction_input;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.direction_output =
=3D ad7879_gpio_direction_output;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.get =3D ad7879_gp=
io_get_value;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.set =3D ad7879_gp=
io_set_value;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.can_sleep =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.base =3D pdata->g=
pio_base;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.ngpio =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.label =3D "AD7879=
-GPIO";
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.owner =3D THIS_MO=
DULE;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.dev =3D dev;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D gpiochip_add(&ts=
->gc);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev_err(dev, "failed to register gpio %d\n",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->gc.base);
>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 return ret;
>> +}
>> +
>> +static int ad7879_gpio_remove(struct device *dev)
>
> There is no chance we can handle errors returned by this function so =
I'd
> make it 'void'.

right
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
