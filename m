From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: light: apple-ib-als: Add driver for ALS on
 iBridge chip.
Date: Mon, 22 Apr 2019 13:01:38 +0100
Message-ID: <20190422130138.336fb227@archlinux>
References: <20190422031251.11968-1-ronald@innovation.ch>
        <20190422031251.11968-4-ronald@innovation.ch>
        <alpine.DEB.2.21.1904221101420.964@vps.pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1904221101420.964@vps.pmeerw.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 22 Apr 2019 11:17:27 +0200 (CEST)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> On Sun, 21 Apr 2019, Ronald Tschal=C3=A4r wrote:
>=20
> > On 2016/2017 MacBook Pro's with a Touch Bar the ALS is attached to,
> > and exposed via the iBridge device. This provides the driver for that
> > sensor. =20
>=20
> some comments below inline
I'll 'nest' on Peter's review to avoid repetition.

A few additional comments inline.

Thanks,

Jonathan
> =20
> > Signed-off-by: Ronald Tschal=C3=A4r <ronald@innovation.ch>
> > ---
> >  drivers/iio/light/Kconfig        |  12 +
> >  drivers/iio/light/Makefile       |   1 +
> >  drivers/iio/light/apple-ib-als.c | 694 +++++++++++++++++++++++++++++++
> >  3 files changed, 707 insertions(+)
> >  create mode 100644 drivers/iio/light/apple-ib-als.c
> >=20
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 36f458433480..49159fab1c0e 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -64,6 +64,18 @@ config APDS9960
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called apds9960
> > =20
> > +config APPLE_IBRIDGE_ALS
> > +	tristate "Apple iBridge ambient light sensor"
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	depends on MFD_APPLE_IBRIDGE
> > +	help
> > +	  Say Y here to build the driver for the Apple iBridge ALS
> > +	  sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called apple-ib-als.
> > +
> >  config BH1750
> >  	tristate "ROHM BH1750 ambient light sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 286bf3975372..144d918917f7 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_ADJD_S311)		+=3D adjd_s311.o
> >  obj-$(CONFIG_AL3320A)		+=3D al3320a.o
> >  obj-$(CONFIG_APDS9300)		+=3D apds9300.o
> >  obj-$(CONFIG_APDS9960)		+=3D apds9960.o
> > +obj-$(CONFIG_APPLE_IBRIDGE_ALS)	+=3D apple-ib-als.o
> >  obj-$(CONFIG_BH1750)		+=3D bh1750.o
> >  obj-$(CONFIG_BH1780)		+=3D bh1780.o
> >  obj-$(CONFIG_CM32181)		+=3D cm32181.o
> > diff --git a/drivers/iio/light/apple-ib-als.c b/drivers/iio/light/apple=
-ib-als.c
> > new file mode 100644
> > index 000000000000..1718fcbe304f
> > --- /dev/null
> > +++ b/drivers/iio/light/apple-ib-als.c
> > @@ -0,0 +1,694 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Apple Ambient Light Sensor Driver
> > + *
> > + * Copyright (c) 2017-2018 Ronald Tschal=C3=A4r
> > + */
> > +
> > +/*
> > + * MacBookPro models with an iBridge chip (13,[23] and 14,[23]) have an
> > + * ambient light sensor that is exposed via one of the USB interfaces =
on
> > + * the iBridge as a standard HID light sensor. However, we cannot use =
the
> > + * existing hid-sensor-als driver, for two reasons:
> > + *
> > + * 1. The hid-sensor-als driver is part of the hid-sensor-hub which in=
 turn
> > + *    is a hid driver, but you can't have more than one hid driver per=
 hid
> > + *    device, which is a problem because the touch bar also needs to
> > + *    register as a driver for this hid device.
> > + *
> > + * 2. While the hid-sensors-als driver stores sensor readings received=
 via
> > + *    interrupt in an iio buffer, reads on the sysfs
> > + *    .../iio:deviceX/in_illuminance_YYY attribute result in a get of =
the
> > + *    feature report; however, in the case of this sensor here the
> > + *    illuminance field of that report is always 0. Instead, the input
> > + *    report needs to be requested.
> > + */
> > +
> > +#define dev_fmt(fmt) "als: " fmt
> > +
> > +#include <linux/device.h>
> > +#include <linux/hid.h>
> > +#include <linux/hid-sensor-ids.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/mfd/apple-ibridge.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#define APPLEALS_DYN_SENS		0	/* our dynamic sensitivity */
> > +#define APPLEALS_DEF_CHANGE_SENS	APPLEALS_DYN_SENS
> > +
> > +struct appleals_device {
> > +	struct appleib_device	*ib_dev;
> > +	struct device		*log_dev;
> > +	struct hid_device	*hid_dev;
> > +	struct hid_report	*cfg_report;
> > +	struct hid_field	*illum_field;
> > +	struct iio_dev		*iio_dev;
> > +	struct iio_trigger	*iio_trig;
> > +	int			cur_sensitivity;
> > +	int			cur_hysteresis;
> > +	bool			events_enabled;
> > +};
> > +
> > +static struct hid_driver appleals_hid_driver;
> > +
> > +/*
> > + * This is a primitive way to get a relative sensitivity, one where we=
 get
> > + * notified when the value changes by a certain percentage rather than=
 some
> > + * absolute value. MacOS somehow manages to configure the sensor to wo=
rk this
> > + * way (with a 15% relative sensitivity), but I haven't been able to f=
igure
> > + * out how so far. So until we do, this provides a less-than-perfect
> > + * simulation.
> > + *
> > + * When the brightness value is within one of the ranges, the sensitiv=
ity is
> > + * set to that range's sensitivity. But in order to reduce flapping wh=
en the
> > + * brightness is right on the border between two ranges, the ranges ov=
erlap
> > + * somewhat (by at least one sensitivity), and sensitivity is only cha=
nged if
> > + * the value leaves the current sensitivity's range.
> > + *
> > + * The values chosen for the map are somewhat arbitrary: a compromise =
of not
> > + * too many ranges (and hence changing the sensitivity) but not too sm=
all or
> > + * large of a percentage of the min and max values in the range (curre=
ntly
> > + * from 7.5% to 30%, i.e. within a factor of 2 of 15%), as well as jus=
t plain
> > + * "this feels reasonable to me".
> > + */
> > +struct appleals_sensitivity_map {
> > +	int	sensitivity;
> > +	int	illum_low;
> > +	int	illum_high;
> > +};
> > +
> > +static struct appleals_sensitivity_map appleals_sensitivity_map[] =3D =
{ =20
>=20
> const?
>=20
> > +	{   1,    0,   14 },
> > +	{   3,   10,   40 },
> > +	{   9,   30,  120 },
> > +	{  27,   90,  360 },
> > +	{  81,  270, 1080 },
> > +	{ 243,  810, 3240 },
> > +	{ 729, 2430, 9720 },
> > +};
> > +
> > +static int appleals_compute_sensitivity(int cur_illum, int cur_sens)
> > +{
> > +	struct appleals_sensitivity_map *entry;
> > +	int i;
> > +
> > +	/* see if we're still in current range */
> > +	for (i =3D 0; i < ARRAY_SIZE(appleals_sensitivity_map); i++) {
> > +		entry =3D &appleals_sensitivity_map[i];
> > +
> > +		if (entry->sensitivity =3D=3D cur_sens &&
> > +		    entry->illum_low <=3D cur_illum &&
> > +		    entry->illum_high >=3D cur_illum)
> > +			return cur_sens;
> > +		else if (entry->sensitivity > cur_sens)
> > +			break;
> > +	}
> > +
> > +	/* not in current range, so find new sensitivity */
> > +	for (i =3D 0; i < ARRAY_SIZE(appleals_sensitivity_map); i++) {
> > +		entry =3D &appleals_sensitivity_map[i];
> > +
> > +		if (entry->illum_low <=3D cur_illum &&
> > +		    entry->illum_high >=3D cur_illum)
> > +			return entry->sensitivity;
> > +	}
> > +
> > +	/* hmm, not in table, so assume we are above highest range */
> > +	i =3D ARRAY_SIZE(appleals_sensitivity_map) - 1;
> > +	return appleals_sensitivity_map[i].sensitivity;
> > +}
> > +
> > +static int appleals_get_field_value_for_usage(struct hid_field *field,
> > +					      unsigned int usage)
> > +{
> > +	int u;
> > +
> > +	if (!field)
> > +		return -1;
> > +
> > +	for (u =3D 0; u < field->maxusage; u++) {
> > +		if (field->usage[u].hid =3D=3D usage)
> > +			return u + field->logical_minimum;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +static __s32 appleals_get_field_value(struct appleals_device *als_dev,
> > +				      struct hid_field *field)
> > +{
> > +	hid_hw_request(als_dev->hid_dev, field->report, HID_REQ_GET_REPORT);
> > +	hid_hw_wait(als_dev->hid_dev);
> > +
> > +	return field->value[0];
> > +}
> > +
> > +static void appleals_set_field_value(struct appleals_device *als_dev,
> > +				     struct hid_field *field, __s32 value)
> > +{
> > +	hid_set_field(field, 0, value);
> > +	hid_hw_request(als_dev->hid_dev, field->report, HID_REQ_SET_REPORT);
> > +}
> > +
> > +static int appleals_get_config(struct appleals_device *als_dev,
> > +			       unsigned int field_usage, __s32 *value)
> > +{
> > +	struct hid_field *field;
> > +
> > +	field =3D appleib_find_report_field(als_dev->cfg_report, field_usage);
> > +	if (!field)
> > +		return -EINVAL;
> > +
> > +	*value =3D appleals_get_field_value(als_dev, field);
> > +
> > +	return 0;
> > +}
> > +
> > +static int appleals_set_config(struct appleals_device *als_dev,
> > +			       unsigned int field_usage, __s32 value)
> > +{
> > +	struct hid_field *field;
> > +
> > +	field =3D appleib_find_report_field(als_dev->cfg_report, field_usage);
> > +	if (!field)
> > +		return -EINVAL;
> > +
> > +	appleals_set_field_value(als_dev, field, value);
> > +
> > +	return 0;
> > +}
> > +
> > +static int appleals_set_enum_config(struct appleals_device *als_dev,
> > +				    unsigned int field_usage,
> > +				    unsigned int value_usage)
> > +{
> > +	struct hid_field *field;
> > +	int value;
> > +
> > +	field =3D appleib_find_report_field(als_dev->cfg_report, field_usage);
> > +	if (!field)
> > +		return -EINVAL;
> > +
> > +	value =3D appleals_get_field_value_for_usage(field, value_usage); =20
>=20
> can return -1, not checked
>=20
> > +
> > +	appleals_set_field_value(als_dev, field, value);
> > +
> > +	return 0;
> > +}
> > +
> > +static void appleals_update_dyn_sensitivity(struct appleals_device *al=
s_dev,
> > +					    __s32 value)
> > +{
> > +	int new_sens;
> > +	int rc;
> > +
> > +	new_sens =3D appleals_compute_sensitivity(value,
> > +						als_dev->cur_sensitivity);
> > +	if (new_sens !=3D als_dev->cur_sensitivity) {
> > +		rc =3D appleals_set_config(als_dev,
> > +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS,
> > +			new_sens);
> > +		if (!rc)
> > +			als_dev->cur_sensitivity =3D new_sens;
> > +	}
> > +}
> > +
> > +static void appleals_push_new_value(struct appleals_device *als_dev,
> > +				    __s32 value)
> > +{
> > +	__s32 buf[2] =3D { value, value };
> > +
> > +	iio_push_to_buffers(als_dev->iio_dev, buf);
> > +
> > +	if (als_dev->cur_hysteresis =3D=3D APPLEALS_DYN_SENS)
> > +		appleals_update_dyn_sensitivity(als_dev, value);
> > +}
> > +
> > +static int appleals_hid_event(struct hid_device *hdev, struct hid_fiel=
d *field,
> > +			      struct hid_usage *usage, __s32 value)
> > +{
> > +	struct appleals_device *als_dev =3D
> > +		appleib_get_drvdata(hid_get_drvdata(hdev),
> > +				    &appleals_hid_driver);
> > +	int rc =3D 0;
> > +
> > +	if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_SENSOR)
> > +		return 0;
> > +
> > +	if (usage->hid =3D=3D HID_USAGE_SENSOR_LIGHT_ILLUM) {
> > +		appleals_push_new_value(als_dev, value);
> > +		rc =3D 1;
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static int appleals_enable_events(struct iio_trigger *trig, bool enabl=
e)
> > +{
> > +	struct appleals_device *als_dev =3D iio_trigger_get_drvdata(trig);
> > +	int value;
> > +
> > +	/* set the sensor's reporting state */
> > +	appleals_set_enum_config(als_dev, HID_USAGE_SENSOR_PROP_REPORT_STATE,
> > +		enable ? HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM :
> > +			 HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM);
> > +	als_dev->events_enabled =3D enable;
> > +
> > +	/* if the sensor was enabled, push an initial value */
> > +	if (enable) {
> > +		value =3D appleals_get_field_value(als_dev, als_dev->illum_field);
> > +		appleals_push_new_value(als_dev, value);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int appleals_read_raw(struct iio_dev *iio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask)
> > +{
> > +	struct appleals_device *als_dev =3D
> > +				*(struct appleals_device **)iio_priv(iio_dev);
> > +	__s32 value;
> > +	int rc;
> > +
> > +	*val =3D 0;
> > +	*val2 =3D 0; =20
>=20
> no need to set these here
>=20
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		*val =3D appleals_get_field_value(als_dev, als_dev->illum_field);

How can one read by both processed and raw?

> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		rc =3D appleals_get_config(als_dev,
> > +					 HID_USAGE_SENSOR_PROP_REPORT_INTERVAL,
> > +					 &value);
> > +		if (rc)
> > +			return rc;
> > +
> > +		/* interval is in ms; val is in HZ, val2 in =C2=B5HZ */
> > +		value =3D 1000000000 / value;
> > +		*val =3D value / 1000000;
> > +		*val2 =3D value - (*val * 1000000);
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case IIO_CHAN_INFO_HYSTERESIS:
> > +		if (als_dev->cur_hysteresis =3D=3D APPLEALS_DYN_SENS) {
> > +			*val =3D als_dev->cur_hysteresis;
> > +			return IIO_VAL_INT;
> > +		}
> > +
> > +		rc =3D appleals_get_config(als_dev,
> > +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS,
> > +			val);
> > +		if (!rc) {
> > +			als_dev->cur_sensitivity =3D *val;
> > +			als_dev->cur_hysteresis =3D *val;
> > +		}
> > +		return rc ? rc : IIO_VAL_INT;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int appleals_write_raw(struct iio_dev *iio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      int val, int val2, long mask)
> > +{
> > +	struct appleals_device *als_dev =3D
> > +				*(struct appleals_device **)iio_priv(iio_dev);
> > +	__s32 illum;
> > +	int rc;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		rc =3D appleals_set_config(als_dev,
> > +					 HID_USAGE_SENSOR_PROP_REPORT_INTERVAL,
> > +					 1000000000 / (val * 1000000 + val2));
> > +		break; =20
>=20
> maybe return directly instead of at the end (matter of taste);
> here and in the other cases below
>=20
> > +
> > +	case IIO_CHAN_INFO_HYSTERESIS:
> > +		if (val =3D=3D APPLEALS_DYN_SENS) {
> > +			if (als_dev->cur_hysteresis !=3D APPLEALS_DYN_SENS) {
> > +				als_dev->cur_hysteresis =3D val;
> > +				illum =3D appleals_get_field_value(als_dev,
> > +							als_dev->illum_field);
> > +				appleals_update_dyn_sensitivity(als_dev, illum);

There is some debate in another thread on whether dynamic sensitivity can be
mapped to hysteresis or not...

> > +			}
> > +			rc =3D 0;
> > +			break;
> > +		}
> > +
> > +		rc =3D appleals_set_config(als_dev,
> > +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS,
> > +			val);
> > +		if (!rc) {
> > +			als_dev->cur_sensitivity =3D val;
> > +			als_dev->cur_hysteresis =3D val;
> > +		}
> > +		break;
> > +
> > +	default:
> > +		rc =3D -EINVAL;
> > +	}
> > +
> > +	return rc;
> > +}
> > +
> > +static const struct iio_chan_spec appleals_channels[] =3D {
> > +	{
> > +		.type =3D IIO_INTENSITY,
> > +		.modified =3D 1,
> > +		.channel2 =3D IIO_MOD_LIGHT_BOTH,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED) |
> > +			BIT(IIO_CHAN_INFO_RAW),
Why return both processed and raw?  We don't generally allow that in IIO
(there are a few historical exceptions due to us getting it wrong the
first time).

> > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +			BIT(IIO_CHAN_INFO_HYSTERESIS),
> > +		.scan_type =3D {
> > +			.sign =3D 'u',
> > +			.realbits =3D 32,
> > +			.storagebits =3D 32,
> > +		},
> > +		.scan_index =3D 0,
> > +	},
> > +	{
> > +		.type =3D IIO_LIGHT,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED) |
> > +			BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +			BIT(IIO_CHAN_INFO_HYSTERESIS),
> > +		.scan_type =3D {
> > +			.sign =3D 'u',
> > +			.realbits =3D 32,
> > +			.storagebits =3D 32,
> > +		},
> > +		.scan_index =3D 1,
> > +	}
> > +};
> > +
> > +static const struct iio_trigger_ops appleals_trigger_ops =3D {
> > +	.set_trigger_state =3D &appleals_enable_events,
> > +};
> > +
> > +static const struct iio_info appleals_info =3D {
> > +	.read_raw =3D &appleals_read_raw,
> > +	.write_raw =3D &appleals_write_raw,
> > +};
> > +
> > +static void appleals_config_sensor(struct appleals_device *als_dev,
> > +				   bool events_enabled, int sensitivity)
> > +{
> > +	struct hid_field *field;
> > +	__s32 val;
> > +
> > +	/*
> > +	 * We're (often) in a probe here, so need to enable input processing
> > +	 * in that case, but only in that case.
> > +	 */
I'd be a little happier if this wasn't termed 'in_hid_probe' but rather som=
ething
like _needs_io_start.

That way we are reflecting what needs to happen, not where we are in the co=
de
flow that makes it true.

> > +	if (appleib_in_hid_probe(als_dev->ib_dev))
> > +		hid_device_io_start(als_dev->hid_dev);
> > +
> > +	/* power on the sensor */
> > +	field =3D appleib_find_report_field(als_dev->cfg_report,
> > +					  HID_USAGE_SENSOR_PROY_POWER_STATE);
> > +	val =3D appleals_get_field_value_for_usage(field,
> > +			HID_USAGE_SENSOR_PROP_POWER_STATE_D0_FULL_POWER_ENUM); =20
>=20
> what if -1?
>=20
> > +	hid_set_field(field, 0, val);
> > +
> > +	/* configure reporting of change events */
> > +	field =3D appleib_find_report_field(als_dev->cfg_report,
> > +					  HID_USAGE_SENSOR_PROP_REPORT_STATE);
> > +	val =3D appleals_get_field_value_for_usage(field,
> > +		events_enabled ?
> > +			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM :
> > +			HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM);
> > +	hid_set_field(field, 0, val);
> > +
> > +	/* report change events asap */
> > +	field =3D appleib_find_report_field(als_dev->cfg_report,
> > +					 HID_USAGE_SENSOR_PROP_REPORT_INTERVAL);
> > +	hid_set_field(field, 0, field->logical_minimum);
> > +
> > +	/*
> > +	 * Set initial change sensitivity; if dynamic, enabling trigger will =
set
> > +	 * it instead.
> > +	 */
> > +	if (sensitivity !=3D APPLEALS_DYN_SENS) {
> > +		field =3D appleib_find_report_field(als_dev->cfg_report,
> > +			HID_USAGE_SENSOR_LIGHT_ILLUM |
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS);
> > +
> > +		hid_set_field(field, 0, sensitivity);
> > +	}
> > +
> > +	/* write the new config to the sensor */
> > +	hid_hw_request(als_dev->hid_dev, als_dev->cfg_report,
> > +		       HID_REQ_SET_REPORT);
> > +
> > +	if (appleib_in_hid_probe(als_dev->ib_dev))
> > +		hid_device_io_stop(als_dev->hid_dev);
> > +}; =20
>=20
> no semicolon at the end of a function please
>=20
> > +
> > +static int appleals_config_iio(struct appleals_device *als_dev)
> > +{
> > +	struct iio_dev *iio_dev;
> > +	struct iio_trigger *iio_trig;
> > +	int rc;
> > +
> > +	/* create and register iio device */
A very good reason for not adding superficial comments.
This one is wrong or at least misleading.  It doesn't register
the iio device.  So get rid of all these comments that are
just saying what the code next to them is doing.  Keep the ones
that add extra information.


> > +	iio_dev =3D iio_device_alloc(sizeof(als_dev)); =20
>=20
> how about using the devm_ variants?
>=20
> > +	if (!iio_dev)
> > +		return -ENOMEM;
> > +
> > +	*(struct appleals_device **)iio_priv(iio_dev) =3D als_dev;

That is nasty.  Add a local variable to make to clear that iio_priv(iio_dev)
is actually some space for this pointer. Complex type casting is not
terribly readable.

> > +
> > +	iio_dev->channels =3D appleals_channels;
> > +	iio_dev->num_channels =3D ARRAY_SIZE(appleals_channels);
> > +	iio_dev->dev.parent =3D &als_dev->hid_dev->dev;
> > +	iio_dev->info =3D &appleals_info;
> > +	iio_dev->name =3D "als";
> > +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	rc =3D iio_triggered_buffer_setup(iio_dev, &iio_pollfunc_store_time, =
NULL,
> > +					NULL);
> > +	if (rc) {
> > +		dev_err(als_dev->log_dev, "failed to set up iio triggers: %d\n", =20
>=20
> just one trigger?
Also wrong as it's not actually setting up the trigger at all ;) It's setti=
ng
up the handling for what to do when a trigger event occurs.

>=20
> > +			rc);
> > +		goto free_iio_dev;
> > +	}
> > +
> > +	iio_trig =3D iio_trigger_alloc("%s-dev%d", iio_dev->name, iio_dev->id=
);
> > +	if (!iio_trig) {
> > +		rc =3D -ENOMEM;
> > +		goto clean_trig_buf;
> > +	}
> > +
> > +	iio_trig->dev.parent =3D &als_dev->hid_dev->dev;
> > +	iio_trig->ops =3D &appleals_trigger_ops;
> > +	iio_trigger_set_drvdata(iio_trig, als_dev);
> > +
> > +	rc =3D iio_trigger_register(iio_trig);
> > +	if (rc) {
> > +		dev_err(als_dev->log_dev, "failed to register iio trigger: %d\n", =20
>=20
> some messages start lowercase, some uppercase (nitpicking)
>=20
> > +			rc);
> > +		goto free_iio_trig;
> > +	}
> > +
> > +	als_dev->iio_trig =3D iio_trig;
> > +
> > +	rc =3D iio_device_register(iio_dev);
> > +	if (rc) {
> > +		dev_err(als_dev->log_dev, "failed to register iio device: %d\n",
> > +			rc);
> > +		goto unreg_iio_trig;
> > +	}
> > +
> > +	als_dev->iio_dev =3D iio_dev;

I really don't like nest of pointers going on in here.  I haven't dug
down to check if any of them can be remove, but they are definitely
ugly to deal with.

> > +
> > +	return 0;
> > +
> > +unreg_iio_trig:
> > +	iio_trigger_unregister(iio_trig);
> > +free_iio_trig:
> > +	iio_trigger_free(iio_trig);
> > +	als_dev->iio_trig =3D NULL;
> > +clean_trig_buf:
> > +	iio_triggered_buffer_cleanup(iio_dev);
> > +free_iio_dev:
> > +	iio_device_free(iio_dev);
> > +
> > +	return rc;
> > +}
> > +
> > +static int appleals_probe(struct hid_device *hdev,
> > +			  const struct hid_device_id *id)
> > +{
> > +	struct appleals_device *als_dev =3D
> > +		appleib_get_drvdata(hid_get_drvdata(hdev),
> > +				    &appleals_hid_driver);
> > +	struct hid_field *state_field;
> > +	struct hid_field *illum_field;
> > +	int rc;
> > +
> > +	/* find als fields and reports */
> > +	state_field =3D appleib_find_hid_field(hdev, HID_USAGE_SENSOR_ALS,
> > +					    HID_USAGE_SENSOR_PROP_REPORT_STATE);
> > +	illum_field =3D appleib_find_hid_field(hdev, HID_USAGE_SENSOR_ALS,
> > +					     HID_USAGE_SENSOR_LIGHT_ILLUM);
> > +	if (!state_field || !illum_field)
> > +		return -ENODEV;
> > +
> > +	if (als_dev->hid_dev) {
> > +		dev_warn(als_dev->log_dev,
> > +			 "Found duplicate ambient light sensor - ignoring\n");

I'll bite.  So how can this actually happen?  What fundamentally breaks in
your model if there really are two?  Can you fix whatever that is so
as to drop this handling?

> > +		return -EBUSY;
> > +	}
> > +
> > +	dev_info(als_dev->log_dev, "Found ambient light sensor\n"); =20
>=20
> in general avoid logging for the OK case, it just clutters the log
>=20
> > +
> > +	/* initialize device */
> > +	als_dev->hid_dev =3D hdev;
> > +	als_dev->cfg_report =3D state_field->report;
> > +	als_dev->illum_field =3D illum_field;
> > +
> > +	als_dev->cur_hysteresis =3D APPLEALS_DEF_CHANGE_SENS;
> > +	als_dev->cur_sensitivity =3D APPLEALS_DEF_CHANGE_SENS;
> > +	appleals_config_sensor(als_dev, false, als_dev->cur_sensitivity);
> > +
> > +	rc =3D appleals_config_iio(als_dev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	return 0;

return appleals_config_iio(als_dev);

> > +}
> > +
> > +static void appleals_remove(struct hid_device *hdev)
> > +{
> > +	struct appleals_device *als_dev =3D
> > +		appleib_get_drvdata(hid_get_drvdata(hdev),
> > +				    &appleals_hid_driver);
> > + =20
>=20
> could be a lot less if devm_ were used?
>=20
> > +	if (als_dev->iio_dev) {
> > +		iio_device_unregister(als_dev->iio_dev);
> > +
> > +		iio_trigger_unregister(als_dev->iio_trig);
> > +		iio_trigger_free(als_dev->iio_trig);
> > +		als_dev->iio_trig =3D NULL;

I would be decidedly worried if you actually have any paths
where setting these to NULL do anything useful. By the time
we get here we should absolutely 'know' nothing will touch
these pointers.

It is these that are blocking Peter's suggestion of using
devm to clean all of this up automatically for you.

> > +
> > +		iio_triggered_buffer_cleanup(als_dev->iio_dev);
> > +		iio_device_free(als_dev->iio_dev);
> > +		als_dev->iio_dev =3D NULL;
> > +	}
> > +
> > +	als_dev->hid_dev =3D NULL;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int appleals_reset_resume(struct hid_device *hdev)
> > +{
> > +	struct appleals_device *als_dev =3D
> > +		appleib_get_drvdata(hid_get_drvdata(hdev),
> > +				    &appleals_hid_driver);
> > +
> > +	appleals_config_sensor(als_dev, als_dev->events_enabled,
> > +			       als_dev->cur_sensitivity);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static struct hid_driver appleals_hid_driver =3D {
> > +	.name =3D "apple-ib-als",
> > +	.probe =3D appleals_probe,
> > +	.remove =3D appleals_remove,
> > +	.event =3D appleals_hid_event,
> > +#ifdef CONFIG_PM
> > +	.reset_resume =3D appleals_reset_resume,
> > +#endif
> > +};
> > +
> > +static int appleals_platform_probe(struct platform_device *pdev)
> > +{
> > +	struct appleib_platform_data *pdata =3D pdev->dev.platform_data;
> > +	struct appleib_device *ib_dev =3D pdata->ib_dev;
> > +	struct appleals_device *als_dev;
> > +	int rc;
> > +
> > +	als_dev =3D kzalloc(sizeof(*als_dev), GFP_KERNEL);
> > +	if (!als_dev)
> > +		return -ENOMEM;
> > +
> > +	als_dev->ib_dev =3D ib_dev;
> > +	als_dev->log_dev =3D pdata->log_dev;
> > +
> > +	rc =3D appleib_register_hid_driver(ib_dev, &appleals_hid_driver, als_=
dev);

Hmm. This is all a bit odd.  We register a platform device, to call it's dr=
iver
so that it can then register another driver?  I'll let Lee comment on that =
but
it does seem overly complex.

> > +	if (rc) {
> > +		dev_err(als_dev->log_dev, "Error registering hid driver: %d\n",
> > +			rc);
> > +		goto error;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, als_dev);
> > +
> > +	return 0;
> > +
> > +error:
> > +	kfree(als_dev);
> > +	return rc;
> > +}
> > +
> > +static int appleals_platform_remove(struct platform_device *pdev)
> > +{
> > +	struct appleib_platform_data *pdata =3D pdev->dev.platform_data;
> > +	struct appleib_device *ib_dev =3D pdata->ib_dev;
> > +	struct appleals_device *als_dev =3D platform_get_drvdata(pdev);
> > +	int rc;
> > +
> > +	rc =3D appleib_unregister_hid_driver(ib_dev, &appleals_hid_driver);
> > +	if (rc) {
> > +		dev_err(als_dev->log_dev,
> > +			"Error unregistering hid driver: %d\n", rc);

Given you are going to have this error printing in every sub driver and
the text is totally generic, can you just move it into the core?

Same applies for similar cases above.

> > +		goto error;
> > +	}
> > +
> > +	kfree(als_dev);

Use managed allocation to avoid needing to clean this up?

> > +
> > +	return 0;
> > +
> > +error:
> > +	return rc;
> > +}
> > +
> > +static const struct platform_device_id appleals_platform_ids[] =3D {
> > +	{ .name =3D PLAT_NAME_IB_ALS },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, appleals_platform_ids);
> > +
> > +static struct platform_driver appleals_platform_driver =3D {
> > +	.id_table =3D appleals_platform_ids,
> > +	.driver =3D {
> > +		.name	=3D "apple-ib-als",
> > +	},
> > +	.probe =3D appleals_platform_probe,
> > +	.remove =3D appleals_platform_remove,
> > +};
> > +
> > +module_platform_driver(appleals_platform_driver);
> > +
> > +MODULE_AUTHOR("Ronald Tschal=C3=A4r");
> > +MODULE_DESCRIPTION("Apple iBridge ALS driver");
> > +MODULE_LICENSE("GPL v2");
> >  =20
>=20
