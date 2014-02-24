From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH v2 1/4] Add ff-memless-next driver
Date: Mon, 24 Feb 2014 02:18:21 +0100
Message-ID: <3296661.ZtKKWyXPzF@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime> <3364546.xScl1m6sdc@geidi-prime> <530A931D.9030308@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530A931D.9030308@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

On Monday 24 of February 2014 02:32:29 Anssi Hannula wrote:
> 24.02.2014 01:29, Michal Mal=FD kirjoitti:
> > Introduce ff-memless-next module as a possible future replacement o=
f
> > ff-memless.
> >=20
> > Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
> > Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
>=20
> Some comments below.
>=20
> > ---
> >=20
> >  v2:
> >   Handle upload and removal of uncombinable effects correctly
> >   Remove redundant information from the documentation file
> >   Invert direction of force along Y axis to conform to common conve=
ntions
> >   Set FF_GAIN bit
> > =20
> >  Documentation/input/ff-memless-next.txt | 141 ++++++
> >  drivers/input/Kconfig                   |  11 +
> >  drivers/input/Makefile                  |   1 +
> >  drivers/input/ff-memless-next.c         | 789
> >  ++++++++++++++++++++++++++++++++ include/linux/input/ff-memless-ne=
xt.h =20
> >  |  32 ++
> >  5 files changed, 974 insertions(+)
> >  create mode 100644 Documentation/input/ff-memless-next.txt
> >  create mode 100644 drivers/input/ff-memless-next.c
> >  create mode 100644 include/linux/input/ff-memless-next.h
> >=20
> > diff --git a/Documentation/input/ff-memless-next.txt
> > b/Documentation/input/ff-memless-next.txt new file mode 100644
> > index 0000000..1b550dc
> > --- /dev/null
> > +++ b/Documentation/input/ff-memless-next.txt
> > @@ -0,0 +1,141 @@
>=20
> [...]
>=20
> > +3. API provided by "ff-memless-next"
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +"ff-memless-next" provides an API for developers of hardware-speci=
fic
> > +drivers. In order to use the API, the hardware-specific driver sho=
uld
> > +include <linux/input/ff-memless-next.h>
>=20
> > +Functions and structs defined by this API are:
> [...]
>=20
> This kind of basic API documentation belongs in the headers (kernel-d=
oc
> format).
>=20
> [...]
>=20
> > +	MLNX_UPLOAD_UNCOMB - Check if the device can accept and play
> > +			     "uncombinable" effect and upload the effect into
> > +			     the device's internal memory.
> > +			     Hardware-specific driver should return 0
> > +			     on success.
> > +	MLNX_ERASE_UNCOMB - Remove "uncombinable" effect from device's
> > +			    internal memory.
> > +			    Hardware-specific driver should return 0
> > +			    on success.
> > +	MLNX_START_UNCOMB - Start playback of "uncombinable" effect.
> > +	MLNX_STOP_UNCOMB - Stop playback of "uncombinable" effect.
>=20
> These seem to be unused by any drivers?
>=20
> I don't think they should be added to the kernel before there is an
> implementation using them (it also makes reviewing them more difficul=
t).

They are used by my dummy driver (link to the source is in the document=
ation).=20
Handling uncombinable effects in lg4ff would be a bit more involved so =
I=20
decided to add support for these in a separate patch series.

> [...]
>=20
> > +4. Specifics of "ff-memless-next" for userspace developers
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +None of the persons involved in development or testing of
> > "ff-memless-next" +is aware of any reference force feedback
> > specifications. "ff-memless-next" +tries to adhere to Microsoft's
> > DirectInput specifications because we +believe that is what most
> > developers have experience with.
> > +
> > +- Waveforms of periodic effects do not start at the origin, but as
> > follows: +	SAW_UP: At minimum
> > +	SAW_DOWN: At maximum
> > +	SQUARE: At maximum
> > +	TRIANGLE: At maximum
> > +	SINE: At origin
> > +
> > +- Updating periodic effects:
> > +	- All periodic effects are restarted when their parameters are=20
updated.
> > +
> > +- Updating effects of finite duration:
> > +	- Once an effect of finite length finishes playing, it is conside=
red
> > +	  stopped. Only effects that are playing can be updated on the fl=
y.
> > +	  Therefore effects of finite duration can be updated only until
> > +	  they finish playing.
>=20
> Stopped effects should still be able to be updated.
>=20
> Anyway, if you want to target userspace developers with this
> information, you should put it in generic documentation ("it is not
> guaranteed that X", etc.). If not, don't say "for userspace developer=
s".
>=20
> [...]
>=20
> > diff --git a/drivers/input/ff-memless-next.c
> > b/drivers/input/ff-memless-next.c new file mode 100644
> > index 0000000..843a223
> > --- /dev/null
> > +++ b/drivers/input/ff-memless-next.c
> > @@ -0,0 +1,789 @@
> > +/*
> > + * Force feedback support for memoryless devices
> > + *
> > + * This module is based on "ff-memless" orignally written by Anssi
> > Hannula. + * It is extended to support all force feedback effects
> > currently supported + * by the Linux input stack.
> > + *
> > + * Copyright(c) 2013 Michal Maly <madcatxster@prifuk.cz>
> > + *
> > + */
>=20
> [...]
>=20
> > +static int mlnx_upload(struct input_dev *dev, struct ff_effect *ef=
fect,
> > +		       struct ff_effect *old)
> > +{
>=20
> [...]
>=20
> > +		}
> > +
> > +		mlnx_schedule_playback(mlnxdev);
> > +		spin_unlock_irq(&dev->event_lock);
> > +		return 0;
>=20
> The above two lines are unneeded.
Oops...

> > +	}
> > +
> > +	spin_unlock_irq(&dev->event_lock);
> > +
> > +	return 0;
> > +}
> > +
>=20
> [...]
>=20
> > diff --git a/include/linux/input/ff-memless-next.h
> > b/include/linux/input/ff-memless-next.h new file mode 100644
> > index 0000000..ba89ba1
> > --- /dev/null
> > +++ b/include/linux/input/ff-memless-next.h
> > @@ -0,0 +1,32 @@
>=20
> [...]
>=20
> > +int input_ff_create_mlnx(struct input_dev *dev, void *data,
> > +			 int(*control_effect)(struct input_dev *, void *, const=20
struct
> > mlnx_effect_command *), +			 const u16 update_rate);
>=20
> Why is update_rate now driver-selectable?
Because it is my intention to replace ff-memless with MLNX, I want to a=
ccount=20
for (very old?) devices that might have a limit on how many commands th=
ey can=20
accept within a given timeframe. Update interval in ff-memless is 50 ms=
ecs=20
whereas Logitech wheels can go as low as 8 msecs. The lower the update=20
interval - the better the quality of periodic, ramp and envelope effect=
s.=20
Allowing the driver to choose how fast will MLNX generate updates seeme=
d like=20
the best way to go.


Your feedback is very much appreciated...

Michal M.
