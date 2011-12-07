From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] Driver for AUO In-Cell touchscreens using pixcir ICs
Date: Wed, 7 Dec 2011 23:09:43 +0100
Message-ID: <201112072309.43589.heiko@sntech.de>
References: <201112052105.31757.heiko@sntech.de> <20111206055637.GB21617@core.coreip.homeip.net> <201112071531.21157.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from s15407518.onlinehome-server.info ([82.165.136.167]:52461 "EHLO
	s15407518.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752444Ab1LGWJq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Dec 2011 17:09:46 -0500
In-Reply-To: <201112071531.21157.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Am Mittwoch 07 Dezember 2011, 15:31:20 schrieb Heiko St=FCbner:
> Hi Dmitry,
>=20
> thanks for the review
>=20
> Am Dienstag, 6. Dezember 2011, 06:56:37 schrieb Dmitry Torokhov:
> > On Mon, Dec 05, 2011 at 09:05:30PM +0100, Heiko St=FCbner wrote:
> > > Some displays from AUO have a so called in-cell touchscreen, mean=
ing it
> > > is built directly into the display unit.
> > >=20
> > > Touchdata is gathered through PIXCIR Tango-ICs and processed in a=
n
> > > Atmel ATmega168P with custom firmware. Communication between the =
host
> > > system and ATmega is done via I2C.
> > >=20
> > > Devices using this touch solution include the Dell Streak5 and th=
e
> > > family of Qisda ebook readers.
> > >=20
> > > The driver reports single- and multi-touch events including touch=
 area
> > > values.
> > >=20
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > > changes since v1: address comments from Christoph Fritz
> > > (wrong type for error checks, wrong call to input_free_device)
> > >=20
> > >  drivers/input/touchscreen/Kconfig         |   14 +
> > >  drivers/input/touchscreen/Makefile        |    1 +
> > >  drivers/input/touchscreen/auo-pixcir-ts.c |  656
> > >  +++++++++++++++++++++++++++++ include/linux/input/auo-pixcir-ts.=
h
> > > =20
> > >  |   57 +++
> > > =20
> > >  4 files changed, 728 insertions(+), 0 deletions(-)
> > >  create mode 100644 drivers/input/touchscreen/auo-pixcir-ts.c
> > >  create mode 100644 include/linux/input/auo-pixcir-ts.h
>=20
> [ ... small corrections, thanks for finding them ... ]
>=20
> > > +
> > > +		for (i =3D 0; i < AUO_PIXCIR_REPORT_POINTS; i++) {
> > > +			if (point[i].coord_x > 0 || point[i].coord_y > 0) {
> > > +				input_report_abs(ts->input, ABS_MT_POSITION_X,
> > > +						 point[i].coord_x);
> > > +				input_report_abs(ts->input, ABS_MT_POSITION_Y,
> > > +						 point[i].coord_y);
> > > +				input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR,
> > > +						 point[i].area_major);
> > > +				input_report_abs(ts->input, ABS_MT_TOUCH_MINOR,
> > > +						 point[i].area_minor);
> > > +				input_report_abs(ts->input, ABS_MT_ORIENTATION,
> > > +						 point[i].orientation);
> > > +				input_mt_sync(ts->input);
> >=20
> > Is there a way to track the contacts and switch to protocol B by an=
y
> > chance?
>=20
> I'm not sure, but will check how the device handles changing the numb=
er of
> touching fingers and if it would be possible to switch.

Sadly, the device does not seem capable of really tracking the contacts=
=20
individually.
My testcase:
- p0 <-> finger0, p1 <-> finger1
- finger0 is lifted=20
in todays test: new mapping finger1 <-> p0
some time ago during another test sometimes it did this switch and some=
times=20
not, so the mapping reported point <-> finger is probably not stable.

> > > +
> > > +				/* use first finger as source for singletouch */
> > > +				if (fingers =3D=3D 0)
> > > +					abs =3D i;
> > > +
> > > +				/* number of touch points could also be queried
> > > +				 * via i2c but would require an additional call
> > > +				 */
> > > +				fingers++;
> > > +			}
> > > +		}
>=20
> [ ... more small stuff for me to fix ... ]
>=20
> > > +
> > > +	ret =3D input_register_device(input_dev);
> > > +	if (ret) {
> > > +		dev_err(&client->dev, "could not register input device\n");
> > > +		goto err_input_register;
> > > +	}
> > > +
> > > +	input_set_drvdata(ts->input, ts);
> >=20
> > Just do this earlier and then auo_pixcir_stop() is enough, you won'=
t
> > need to call auo_pixcir_int_enable() before registering IRQ.
>=20
> Just to be sure, you mean moving the input_set_drvdata before the irq=
-
> registration?

seems to work

> > > +
> > > +	i2c_set_clientdata(client, ts);
> > > +
> > > +	return 0;
> > > +
>=20
> [ ... and still more small stuff ]
>=20
> Thanks
> Heiko

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
