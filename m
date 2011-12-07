From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] Driver for AUO In-Cell touchscreens using pixcir ICs
Date: Wed, 7 Dec 2011 15:31:20 +0100
Message-ID: <201112071531.21157.heiko@sntech.de>
References: <201112052105.31757.heiko@sntech.de> <20111206055637.GB21617@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:47022 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab1LGObY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 09:31:24 -0500
In-Reply-To: <20111206055637.GB21617@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Dmitry,

thanks for the review

Am Dienstag, 6. Dezember 2011, 06:56:37 schrieb Dmitry Torokhov:
> On Mon, Dec 05, 2011 at 09:05:30PM +0100, Heiko St=FCbner wrote:
> > Some displays from AUO have a so called in-cell touchscreen, meanin=
g it
> > is built directly into the display unit.
> >=20
> > Touchdata is gathered through PIXCIR Tango-ICs and processed in an
> > Atmel ATmega168P with custom firmware. Communication between the ho=
st
> > system and ATmega is done via I2C.
> >=20
> > Devices using this touch solution include the Dell Streak5 and the =
family
> > of Qisda ebook readers.
> >=20
> > The driver reports single- and multi-touch events including touch a=
rea
> > values.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > changes since v1: address comments from Christoph Fritz
> > (wrong type for error checks, wrong call to input_free_device)
> >=20
> >  drivers/input/touchscreen/Kconfig         |   14 +
> >  drivers/input/touchscreen/Makefile        |    1 +
> >  drivers/input/touchscreen/auo-pixcir-ts.c |  656
> >  +++++++++++++++++++++++++++++ include/linux/input/auo-pixcir-ts.h =
    =20
> >  |   57 +++
> >  4 files changed, 728 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/touchscreen/auo-pixcir-ts.c
> >  create mode 100644 include/linux/input/auo-pixcir-ts.h
> >=20

[ ... small corrections, thanks for finding them ... ]

> > +
> > +		for (i =3D 0; i < AUO_PIXCIR_REPORT_POINTS; i++) {
> > +			if (point[i].coord_x > 0 || point[i].coord_y > 0) {
> > +				input_report_abs(ts->input, ABS_MT_POSITION_X,
> > +						 point[i].coord_x);
> > +				input_report_abs(ts->input, ABS_MT_POSITION_Y,
> > +						 point[i].coord_y);
> > +				input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> > +						 point[i].area_major);
> > +				input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> > +						 point[i].area_minor);
> > +				input_report_abs(ts->input, ABS_MT_ORIENTATION,
> > +						 point[i].orientation);
> > +				input_mt_sync(ts->input);
>=20
> Is there a way to track the contacts and switch to protocol B by any
> chance?
I'm not sure, but will check how the device handles changing the number=
 of=20
touching fingers and if it would be possible to switch.

> > +
> > +				/* use first finger as source for singletouch */
> > +				if (fingers =3D=3D 0)
> > +					abs =3D i;
> > +
> > +				/* number of touch points could also be queried
> > +				 * via i2c but would require an additional call
> > +				 */
> > +				fingers++;
> > +			}
> > +		}

[ ... more small stuff for me to fix ... ]

> > +
> > +	ret =3D input_register_device(input_dev);
> > +	if (ret) {
> > +		dev_err(&client->dev, "could not register input device\n");
> > +		goto err_input_register;
> > +	}
> > +
> > +	input_set_drvdata(ts->input, ts);
>=20
> Just do this earlier and then auo_pixcir_stop() is enough, you won't
> need to call auo_pixcir_int_enable() before registering IRQ.

Just to be sure, you mean moving the input_set_drvdata before the irq-
registration?

> > +
> > +	i2c_set_clientdata(client, ts);
> > +
> > +	return 0;
> > +

[ ... and still more small stuff ]

Thanks
Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
