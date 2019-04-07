From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
Date: Sun, 7 Apr 2019 13:30:37 +0100
Message-ID: <20190407133037.0ad98897@archlinux>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Piel <eric.piel@tremplin-utc.net>, linux-input@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 31 Mar 2019 12:09:46 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

Hi Nikolaus,

I'm probably going to repeat a few things I sent for v1 as the audience has
expanded somewhat!

Good to see this moving forwards though as there has been at least some dem=
and
for it going way back to the early days of IIO.

> Some user spaces (e.g. some Android devices) use /dev/input/event* for ha=
ndling
> the 3D position of the device with respect to the center of gravity (eart=
h).
> This can be used for gaming input, auto-rotation of screens etc.
>=20
> This interface should be the standard for such use cases because it is an=
 abstraction
> of how orientation data is acquired from sensor chips. Sensor chips may b=
e connected
> through different interfaces and in different positions. They may also ha=
ve different
> parameters. And, if a chip is replaced by a different one, the values rep=
orted by
> the device position interface should remain the same, provided the device=
 tree reflects
> the changed chip.
>=20
> This did initially lead to input accelerometer drivers like drivers/input=
/misc/bma150.c
> or drivers/misc/lis3lv02d/
>=20
> But nowadays, new accelerometer chips mostly get iio drivers and rarely i=
nput drivers.
>=20
> Therefore we need something like a protocol stack which bridges raw data =
and input devices.
> It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or ke=
yboard
> input events vs. raw gpio or raw USB access.
>=20
> This patch bridges the gap between raw iio data and the input device abst=
raction
> so that accelerometer measurements can additionally be presented as X/Y/Z=
 accelerometer
> channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.
>=20
> There are no special requirements or changes needed for an iio driver.
>=20
> There is no need to define a mapping (e.g. in device tree).
This worries me, as it inherently means we end up with this interface being
registered in cases where it makes no sense.  A lot of generic distros get
used across widely differing use cases.

I think we need some deliberate userspace interaction to instantiate
one of these rather than 'always doing it'.

As I mentioned in V1, look at the possibility of a configfs based method
to build the map.  It's easy for userspace to work out what makes sense to
map in principle.  There may be some missing info that we also need to
look to expose.

In general, userspace created channel maps would be very useful for
other things such as maker type boards where they can plug all sorts
of odd things into ADC channels for example.

>=20
> This driver simply collects the first 3 accelerometer channels as X, Y an=
d Z.
> If only 1 or 2 channels are available, they are used for X and Y only. Ad=
ditional
> channels are ignored.
>=20
> Scaling is done automatically so that 1g is represented by value 256 and
> range is assumed to be -511 .. +511 which gives a reasonable precision as=
 an
> input device.

Why do we do this, rather than letting input deal with it?  Input is used
to widely differing scales IIRC

>=20
> If a mount-matrix is provided by the iio driver, it is also taken into ac=
count
> so that the input event automatically gets the correct orientation with r=
espect
> to the device.
>=20
> If this extension is not configured into the kernel it takes no resources=
 (except
> source code).
>=20
> If it is configured, but there is no accelerometer, there is only a tiny =
penalty
> for scanning for accelerometer channels once during probe of each iio dev=
ice.
>=20
> If it runs, the driver polls the device(s) once every 100 ms. A mode wher=
e the
> iio device defines the update rate is not implemented and for further stu=
dy.
>=20
> If there is no user-space client, polling is not running.
>=20
> The driver is capable to handle multiple iio accelerometers and they are
> presented by unique /dev/input/event* files. The iio chip name is used to=
 define
> the input device name so that it can be identified (e.g. by udev rules or=
 evtest).
>=20
> Here is some example what you can expect from the driver (device:
> arch/arm/boot/dts/omap3-gta04a5.dts):
>=20
> root@letux:~# dmesg|fgrep iio
> [ =C2=A0 =C2=A06.324584] input: iio-bridge: bmc150_accel as /devices/plat=
form/68000000.ocp/48072000.i2c/i2c-1/1-0010/iio:device1/input/input5
> [ =C2=A0 =C2=A06.516632] input: iio-bridge: bno055 as /devices/platform/6=
8000000.ocp/48072000.i2c/i2c-1/1-0029/iio:device3/input/input7
> root@letux:~# evtest /dev/input/event5 | head -19
> Input driver version is 1.0.1
> Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
> Input device name: "iio-bridge: bmc150_accel"
> Supported events:
> =C2=A0 Event type 0 (EV_SYN)
> =C2=A0 Event type 3 (EV_ABS)
> =C2=A0 =C2=A0 Event code 0 (ABS_X)
> =C2=A0 =C2=A0 =C2=A0 Value =C2=A0 =C2=A0 =C2=A08
> =C2=A0 =C2=A0 =C2=A0 Min =C2=A0 =C2=A0 -511
> =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 =C2=A0 =C2=A0511
> =C2=A0 =C2=A0 Event code 1 (ABS_Y)
> =C2=A0 =C2=A0 =C2=A0 Value =C2=A0 =C2=A0-44
> =C2=A0 =C2=A0 =C2=A0 Min =C2=A0 =C2=A0 -511
> =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 =C2=A0 =C2=A0511
> =C2=A0 =C2=A0 Event code 2 (ABS_Z)
> =C2=A0 =C2=A0 =C2=A0 Value =C2=A0 -265
> =C2=A0 =C2=A0 =C2=A0 Min =C2=A0 =C2=A0 -511
> =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 =C2=A0 =C2=A0511
> Properties:
> root@letux:~# evtest /dev/input/event7 | head -19
> Input driver version is 1.0.1
> Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
> Input device name: "iio-bridge: bno055"
> Supported events:
> =C2=A0 Event type 0 (EV_SYN)
> =C2=A0 Event type 3 (EV_ABS)
> =C2=A0 =C2=A0 Event code 0 (ABS_X)
> =C2=A0 =C2=A0 =C2=A0 Value =C2=A0 =C2=A0 -6
> =C2=A0 =C2=A0 =C2=A0 Min =C2=A0 =C2=A0 -511
> =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 =C2=A0 =C2=A0511
> =C2=A0 =C2=A0 Event code 1 (ABS_Y)
> =C2=A0 =C2=A0 =C2=A0 Value =C2=A0 =C2=A0 17
> =C2=A0 =C2=A0 =C2=A0 Min =C2=A0 =C2=A0 -511
> =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 =C2=A0 =C2=A0511
> =C2=A0 =C2=A0 Event code 2 (ABS_Z)
> =C2=A0 =C2=A0 =C2=A0 Value =C2=A0 -250
> =C2=A0 =C2=A0 =C2=A0 Min =C2=A0 =C2=A0 -511
> =C2=A0 =C2=A0 =C2=A0 Max =C2=A0 =C2=A0 =C2=A0511
> Properties:
> root@letux:~#=C2=A0
>=20
> Although the sensor chips are mounted with different axis orientation,
> the application of the mount matrix provides equivalent (despite noise
> and precision) information on device orientation.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/iio/Kconfig                    |   7 +
>  drivers/iio/Makefile                   |   1 +
>  drivers/iio/industrialio-core.c        |  12 +
>  drivers/iio/industrialio-inputbridge.c | 295 +++++++++++++++++++++++++
>  drivers/iio/industrialio-inputbridge.h |  28 +++
>  5 files changed, 343 insertions(+)
>  create mode 100644 drivers/iio/industrialio-inputbridge.c
>  create mode 100644 drivers/iio/industrialio-inputbridge.h
>=20
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d08aeb41cd07..d85afe002613 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -68,6 +68,13 @@ config IIO_TRIGGERED_EVENT
>  	help
>  	  Provides helper functions for setting up triggered events.
> =20
> +config IIO_INPUT_BRIDGE
> +	bool "Enable accelerometer bridge to input driver"

Dependency on input?

> +	help
> +	  Provides a /dev/input/event* device for accelerometers
> +	  to use as a 3D input device, e.g. for gaming or auto-rotation
> +	  of screen contents.
> +
>  source "drivers/iio/accel/Kconfig"
>  source "drivers/iio/adc/Kconfig"
>  source "drivers/iio/afe/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index cb5993251381..d695e5a27da5 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_IIO) +=3D industrialio.o
>  industrialio-y :=3D industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
> +industrialio-$(CONFIG_IIO_INPUT_BRIDGE) +=3D industrialio-inputbridge.o
> =20
>  obj-$(CONFIG_IIO_CONFIGFS) +=3D industrialio-configfs.o
>  obj-$(CONFIG_IIO_SW_DEVICE) +=3D industrialio-sw-device.o
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 4700fd5d8c90..81f412b41a78 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -29,6 +29,7 @@
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> +#include "industrialio-inputbridge.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/buffer.h>
> @@ -1723,6 +1724,15 @@ int __iio_device_register(struct iio_dev *indio_de=
v, struct module *this_mod)
>  	if (ret < 0)
>  		goto error_unreg_eventset;
> =20
> +	ret =3D iio_device_register_inputbridge(indio_dev);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to register as input driver\n");
> +		device_del(&indio_dev->dev);
> +
This doesn't look like balanced error handling given the goto in the previo=
us
case.  If we are treating this as an error we need to unwind the whole
of this function properly.

> +		return ret;
> +	}
> +
>  	return 0;
> =20
>  error_unreg_eventset:
> @@ -1745,6 +1755,8 @@ void iio_device_unregister(struct iio_dev *indio_de=
v)
>  {
>  	mutex_lock(&indio_dev->info_exist_lock);
> =20
> +	iio_device_unregister_inputbridge(indio_dev);
> +
>  	cdev_device_del(&indio_dev->chrdev, &indio_dev->dev);
> =20
>  	iio_device_unregister_debugfs(indio_dev);
> diff --git a/drivers/iio/industrialio-inputbridge.c b/drivers/iio/industr=
ialio-inputbridge.c
> new file mode 100644
> index 000000000000..dd672e25bc70
> --- /dev/null
> +++ b/drivers/iio/industrialio-inputbridge.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The Industrial I/O core, bridge to input devices
> + *
> + * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
No need for the boiler plate if you have SPDX.  That is one of the
advantages!

> + */
> +
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/input.h>
> +#include <linux/input-polldev.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "industrialio-inputbridge.h"
> +
> +/* currently, only polling is implemented */
> +#define POLLING_MSEC	100
> +
> +struct iio_input_map {
> +	struct input_polled_dev *poll_dev;	/* the input device */
> +	struct iio_channel channels[3];		/* x, y, z channels */
> +	struct matrix {
> +		int mxx, myx, mzx;	/* fixed point mount-matrix */
> +		int mxy, myy, mzy;
> +		int mxz, myz, mzz;
> +	} matrix;
> +};
> +
> +static inline struct iio_input_map *to_iio_input_map(
> +		struct iio_channel *channel)
> +{
> +	return (struct iio_input_map *) channel->data;
> +}
> +
> +/* minimum and maximum range we want to report */
> +#define ABSMAX_ACC_VAL		(512 - 1)
> +#define ABSMIN_ACC_VAL		-(ABSMAX_ACC_VAL)
> +
> +/* scale processed iio values so that 1g maps to ABSMAX_ACC_VAL / 2 */
> +#define SCALE			((100 * ABSMAX_ACC_VAL) / (2 * 981))
> +
> +/*
> + * convert float string to scaled fixed point format, e.g.
> + *   1		-> 1000		(value passed as unit)
> + *   1.23	-> 1230
> + *   0.1234	->  123
> + *   -.01234	->  -12
> + */
> +
> +static int32_t atofix(const char *str, uint32_t unit)
> +{
> +	int32_t mantissa =3D 0;
> +	bool sign =3D false;
> +	bool decimal =3D false;
> +	int32_t divisor =3D 1;
> +
> +	if (*str =3D=3D '-')
> +		sign =3D true, str++;
> +	while (*str && divisor < unit) {
> +		if (*str >=3D '0' && *str <=3D '9') {
> +			mantissa =3D 10 * mantissa + (*str - '0');
> +			if (decimal)
> +				divisor *=3D 10;
> +		} else if (*str =3D=3D '.')
> +			decimal =3D true;
> +		else
> +			return 0;	/* error */
> +		str++;
> +	}
> +
> +	mantissa =3D (mantissa * unit) / divisor;
> +	if (sign)
> +		mantissa =3D -mantissa;
> +
> +	return mantissa;
> +}
> +
> +static void iio_apply_matrix(struct matrix *m, int *in, int *out, uint32=
_t unit)
> +{
> +	/* apply mount matrix */
> +	out[0] =3D (m->mxx * in[0] + m->myx * in[1] + m->mzx * in[2]) / unit;
> +	out[1] =3D (m->mxy * in[0] + m->myy * in[1] + m->mzy * in[2]) / unit;
> +	out[2] =3D (m->mxz * in[0] + m->myz * in[1] + m->mzz * in[2]) / unit;
> +}
> +
> +#define FIXED_POINT_UNIT	1000	/* seems reasonable for accelerometer inpu=
t */
> +
> +static void iio_accel_poll(struct input_polled_dev *dev)
> +{
> +	struct iio_input_map *map =3D dev->private;
> +	struct input_dev *input =3D dev->input;
> +
> +	int values[3];		/* values while processing */
> +	int aligned_values[3];	/* mount matrix applied */
> +
> +	int cindex =3D 0;
> +
> +printk("%s: map=3D%px input=3D%px\n", __func__, map, input);
Remember to tidy these debug statements up at some point.

> +
> +	while (cindex < ARRAY_SIZE(values)) {
> +		struct iio_channel *channel =3D
> +			&map->channels[cindex];
> +		int val;
> +		int ret;
> +
> +		if (!channel->indio_dev) {
> +			values[cindex] =3D 0;
> +			continue;
> +		}
> +
> +		ret =3D iio_read_channel_raw(channel, &val);
> +
> +		if (ret < 0) {
> +			pr_err("%s(): channel read error %d\n",
> +				__func__, cindex);
> +			return;
> +		}
> +
> +		ret =3D iio_convert_raw_to_processed(channel, val,
> +				 &values[cindex], SCALE);
> +
> +		if (ret < 0) {
> +			pr_err("%s(): channel processing error\n",
> +				__func__);
> +			return;
> +		}
> +
> +		cindex++;
> +	}
> +
> +	iio_apply_matrix(&map->matrix, values, aligned_values, FIXED_POINT_UNIT=
);
> +
> +	input_report_abs(input, ABS_X, aligned_values[0]);
> +	input_report_abs(input, ABS_Y, aligned_values[1]);
> +	input_report_abs(input, ABS_Z, aligned_values[2]);
> +	input_sync(input);
> +}
> +
> +static int dindex=3D0;	/* assign unique names to accel/input devices */
Build something from the iio device IDA perhaps?  Those are unique
as well.  Useful to know which one this is linked to.

> +
> +static int iio_input_register_accel_channel(struct iio_dev *indio_dev,
> +		 const struct iio_chan_spec *chan)
> +{ /* we found some accelerometer channel */
> +	int ret;
> +	int cindex;
> +	struct iio_input_map *map =3D iio_device_get_drvdata(indio_dev);

Don't do that.   That is in the domain of the device driver and so
will sometimes already be in use.=20

> +
> +printk("%s: map=3D%px\n", __func__, map);
> +
> +	if (!map) {
> +		struct input_polled_dev *poll_dev;
> +		const struct iio_chan_spec_ext_info *ext_info;
> +
> +		map =3D devm_kzalloc(&indio_dev->dev, sizeof(struct iio_input_map), GF=
P_KERNEL);
> +		if (!map)
> +			return -ENOMEM;
> +
> +		iio_device_set_drvdata(indio_dev, map);
> +
> +		poll_dev =3D devm_input_allocate_polled_device(&indio_dev->dev);
> +		if (!poll_dev)
> +			return -ENOMEM;
> +
> +		poll_dev->private =3D map;
> +		poll_dev->poll =3D iio_accel_poll;
> +		poll_dev->poll_interval =3D POLLING_MSEC;
> +
> +		poll_dev->input->name =3D kasprintf(GFP_KERNEL, "iio-bridge: %s",
> +						    indio_dev->name);
> +		poll_dev->input->phys =3D kasprintf(GFP_KERNEL, "accel/input%d",
> +						    dindex++);
> +
> +// do we need something like this?
> +//		poll_dev->input->id.bustype =3D BUS_IIO;
> +//		poll_dev->input->id.vendor =3D 0x0001;
> +//		poll_dev->input->id.product =3D 0x0001;
> +//		poll_dev->input->id.version =3D 0x0001;
> +
> +		set_bit(INPUT_PROP_ACCELEROMETER, poll_dev->input->propbit);
> +		poll_dev->input->evbit[0] =3D BIT_MASK(EV_ABS);
> +		input_alloc_absinfo(poll_dev->input);
> +		input_set_abs_params(poll_dev->input, ABS_X, ABSMIN_ACC_VAL,
> +					ABSMAX_ACC_VAL, 0, 0);
> +		input_set_abs_params(poll_dev->input, ABS_Y, ABSMIN_ACC_VAL,
> +					ABSMAX_ACC_VAL, 0, 0);
> +		input_set_abs_params(poll_dev->input, ABS_Z, ABSMIN_ACC_VAL,
> +					ABSMAX_ACC_VAL, 0, 0);
> +
> +		map->poll_dev =3D poll_dev;
> +
> +		ret =3D input_register_polled_device(poll_dev);
> +
> +		if (ret < 0) {
> +			kfree(poll_dev->input->name);
> +			kfree(poll_dev->input->phys);
> +			return ret;
> +		}
> +
> +		/* assume all channels of a device share the same matrix */
> +
> +		ext_info =3D chan->ext_info;
> +		for (; ext_info && ext_info->name; ext_info++) {
> +			if (strcmp(ext_info->name, "mount_matrix") =3D=3D 0)
> +				break;
> +		}
> +
> +		if (ext_info && ext_info->name) {
> +			/* matrix found */
> +			uintptr_t priv =3D ext_info->private;
> +			const struct iio_mount_matrix *mtx;
> +
> +			mtx =3D ((iio_get_mount_matrix_t *) priv)(indio_dev,
> +								chan);
> +
> +			map->matrix.mxx =3D atofix(mtx->rotation[0], FIXED_POINT_UNIT);
> +			map->matrix.myx =3D atofix(mtx->rotation[1], FIXED_POINT_UNIT);
> +			map->matrix.mzx =3D atofix(mtx->rotation[2], FIXED_POINT_UNIT);
> +			map->matrix.mxy =3D atofix(mtx->rotation[3], FIXED_POINT_UNIT);
> +			map->matrix.myy =3D atofix(mtx->rotation[4], FIXED_POINT_UNIT);
> +			map->matrix.mzy =3D atofix(mtx->rotation[5], FIXED_POINT_UNIT);
> +			map->matrix.mxz =3D atofix(mtx->rotation[6], FIXED_POINT_UNIT);
> +			map->matrix.myz =3D atofix(mtx->rotation[7], FIXED_POINT_UNIT);
> +			map->matrix.mzz =3D atofix(mtx->rotation[8], FIXED_POINT_UNIT);
> +		} else {
> +			map->matrix.mxx =3D FIXED_POINT_UNIT;
> +			map->matrix.myx =3D 0;
> +			map->matrix.mzx =3D 0;
> +			map->matrix.mxy =3D 0;
> +			map->matrix.myy =3D FIXED_POINT_UNIT;
> +			map->matrix.mzy =3D 0;
> +			map->matrix.mxz =3D 0;
> +			map->matrix.myz =3D 0;
> +			map->matrix.mzz =3D FIXED_POINT_UNIT;
> +		}
> +	}
> +
> +// brauchen wir das noch? Oder nehmen wir einfach an dass es 3 Kan=C3=A4=
le gibt?
> +
> +	/* find free channel within this device */
> +
> +	for (cindex =3D 0; cindex < ARRAY_SIZE(map->channels); cindex++) {
> +		if (!map->channels[cindex].indio_dev)
> +			break;
> +	}
> +
> +	/* check if we already have collected enough channels */
> +	if (cindex =3D=3D ARRAY_SIZE(map->channels))
> +		return 0;	/* silently ignore */
> +
> +	map->channels[cindex].indio_dev =3D indio_dev;
> +	map->channels[cindex].channel =3D chan;
> +	map->channels[cindex].data =3D map;
> +
> +	return 0;
> +}
> +
> +int iio_device_register_inputbridge(struct iio_dev *indio_dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		const struct iio_chan_spec *chan =3D
> +				&indio_dev->channels[i];
> +
> +		if (chan->type =3D=3D IIO_ACCEL) {
> +			int r =3D iio_input_register_accel_channel(indio_dev,
> +								 chan);
It would be cleaner (and safer) to go find all the necessary channels then
set up the map in one go, rather that iterating and trying to build it
in a sequential fashion.

So move the search loop inside and have something like.

iio_input_find_accel_channel(indio_dev, chan, &numchans);
iio_input_register_device(indio_dev, chan, numchans);
=20
> +
> +			if (r < 0)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void iio_device_unregister_inputbridge(struct iio_dev *indio_dev)
> +{
> +	struct iio_input_map *map =3D iio_device_get_drvdata(indio_dev);
> +	struct input_dev *input =3D map->poll_dev->input;
> +
> +	kfree(input->name);
> +	kfree(input->phys);
> +	input_unregister_polled_device(map->poll_dev);
> +}
> +
> +MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
> +MODULE_DESCRIPTION("Bridge to present Industrial I/O accelerometers as p=
roperly oriented Input devices");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/industrialio-inputbridge.h b/drivers/iio/industr=
ialio-inputbridge.h
> new file mode 100644
> index 000000000000..1363b10ab3f7
> --- /dev/null
> +++ b/drivers/iio/industrialio-inputbridge.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * The Industrial I/O core, bridge to input devices
> + *
> + * Copyright (c) 2016-2019 Golden Delicious Computers GmbH&Co. KG
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2 as publis=
hed by
> + * the Free Software Foundation.
> + */
> +
> +#if defined(CONFIG_IIO_INPUT_BRIDGE)
> +
> +extern int iio_device_register_inputbridge(struct iio_dev *indio_dev);
> +extern void iio_device_unregister_inputbridge(struct iio_dev *indio_dev);
> +
> +#else
> +
> +static inline int iio_device_register_inputbridge(struct iio_dev *indio_=
dev)
> +{
> +	return 0;
> +}
> +
> +static inline void iio_device_unregister_inputbridge(struct iio_dev *ind=
io_dev)
> +{
> +}
> +
> +#endif
