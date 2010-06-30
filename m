From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC][PATCH]add Honeywell hmc5843 3-Axis Magnetometer (digital
 compass) driver.
Date: Wed, 30 Jun 2010 20:52:05 +0100
Message-ID: <4C2BA065.8040903@cam.ac.uk>
References: <0680EC522D0CC943BC586913CF3768C003B3553F73@dbde02.ent.ti.com> <0680EC522D0CC943BC586913CF3768C003B3602F54@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:33593 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab0F3Tt4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 15:49:56 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3602F54@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "sfking@fdwdc.com" <sfking@fdwdc.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

Welcome to iio!

This is only an initial pass.. I haven't read the datasheet yet!

I think your email client has eaten the tabs, so please fix this
before resending.  There are also a few suspiciously long lines
implying the need to run checkpatch over this and fix everything
it throws up.

A fair number of questions / comments below, but they are all
fairly trivial.  

> Adding support for the Honeywell HMC5843. The interface to the device is i2c.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/staging/iio/magnetometer/Kconfig   |   17 +
>  drivers/staging/iio/magnetometer/Makefile  |    5 +
>  drivers/staging/iio/magnetometer/hmc5843.c |  499 ++++++++++++++++++++++++++++
>  3 files changed, 521 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/magnetometer/Kconfig
>  create mode 100644 drivers/staging/iio/magnetometer/Makefile
>  create mode 100644 drivers/staging/iio/magnetometer/hmc5843.c
> 
> diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
> new file mode 100644
> index 0000000..6beda8c
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/Kconfig
> @@ -0,0 +1,17 @@
> +#
> +# Magnetometer sensors
> +#
> +comment "Magnetometer sensors"
Single blank line probably...
> +
> +
> +config SENSORS_HMC5843
> +       tristate "Honeywell HMC5843 3-Axis Magnetometer"
> +       depends on I2C && SYSFS
loose the sysfs as it should be handled before this menu option is seen

> +#      select INPUT_POLLDEV
left over commented to be removed.

> +       help
> +         Say Y here to add support for the Honeywell HMC 5843 3-Axis
> +         Magnetometer (digital compass).
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called hmc5843
> +
> diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/iio/magnetometer/Makefile
> new file mode 100644
> index 0000000..f9bfb2e
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for industrial I/O Magnetometer sensors
> +#
> +
> +obj-$(CONFIG_SENSORS_HMC5843)  += hmc5843.o
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> new file mode 100644
> index 0000000..fc3dda9
> --- /dev/null
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -0,0 +1,499 @@
> +/*  Copyright (c) 2010  Shubhrajyoti Datta <shubhrajyoti@ti.com>
> +
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> +*/
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
To make life easy when we merge iio it would be great to group 
all the iio headers together.  Good practice anyway to group
headers where it makes sense.
> +#include "../iio.h"
> +#include <linux/types.h>
> +#include "../sysfs.h"
> +#include "magnet.h"
> +
> +#define HMC5843_I2C_ADDRESS                    0x1E
> +
> +#define HMC5843_CONFIG_REG_A                   0x00
> +#define HMC5843_CONFIG_REG_B                   0x01
> +#define HMC5843_MODE_REG                       0x02
> +#define HMC5843_DATA_OUT_X_MSB_REG             0x03
> +#define HMC5843_DATA_OUT_X_LSB_REG             0x04
> +#define HMC5843_DATA_OUT_Y_MSB_REG             0x05
> +#define HMC5843_DATA_OUT_Y_LSB_REG             0x06
> +#define HMC5843_DATA_OUT_Z_MSB_REG             0x07
> +#define HMC5843_DATA_OUT_Z_LSB_REG             0x08
> +#define HMC5843_STATUS_REG                     0x09
> +#define HMC5843_ID_REG_A                       0x0A
> +#define HMC5843_ID_REG_B                       0x0B
> +#define HMC5843_ID_REG_C                       0x0C
> +
> +
> +#define HMC5843_ID_REG_LENGTH                  0x03
> +#define HMC5843_ID_STRING                      "H43"
> +
> +/*
> + * Range settings in  (+-)Ga
> + * */
> +#define RANGE_GAIN_OFFSET                      0x05
> +
> +#define        RANGE_0_7                               0x00
> +#define        RANGE_1_0                               0x01 /* default */
> +#define        RANGE_1_5                               0x02
> +#define        RANGE_2_0                               0x03
> +#define        RANGE_3_2                               0x04
> +#define        RANGE_3_8                               0x05
> +#define        RANGE_4_5                               0x06
> +#define        RANGE_6_5                               0x07 /* Not recommended */
> +
> +/*
> + * Device status
> + */
> +#define        DATA_READY                              0x01
> +#define        DATA_OUTPUT_LOCK                        0x02
> +#define        VOLTAGE_REGULATOR_ENABLED               0x04
> +
> +/*
> + * Mode register configuration
> + */
> +#define        MODE_CONVERSION_CONTINUOUS              0x00
> +#define        MODE_CONVERSION_SINGLE                  0x01
> +#define        MODE_IDLE                               0x02
> +#define        MODE_SLEEP                              0x03
> +
> +/* Minimum Data Output Rate in 1/10 Hz  */
> +#define RATE_OFFSET                            0x02
> +#define        RATE_5                                  0x00
> +#define        RATE_10                                 0x01
> +#define        RATE_20                                 0x02
> +#define        RATE_50                                 0x03
> +#define        RATE_100                                0x04
> +#define        RATE_200                                0x05
> +#define        RATE_500                                0x06
> +#define        RATE_NOT_USED                           0x07
> +
> +/*
> + * Device Configutration
> + */
> +#define        CONF_NORMAL                             0x00
> +#define        CONF_POSITIVE_BIAS                      0x01
> +#define        CONF_NEGATIVE_BIAS                      0x02
> +#define        CONF_NOT_USED                           0x03
> +
> +static const int regval_to_counts_per_mg[] = {
> +       1620,   /* RANGE_0_7 */
> +       1300,
> +       970,
> +       780,
> +       530,
> +       460,
> +       390,
> +       280     /* RANGE_6_5 */
> +};
> +static const int regval_to_input_field_mg[] = {
> +       700,
> +       1000,
> +       1500,
> +       2000,
> +       3200,
> +       3800,
> +       4500,
> +       6500
> +};
> +
> +/* Addresses to scan: 0x1E */
> +static const unsigned short normal_i2c[] = { HMC5843_I2C_ADDRESS,
> +                                                       I2C_CLIENT_END };
> +
> +/* Each client has this additional data */
> +struct hmc5843_data {
> +       struct iio_dev  *indio_dev;
> +       u8              rate;
> +       u8              meas_conf;
> +       u8              operating_mode;
> +       u8              range;
> +       s16             data[3];
> +};
> +
I think a bit of simple function reordering should remove necessity
for this function def.
> +static void hmc5843_init_client(struct i2c_client *client);
> +
> +static s32 hmc5843_set_operating_mode(struct i2c_client *client,
> +                                      u8 operating_mode)
> +{
> +       /* The lower two bits contain the current conversion mode */
> +       return i2c_smbus_write_byte_data(client,
> +                                       HMC5843_MODE_REG,
> +                                       (operating_mode & 0x03));
> +}
> +
> +/* API for setting the measurmet configuration to
bonus space before comma
> + * Normal , Positive bias and Negitive bias
> + */
Can you give more details on this please?  Does this have a predictable
effect on what one needs to do to work out actual numbers in userspace
from the raw values the driver is producing?
> +static s32 hmc5843_set_meas_conf(struct i2c_client *client,
> +                                     u8 meas_conf)
> +{
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       u8 reg_val;
> +       reg_val = (meas_conf & 0x03) |  (data->rate << RATE_OFFSET);
> +       return  i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
> +}
> +
Please avoid magic numbers.  What you want is a pair of attributes:

* sampling_frequency_available which is a constant string listing
of those frequencies that are available (in hz).
* sampling_frequency which then matches against the actual value
list and figures out what the internal representation is.

I'm afraid rigorous inforcement of trying to avoid magic numbers
is vital if we are ever going to have general userspace code.
> +static s32 hmc5843_set_rate(struct i2c_client *client,
> +                               u8 rate)
> +{
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       u8 reg_val;
nitpick: line break here please
> +       reg_val = (data->meas_conf) |  (rate << RATE_OFFSET);
> +       if (rate >= RATE_NOT_USED) {
> +               dev_err(&client->dev,
> +                       "This data output rate is not supported \n");
> +               return -EINVAL;
> +       }
> +       return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
> +}
> +
> +static ssize_t hmc5843_read_measurement(struct device *dev,
> +               struct device_attribute *attr,
> +               char *buf)
> +{
nitpick: move comment up to above the function.
> +       /* Return the measurement value from the  specified channel */
> +       struct i2c_client *client = to_i2c_client(dev);
> +       s16 coordinate_val;
> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +       s32 result;
nitpick: New line after defs and before code.
> +       result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> +       while (!(result & DATA_READY))
> +               result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> +
> +       result = i2c_smbus_read_word_data(client, this_attr->address);
> +       if (result > 0) {
 as coordinate_val is an s16 which not type cast to that?
> +               coordinate_val  = (int)swab16((u16)result);
curious line break below...
> +               return sprintf(buf, "%d\n",
> +                               coordinate_val);
So, this is a raw value? (e.g. it will need scaling in userspace)
> +       }
> +       return result;
> +}
> +static IIO_DEV_ATTR_MAGN_X(hmc5843_read_measurement,
> +               HMC5843_DATA_OUT_X_MSB_REG);
> +static IIO_DEV_ATTR_MAGN_Y(hmc5843_read_measurement,
> +               HMC5843_DATA_OUT_Y_MSB_REG);
> +static IIO_DEV_ATTR_MAGN_Z(hmc5843_read_measurement,
> +               HMC5843_DATA_OUT_Z_MSB_REG);
> +
This definitely need some documentation please!
Also, as per other functions, please prefix name with hmc5843
to make name clashes extremely unlikely.  Applies to quite a few
of the functions that follow.
> +static ssize_t show_operating_mode(struct device *dev,
> +                                       struct device_attribute *attr,
> +                                       char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       return sprintf(buf, "%d\n", data->operating_mode);
> +}
nitpick: new line between functions please.
> +static ssize_t set_operating_mode(struct device *dev,
> +                               struct device_attribute *attr,
> +                               const char *buf,
> +                               size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +       unsigned long operating_mode = 0;
> +       s32 status;
> +
> +       strict_strtoul(buf, 10, &operating_mode);
> +       dev_dbg(dev, "set Conversion mode to %lu\n", operating_mode);
> +       if (operating_mode > MODE_SLEEP)
> +                       return -EINVAL;
> +
> +       status = i2c_smbus_write_byte_data(client, this_attr->address,
> +                                       operating_mode);
> +       if (status)
> +               return -EINVAL;
> +
> +       data->operating_mode = operating_mode;
> +       return count;
> +}
> +static IIO_DEVICE_ATTR(operating_mode,
> +                       S_IWUSR | S_IRUGO,
> +                       show_operating_mode,
> +                       set_operating_mode,
> +                       HMC5843_MODE_REG);
> +
> +static ssize_t show_measurement_configuration(struct device *dev,
> +                                               struct device_attribute *attr,
> +                                               char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       return sprintf(buf, "%d\n", data->meas_conf);
> +}
> +
> +static ssize_t set_measurement_configuration(struct device *dev,
> +                                               struct device_attribute *attr,
> +                                               const char *buf,
> +                                               size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       unsigned long meas_conf = 0;
> +       strict_strtoul(buf, 10, &meas_conf);
> +       dev_dbg(dev, "set mode to %lu\n", meas_conf);

What about other errors from i2c_smbus call?
> +       if (hmc5843_set_meas_conf(client, meas_conf) == -EINVAL)
> +               return -EINVAL;
> +       data->meas_conf = meas_conf;
I wonder if you need some locking to ensure the cached values are equal
to those on the device (nothing prevents 2 calls to the function at the
same time).
> +       return count;
> +}
Please provide some documentation for this.
> +static IIO_DEVICE_ATTR(meas_conf,
> +                       S_IWUSR | S_IRUGO,
> +                       show_measurement_configuration,
> +                       set_measurement_configuration,
> +                       0);
> +

Moving this one to next to set_rate will give more readable code.
> +static ssize_t show_rate(struct device *dev,
> +                       struct device_attribute *attr, char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
Please consider error from i2c_smbus call.
> +       u32 rate = (i2c_smbus_read_byte_data(client,  this_attr->address) & 0x1C) >> RATE_OFFSET;
> +       return sprintf(buf, "%d\n", rate);
> +}
> +
> +static ssize_t set_rate(struct device *dev, struct device_attribute *attr,
> +                       const char *buf, size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       unsigned long rate = 0;
> +       strict_strtoul(buf, 10, &rate);
please handle return value.
> +
> +       dev_dbg(dev, "set rate to %lu\n", rate);
> +       if (hmc5843_set_rate(client, rate) == -EINVAL)
> +               return -EINVAL;
> +       data->rate = rate;
> +       return count;
> +}
sampling_frequency please. No idea why we went with that, but
there are quite a few drivers using it now.
> +static IIO_DEVICE_ATTR(rate, S_IWUSR | S_IRUGO, show_rate,
> +                       set_rate, HMC5843_CONFIG_REG_A);
> +
> +static ssize_t show_range(struct device *dev,
> +                               struct device_attribute *attr,
> +                               char *buf)
> +{
> +       u8 range;
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +
> +       range = data->range;
I know this occurs elsewhere in the subsystem (it's on my
todo list to cull them!), as per hwmon whose abi we lifted
please don't output units, it just makes userspace code
more fiddly.

> +       return sprintf(buf, " %dmGa\n", regval_to_input_field_mg[range]);
> +}
> +

Can you describe this interface please?  Looks suspiciously
like some magic numbers to me which is curious as you seem to have
nice real numbers for the show range value above.
You may want a magn_xyz_range_available listing the options,
or to round up to an available value.  Actually if it applies to
all channels, then supress the xyz.  The abi only allows all or
one for each channel (which may effect each other).
> +static ssize_t set_range(struct device *dev,
> +                       struct device_attribute *attr,
> +                       const char *buf,
> +                       size_t count)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       unsigned long range = 0;
> +
> +       strict_strtoul(buf, 10, &range);
> +       dev_dbg(dev, "set range to %lu\n", range);
> +
> +       if (range > RANGE_6_5)
> +               return -EINVAL;
> +
> +       data->range = range;
> +       range = range << RANGE_GAIN_OFFSET;
> +       if (i2c_smbus_write_byte_data(client, this_attr->address, range) ==
> +                                                                       -EINVAL)
> +               return -EINVAL;
> +
> +       return count;
> +}
> +

To match similar bits of the abi, can we call this one magn_range
as it applies to all magn channels.
> +static IIO_DEVICE_ATTR(magn_xyz_range,
> +                       S_IWUSR | S_IRUGO,
> +                       show_range,
> +                       set_range,
> +                       HMC5843_CONFIG_REG_B);
> +
> +static ssize_t show_gain(struct device *dev,
> +                       struct device_attribute *attr,
> +                       char *buf)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       return sprintf(buf, "%d\n", regval_to_counts_per_mg[data->range]);
> +}

Same here. If it applies to all, supress the channel names. So magn_gain
> +static IIO_DEVICE_ATTR(magn_xyz_gain, S_IRUGO, show_gain, NULL , 0);
> +
> +
> +static struct attribute *hmc5843_attributes[] = {
> +       &iio_dev_attr_meas_conf.dev_attr.attr,
> +       &iio_dev_attr_operating_mode.dev_attr.attr,
> +       &iio_dev_attr_rate.dev_attr.attr,
> +       &iio_dev_attr_magn_xyz_range.dev_attr.attr,
> +       &iio_dev_attr_magn_xyz_gain.dev_attr.attr,
> +       &iio_dev_attr_magn_x_raw.dev_attr.attr,
> +       &iio_dev_attr_magn_y_raw.dev_attr.attr,
> +       &iio_dev_attr_magn_z_raw.dev_attr.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group hmc5843_group = {
> +       .attrs = hmc5843_attributes,
> +};
> +
> +static int hmc5843_detect(struct i2c_client *client,
> +                         struct i2c_board_info *info)
> +{
> +       unsigned char id_str[HMC5843_ID_REG_LENGTH];
> +
> +       if (client->addr != HMC5843_I2C_ADDRESS)
> +               return -ENODEV;
> +
> +       if (i2c_smbus_read_i2c_block_data(client, HMC5843_ID_REG_A,
> +                               HMC5843_ID_REG_LENGTH, id_str)
> +                       != HMC5843_ID_REG_LENGTH)
> +               return -ENODEV;
> +
> +       if (0 != strncmp(id_str, HMC5843_ID_STRING, HMC5843_ID_REG_LENGTH))
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
one new line please
> +
> +static int hmc5843_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct hmc5843_data *data;
> +       int err = 0;
> +
> +       data = kzalloc(sizeof(struct hmc5843_data), GFP_KERNEL);
> +       if (!data) {
> +               err = -ENOMEM;
> +               goto exit;
> +       }
> +
> +       /* default settings at probe */
> +
> +       data->meas_conf = CONF_NORMAL;
> +       data->range = RANGE_1_0;
> +       data->operating_mode = MODE_CONVERSION_CONTINUOUS;
> +
> +       i2c_set_clientdata(client, data);
> +
> +       /* Initialize the HMC5843 chip */
> +       hmc5843_init_client(client);
> +
> +       data->indio_dev = iio_allocate_device();
> +       if (!data->indio_dev) 
if this fails, please return -ENOMEM;  Currently you return sucess!
> +               goto exit_free;
> +       data->indio_dev->attrs = &hmc5843_group;
> +       data->indio_dev->dev.parent = &client->dev;
> +       data->indio_dev->dev_data = (void *)(data);
> +       data->indio_dev->driver_module = THIS_MODULE;
> +       data->indio_dev->modes = INDIO_DIRECT_MODE;
> +       err = iio_device_register(data->indio_dev);
> +       if (err)
> +               goto exit_free;
> +       /* Register sysfs hooks */
please use the iio register stuff for this as per other drivers.
(basically set data->indio_dev->attrs = &hmc5843_group before iio_device_register
call and it will all be handled for you.
> +       err = sysfs_create_group(&client->dev.kobj, &hmc5843_group);
> +       if (err)
> +               goto exit_free2;
> +
> +       return 0;
> +exit_free2:
> +       iio_device_unregister(data->indio_dev);
> +exit_free:
> +       kfree(data);
> +exit:
> +       return err;
> +}
> +
> +static int hmc5843_remove(struct i2c_client *client)
> +{
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +        /*  sleep mode to save power */
> +       hmc5843_set_operating_mode(client, MODE_SLEEP);
> +       iio_device_unregister(data->indio_dev);

 make the change above and you won't need to do this
> +       sysfs_remove_group(&client->dev.kobj, &hmc5843_group);
> +       kfree(i2c_get_clientdata(client));
> +       return 0;
> +}
> +
> +/* Called when we have found a new HMC5843. */
> +static void hmc5843_init_client(struct i2c_client *client)
> +{
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       hmc5843_set_meas_conf(client, data->meas_conf);
> +       hmc5843_set_rate(client, data->rate);
> +       hmc5843_set_operating_mode(client, data->operating_mode);
> +       i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_B, data->range);
> +       pr_info("HMC5843 initialized\n");
> +}
> +
> +static int hmc5843_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +       hmc5843_set_operating_mode(client, MODE_SLEEP);
> +       pr_info("HMC5843 suspended\n");
> +       return 0;
> +}
> +
> +static int hmc5843_resume(struct i2c_client *client)
> +{
> +       struct hmc5843_data *data = i2c_get_clientdata(client);
> +       hmc5843_set_operating_mode(client, data->operating_mode);
probably uncessary noise in debug for an in mainline driver
(obviously very handy during development!)
> +       pr_info("HMC5843 resumed\n");
> +       return 0;
> +}
> +
> +static const struct i2c_device_id hmc5843_id[] = {
> +       { "hmc5843", 0 },
> +       { }
> +};
> +
> +static struct i2c_driver hmc5843_driver = {
> +       .driver = {
> +               .name   = "hmc5843",
> +       },
> +       .id_table       = hmc5843_id,
> +       .probe          = hmc5843_probe,
> +       .remove         = hmc5843_remove,
> +       .detect         = hmc5843_detect,
> +       .address_list   = normal_i2c,
> +       .suspend        = hmc5843_suspend,
> +       .resume         = hmc5843_resume,
> +};
> +
> +static int __init hmc5843_init(void)
> +{
loose this debug printk
> +       printk(KERN_INFO "init!\n");
> +       return i2c_add_driver(&hmc5843_driver);
> +}
> +
> +static void __exit hmc5843_exit(void)
> +{
loose this debug printk
> +       printk(KERN_INFO "exit!\n");
> +       i2c_del_driver(&hmc5843_driver);
> +}
> +
> +MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com");
> +MODULE_DESCRIPTION("HMC5843 driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(hmc5843_init);
> +module_exit(hmc5843_exit);
> --
> 1.5.4.7
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

