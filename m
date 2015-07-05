From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC_v2 4/4] HID: hid-sony: Add IIO support for DualShock4 Controller
Date: Sun, 05 Jul 2015 15:01:04 +0100
Message-ID: <559938A0.1000708@kernel.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org> <1435105830-2297-5-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435105830-2297-5-git-send-email-simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 24/06/15 01:30, Simon Wood wrote:
A couple of trivial bits and no sign off.
> ---
>  drivers/hid/hid-sony.c | 87 +++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 79 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index ce0526d..f1c1a16 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -62,7 +62,7 @@
>  				DUALSHOCK4_CONTROLLER)
>  #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
>  #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
> -#define SONY_IIO_SUPPORT SIXAXIS_CONTROLLER
> +#define SONY_IIO_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
>  
>  #define MAX_LEDS 4
>  
> @@ -848,13 +848,16 @@ struct sony_sc {
>  #if IS_BUILTIN(CONFIG_IIO) || \
>  	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
>  	struct iio_dev *indio_dev;
> -	__u16 last_data[3];
> +	__s16 last_data[6];
>  };
>  
>  enum sony_iio_axis {
>  	AXIS_ACC_X,
>  	AXIS_ACC_Y,
>  	AXIS_ACC_Z,
> +	AXIS_GYRO_X,
> +	AXIS_GYRO_Y,
> +	AXIS_GYRO_Z,
>  };
>  
>  static void sony_iio_trigger_work(struct irq_work *work);
> @@ -863,7 +866,7 @@ struct sony_iio {
>  	struct sony_sc *sc;
>  	struct iio_trigger *trig;
>  
> -	u8 buff[16];		/* 3x 16-bit + padding + timestamp */
> +	u8 buff[24];		/* 6x 16-bit + padding + timestamp */
>  	struct irq_work work;
>  #endif
>  };
> @@ -1095,6 +1098,25 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>  	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
>  			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
>  			&& rd[0] == 0x11 && size == 78)) {
> +#if IS_BUILTIN(CONFIG_IIO) || \
> +	(IS_MODULE(CONFIG_IIO) && IS_MODULE(CONFIG_HID_SONY))
> +		int offset = (sc->quirks & DUALSHOCK4_CONTROLLER_USB) ? 13 : 15;
> +
Run checkpatch over the patches.  Spaces around the +s
> +		sc->last_data[AXIS_ACC_X] = (rd[offset+7] << 8) + rd[offset+6];
> +		sc->last_data[AXIS_ACC_Y] = (rd[offset+9] << 8) + rd[offset+8];
> +		sc->last_data[AXIS_ACC_Z] = (rd[offset+11] << 8) + rd[offset+10];
> +
> +		sc->last_data[AXIS_GYRO_X] = (rd[offset+1] << 8) + rd[offset];
> +		sc->last_data[AXIS_GYRO_Y] = (rd[offset+3] << 8) + rd[offset+2];
> +		sc->last_data[AXIS_GYRO_Z] = (rd[offset+5] << 8) + rd[offset+4];
> +
> +		if (sc->indio_dev) {
> +			struct sony_iio *data;
> +
> +			data = iio_priv(sc->indio_dev);
> +			sony_iio_trigger_work(&data->work);
> +		}
> +#endif
>  		dualshock4_parse_report(sc, rd, size);
>  	}
>  
> @@ -1827,6 +1849,7 @@ static int sony_iio_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_ACCEL:
> +		case IIO_ANGL_VEL:
>  			*val = data->sc->last_data[chan->address];
>  			return IIO_VAL_INT;
>  		default:
> @@ -1835,8 +1858,17 @@ static int sony_iio_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_ACCEL:
> -			*val = 0;	/* 9.80665/117 = 0.084540086 */
> -			*val2 = 84540;
> +			if (data->sc->quirks & SIXAXIS_CONTROLLER) {
> +				*val = 0;	/* 9.80665/117 = 0.084540086 */
> +				*val2 = 84540;
> +			} else if (data->sc->quirks & DUALSHOCK4_CONTROLLER) {
> +				*val = 0;	/* 9.80665/8192 = 0.001197101 */
> +				*val2 = 1197;
> +			}
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_ANGL_VEL:
> +			*val = 0;	/* 0.001 */
> +			*val2 = 1000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
> @@ -1844,7 +1876,13 @@ static int sony_iio_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_ACCEL:
> -			*val = -512;
> +			if (data->sc->quirks & SIXAXIS_CONTROLLER)
> +				*val = -512;
> +			else if (data->sc->quirks & DUALSHOCK4_CONTROLLER)
> +				*val = 0;
> +			return IIO_VAL_INT;
> +		case IIO_ANGL_VEL:
> +			*val = 0;
>  			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
> @@ -1871,6 +1909,23 @@ static int sony_iio_read_raw(struct iio_dev *indio_dev,
>  	},                                                              \
>  }
>  
> +#define SONY_GYRO_CHANNEL(_axis) {                                      \
> +	.type = IIO_ANGL_VEL,                                           \
> +	.modified = 1,                                                  \
> +	.channel2 = IIO_MOD_##_axis,                                    \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                   \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
> +		BIT(IIO_CHAN_INFO_OFFSET),                              \
> +	.address = AXIS_GYRO_##_axis,                                   \
> +	.scan_index = AXIS_GYRO_##_axis,                                \
> +	.scan_type = {                                                  \
> +		.sign = 's',                                            \
> +		.realbits = 16,                                         \
> +		.storagebits = 16,                                      \
> +		.shift = 0,                                             \
Drop the specification of shift as unnecesary.
> +	},                                                              \
> +}
> +
>  static const struct iio_chan_spec sony_sixaxis_channels[] = {
>  	SONY_ACC_CHANNEL(X),
>  	SONY_ACC_CHANNEL(Y),
> @@ -1878,6 +1933,16 @@ static const struct iio_chan_spec sony_sixaxis_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static const struct iio_chan_spec sony_dualshock4_channels[] = {
> +	SONY_ACC_CHANNEL(X),
> +	SONY_ACC_CHANNEL(Y),
> +	SONY_ACC_CHANNEL(Z),
> +	SONY_GYRO_CHANNEL(X),
> +	SONY_GYRO_CHANNEL(Y),
> +	SONY_GYRO_CHANNEL(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(6),
> +};
> +
>  static const struct iio_info sony_iio_info = {
>  	.read_raw = &sony_iio_read_raw,
>  	.driver_module = THIS_MODULE,
> @@ -1943,8 +2008,14 @@ static int sony_iio_probe(struct sony_sc *sc)
>  	indio_dev->name = dev_name(&hdev->dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
>  	indio_dev->info = &sony_iio_info;
> -	indio_dev->channels = sony_sixaxis_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(sony_sixaxis_channels);
> +
> +	if (sc->quirks & SIXAXIS_CONTROLLER) {
> +		indio_dev->channels = sony_sixaxis_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(sony_sixaxis_channels);
> +	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
> +		indio_dev->channels = sony_dualshock4_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(sony_dualshock4_channels);
> +	}
>  
>  	data->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
>  		indio_dev->id);
> 
