From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Date: Sun, 14 Apr 2019 12:40:29 +0100
Message-ID: <20190414124029.1f1f6084@archlinux>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
        <20190407133037.0ad98897@archlinux>
        <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 8 Apr 2019 15:15:56 +0200
H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Hi Jonathan,
>=20
> > Am 07.04.2019 um 14:30 schrieb Jonathan Cameron <jic23@kernel.org>:
> >=20
> > On Sun, 31 Mar 2019 12:09:46 +0200
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >=20
> > Hi Nikolaus,
> >=20
> > I'm probably going to repeat a few things I sent for v1 as the audience=
 has
> > expanded somewhat!
> >=20
> > Good to see this moving forwards though as there has been at least some=
 demand
> > for it going way back to the early days of IIO.
> >  =20
> >> Some user spaces (e.g. some Android devices) use /dev/input/event* for=
 handling
> >> the 3D position of the device with respect to the center of gravity (e=
arth).
> >> This can be used for gaming input, auto-rotation of screens etc.
> >>=20
> >> This interface should be the standard for such use cases because it is=
 an abstraction
> >> of how orientation data is acquired from sensor chips. Sensor chips ma=
y be connected
> >> through different interfaces and in different positions. They may also=
 have different
> >> parameters. And, if a chip is replaced by a different one, the values =
reported by
> >> the device position interface should remain the same, provided the dev=
ice tree reflects
> >> the changed chip.
> >>=20
> >> This did initially lead to input accelerometer drivers like drivers/in=
put/misc/bma150.c
> >> or drivers/misc/lis3lv02d/
> >>=20
> >> But nowadays, new accelerometer chips mostly get iio drivers and rarel=
y input drivers.
> >>=20
> >> Therefore we need something like a protocol stack which bridges raw da=
ta and input devices.
> >> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or=
 keyboard
> >> input events vs. raw gpio or raw USB access.
> >>=20
> >> This patch bridges the gap between raw iio data and the input device a=
bstraction
> >> so that accelerometer measurements can additionally be presented as X/=
Y/Z accelerometer
> >> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
> >>=20
> >> There are no special requirements or changes needed for an iio driver.
> >>=20
> >> There is no need to define a mapping (e.g. in device tree). =20
> > This worries me, as it inherently means we end up with this interface b=
eing
> > registered in cases where it makes no sense.  A lot of generic distros =
get
> > used across widely differing use cases. =20
>=20
> I still do not fully understand what is worrying you here.

>=20
> Do you worry about functionality, flexibility or resources or something e=
lse?

Two main things:
1) Lack of generality of the approach.=20
   This is a single use trick for input devices. Why does it make sense for
   input devices?  There are lots of other in kernel users and potential
   ones in the future.  The ability to register additional IIO consumers li=
ke
   this is useful, lets make it useful to everyone.

2) To much generality of the specific usecase.  I don't want to put an Input
   interface on accelerometers where it makes no sense.  The rule of it has
   2-3 axis so it must make sense isn't good enough to my mind.  How
   does userspace know which accelerometer to use (more and more devices ha=
ve
   multiple?)  You could do something like looking at the location info from
   DT / ACPI in your driver and pick the 'best' but that's policy. Should be
   in userspace.  Sure you can just use the right input driver, but the mom=
ent
   we do that, we need aware userspace, if that's the case why not make it
   aware from the start.

Believe me I've been round this one a good few times and thought about it
a lot.  I'll take a lot of convincing that this isn't a problem that
should be pushed into userspace.

>=20
> I think having them mapped always does not need much resources (except a =
handful of bytes
> in memory and some =C2=B5s during probing) unless the event device is ope=
ned and really used.
> Only then it starts e.g. I2C traffic to read the sensors.

The bytes don't really mater. The userspace ABI additions do.

>=20
> So it is just some unused file sitting around in /dev. Or 2 or could be e=
ven 100.
> For devices which have no iio accelerometers configured, there will be no=
 /dev/input
> file. So we are discussing the rare case of devices with more than one or=
 two accelerometers.

Well they aren't exactly rare in IIO using systems ;)

>=20
> Now, on every system there are many interfaces and files that are not use=
d because it makes
> no sense to look at them. If I check on one of my systems, I find for exa=
mple a lot of
> /dev/tty and only a very small portion is used and generic distros have n=
o issue with it.
>=20
> There is even /dev/iio:device0 to /dev/iio:device5 representing the raw i=
io devices.
> Not all of them are actively used, but they are simply there and can be s=
canned for.

Agreed, in the ideal case we wouldn't have had that either, but we are
stuck with it.  The long term plan is to allow use of IIO backends without =
the
front end being there at all. Lots of SoC ADC users would prefer this. We a=
re
stuck with the legacy intertwining fo the front end and back end of IIO so
this isn't as easy to do as I would like.

>=20
> So I do not see a resource problem if every accelerometer /dev/iio:device=
* gets
> some companion /dev/input/event* for being used on demand - but only if t=
his bridge
> is configured at all.

That argument does not apply. If we add a config option, distros will enabl=
e it.
So the vast majority of systems will ship with this turned on.  You cannot
use a config variable to control policy and expect it to be change by anyone
but a very very small subset of users.  So please drop the 'you can just not
build it argument'.

Userspace configuration changing is a lot easier if people actually care.
Sure, many distros will ship the same script to everyone.

>=20
> > I think we need some deliberate userspace interaction to instantiate
> > one of these rather than 'always doing it'. =20
>=20
> My gut feeling is that this additional user-space interaction needs more =
resources and
> adds a lot of complexity, independently of how it is done.

Trivial resources and actually fairly trivial complexity.  Key thing is
it puts the burden on the users of this functionality to configure what they
want.

>=20
> And I think is even less flexible than "always doing it". Let me explain =
this claim.
>=20
> For me, the kernel should present everything the hardware supports to use=
r-space
> in better digestable device files or APIs (without making any assumptions=
 about the
> user-space code).

Agreed, we just have a different view on how this should be done. I want
it to be dynamic and extremely flexible, you want the easy way of just
putting a fixed set out all the time.

>=20
> Then, every user-space that will be installed can find out what the hardw=
are supports
> by looking at standard places.
>=20
> E.g. it can scan for all mice and keyboards. And for all input accelerome=
ters.

Or, you an have the correct 'fairly trivial' userspace setup to scan for all
registered accelerometers and 'on demand' create the bindings to bring them=
 up as
Input accelerometers if that is what makes sense for your platform.

>=20
> If the kernel is hiding some chips and needs some initial user-space acti=
on before
> presenting them all, this requires that the user-space has some a-priori =
knowledge
> about which specific devices it should ask for.

No more that it needs to know which accelerometer to use?

> So it does not really need to scan
> for them. Because it must already know. Obviously in some mapping table s=
tored at
> a well known location inside the rootfs image.

No. Let me give some more details of how this would work.  It's really just
a more flexible version of what you have.

A distro, or individual user decides to put the relevant script in place fo=
r the
following:

1. Userspace detects a new accelerometer driver, via the standard methods (=
uevent)
2. Userspace looks to see if it has the required properties. Now this inclu=
des things
like detecting that it is the accelerometer in the lid of a laptop - if so =
do not
register it as an input device.  If it's in the keyboard then do register i=
t.
3. Userspace script then creates the files in configfs
/sys/kernel/config/iio/maps/
(this interface needs appropriate definition)
Maybe...
/sys/kernel/config/iio/maps/iio_input/iio_device:X/accel_x, accel_y, etc
When done it writes to the bind file
/sys/kernel/config/iio/maps/iio_input/iio_device:X/bind
which instantiates the input driver.

This moves all of the policy decision into userspace, where it belongs.  If
we want to enable a particular accelerometer on a particular board because =
it
actually works better than the one the default policy says to use, then we =
can
do so.

The resulting infrastructure is much more general, because it lets us do the
same for any IIO consumer.  This input bridge is not a special case. It wor=
ks
equally well for the existing hwmon bridge any would even let us do things
like provide the information from userspace that we have an analog accelero=
meter
wired up to an ADC on some hacker board.


>=20
> This seems to make it impossible to develop a generic distro rootfs image=
 - without
> asking the user for manual configuration. And that where the kernel alrea=
dy knows
> this (which iio accelerometers do exist for a specific piece of hardware).
>=20
> This is why I believe a mechanism to instantiate only on demand isn't add=
ing but
> removing flexibility because it prevents copying a rootfs from one device=
 to another.

I disagree, see above.

>=20
> >=20
> > As I mentioned in V1, look at the possibility of a configfs based method
> > to build the map.  It's easy for userspace to work out what makes sense=
 to
> > map in principle.  There may be some missing info that we also need to
> > look to expose. =20
>=20
> With a "may be missing" it is impossible to write code for it...
> Can you please name which information is missing on the input acceleromet=
er
> API?

See above. It's not the input accelerometer ABI, it's the missing ability
to instantiate IIO maps from user space.

>=20
> >=20
> > In general, userspace created channel maps would be very useful for
> > other things such as maker type boards where they can plug all sorts
> > of odd things into ADC channels for example. =20
>=20
> Ok, I understand, but this is a different problem where this iio-input-br=
idge is not
> intended to be a solution. Generic ADCs are not input devices. Like SD ca=
rds are not
> keyboards.
>=20
> So we should not try to mix the idea of general mapping with this input-b=
ridge for
> input accelerometers.
Yes we should. You are proposing a solution that is a subset of the larger
problem set.  Why introduce a stop gap like this when we can do it correctly
and provide something useful for all those other use cases.

The only difference here is the uevent triggered script that creates those =
maps
for your particular usecase.


>=20
> BTW, there is a way to define additional mapping using udev rules which s=
ymlink the
> /dev/input/event* paths to stable names like /dev/input/accelerometer.
>=20
> This comes without additional code and is already provided by udev and th=
e input system.
>=20
> So in summary, I have not yet seen a convincing scenario where being able=
 to dynamically
> map iio channels to input devices seems beneficial.

That is true for the narrow case you are talking about. I don't want to see=
 that
narrow case solved in a fashion that effectively breaks solving it properly.
If we add this, we have to export all accelerometers for ever under all cir=
cumstances
to userspace, because to remove it will break existing userspace.

If we stand back and work out if we can do the general solution now, we avo=
id
this problem.

>=20
> >  =20
> >>=20
> >> This driver simply collects the first 3 accelerometer channels as X, Y=
 and Z.
> >> If only 1 or 2 channels are available, they are used for X and Y only.=
 Additional
> >> channels are ignored.
> >>=20
> >> Scaling is done automatically so that 1g is represented by value 256 a=
nd
> >> range is assumed to be -511 .. +511 which gives a reasonable precision=
 as an
> >> input device. =20
> >=20
> > Why do we do this, rather than letting input deal with it?  Input is us=
ed
> > to widely differing scales IIRC =20
>=20
> Well, it can't be done differently... And what I call scale here is nothi=
ng more than
> defining ABSMIN_ACC_VAL and ABSMAX_ACC_VAL.
>=20
> We need to apply some scale since iio reports in (fractional) units of 1g=
, i.e. values
> of magnitude 1.

m/s^2 not g, but doesn't matter for the point of view of this discussion.

> These are not adaequate for input events which use integers. So we must
> define some factor for iio_convert_raw_to_processed() to scale from raw v=
alue range
> to int value range. We could report raw values but this would be an impro=
per abstraction
> from chip specific differences.

Hmm. I can see we perhaps need some mapping, but is there a concept of stan=
dard scale
for existing input accelerometers?  How is this done to give for other inpu=
t devices
such as touch screens?  I'd expect to see a separation between scale, and r=
ange.


>=20
> BTW: the range (and therefore the factor) is reported through the evdev d=
river to user-space
> (evtest reports Min and Max as you can see in the example).
>=20
> The most important thing is that this is a hardware independent definitio=
n. Every accelerometer
> chip will report this range. So you can easily upgrade hardware or switch=
 accelerometers
> without touching user-space calibration. Like you can replace ethernet co=
ntroller chips but
> networking works the same with all of them.

Agreed, it needs to be hardware independent by the time it hits userspace, =
but I would
have thought that scaling would be done in input, rather than IIO. It's har=
dly
a problem unique to our usecase!

Perhaps Dmitry can give some advice on this.

>=20
> >  =20
> >>=20
> >> If a mount-matrix is provided by the iio driver, it is also taken into=
 account
> >> so that the input event automatically gets the correct orientation wit=
h respect
> >> to the device.
> >>=20
> >> If this extension is not configured into the kernel it takes no resour=
ces (except
> >> source code).
> >>=20
> >> If it is configured, but there is no accelerometer, there is only a ti=
ny penalty
> >> for scanning for accelerometer channels once during probe of each iio =
device.
> >>=20
> >> If it runs, the driver polls the device(s) once every 100 ms. A mode w=
here the
> >> iio device defines the update rate is not implemented and for further =
study.
> >>=20
> >> If there is no user-space client, polling is not running.
> >>=20
> >> The driver is capable to handle multiple iio accelerometers and they a=
re
> >> presented by unique /dev/input/event* files. The iio chip name is used=
 to define
> >> the input device name so that it can be identified (e.g. by udev rules=
 or evtest).
> >>=20
> >> Here is some example what you can expect from the driver (device:
> >> arch/arm/boot/dts/omap3-gta04a5.dts):
> >>=20
> >> root@letux:~# dmesg|fgrep iio
> >> [    6.324584] input: iio-bridge: bmc150_accel as /devices/platform/68=
000000.ocp/48072000.i2c/i2c-1/1-0010/iio:device1/input/input5
> >> [    6.516632] input: iio-bridge: bno055 as /devices/platform/68000000=
.ocp/48072000.i2c/i2c-1/1-0029/iio:device3/input/input7
> >> root@letux:~# evtest /dev/input/event5 | head -19
> >> Input driver version is 1.0.1
> >> Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
> >> Input device name: "iio-bridge: bmc150_accel"
> >> Supported events:
> >>   Event type 0 (EV_SYN)
> >>   Event type 3 (EV_ABS)
> >>     Event code 0 (ABS_X)
> >>       Value      8
> >>       Min     -511
> >>       Max      511
> >>     Event code 1 (ABS_Y)
> >>       Value    -44
> >>       Min     -511
> >>       Max      511
> >>     Event code 2 (ABS_Z)
> >>       Value   -265
> >>       Min     -511
> >>       Max      511
> >> Properties:
> >> root@letux:~# evtest /dev/input/event7 | head -19
> >> Input driver version is 1.0.1
> >> Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
> >> Input device name: "iio-bridge: bno055"
> >> Supported events:
> >>   Event type 0 (EV_SYN)
> >>   Event type 3 (EV_ABS)
> >>     Event code 0 (ABS_X)
> >>       Value     -6
> >>       Min     -511
> >>       Max      511
> >>     Event code 1 (ABS_Y)
> >>       Value     17
> >>       Min     -511
> >>       Max      511
> >>     Event code 2 (ABS_Z)
> >>       Value   -250
> >>       Min     -511
> >>       Max      511
> >> Properties:
> >> root@letux:~#=20
> >>=20
> >> Although the sensor chips are mounted with different axis orientation,
> >> the application of the mount matrix provides equivalent (despite noise
> >> and precision) information on device orientation.
> >>=20
> >> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> >> ---
> >> drivers/iio/Kconfig                    |   7 +
> >> drivers/iio/Makefile                   |   1 +
> >> drivers/iio/industrialio-core.c        |  12 +
> >> drivers/iio/industrialio-inputbridge.c | 295 +++++++++++++++++++++++++
> >> drivers/iio/industrialio-inputbridge.h |  28 +++
> >> 5 files changed, 343 insertions(+)
> >> create mode 100644 drivers/iio/industrialio-inputbridge.c
> >> create mode 100644 drivers/iio/industrialio-inputbridge.h
> >>=20
> >> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> >> index d08aeb41cd07..d85afe002613 100644
> >> --- a/drivers/iio/Kconfig
> >> +++ b/drivers/iio/Kconfig
> >> @@ -68,6 +68,13 @@ config IIO_TRIGGERED_EVENT
> >> 	help
> >> 	  Provides helper functions for setting up triggered events.
> >>=20
> >> +config IIO_INPUT_BRIDGE
> >> +	bool "Enable accelerometer bridge to input driver" =20
> >=20
> > Dependency on input? =20
>=20
> Yes, should be added.
>=20
> >  =20
> >> +	help
> >> +	  Provides a /dev/input/event* device for accelerometers
> >> +	  to use as a 3D input device, e.g. for gaming or auto-rotation
> >> +	  of screen contents.
> >> +
> >> source "drivers/iio/accel/Kconfig"
> >> source "drivers/iio/adc/Kconfig"
> >> source "drivers/iio/afe/Kconfig"
> >> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> >> index cb5993251381..d695e5a27da5 100644
> >> --- a/drivers/iio/Makefile
> >> +++ b/drivers/iio/Makefile
> >> @@ -7,6 +7,7 @@ obj-$(CONFIG_IIO) +=3D industrialio.o
> >> industrialio-y :=3D industrialio-core.o industrialio-event.o inkern.o
> >> industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
> >> industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
> >> +industrialio-$(CONFIG_IIO_INPUT_BRIDGE) +=3D industrialio-inputbridge=
.o
> >>=20
> >> obj-$(CONFIG_IIO_CONFIGFS) +=3D industrialio-configfs.o
> >> obj-$(CONFIG_IIO_SW_DEVICE) +=3D industrialio-sw-device.o
> >> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industriali=
o-core.c
> >> index 4700fd5d8c90..81f412b41a78 100644
> >> --- a/drivers/iio/industrialio-core.c
> >> +++ b/drivers/iio/industrialio-core.c
> >> @@ -29,6 +29,7 @@
> >> #include <linux/iio/iio.h>
> >> #include "iio_core.h"
> >> #include "iio_core_trigger.h"
> >> +#include "industrialio-inputbridge.h"
> >> #include <linux/iio/sysfs.h>
> >> #include <linux/iio/events.h>
> >> #include <linux/iio/buffer.h>
> >> @@ -1723,6 +1724,15 @@ int __iio_device_register(struct iio_dev *indio=
_dev, struct module *this_mod)
> >> 	if (ret < 0)
> >> 		goto error_unreg_eventset;
> >>=20
> >> +	ret =3D iio_device_register_inputbridge(indio_dev);
> >> +	if (ret) {
> >> +		dev_err(indio_dev->dev.parent,
> >> +			"Failed to register as input driver\n");
> >> +		device_del(&indio_dev->dev);
> >> + =20
> > This doesn't look like balanced error handling given the goto in the pr=
evious
> > case.  If we are treating this as an error we need to unwind the whole
> > of this function properly. =20
>=20
> Will to check.
>=20
> >  =20
> >> +		return ret;
> >> +	}
> >> +
> >> 	return 0;
> >>=20
> >> error_unreg_eventset:
> >> @@ -1745,6 +1755,8 @@ void iio_device_unregister(struct iio_dev *indio=
_dev)
> >> {
> >> 	mutex_lock(&indio_dev->info_exist_lock);
> >>=20
> >> +	iio_device_unregister_inputbridge(indio_dev);
> >> +
> >> 	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> >>=20
> >> 	iio_device_unregister_debugfs(indio_dev);
> >> diff --git a/drivers/iio/industrialio-inputbridge.c b/drivers/iio/indu=
strialio-inputbridge.c
> >> new file mode 100644
> >> index 000000000000..dd672e25bc70
> >> --- /dev/null
> >> +++ b/drivers/iio/industrialio-inputbridge.c
> >> @@ -0,0 +1,295 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * The Industrial I/O core, bridge to input devices
> >> + *
> >> + * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy it
> >> + * under the terms of the GNU General Public License version 2 as pub=
lished by
> >> + * the Free Software Foundation. =20
> > No need for the boiler plate if you have SPDX.  That is one of the
> > advantages! =20
>=20
> Ok.
>=20
> >  =20
> >> + */
> >> +
> >> +#include <linux/iio/consumer.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/types.h>
> >> +#include <linux/input.h>
> >> +#include <linux/input-polldev.h>
> >> +#include <linux/module.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include "industrialio-inputbridge.h"
> >> +
> >> +/* currently, only polling is implemented */
> >> +#define POLLING_MSEC	100
> >> +
> >> +struct iio_input_map {
> >> +	struct input_polled_dev *poll_dev;	/* the input device */
> >> +	struct iio_channel channels[3];		/* x, y, z channels */
> >> +	struct matrix {
> >> +		int mxx, myx, mzx;	/* fixed point mount-matrix */
> >> +		int mxy, myy, mzy;
> >> +		int mxz, myz, mzz;
> >> +	} matrix;
> >> +};
> >> +
> >> +static inline struct iio_input_map *to_iio_input_map(
> >> +		struct iio_channel *channel)
> >> +{
> >> +	return (struct iio_input_map *) channel->data;
> >> +}
> >> +
> >> +/* minimum and maximum range we want to report */
> >> +#define ABSMAX_ACC_VAL		(512 - 1)
> >> +#define ABSMIN_ACC_VAL		-(ABSMAX_ACC_VAL)
> >> +
> >> +/* scale processed iio values so that 1g maps to ABSMAX_ACC_VAL / 2 */
> >> +#define SCALE			((100 * ABSMAX_ACC_VAL) / (2 * 981))
> >> +
> >> +/*
> >> + * convert float string to scaled fixed point format, e.g.
> >> + *   1		-> 1000		(value passed as unit)
> >> + *   1.23	-> 1230
> >> + *   0.1234	->  123
> >> + *   -.01234	->  -12
> >> + */
> >> +
> >> +static int32_t atofix(const char *str, uint32_t unit)
> >> +{
> >> +	int32_t mantissa =3D 0;
> >> +	bool sign =3D false;
> >> +	bool decimal =3D false;
> >> +	int32_t divisor =3D 1;
> >> +
> >> +	if (*str =3D=3D '-')
> >> +		sign =3D true, str++;
> >> +	while (*str && divisor < unit) {
> >> +		if (*str >=3D '0' && *str <=3D '9') {
> >> +			mantissa =3D 10 * mantissa + (*str - '0');
> >> +			if (decimal)
> >> +				divisor *=3D 10;
> >> +		} else if (*str =3D=3D '.')
> >> +			decimal =3D true;
> >> +		else
> >> +			return 0;	/* error */
> >> +		str++;
> >> +	}
> >> +
> >> +	mantissa =3D (mantissa * unit) / divisor;
> >> +	if (sign)
> >> +		mantissa =3D -mantissa;
> >> +
> >> +	return mantissa;
> >> +}
> >> +
> >> +static void iio_apply_matrix(struct matrix *m, int *in, int *out, uin=
t32_t unit)
> >> +{
> >> +	/* apply mount matrix */
> >> +	out[0] =3D (m->mxx * in[0] + m->myx * in[1] + m->mzx * in[2]) / unit;
> >> +	out[1] =3D (m->mxy * in[0] + m->myy * in[1] + m->mzy * in[2]) / unit;
> >> +	out[2] =3D (m->mxz * in[0] + m->myz * in[1] + m->mzz * in[2]) / unit;
> >> +}
> >> +
> >> +#define FIXED_POINT_UNIT	1000	/* seems reasonable for accelerometer i=
nput */
> >> +
> >> +static void iio_accel_poll(struct input_polled_dev *dev)
> >> +{
> >> +	struct iio_input_map *map =3D dev->private;
> >> +	struct input_dev *input =3D dev->input;
> >> +
> >> +	int values[3];		/* values while processing */
> >> +	int aligned_values[3];	/* mount matrix applied */
> >> +
> >> +	int cindex =3D 0;
> >> +
> >> +printk("%s: map=3D%px input=3D%px\n", __func__, map, input); =20
> > Remember to tidy these debug statements up at some point. =20
>=20
> Oops... Shouldn't be there. Maybe I did squash in some commit from my deb=
ugging branch.
>=20
> >  =20
> >> +
> >> +	while (cindex < ARRAY_SIZE(values)) {
> >> +		struct iio_channel *channel =3D
> >> +			&map->channels[cindex];
> >> +		int val;
> >> +		int ret;
> >> +
> >> +		if (!channel->indio_dev) {
> >> +			values[cindex] =3D 0;
> >> +			continue;
> >> +		}
> >> +
> >> +		ret =3D iio_read_channel_raw(channel, &val);
> >> +
> >> +		if (ret < 0) {
> >> +			pr_err("%s(): channel read error %d\n",
> >> +				__func__, cindex);
> >> +			return;
> >> +		}
> >> +
> >> +		ret =3D iio_convert_raw_to_processed(channel, val,
> >> +				 &values[cindex], SCALE);
> >> +
> >> +		if (ret < 0) {
> >> +			pr_err("%s(): channel processing error\n",
> >> +				__func__);
> >> +			return;
> >> +		}
> >> +
> >> +		cindex++;
> >> +	}
> >> +
> >> +	iio_apply_matrix(&map->matrix, values, aligned_values, FIXED_POINT_U=
NIT);
> >> +
> >> +	input_report_abs(input, ABS_X, aligned_values[0]);
> >> +	input_report_abs(input, ABS_Y, aligned_values[1]);
> >> +	input_report_abs(input, ABS_Z, aligned_values[2]);
> >> +	input_sync(input);
> >> +}
> >> +
> >> +static int dindex=3D0;	/* assign unique names to accel/input devices =
*/ =20
> > Build something from the iio device IDA perhaps?  Those are unique
> > as well.  Useful to know which one this is linked to. =20
>=20
> We just use this unique number in the poll_dev->input->phys name.
> Mainly this number gives them unique names in /sys/class/input/input*/phys
> =20
> Using the iio device IDA seems to be a very good replacement.
>=20
> >  =20
> >> +
> >> +static int iio_input_register_accel_channel(struct iio_dev *indio_dev,
> >> +		 const struct iio_chan_spec *chan)
> >> +{ /* we found some accelerometer channel */
> >> +	int ret;
> >> +	int cindex;
> >> +	struct iio_input_map *map =3D iio_device_get_drvdata(indio_dev); =20
> >=20
> > Don't do that.   That is in the domain of the device driver and so
> > will sometimes already be in use.  =20
>=20
> Hm. Is there an alternative to attach such private data to an struct iio_=
dev
> allocated by someone else? I have not found one yet.
>=20
> Or can I add some void *input_mapping; to struct iio_dev? Depending on
> #if defined(CONFIG_IIO_INPUT_BRIDGE)?

Yes, add a new element.

>=20
> >  =20
> >> +
> >> +printk("%s: map=3D%px\n", __func__, map);
> >> +
> >> +	if (!map) {
> >> +		struct input_polled_dev *poll_dev;
> >> +		const struct iio_chan_spec_ext_info *ext_info;
> >> +
> >> +		map =3D devm_kzalloc(&indio_dev->dev, sizeof(struct iio_input_map),=
 GFP_KERNEL);
> >> +		if (!map)
> >> +			return -ENOMEM;
> >> +
> >> +		iio_device_set_drvdata(indio_dev, map);
> >> +
> >> +		poll_dev =3D devm_input_allocate_polled_device(&indio_dev->dev);
> >> +		if (!poll_dev)
> >> +			return -ENOMEM;
> >> +
> >> +		poll_dev->private =3D map;
> >> +		poll_dev->poll =3D iio_accel_poll;
> >> +		poll_dev->poll_interval =3D POLLING_MSEC;
> >> +
> >> +		poll_dev->input->name =3D kasprintf(GFP_KERNEL, "iio-bridge: %s",
> >> +						    indio_dev->name);
> >> +		poll_dev->input->phys =3D kasprintf(GFP_KERNEL, "accel/input%d", =20
>=20
> If we use the IDA, we can define phys as "iio:device%d", indio_dev->id)
> which makes it easy to locate the associated iio device file name (althou=
gh
> there are other mechanisms in sysfs tree).
>=20
> >> +						    dindex++);
> >> +
> >> +// do we need something like this?
> >> +//		poll_dev->input->id.bustype =3D BUS_IIO;
> >> +//		poll_dev->input->id.vendor =3D 0x0001;
> >> +//		poll_dev->input->id.product =3D 0x0001;
> >> +//		poll_dev->input->id.version =3D 0x0001;
> >> +
> >> +		set_bit(INPUT_PROP_ACCELEROMETER, poll_dev->input->propbit);
> >> +		poll_dev->input->evbit[0] =3D BIT_MASK(EV_ABS);
> >> +		input_alloc_absinfo(poll_dev->input);
> >> +		input_set_abs_params(poll_dev->input, ABS_X, ABSMIN_ACC_VAL,
> >> +					ABSMAX_ACC_VAL, 0, 0);
> >> +		input_set_abs_params(poll_dev->input, ABS_Y, ABSMIN_ACC_VAL,
> >> +					ABSMAX_ACC_VAL, 0, 0);
> >> +		input_set_abs_params(poll_dev->input, ABS_Z, ABSMIN_ACC_VAL,
> >> +					ABSMAX_ACC_VAL, 0, 0);
> >> +
> >> +		map->poll_dev =3D poll_dev;
> >> +
> >> +		ret =3D input_register_polled_device(poll_dev);
> >> +
> >> +		if (ret < 0) {
> >> +			kfree(poll_dev->input->name);
> >> +			kfree(poll_dev->input->phys);
> >> +			return ret;
> >> +		}
> >> +
> >> +		/* assume all channels of a device share the same matrix */
> >> +
> >> +		ext_info =3D chan->ext_info;
> >> +		for (; ext_info && ext_info->name; ext_info++) {
> >> +			if (strcmp(ext_info->name, "mount_matrix") =3D=3D 0)
> >> +				break;
> >> +		}
> >> +
> >> +		if (ext_info && ext_info->name) {
> >> +			/* matrix found */
> >> +			uintptr_t priv =3D ext_info->private;
> >> +			const struct iio_mount_matrix *mtx;
> >> +
> >> +			mtx =3D ((iio_get_mount_matrix_t *) priv)(indio_dev,
> >> +								chan);
> >> +
> >> +			map->matrix.mxx =3D atofix(mtx->rotation[0], FIXED_POINT_UNIT);
> >> +			map->matrix.myx =3D atofix(mtx->rotation[1], FIXED_POINT_UNIT);
> >> +			map->matrix.mzx =3D atofix(mtx->rotation[2], FIXED_POINT_UNIT);
> >> +			map->matrix.mxy =3D atofix(mtx->rotation[3], FIXED_POINT_UNIT);
> >> +			map->matrix.myy =3D atofix(mtx->rotation[4], FIXED_POINT_UNIT);
> >> +			map->matrix.mzy =3D atofix(mtx->rotation[5], FIXED_POINT_UNIT);
> >> +			map->matrix.mxz =3D atofix(mtx->rotation[6], FIXED_POINT_UNIT);
> >> +			map->matrix.myz =3D atofix(mtx->rotation[7], FIXED_POINT_UNIT);
> >> +			map->matrix.mzz =3D atofix(mtx->rotation[8], FIXED_POINT_UNIT);
> >> +		} else {
> >> +			map->matrix.mxx =3D FIXED_POINT_UNIT;
> >> +			map->matrix.myx =3D 0;
> >> +			map->matrix.mzx =3D 0;
> >> +			map->matrix.mxy =3D 0;
> >> +			map->matrix.myy =3D FIXED_POINT_UNIT;
> >> +			map->matrix.mzy =3D 0;
> >> +			map->matrix.mxz =3D 0;
> >> +			map->matrix.myz =3D 0;
> >> +			map->matrix.mzz =3D FIXED_POINT_UNIT;
> >> +		}
> >> +	}
> >> +
> >> +// brauchen wir das noch? Oder nehmen wir einfach an dass es 3 Kan=C3=
=A4le gibt?
> >> +
> >> +	/* find free channel within this device */
> >> +
> >> +	for (cindex =3D 0; cindex < ARRAY_SIZE(map->channels); cindex++) {
> >> +		if (!map->channels[cindex].indio_dev)
> >> +			break;
> >> +	}
> >> +
> >> +	/* check if we already have collected enough channels */
> >> +	if (cindex =3D=3D ARRAY_SIZE(map->channels))
> >> +		return 0;	/* silently ignore */
> >> +
> >> +	map->channels[cindex].indio_dev =3D indio_dev;
> >> +	map->channels[cindex].channel =3D chan;
> >> +	map->channels[cindex].data =3D map;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +int iio_device_register_inputbridge(struct iio_dev *indio_dev)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> >> +		const struct iio_chan_spec *chan =3D
> >> +				&indio_dev->channels[i];
> >> +
> >> +		if (chan->type =3D=3D IIO_ACCEL) {
> >> +			int r =3D iio_input_register_accel_channel(indio_dev,
> >> +								 chan); =20
> > It would be cleaner (and safer) to go find all the necessary channels t=
hen
> > set up the map in one go, rather that iterating and trying to build it
> > in a sequential fashion.
> >=20
> > So move the search loop inside and have something like.
> >=20
> > iio_input_find_accel_channel(indio_dev, chan, &numchans);
> > iio_input_register_device(indio_dev, chan, numchans); =20
>=20
> Well, that looks like it needs some temporary storage of dynamic size
> and loop twice over channels for no functional benefit.

Use fixed size. The worst that happens is we end up with it being
an entry larger that it needs to be.

> And handle the
> special case of numchans =3D=3D 0 (the proposed code simply does not call
> iio_input_register_accel_channel and does not register anything).
>=20
> So I'd prefer to follow the "KISS" principle and register single channels
> instead of a set of channels.

Well we disagree on this.  A singleton approach like used here
is to my mind not KISS.  I would rather see what is there then
act as two simple steps, rather than interleave two different
actions with a totally different path for the first channel found.
If there is only one channel you just built a load of infrastructure
that makes no sense.  If you scan first then you can know that
before building anything.


>=20
> >  =20
> >> +
> >> +			if (r < 0)
> >> +				return r;
> >> +		}
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +void iio_device_unregister_inputbridge(struct iio_dev *indio_dev)
> >> +{
> >> +	struct iio_input_map *map =3D iio_device_get_drvdata(indio_dev);
> >> +	struct input_dev *input =3D map->poll_dev->input;
> >> +
> >> +	kfree(input->name);
> >> +	kfree(input->phys);
> >> +	input_unregister_polled_device(map->poll_dev);
> >> +}
> >> +
> >> +MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
> >> +MODULE_DESCRIPTION("Bridge to present Industrial I/O accelerometers a=
s properly oriented Input devices");
> >> +MODULE_LICENSE("GPL v2");
> >> diff --git a/drivers/iio/industrialio-inputbridge.h b/drivers/iio/indu=
strialio-inputbridge.h
> >> new file mode 100644
> >> index 000000000000..1363b10ab3f7
> >> --- /dev/null
> >> +++ b/drivers/iio/industrialio-inputbridge.h
> >> @@ -0,0 +1,28 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * The Industrial I/O core, bridge to input devices
> >> + *
> >> + * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
> >> + *
> >> + * This program is free software; you can redistribute it and/or modi=
fy it
> >> + * under the terms of the GNU General Public License version 2 as pub=
lished by
> >> + * the Free Software Foundation.
> >> + */
> >> +
> >> +#if defined(CONFIG_IIO_INPUT_BRIDGE)
> >> +
> >> +extern int iio_device_register_inputbridge(struct iio_dev *indio_dev);
> >> +extern void iio_device_unregister_inputbridge(struct iio_dev *indio_d=
ev);
> >> +
> >> +#else
> >> +
> >> +static inline int iio_device_register_inputbridge(struct iio_dev *ind=
io_dev)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static inline void iio_device_unregister_inputbridge(struct iio_dev *=
indio_dev)
> >> +{
> >> +}
> >> +
> >> +#endif =20
> >  =20
>=20
> BR and thanks,
> Nikolaus
>=20
Thanks,

Jonathan
