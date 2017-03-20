From: "Song, Hongyan" <hongyan.song@intel.com>
Subject: RE: [PATCH v2] iio: hid: Add humidity sensor support
Date: Mon, 20 Mar 2017 06:06:52 +0000
Message-ID: <AE3E3DFA698D6144A7445C92D1D41E2F10BE1C0F@SHSMSX103.ccr.corp.intel.com>
References: <1489659448-35429-1-git-send-email-hongyan.song@intel.com>
 <7439dd08-c003-59ff-9762-2979924dc81a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:54833 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750717AbdCTGG7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Mar 2017 02:06:59 -0400
In-Reply-To: <7439dd08-c003-59ff-9762-2979924dc81a@kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

Hi Jonathan,
	Sorry for missed peter's comments in last version change, I have updated i=
t including with your new comments in a new patch version "patch v3",
please comments if there are something which my understanding is not right.=
=20

Thanks!

BR
Song Hongyan=20



-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]=20
Sent: Monday, March 20, 2017 12:37 AM
To: Song, Hongyan <hongyan.song@intel.com>; linux-input@vger.kernel.org; li=
nux-iio@vger.kernel.org
Cc: jikos@kernel.org; Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v2] iio: hid: Add humidity sensor support

On 16/03/17 10:17, Song Hongyan wrote:
> Environmental humidity sensor is a hid defined sensor, it shows raw=20
> humidity measurement of air.
>=20
> More information can be found in:
> http://www.usb.org/developers/hidpage/HUTRR39b.pdf
>=20
> According to IIO ABI definition, humidityrelative data output unit is=20
> milli percent. Add the unit convert from percent to milli percent.
>=20
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Hi Song,

Main issue here is you didn't address one of Peter's comments.
There is a nasty race condition caused by the combination of devm_ and othe=
r elements in the later part of probe.  That will cause a race on removal, =
with the userspace interfaces removed after the device has become non funct=
ional.

Please fix that.  A few suggestions on how inline.  Other trivial bits and =
pieces.  Looking pretty good on the whole.

Thanks,

Jonathan
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c |   2 +
>  drivers/iio/humidity/Kconfig                       |  14 +
>  drivers/iio/humidity/Makefile                      |   3 +
>  drivers/iio/humidity/hid-sensor-humidity.c         | 316 +++++++++++++++=
++++++
>  include/linux/hid-sensor-ids.h                     |   4 +
>  5 files changed, 339 insertions(+)
>  create mode 100644 drivers/iio/humidity/hid-sensor-humidity.c
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c=20
> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 7afdac42..4f280ae 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -62,6 +62,8 @@
>  	{HID_USAGE_SENSOR_TIME_TIMESTAMP, 0, 1000000000, 0},
>  	{HID_USAGE_SENSOR_TIME_TIMESTAMP, HID_USAGE_SENSOR_UNITS_MILLISECOND,
>  		1000000, 0},
> +
> +	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
>  };
> =20
>  static int pow_10(unsigned power)
> diff --git a/drivers/iio/humidity/Kconfig=20
> b/drivers/iio/humidity/Kconfig index 912477d..14b9ce4 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -36,6 +36,20 @@ config HDC100X
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called hdc100x.
> =20
> +config HID_SENSOR_HUMIDITY
> +	tristate "HID Environmental humidity sensor"
> +	depends on HID_SENSOR_HUB
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select HID_SENSOR_IIO_COMMON
> +	select HID_SENSOR_IIO_TRIGGER
> +	help
> +	  Say yes here to build support for the HID SENSOR
> +	  humidity driver
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called hid-sensor-humidity.
> +
>  config HTS221
>  	tristate "STMicroelectronics HTS221 sensor Driver"
>  	depends on (I2C || SPI)
> diff --git a/drivers/iio/humidity/Makefile=20
> b/drivers/iio/humidity/Makefile index a6850e4..be0dede 100644
> --- a/drivers/iio/humidity/Makefile
> +++ b/drivers/iio/humidity/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_AM2315) +=3D am2315.o
>  obj-$(CONFIG_DHT11) +=3D dht11.o
>  obj-$(CONFIG_HDC100X) +=3D hdc100x.o
> +obj-$(CONFIG_HID_SENSOR_HUMIDITY) +=3D hid-sensor-humidity.o
> =20
>  hts221-y :=3D hts221_core.o \
>  	    hts221_buffer.o
> @@ -15,3 +16,5 @@ obj-$(CONFIG_HTS221_SPI) +=3D hts221_spi.o
>  obj-$(CONFIG_HTU21) +=3D htu21.o
>  obj-$(CONFIG_SI7005) +=3D si7005.o
>  obj-$(CONFIG_SI7020) +=3D si7020.o
> +
> +ccflags-y +=3D -I$(srctree)/drivers/iio/common/hid-sensors
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c=20
> b/drivers/iio/humidity/hid-sensor-humidity.c
> new file mode 100644
> index 0000000..cbcb1b0
> --- /dev/null
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -0,0 +1,316 @@
> +/*
> + * HID Sensors Driver
> + * Copyright (c) 2017, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or=20
> +modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but=20
> +WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY=20
> +or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public=20
> +License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License=20
> +along with
> + * this program.
> + */
> +#include <linux/device.h>
> +#include <linux/hid-sensor-hub.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h> #include=20
> +<linux/iio/trigger_consumer.h> #include <linux/module.h> #include=20
> +<linux/platform_device.h>
> +
> +#include "hid-sensor-trigger.h"
> +
> +#define MODULE_NAME "humidity"
That's way too generic. Should be some reference to the fact it is from a h=
id sensor. It's also only used in one place in the code and funily enough n=
ot as the module name.  So just put it inline.

> +
> +struct hid_humidity_state {
> +	struct hid_sensor_common common_attributes;
> +	struct hid_sensor_hub_attribute_info humidity_attr;
> +	s32 humidity_data;
> +	int scale_pre_decml;
Could call it scale_integer, scale_fractional..  Not that important however=
.
> +	int scale_post_decml;
> +	int scale_precision;
> +	int value_offset;
> +};
> +
> +/* Channel definitions */
> +static const struct iio_chan_spec humidity_channels[] =3D {
> +	{
> +		.type =3D IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_HYSTERESIS),
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1)
> +};
> +
> +/* Adjust channel real bits based on report descriptor */ static void=20
> +humidity_adjust_channel_bit_mask(struct iio_chan_spec *channels,
> +					int channel, int size)
> +{
> +	channels[channel].scan_type.sign =3D 's';
> +	/* Real storage bits will change based on the report desc. */
> +	channels[channel].scan_type.realbits =3D size * 8;
> +	/* Maximum size of a sample to capture is s32 */
> +	channels[channel].scan_type.storagebits =3D sizeof(s32) * 8; }
> +
> +static int humidity_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type !=3D IIO_HUMIDITYRELATIVE)
> +			return -EINVAL;
> +		hid_sensor_power_state(&humid_st->common_attributes, true);
> +		*val =3D sensor_hub_input_attr_get_raw_value(
> +				humid_st->common_attributes.hsdev,
> +				HID_USAGE_SENSOR_HUMIDITY,
> +				HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
> +				humid_st->humidity_attr.report_id,
> +				SENSOR_HUB_SYNC);
> +		hid_sensor_power_state(&humid_st->common_attributes, false);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D humid_st->scale_pre_decml;
> +		*val2 =3D humid_st->scale_post_decml;
> +
> +		return humid_st->scale_precision;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D humid_st->value_offset;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return hid_sensor_read_samp_freq_value(
> +				&humid_st->common_attributes, val, val2);
> +
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		return hid_sensor_read_raw_hyst_value(
> +				&humid_st->common_attributes, val, val2);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int humidity_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return hid_sensor_write_samp_freq_value(
> +				&humid_st->common_attributes, val, val2);
> +
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		return hid_sensor_write_raw_hyst_value(
> +				&humid_st->common_attributes, val, val2);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info humidity_info =3D {
> +	.driver_module =3D THIS_MODULE,
> +	.read_raw =3D &humidity_read_raw,
> +	.write_raw =3D &humidity_write_raw,
> +};
> +
> +/* Callback handler to send event after all samples are received and=20
> +captured */ static int humidity_proc_event(struct hid_sensor_hub_device =
*hsdev,
> +				unsigned int usage_id, void *pdev) {
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> +
> +	if (atomic_read(&humid_st->common_attributes.data_ready))
> +		iio_push_to_buffers_with_timestamp(indio_dev,
> +					&humid_st->humidity_data,
> +					iio_get_time_ns(indio_dev));
> +
> +	return 0;
> +}
> +
> +/* Capture samples in local storage */ static int=20
> +humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
> +				unsigned int usage_id, size_t raw_len,
> +				char *raw_data, void *pdev)
> +{
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> +
> +	switch (usage_id) {
> +	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
> +		humid_st->humidity_data =3D *(s32 *)raw_data;
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/* Parse report which is specific to an usage id */ static int=20
> +humidity_parse_report(struct platform_device *pdev,
> +				struct hid_sensor_hub_device *hsdev,
> +				struct iio_chan_spec *channels,
> +				unsigned int usage_id,
> +				struct hid_humidity_state *st)
> +{
> +	int ret;
> +
> +	ret =3D sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
> +					usage_id,
> +					HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
> +					&st->humidity_attr);
> +	if (ret < 0)
> +		return ret;
> +
> +	humidity_adjust_channel_bit_mask(channels, 0,=20
> +st->humidity_attr.size);
> +
> +	st->scale_precision =3D hid_sensor_format_scale(
> +						HID_USAGE_SENSOR_HUMIDITY,
> +						&st->humidity_attr,
> +						&st->scale_pre_decml,
> +						&st->scale_post_decml);
> +
> +	/* Set Sensitivity field ids, when there is no individual modifier */
> +	if (st->common_attributes.sensitivity.index < 0)
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY,
> +			&st->common_attributes.sensitivity);
> +
> +	return ret;
> +}
> +
> +static struct hid_sensor_hub_callbacks humidity_callbacks =3D {
> +	.send_event =3D &humidity_proc_event,
> +	.capture_sample =3D &humidity_capture_sample, };
> +
> +/* Function to initialize the processing for usage id */ static int=20
> +hid_humidity_probe(struct platform_device *pdev) {
> +	static const char *name =3D MODULE_NAME;
> +	struct iio_dev *indio_dev;
> +	struct hid_humidity_state *humid_st;
> +	struct iio_chan_spec *humid_chans;
> +	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(&pdev->dev);
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*humid_st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	humid_st =3D iio_priv(indio_dev);
> +	humid_st->common_attributes.hsdev =3D hsdev;
> +	humid_st->common_attributes.pdev =3D pdev;
> +
> +	ret =3D hid_sensor_parse_common_attributes(hsdev,
> +					HID_USAGE_SENSOR_HUMIDITY,
> +					&humid_st->common_attributes);
> +	if (ret)
> +		return ret;
> +
> +	humid_chans =3D devm_kmemdup(&indio_dev->dev, humidity_channels,
> +					sizeof(humidity_channels), GFP_KERNEL);
> +	if (!humid_chans)
> +		return -ENOMEM;
> +
> +	ret =3D humidity_parse_report(pdev, hsdev, humid_chans,
> +				HID_USAGE_SENSOR_HUMIDITY, humid_st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->channels =3D humid_chans;
> +	indio_dev->num_channels =3D ARRAY_SIZE(humidity_channels);
> +	indio_dev->dev.parent =3D &pdev->dev;
> +	indio_dev->info =3D &humidity_info;
> +	indio_dev->name =3D name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev,
> +					&iio_pollfunc_store_time, NULL, NULL);
> +	if (ret)
> +		return ret;
> +
> +	atomic_set(&humid_st->common_attributes.data_ready, 0);
> +	ret =3D hid_sensor_setup_trigger(indio_dev, name,
> +				&humid_st->common_attributes);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	humidity_callbacks.pdev =3D pdev;
> +	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
> +					&humidity_callbacks);
> +	if (ret)
> +		goto error_remove_trigger;
> +
> +	ret =3D devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +	if (ret)
> +		goto error_remove_callback;

Peter raised this before and you haven't responded. Please make sure to add=
ress all feedback on a patch.  If you have reason not to make the recomende=
d changes / need further information then please reply to the original revi=
ew.

If you use devm_iio_device_register, then your userspace interfaces, come r=
emove time are exposed until after the end of hid_humitiy_remove.

This means you have a nasty race condition in which userspace can be access=
ing the chip after you have removed the callback and the trigger.

Basic rule of thumb is you can only used devm_ calls in probe until you hit=
 something that needs to be unwound.  After that you need to revert back to=
 non managed versions of everything.  Now it wouldn't be unreasonable perha=
ps to add devm_sensor_hub_register_callback and devm_hid_setup_trigger.  Wi=
th those two in place you could drop the remove entirely and let the manage=
d device code clean all of your probe up.  Up to you on whether you want to=
 take that on however, or would rather just use iio_device_register and exp=
licitly unregister it at the start of your remove funciton.

> +
> +	return ret;
> +
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
> +error_remove_trigger:
> +	hid_sensor_remove_trigger(&humid_st->common_attributes);
> +	return ret;
> +}
> +
> +/* Function to deinitialize the processing for usage id */ static int=20
> +hid_humidity_remove(struct platform_device *pdev) {
> +	struct hid_sensor_hub_device *hsdev =3D dev_get_platdata(&pdev->dev);
> +	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
> +
> +	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
> +	hid_sensor_remove_trigger(&humid_st->common_attributes);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id hid_humidity_ids[] =3D {
> +	{
> +		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
> +		.name =3D "HID-SENSOR-200032",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, hid_humidity_ids);
> +
> +static struct platform_driver hid_humidity_platform_driver =3D {
> +	.id_table =3D hid_humidity_ids,
> +	.driver =3D {
> +		.name	=3D "humidity-sensor",
This is perhaps too generic.  But if it's inline with the other hid sensors=
, I guess the boat has sailed!
> +		.pm	=3D &hid_sensor_pm_ops,
> +	},
> +	.probe		=3D hid_humidity_probe,
> +	.remove		=3D hid_humidity_remove,
> +};
> +module_platform_driver(hid_humidity_platform_driver);
> +
> +MODULE_DESCRIPTION("HID Environmental humidity sensor");=20
> +MODULE_AUTHOR("Song Hongyan <hongyan.song@intel.com>");=20
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/hid-sensor-ids.h=20
> b/include/linux/hid-sensor-ids.h index 30c7dc4..719c928 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -45,6 +45,10 @@
>  #define HID_USAGE_SENSOR_DATA_ATMOSPHERIC_PRESSURE              0x200430
>  #define HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE                   0x200431
> =20
> +/* humidity */
> +#define HID_USAGE_SENSOR_HUMIDITY                              0x200032
> +#define HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY                  0x200433
> +
>  /* Gyro 3D: (200076) */
>  #define HID_USAGE_SENSOR_GYRO_3D				0x200076
>  #define HID_USAGE_SENSOR_DATA_ANGL_VELOCITY			0x200456
>=20

