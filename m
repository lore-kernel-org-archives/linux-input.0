From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [RFC_v2 1/4] HID: hid-sony: Add basic IIO support for SixAxis
 Controller
Date: Sun, 05 Jul 2015 14:49:20 +0100
Message-ID: <559935E0.6030107@kernel.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>	<1435105830-2297-2-git-send-email-simon@mungewell.org> <20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59908 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbbGENtY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Jul 2015 09:49:24 -0400
In-Reply-To: <20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>, linux-iio@vger.kernel.org

On 24/06/15 10:13, Antonio Ospite wrote:
> On Tue, 23 Jun 2015 18:30:27 -0600
> Simon Wood <simon@mungewell.org> wrote:
> 
>> ---
>>  drivers/hid/hid-sony.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 152 insertions(+), 1 deletion(-)
>>
> 
> Hi Simon, I don't know much about the IIO API, I just have some generic
> comments.
> 
>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
>> index 6ca96ce..c4686e3 100644
>> --- a/drivers/hid/hid-sony.c
>> +++ b/drivers/hid/hid-sony.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/list.h>
>>  #include <linux/idr.h>
>>  #include <linux/input/mt.h>
>> +#include <linux/iio/iio.h>
>>  
>>  #include "hid-ids.h"
>>  
>> @@ -54,6 +55,7 @@
>>  				DUALSHOCK4_CONTROLLER)
>>  #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
>>  #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
>> +#define SONY_IIO_SUPPORT SIXAXIS_CONTROLLER
>>  
>>  #define MAX_LEDS 4
>>  
>> @@ -835,6 +837,22 @@ struct sony_sc {
>>  	__u8 led_delay_on[MAX_LEDS];
>>  	__u8 led_delay_off[MAX_LEDS];
>>  	__u8 led_count;
>> +
>> +#if IS_BUILTIN(CONFIG_IIO) || \
>> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
> 
> This check can be factored out, just define a HAVE_IIO constant when it
> passes and check for that. This is mainly for readability, it
> avoids having to read the condition over and over.
> 
>> +	struct iio_dev *indio_dev;
>> +	__u16 last_data[3];
>> +};
>> +
>> +enum sony_iio_axis {
>> +	AXIS_ACC_X,
>> +	AXIS_ACC_Y,
>> +	AXIS_ACC_Z,
>> +};
>> +
>> +struct sony_iio {
>> +	struct sony_sc *sc;
>> +#endif
>>  };
>>  
>>  static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
>> @@ -843,7 +861,6 @@ static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
>>  	*rsize = sizeof(sixaxis_rdesc);
>>  	return sixaxis_rdesc;
>>  }
>> -
> 
> unrelated change, which you undo in patch 2 anyway :)
> 
>>  static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
>>  			     unsigned int *rsize)
>>  {
>> @@ -1047,6 +1064,12 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>>  		swap(rd[45], rd[46]);
>>  		swap(rd[47], rd[48]);
>>  
>> +#if IS_BUILTIN(CONFIG_IIO) || \
>> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
>> +		sc->last_data[AXIS_ACC_X] = (rd[42] << 8) + rd[41];
>> +		sc->last_data[AXIS_ACC_Y] = (rd[44] << 8) + rd[43];
>> +		sc->last_data[AXIS_ACC_Z] = (rd[46] << 8) + rd[45];
>> +#endif
>>  		sixaxis_parse_report(sc, rd, size);
>>  	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
>>  			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
>> @@ -1769,6 +1792,114 @@ static void sony_battery_remove(struct sony_sc *sc)
>>  	sc->battery_desc.name = NULL;
>>  }
>>  
>> +#if IS_BUILTIN(CONFIG_IIO) || \
>> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
>> +
>> +static int sony_iio_read_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan,
>> +			      int *val, int *val2,
>> +			      long mask)
>> +{
>> +	struct sony_iio *data = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +			*val = data->sc->last_data[chan->address];
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +			*val = 0;	/* 9.80665/117 = 0.084540086 */
>> +			*val2 = 84540;
> 
> I guess 9.80665 is 'g', but is the 117 taken from the accelerometer
> datasheet? What is it? And BTW I get 9.80665/117 = 0.083817521
> 
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +			*val = -512;
>> +			return IIO_VAL_INT;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +#define SONY_ACC_CHANNEL(_axis) {                                       \
>> +	.type = IIO_ACCEL,                                              \
>> +	.modified = 1,                                                  \
>> +	.channel2 = IIO_MOD_##_axis,                                    \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                   \
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
>> +		BIT(IIO_CHAN_INFO_OFFSET),                              \
>> +	.address = AXIS_ACC_##_axis,                                    \
>> +}
>> +
>> +static const struct iio_chan_spec sony_sixaxis_channels[] = {
>> +	SONY_ACC_CHANNEL(X),
>> +	SONY_ACC_CHANNEL(Y),
>> +	SONY_ACC_CHANNEL(Z),
>> +};
>> +
>> +static const struct iio_info sony_iio_info = {
>> +	.read_raw = &sony_iio_read_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static int sony_iio_probe(struct sony_sc *sc)
>> +{
>> +	struct hid_device *hdev = sc->hdev;
>> +	struct iio_dev *indio_dev;
>> +	struct sony_iio *data;
>> +	int ret;
>> +
>> +	indio_dev = iio_device_alloc(sizeof(*data));
> 
> In general for new code the devm_ variants are preferred, but I am
> not sure in this case, maybe others have comments about that?
Absolutely for the allocation.   No ordering issues with this one.
> 
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	sc->indio_dev = indio_dev;
>> +	data = iio_priv(indio_dev);
>> +	data->sc = sc;
>> +
>> +	indio_dev->dev.parent = &hdev->dev;
>> +	indio_dev->name = dev_name(&hdev->dev);
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &sony_iio_info;
>> +	indio_dev->channels = sony_sixaxis_channels;
>> +	indio_dev->num_channels = 3;
>> +
>> +	ret = iio_device_register(indio_dev);
> 
> if you used the devm_ variant here and in the other patches, the cleanup
> below and the sony_iio_remove() function could go away.
I haven't checked this driver, but rule of thumb for this one is that, if there
is any other related cleanup done without using devm functions then you should
not use the devm_iio_device_register variant as it will mean something has been
cleaned up BEFORE we remove the userspace interfaces that might need it.

> 
>> +	if (ret < 0) {
>> +		hid_err(hdev, "Unable to register iio device\n");
>> +		goto err;
>> +	}
>> +	return 0;
>> +
>> +err:
>> +	kfree(indio_dev);
>> +	sc->indio_dev = NULL;
>> +	return ret;
>> +}
>> +
>> +static void sony_iio_remove(struct sony_sc *sc)
>> +{
>> +	if (!sc->indio_dev)
>> +		return;
>> +
>> +	iio_device_unregister(sc->indio_dev);
>> +	kfree(sc->indio_dev);
>> +	sc->indio_dev = NULL;
>> +}
>> +#endif
>> +
>>  /*
>>   * If a controller is plugged in via USB while already connected via Bluetooth
>>   * it will show up as two devices. A global list of connected controllers and
>> @@ -2073,6 +2204,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  		}
>>  	}
>>  
>> +#if IS_BUILTIN(CONFIG_IIO) || \
>> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
>> +	if (sc->quirks & SONY_IIO_SUPPORT) {
>> +		ret = sony_iio_probe(sc);
>> +		if (ret < 0)
>> +			goto err_stop;
>> +	}
>> +#endif
>> +
>>  	if (sc->quirks & SONY_FF_SUPPORT) {
>>  		ret = sony_init_ff(sc);
>>  		if (ret < 0)
>> @@ -2087,6 +2227,11 @@ err_stop:
>>  		sony_leds_remove(sc);
>>  	if (sc->quirks & SONY_BATTERY_SUPPORT)
>>  		sony_battery_remove(sc);
>> +#if IS_BUILTIN(CONFIG_IIO) || \
>> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
>> +	if (sc->quirks & SONY_IIO_SUPPORT)
>> +		sony_iio_remove(sc);
>> +#endif
>>  	sony_cancel_work_sync(sc);
>>  	kfree(sc->output_report_dmabuf);
>>  	sony_remove_dev_list(sc);
>> @@ -2107,6 +2252,12 @@ static void sony_remove(struct hid_device *hdev)
>>  		sony_battery_remove(sc);
>>  	}
>>  
>> +#if IS_BUILTIN(CONFIG_IIO) || \
>> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
>> +	if (sc->quirks & SONY_IIO_SUPPORT)
>> +		sony_iio_remove(sc);
>> +#endif
>> +
>>  	sony_cancel_work_sync(sc);
>>  
>>  	kfree(sc->output_report_dmabuf);
>> -- 
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

