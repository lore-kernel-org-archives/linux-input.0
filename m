From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/5] Input: bu21013_ts - Move GPIO init and exit
 functions into the driver
Date: Thu, 22 Nov 2012 11:28:36 +0000
Message-ID: <20121122112836.GF4328@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-3-git-send-email-lee.jones@linaro.org>
 <20121121184256.GD18950@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47257 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367Ab2KVSlv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Nov 2012 13:41:51 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3586158bkw.19
        for <linux-input@vger.kernel.org>; Thu, 22 Nov 2012 10:41:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121121184256.GD18950@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 21 Nov 2012, Dmitry Torokhov wrote:

> Hi Lee,
>=20
> On Wed, Nov 14, 2012 at 01:47:14PM +0000, Lee Jones wrote:
> > @@ -272,6 +276,60 @@ static irqreturn_t bu21013_gpio_irq(int irq, v=
oid *device_data)
> >  }
> > =20
> >  /**
> > + * bu21013_gpio_board_init() - configures the touch panel
> > + * @reset_pin: reset pin number
> > + *
> > + * This function is used to configure the voltage and
> > + * reset the touch panel controller.
> > + */
> > +static int bu21013_gpio_board_init(int reset_pin)
> > +{
> > +	int retval =3D 0;
> > +
> > +	bu21013_devices++;
> > +	if (bu21013_devices =3D=3D 1) {
>=20
> This does not make sense. If gpio is per-device now then we should
> simply set it up and not count devices.

No problem. I'll fixup.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
