From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: Add PAT9125 optical tracker sensor
Date: Sun, 7 Apr 2019 11:20:24 +0100
Message-ID: <20190407112024.6297cbfa@archlinux>
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
        <1554456870-8104-4-git-send-email-amergnat@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554456870-8104-4-git-send-email-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, baylibre-upstreaming@groups.io, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri,  5 Apr 2019 09:34:30 +0000
Alexandre Mergnat <amergnat@baylibre.com> wrote:

> This adds support for PixArt Imaging=E2=80=99s miniature low power
> optical navigation chip using LASER light source
> enabling digital surface tracking.

Hi Alexandre,

So I have no problem with this as an IIO driver, but for devices that
are somewhat 'on the edge' I always like to get a clear answer to the
question: Why not input?

I would also argue that, to actually be 'useful' we would typically need
some representation of the 'mechanicals' that are providing the motion
being measured.  Looking at the datasheet this includes, rotating shafts
(side or end on), disk edges and flat surface tracking (mouse like).

That's easy enough to do with the iio in kernel consumer interface. These
are similar to when we handle analog electronic front ends.

I you can, please describe what it is being used for in your application
as that may give us somewhere to start!

+ CC Dmitry and linux-input.

>=20
> This IIO driver allow to read delta position on 2 axis (X and Y).
> The values can be taken through ponctual "read_raw" which will issue
> a read in the device registers to return the deltas or subscribe
> to the data buffer feed automaticaly by a new value using a
> trigger gpio. The buffer payload is: |16 bits delta X|16 bits delta Y|tim=
estamp|.
> The possible I2C adresses are 0x73, 0x75 and 0x79.
>=20
> Unfortunately, the device configuration must be hardcoded in the initiali=
zation
> function and can't be changed "on-the-fly" in user space due to the lack =
of
> configuration interface.
>=20
> The "ot" directory is added to coutain Optical Tracker drivers.
=46rom a shared interface point of view we don't really care 'how', but rathe=
r 'what'.
So arguably this is actually measuring differential position, or sort of
'velocity'.  I think it should probably be mapped to simple position though=
.  See
below.

>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Comments inline.

> ---
>  drivers/iio/Kconfig      |   1 +
>  drivers/iio/Makefile     |   1 +
>  drivers/iio/ot/Kconfig   |  16 ++
>  drivers/iio/ot/Makefile  |   6 +
>  drivers/iio/ot/pat9125.c | 407 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 431 insertions(+)
>  create mode 100644 drivers/iio/ot/Kconfig
>  create mode 100644 drivers/iio/ot/Makefile
>  create mode 100644 drivers/iio/ot/pat9125.c
>=20
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d08aeb4..bdf1bd0 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -86,6 +86,7 @@ source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
>  source "drivers/iio/multiplexer/Kconfig"
>  source "drivers/iio/orientation/Kconfig"
> +source "drivers/iio/ot/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index cb59932..fdda2e1 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -32,6 +32,7 @@ obj-y +=3D light/
>  obj-y +=3D magnetometer/
>  obj-y +=3D multiplexer/
>  obj-y +=3D orientation/
> +obj-y +=3D ot/
>  obj-y +=3D potentiometer/
>  obj-y +=3D potentiostat/
>  obj-y +=3D pressure/
> diff --git a/drivers/iio/ot/Kconfig b/drivers/iio/ot/Kconfig
> new file mode 100644
> index 0000000..3d17fda
> --- /dev/null
> +++ b/drivers/iio/ot/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# Optical tracker sensors
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Optical tracker sensors"
> +
> +config PAT9125
> +	tristate "Optical tracker PAT9125 I2C driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	help
> +	  Say yes here to build support for PAT9125 optical tracker
> +	  sensors.
> +
> +endmenu
> diff --git a/drivers/iio/ot/Makefile b/drivers/iio/ot/Makefile
> new file mode 100644
> index 0000000..cf29491
> --- /dev/null
> +++ b/drivers/iio/ot/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O Optical tracker sensor drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_PAT9125) +=3D pat9125.o
> diff --git a/drivers/iio/ot/pat9125.c b/drivers/iio/ot/pat9125.c
> new file mode 100644
> index 0000000..f416bfa
> --- /dev/null
> +++ b/drivers/iio/ot/pat9125.c
> @@ -0,0 +1,407 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Copyright (C) 2018 BayLibre, SAS

Probably going to need to add 2019!

> + * Author: Alexandre Mergnat <amergnat@baylibre.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +/* I2C Address function to ID pin*/
> +#define PAT9125_I2C_ADDR_HI		0x73
> +#define PAT9125_I2C_ADDR_LO		0x75
> +#define PAT9125_I2C_ADDR_NC		0x79
> +
> +/* Registers */
> +#define PAT9125_PRD_ID1_REG		0x00
> +#define PAT9125_PRD_ID2_REG		0x01
> +#define PAT9125_MOTION_STATUS_REG	0x02
> +#define PAT9125_DELTA_X_LO_REG		0x03
> +#define PAT9125_DELTA_Y_LO_REG		0x04
> +#define PAT9125_OP_MODE_REG		0x05
> +#define PAT9125_CONFIG_REG		0x06
> +#define PAT9125_WRITE_PROTEC_REG	0x09
> +#define PAT9125_SLEEP1_REG		0x0A
> +#define PAT9125_SLEEP2_REG		0x0B
> +#define PAT9125_RES_X_REG		0x0D
> +#define PAT9125_RES_Y_REG		0x0E
> +#define PAT9125_DELTA_XY_HI_REG		0x12
> +#define PAT9125_SHUTER_REG		0x14
> +#define PAT9125_FRAME_AVG_REG		0x17
> +#define PAT9125_ORIENTATION_REG		0x19
> +
> +/* Masks */
> +#define PAT9125_VALID_MOTION_DATA_MASK	0x80
> +#define PAT9125_RESET_MASK		0x80

BIT?

> +
> +/* Registers' values */
> +#define PAT9125_SENSOR_ID_VAL			0x31
> +#define PAT9125_DISABLE_WRITE_PROTECT_VAL	0x5A
> +#define PAT9125_ENABLE_WRITE_PROTECT_VAL	0x00
> +#define PAT9125_CPI_RESOLUTION_X_VAL		0x65
> +#define PAT9125_CPI_RESOLUTION_Y_VAL		0xFF
> +
> +/* Default Value of sampled value size */
> +#define PAT9125_SAMPLED_VAL_BIT_SIZE		12
These defines actually mostly add to obscure what is going on.
In my mind, the values themselves are clearer than the defines.

> +#define PAT9125_SAMPLED_VAL_BYTE_SIZE		2	/* 12 bits by default */
> +#define PAT9125_TIMESTAMP_BYTE_SIZE		8	/* 64 bits */
> +#define PAT9125_PAYLOAD_BYTE_SIZE \
> +	(2 * PAT9125_SAMPLED_VAL_BYTE_SIZE + PAT9125_TIMESTAMP_BYTE_SIZE)
> +#define PAT9125_REALBITS_XY_VAL \
> +	(2 * PAT9125_SAMPLED_VAL_BIT_SIZE)
> +#define PAT9125_STORAGEBITS_XY_VAL \
> +	(2 * PAT9125_SAMPLED_VAL_BYTE_SIZE)
> +
> +struct pat9125_data {
> +	struct i2c_client *client;
I think client is only used to get dev for debug message purposes.
you can get that in a number of other ways including from the regmap.

Hence drop client from this structure.

> +	struct regmap *regmap;
> +	s16 delta_x;
> +	s16 delta_y;
> +};
> +
> +static const struct iio_event_spec pat9125_event =3D {
> +	.type =3D IIO_EV_TYPE_THRESH,
> +	.dir =3D IIO_EV_DIR_RISING,
> +	.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +};
> +
> +static const struct iio_chan_spec pat9125_channels[] =3D {
> +	{
> +		.type =3D IIO_DISTANCE,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_X_AND_Y,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.address =3D 0,
> +		.scan_index =3D 0,
> +		.scan_type =3D {
> +			.sign =3D 's',			\
> +			.realbits =3D 24,			\
That is not how mod_x_and_y is used.  It only exists for events, not
to let you define your own version of channels with two elements.

In IIO these are two separate channels and must be represented as
such.

There is another problem here, in what type of channel this actually
is.  Now I may have the following wrong as the datasheet is less than
super clear!.

It's not outputting position at all, but rather a delta value from
when it was either:
1. last read? (not sure on this)
2. last fired an interrupt?
3. last took a sample? (fixed sampling frequency).=20

If 1 or 2, I would suggest that you provide absolute position to
Linux.  So add the value to a software counter and provide that.
32 bits should be plenty of resolution for that.

If 3, it's a velocity sensor so report it as velocity not position.

If it is actually not possible to report the two channels separately
then don't report them at all except via the buffered interface and
set the available scan masks so that both are on.

> +			.storagebits =3D 32,		\
> +			.shift =3D 8,			\
> +			.endianness =3D IIO_BE,		\
> +		},
> +		.event_spec =3D &pat9125_event,
> +		.num_event_specs =3D 1,
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static int pat9125_read_delta(struct pat9125_data *data)
> +{
> +	struct regmap *regmap =3D data->regmap;
> +	int status =3D 0;
> +	int val_x =3D 0;
> +	int val_y =3D 0;
> +	int val_xy =3D 0;
val_xy is a confusing name.  perhaps val_high_nibbles?

> +	int r;
ret, be consistent with naming.

> +
> +	r =3D regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
> +	if (r < 0)
> +		return r;
> +
> +	/* Check motion bit in bit7 */
Why?  This is reading a value, if there is no motion, then is the
right answer not to set it to such? i.e. 0.

Also we carefully used a macro to hide the fact it is bit7 so don't put
it in the comment ;)

> +	if (status & PAT9125_VALID_MOTION_DATA_MASK) {
> +		r =3D regmap_read(regmap, PAT9125_DELTA_X_LO_REG, &val_x);
> +		if (r < 0)
> +			return r;

One thing that isn't clear from the datasheet I am looking at is whether th=
is
is potentially racey.  What stops an update whilst we are reading?

> +
> +		r =3D regmap_read(regmap, PAT9125_DELTA_Y_LO_REG, &val_y);
> +		if (r < 0)
> +			return r;
> +
> +		r =3D regmap_read(regmap, PAT9125_DELTA_XY_HI_REG, &val_xy);
> +		if (r < 0)
> +			return r;
> +
> +		data->delta_x =3D val_x | ((val_xy << 4) & 0xF00);
> +		data->delta_y =3D val_y | ((val_xy << 8) & 0xF00);
> +
> +		if (data->delta_x & 0x800)
> +			data->delta_x |=3D 0xF000;
This looks like sign extension to me.  We have standard functions for
that.sign_extend32.  Note that it's actually cheaper to do a 32 bit sign ex=
tend
to 32 bits than it is to 16, then assign back to 16 if you want to.

> +
> +		if (data->delta_y & 0x800)
> +			data->delta_y |=3D 0xF000;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pat9125_read_raw() - Sample and return the value(s)
> + * function to the associated channel info enum.
> + **/
> +static int pat9125_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D pat9125_read_delta(data);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D data->delta_x;
> +		*val2 =3D data->delta_y;

That's not how the IIO interface works.  You can't just push values
into different fields.  These are two axis, and are independent.
If you absolutely have to read them together then it must be done with
the buffered interface and we simply don't provide a read raw interface at
all.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +/**
> + * pat9125_read_event_value() - return last sampled value.
> + **/
> +static int pat9125_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val,
> +				    int *val2)
> +{
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		val[0] =3D data->delta_x;
> +		val[1] =3D data->delta_y;

Silly question for you.  What happens if you set the delta values to 0?
Do we get an interrupt which is effectively data ready?
If we do, you might want to think about a scheme where that is an option.
As things currently stand we have a confusing interface where changing this
threshold effects the buffered data output.   That should only be the
case if this interface is for a trigger, not an event.

> +		*val2 =3D 2;
> +		return IIO_VAL_INT_MULTIPLE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * pat9125_event_handler() - handling ring and non ring events
> + * @irq: The irq being handled.
> + * @private: struct iio_device pointer for the device.
This blank line doesn't add anything to readability so tidy it up.
> + *
> + */
> +static irqreturn_t pat9125_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +	int ret =3D 0;

ret is always set below, so don't initialise.

> +	u8 *payload;
> +	s64 last_timestamp =3D iio_get_time_ns(indio_dev);
> +
> +	payload =3D kmalloc(sizeof(s64) + 2 *
> +		  PAT9125_SAMPLED_VAL_BYTE_SIZE, GFP_KERNEL);
Why on the stack?  It's small and last thing you want to
do is a memory allocation ever time.

Also, you haven't allowed for the required alignment of the
timestamp. This needs to be a multiple of 8 bytes.
=20
> +
> +	ret =3D pat9125_read_delta(data);
> +	if (ret)
> +		return ret;
> +	memcpy(&payload[0], &data->delta_x, 2);

Make payload and array of u16 and you can just assign directly.

> +	memcpy(&payload[2], &data->delta_y, 2);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, payload, last_timestamp);

Hmm. This is not how IIO is normally used.  So the oddity here is the sensor
only produces an interrupt on a change of value.

So in IIO terms this would normally be considered a 'value change trigger'
driving normal buffered sampling.  I think it is also perfectly valid
if someone wants evenly spaced samples to read on demand?  If so
then you definitely want to allow use of high resolution timer triggers
and similar.=20

So, create a trigger that is base don the 'event' - there are other drivers
doing this.  It's possible that you might want that 'trigger' to also
call the iio event interface, but usually only if there are usecases where
knowing "motion happened" is useful rather than what the motion was.

Then use the triggered_buffer helpers to set up all the data capture side
of things.

> +	iio_push_event(indio_dev,
> +		       IIO_MOD_EVENT_CODE(IIO_DISTANCE,
> +					  0,
> +					  IIO_MOD_X_AND_Y,
That one is wrong btw, surely it is IIO_MOD_X_OR_Y. You aren't
triggering on motion in 'both X and Y' directions, motion in one
of them is enough.

> +					  IIO_EV_TYPE_THRESH,
> +					  IIO_EV_DIR_RISING),
> +		       last_timestamp);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pat9125_configure_ring(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer;
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +
> +	buffer =3D devm_iio_kfifo_allocate(&data->client->dev);
> +	if (!buffer)
> +		return -ENOMEM;
Hmm. Direct use of kfifo's is fairly unusual as it normally means there
is something unusual about how the device is being mapped to the IIO
elements.

> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +	indio_dev->modes |=3D INDIO_BUFFER_SOFTWARE;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config pat9125_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> +
> +static const struct iio_info pat9125_info =3D {
> +	.read_raw =3D pat9125_read_raw,
> +	.read_event_value =3D &pat9125_read_event_value,
> +};
> +
> +static int pat9125_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct pat9125_data *data;
> +	struct iio_dev *indio_dev;
> +	int r, sensor_pid;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "IIO device allocation failed");
> +		return -ENOMEM;
> +	}
> +
> +	data =3D iio_priv(indio_dev);
> +	data->client =3D client;
> +
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->name =3D id->name;
> +	indio_dev->channels =3D pat9125_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(pat9125_channels);
> +	indio_dev->info =3D &pat9125_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	r =3D pat9125_configure_ring(indio_dev);

I'd rename this, its a fifo, rather than a ring (it was a ring
early in IIO's history so the naming still kicks around
in a few drivers).

> +	if (r < 0) {
> +		dev_err(&client->dev, "FIFO buffer allocation failed");
> +		return r;
> +	}
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &pat9125_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev,
> +			"regmap init failed %ld",
> +			PTR_ERR(data->regmap));

This is wrapped onto more lines than necessary.  Kernel coding convention
is to keep as many parameters on each line as fit under 80 chars.

> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	/* Check device ID */
> +	r =3D regmap_read(data->regmap, PAT9125_PRD_ID1_REG, &sensor_pid);
> +	if (r < 0)
> +		goto reg_access_fail;
> +	if (sensor_pid !=3D PAT9125_SENSOR_ID_VAL)
> +		return -ENODEV;
> +
> +	/* Software reset (i.e. set bit7 to 1).
Multiline, comment style in most of the kernel, including IIO is
/*
 * Soft reset...
 */

> +	 * It will reset to 0 automatically
> +	 */
> +	r =3D regmap_write_bits(data->regmap,
> +			      PAT9125_CONFIG_REG,
> +			      PAT9125_RESET_MASK,
> +			      1);
> +	if (r < 0)
> +		goto reg_access_fail;
> +
> +	/* Delay 20ms */
> +	msleep(20);
> +
> +	/* Disable write protect */
Don't add comments for things that are obvious from the code.
(i.e. the sleep above and this one).

> +	r =3D regmap_write(data->regmap,
> +			 PAT9125_WRITE_PROTEC_REG,
> +			 PAT9125_DISABLE_WRITE_PROTECT_VAL);
> +	if (r < 0)
> +		goto reg_access_fail;
> +
> +	/* Set X-axis resolution (depends on application) */
> +	r =3D regmap_write(data->regmap,
> +			 PAT9125_RES_X_REG,
> +			 0x0A);

Need to control this from somewhere. Device tree binding perhaps?

> +	if (r < 0)
> +		goto reg_access_fail;
> +
> +	/* Set Y-axis resolution (depends on application) */
> +	r =3D regmap_write(data->regmap,
> +			 PAT9125_RES_Y_REG,
> +			 0x0A);
> +	if (r < 0)
> +		goto reg_access_fail;
> +
> +	/* Enable write protection */
> +	r =3D regmap_write(data->regmap,
> +			 PAT9125_WRITE_PROTEC_REG,
> +			 PAT9125_ENABLE_WRITE_PROTECT_VAL);
> +	if (r < 0)
> +		goto reg_access_fail;
> +
> +	r =3D devm_iio_device_register(&client->dev, indio_dev);
> +	if (r) {
> +		dev_err(&client->dev, "IIO device register failed");
> +		return r;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	dev_info(&client->dev, "%s: sensor '%s'\n",
> +		 dev_name(&indio_dev->dev),
> +		 client->name);
> +
> +	/* Make read to reset motion bit status */
> +	r =3D pat9125_read_delta(data);
> +	if (r)
> +		goto reg_access_fail;
> +
> +	/* Init GPIO IRQ */
> +	if (client->irq) {
> +		r =3D devm_request_threaded_irq(&client->dev,
> +					      client->irq,
> +					      NULL,
> +					      pat9125_event_handler,
> +					      IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					      "pat9125",
> +					      indio_dev);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +
> +reg_access_fail:
This just makes the code flow harder to follow.  If you want to add
the print out, just replicate it, with information for example on=20
which register access failed.

Only do goto, return paths if there is actual code to run.

> +	dev_err(&client->dev, "register access failed %d", r);
> +	return r;
> +}
> +
> +static int pat9125_remove(struct i2c_client *client)
> +{
> +	dev_info(&client->dev, "PAT9125 removed\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id pat9125_id[] =3D {
> +	{ "pat9125", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pat9125_id);
> +
> +static const unsigned short normal_i2c[] =3D {
> +	PAT9125_I2C_ADDR_HI,
> +	PAT9125_I2C_ADDR_LO,
> +	PAT9125_I2C_ADDR_NC,
> +	I2C_CLIENT_END
> +};
> +
> +static struct i2c_driver pat9125_driver =3D {
> +	.driver =3D {
> +		.name =3D "pat9125",
> +	},
> +	.probe =3D pat9125_probe,
> +	.remove =3D pat9125_remove,
> +	.address_list =3D normal_i2c,
> +	.id_table =3D pat9125_id,
> +};
> +
> +module_i2c_driver(pat9125_driver);
> +
> +MODULE_AUTHOR("Alexandre Mergnat <amergnat@baylibre.com>");
> +MODULE_DESCRIPTION("Optical Tracking sensor");
> +MODULE_LICENSE("GPL");
> +
Clean up this blank line.

Thanks,

Jonathan
