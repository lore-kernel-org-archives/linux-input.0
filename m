From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iio: accel: Add driver for the Analog Devices ADXL345
 3-axis accelerometer
Date: Sat, 4 Feb 2017 12:34:57 +0000
Message-ID: <d618b5d7-406f-36ab-9238-8c996f48addb@kernel.org>
References: <1485846776-7187-1-git-send-email-eraretuya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485846776-7187-1-git-send-email-eraretuya-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eva Rachel Retuya <eraretuya-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Daniel Baluta <daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alison Schofield <amsfield22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 31/01/17 07:12, Eva Rachel Retuya wrote:
> Add basic IIO support for the Analog Devices ADXL345 3-axis accelerometer.
> The datasheet can be found here:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Cc: Daniel Baluta <daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Alison Schofield <amsfield22-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Looks good to me.

So my only question is about how you would like to handle this.
Clearly you are actively working on the driver so would you prefer:

1) I take each step into the iio tree as and when it is ready (I think this one is)
2) We build up a full series of patches taking this driver all the way and then I take
that whole set at once.

I'm happy either way, it just depends on what works best for you.

Note that practically we've just missed the 4.11 merge window so have 3 months
until the next one.  In the meantime we can get stuff all ready to go and into 
linux-next etc.

Jonathan
> ---
> v1 Mailing list discussion:
> https://marc.info/?l=linux-iio&m=148533644407371&w=2 
> 
> Changes since v1:
> * Switch tag from RFC to PATCH
> From Jonathan's Review
> * Kconfig: add input driver's (adxl34x) selection state as dependency.
> From Peter's Review
> * Implement full-resolution mode scale.
> * Add comment stating FULL_RES is up to 13-bits in resolution.
> * Drop newline and le16_to_cpu usage in read_raw.
> * Allow the sensor to return to standby mode if iio_device_register fails.
> 
>  drivers/iio/accel/Kconfig   |  11 +++
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/adxl345.c | 194 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 206 insertions(+)
>  create mode 100644 drivers/iio/accel/adxl345.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index ef8401a..2308bac 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -5,6 +5,17 @@
>  
>  menu "Accelerometers"
>  
> +config ADXL345
> +	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
> +	depends on !(INPUT_ADXL34X=y || INPUT_ADXL34X=m)
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build support for the Analog Devices
> +	  ADXL345 3-axis digital accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adxl345.
> +
>  config BMA180
>  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 69fe8ed..618488d 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -3,6 +3,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_ADXL345) += adxl345.o
>  obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345.c
> new file mode 100644
> index 0000000..c34991f
> --- /dev/null
> +++ b/drivers/iio/accel/adxl345.c
> @@ -0,0 +1,194 @@
> +/*
> + * ADXL345 3-Axis Digital Accelerometer
> + *
> + * Copyright (c) 2017 Eva Rachel Retuya <eraretuya-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License. See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for ADXL345
> + * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
> + * 0x53 (ALT ADDRESS pin grounded)
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define ADXL345_REG_DEVID		0x00
> +#define ADXL345_REG_POWER_CTL		0x2D
> +#define ADXL345_REG_DATA_FORMAT		0x31
> +#define ADXL345_REG_DATAX0		0x32
> +#define ADXL345_REG_DATAY0		0x34
> +#define ADXL345_REG_DATAZ0		0x36
> +
> +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> +#define ADXL345_POWER_CTL_STANDBY	0x00
> +
> +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
> +#define ADXL345_DATA_FORMAT_2G		0
> +#define ADXL345_DATA_FORMAT_4G		1
> +#define ADXL345_DATA_FORMAT_8G		2
> +#define ADXL345_DATA_FORMAT_16G		3
> +
> +#define ADXL345_DEVID			0xE5
> +
> +/*
> + * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> + * in all g ranges.
> + *
> + * At +/- 16g with 13-bit resolution, scale is computed as:
> + * (16 + 16) * 9.81 / (2^13 - 1) = 0.0383
> + */
> +static const int adxl345_uscale = 38300;
> +
> +struct adxl345_data {
> +	struct i2c_client *client;
> +	u8 data_range;
> +};
> +
> +#define ADXL345_CHANNEL(reg, axis) {					\
> +	.type = IIO_ACCEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.address = reg,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +}
> +
> +static const struct iio_chan_spec adxl345_channels[] = {
> +	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
> +	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
> +	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
> +};
> +
> +static int adxl345_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Data is stored in adjacent registers:
> +		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
> +		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
> +		 */
> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(ret, 12);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = adxl345_uscale;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info adxl345_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= adxl345_read_raw,
> +};
> +
> +static int adxl345_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct adxl345_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, ADXL345_REG_DEVID);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading device ID: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != ADXL345_DEVID) {
> +		dev_err(&client->dev, "Invalid device ID: %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	/* Enable full-resolution mode */
> +	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_DATA_FORMAT,
> +					data->data_range);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to set data range: %d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->info = &adxl345_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = adxl345_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> +
> +	/* Enable measurement mode */
> +	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> +					ADXL345_POWER_CTL_MEASURE);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to enable measurement mode: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "iio_device_register failed: %d\n", ret);
> +		i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> +					  ADXL345_POWER_CTL_STANDBY);
> +	}
> +
> +	return ret;
> +}
> +
> +static int adxl345_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct adxl345_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> +					 ADXL345_POWER_CTL_STANDBY);
> +}
> +
> +static const struct i2c_device_id adxl345_i2c_id[] = {
> +	{ "adxl345", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> +
> +static struct i2c_driver adxl345_driver = {
> +	.driver = {
> +		.name	= "adxl345",
> +	},
> +	.probe		= adxl345_probe,
> +	.remove		= adxl345_remove,
> +	.id_table	= adxl345_i2c_id,
> +};
> +
> +module_i2c_driver(adxl345_driver);
> +
> +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> 
