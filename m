From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 12/19] twl4030: mfd_cell is now implicitly available to
 drivers
Date: Fri, 4 Feb 2011 11:41:59 +0100
Message-ID: <20110204104159.GA18714@pengutronix.de>
References: <20110202195417.228e2656@queued.net>
 <20110202201522.72d37f1e@queued.net>
 <20110203060521.GA25739@core.coreip.homeip.net>
 <20110202223959.244b4a01@queued.net>
 <20110203065339.GA5592@core.coreip.homeip.net>
 <20110202230326.167fe873@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110202230326.167fe873@queued.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org, Mark@alsa-project.org, Jaroslav@alsa-project.org, linux-input@vger.kernel.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org

Hello Andres,

On Wed, Feb 02, 2011 at 11:03:26PM -0800, Andres Salomon wrote:
> On Wed, 2 Feb 2011 22:53:39 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>=20
> > On Wed, Feb 02, 2011 at 10:39:59PM -0800, Andres Salomon wrote:
> > > On Wed, 2 Feb 2011 22:05:21 -0800
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >=20
> > > > On Wed, Feb 02, 2011 at 08:15:22PM -0800, Andres Salomon wrote:
> > > > >  static int __devinit twl4030_vibra_probe(struct platform_dev=
ice
> > > > > *pdev) {
> > > > > -	struct twl4030_codec_vibra_data *pdata =3D
> > > > > pdev->dev.platform_data;
> > > > > +	struct twl4030_codec_vibra_data *pdata =3D
> > > > > platform_get_drvdata(pdev);
> > > >=20
> > > > No, device's drvdata belongs to _this_ driver, and it is suppos=
ed
> > > > to manage it and use as it sees fit.
> > >=20
> > > Right, so it's used to pass data to the probe function; once the
> > > probe function has obtained the pdata pointer, it's free to do wi=
th
> > > it what it will.
> > >=20
> > >=20
> > > >=20
> > > > Note platform_set_drvdata(pdev, info) later in this function al=
ong
> > > > with platform_set_drvdata(pdev, NULL) in twl4030_vibra_remove()=
,
> > > > which means that with your change you will be able to bind the
> > > > device only once.
> > > >=20
> > >=20
> > > Hm, good point; if the driver is reloaded, the pdev that was
> > > created by mfd-core will have lost the pointer to pdata.
> > >=20
> > > I wonder if I should be using mfd's driver_data instead. I used
> > > platform_data because a bunch of drivers had already made use of =
it
> > > to pass cell information..
> >=20
> > Then they are doing it incorrectly. One possible way is to have par=
ent
> > device carry relevant data in its drvdata and have children get it
> > from there.
> >=20
>=20
> I believe some drivers are even using the parent device already.  See
> drivers/leds/leds-mc13783.c, for example, whose parent device drvdata
> is used to pass around a struct mc13783 to its children.  Sounds
> like a possibility, will need to look into it further.
IMHO this isn't optimal done.  The led driver somehow needs access to a
struct mc13xxx because that one defines how to change the led-related
registers.

If you ask me, the most clean solution would be that the functions like
mc13xxx_lock and mc13xxx_reg_rmw wouldn't take a struct mc13xxx * as
first parameter but a struct device *.  Because in fact it's not the le=
d
driver's business what the mfd driver stores in his driver data.

(Note, I said clean, neither easy nor effective nor best.)

Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
