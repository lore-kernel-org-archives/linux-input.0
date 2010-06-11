From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] [PATCH] Adding support for the BMP085 driver support.
Date: Fri, 11 Jun 2010 11:03:57 +0100
Message-ID: <4C120A0D.5090803@cam.ac.uk>
References: <0680EC522D0CC943BC586913CF3768C003B3401B10@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:59122 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab0FKKEr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 06:04:47 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3401B10@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 06/11/10 08:07, Datta, Shubhrajyoti wrote:
> The interface of the device is I2C. The driver is based on an initial driver written by Christoph Mair.
Hi.

This isn't even vaguely a human input device (for
reference of others, it is a barometric pressure
sensor).  Hence why input?  To my mind either
this goes in drivers/misc or drivers/staging/iio
(probably only as a minimal driver as we don't need
buffering or events for this one - see the kxsd9 for
an example.)

I've done a quick review anyway. Other than a few
quirks, it's a nice clean driver so beyond cleanups
my only objection is this shouldn't be in misc.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
> ---
>  drivers/input/misc/bmp085.c |  371 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 371 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/misc/bmp085.c
> 
> diff --git a/drivers/input/misc/bmp085.c b/drivers/input/misc/bmp085.c
> new file mode 100644
> index 0000000..84e81ef
> --- /dev/null
> +++ b/drivers/input/misc/bmp085.c
> @@ -0,0 +1,371 @@
> +/*  Copyright (c) 2009  Christoph Mair <christoph.mair@gmail.com>
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
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/input-polldev.h>
> +
> +#define BMP085_I2C_ADDRESS			0x77
> +#define BMP085_CALIBRATION_DATA_START	0xAA
> +#define BMP085_CALIBRATION_DATA_LENGTH	22
> +#define BMP085_CHIP_ID_REG			0xD0
> +#define BMP085_VERSION_REG			0xD1
> +#define BMP085_CHIP_ID				0x55
> +#define BMP085_CTRL_REG			0xF4
> +#define BMP085_TEMP_REG			0x2E
> +#define BMP085_PRESSURE_OSRS0		0x34
> +#define BMP085_MSB 				0xF6
> +#define BMP085_LSB 				0xF7
> +#define BMP085_XLSB 				0xF8
> +#define BMP085_TEMP_CONV_TIME		5	
> +
> +struct bmp085_calibration_data {
> +	s16 AC1, AC2, AC3;
> +	u16 AC4, AC5, AC6;
> +	s16 B1, B2;
> +	s16 MB, MC, MD;
> +};
> +
> +/* Each client has this additional data */
> +struct bmp085_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	struct input_polled_dev *ipdev;
> +	unsigned char version;
why store this?  It is only used in the probe.

> +	struct bmp085_calibration_data calibration;
> +	unsigned char oversampling_setting;
> +	unsigned long next_temp_measurement;
as noted below what you put in here looks invalid an you
don't use it for anything.

> +	long b6; /* calculated temperature correction coefficient */
> +};
> +
> +static void bmp085_init_client(struct i2c_client *client);
> +
> +static s32 bmp085_get_calibration_data(struct i2c_client *client)
> +{
> +	u8 tmp[BMP085_CALIBRATION_DATA_LENGTH];
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	struct bmp085_calibration_data *cali = &(data->calibration);
> +	s32 status = i2c_smbus_read_i2c_block_data(client,
> +				BMP085_CALIBRATION_DATA_START,
> +				BMP085_CALIBRATION_DATA_LENGTH, tmp);
> +
> +	cali->AC1 =  (tmp[0] << 8) | tmp[1];
> +	cali->AC2 =  (tmp[2] << 8) | tmp[3];
> +	cali->AC3 =  (tmp[4] << 8) | tmp[5];
> +	cali->AC4 =  (tmp[6] << 8) | tmp[7];
> +	cali->AC5 =  (tmp[8] << 8) | tmp[9];
> +	cali->AC6 = (tmp[10] << 8) | tmp[11];
> +
> +	/*parameters B1,B2*/
> +	cali->B1 =  (tmp[12] << 8) | tmp[13];
> +	cali->B2 =  (tmp[14] << 8) | tmp[15];
> +
> +	/*parameters MB,MC,MD*/
> +	cali->MB =  (tmp[16] << 8) | tmp[17];
> +	cali->MC =  (tmp[18] << 8) | tmp[19];
> +	cali->MD =  (tmp[20] << 8) | tmp[21];
> +	return status;
> +}
> +
> +static s32 bmp085_get_temperature(struct i2c_client *client)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	u16 temperature = 0x00;
> +	u8 tmp[2];
> +	s32 status = i2c_smbus_write_byte_data(client, BMP085_CTRL_REG,
> +						BMP085_TEMP_REG);
> +	if (status != 0) {
> +		dev_err(&client->dev, "bmp085: Error requesting\
> +				temperature measurement.\n");
> +		return status;
> +	}
> +	msleep(BMP085_TEMP_CONV_TIME);
> +
> +	i2c_smbus_read_i2c_block_data(client, BMP085_MSB, 2, tmp);
> +	/* next temperature measurement is needed in one second */
> +	data->next_temp_measurement = jiffies + 1;
umm. if you want one second then I'm fairly sure jiffies + 1
isn't going to give you it.  then again this is never used
anyway so get rid of it.

> +	temperature = (tmp[0] << 8) + tmp[1];
> +	pr_info("temperature: %u\n", temperature);
> +	return temperature;
> +}
> +
> +static s32 bmp085_read_pressure(struct i2c_client *client, u32 *pressure)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	u8 tmp[3];

why set this to zero?
> +	s32 status = 0;

why set this to zero?  you over write it anyway.
> +	*pressure = 0;
> +
> +	status = i2c_smbus_write_byte_data(client, BMP085_CTRL_REG,
> +		BMP085_PRESSURE_OSRS0 + (data->oversampling_setting<<6));
> +	if (status != 0)
> +		return status;
> +
> +	/* wait for the end of conversion */
> +	msleep(2+(3 << data->oversampling_setting));
> +
> +	status = i2c_smbus_read_i2c_block_data(client, BMP085_MSB, 0x03, tmp);

this comment either needs more info or it simply needs to say
what endianness the data has.
> +	/* swap positions to correct the MSB/LSB positions*/
> +	*pressure = (tmp[0] << 16) | (tmp[1] << 8) | tmp[2];
> +	*pressure = *pressure >> (8-data->oversampling_setting);
> +	return status;
> +}
> +
> +/* sysfs callbacks */
> +static ssize_t set_oversampling(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf,
> +				size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	data->oversampling_setting = simple_strtoul(buf, NULL, 10);
> +	if (data->oversampling_setting > 3)
> +		data->oversampling_setting = 3;
> +	return count;
> +}
> +
> +static ssize_t show_oversampling(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	return sprintf(buf, "%u\n", data->oversampling_setting);
> +}
> +static DEVICE_ATTR(oversampling, S_IWUSR | S_IRUGO,
> +	show_oversampling, set_oversampling);
> +
> +static void bmp085_read_temperature(struct i2c_client *client,  long *buf)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	struct bmp085_calibration_data *cali = &data->calibration;
> +
personally I'd be more inclined to keep to a cleaner C style
given this next line is calling a function (that is, define
these long's first then use them)
also note there ar no guarantees of the length of a long. Please
use explicit types s32 etc if you need a specific length.
> +	long raw_temp = bmp085_get_temperature(client);
> +	long x1 = ((raw_temp - cali->AC6) * cali->AC5) >> 15;
> +	long x2 = (cali->MC << 11) / (x1 + cali->MD);
> +	data->b6 = x1 + x2 - 4000;
> +	*buf = ((x1+x2+8) >> 4) ;
> +}
> +
> +static int bmp085_read_sensor(struct bmp085_data *bmp085,
> +					long *pressure,
> +					long *temp)
> +{
> +
> +	struct i2c_client *client = bmp085->client;
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	struct bmp085_calibration_data *cali = &data->calibration;
> +	long x1, x2, x3, b3;
> +	unsigned long b4, b7;
> +	long p;
> +	unsigned int raw_pressure;
> +	long raw_temp;
> +
> +	bmp085_read_temperature(client,  &raw_temp);
> +	*temp = raw_temp ;
> +	bmp085_read_pressure(client, &raw_pressure);
> +
> +	x1 = (data->b6 * data->b6) >> 12;
> +	x1 *= cali->B2;
> +	x1 >>= 11;
> +
> +	x2 = cali->AC2 * data->b6;
> +	x2 >>= 11;
> +
> +	x3 = x1 + x2;
> +
> +	b3 = (((((long)cali->AC1) * 4 + x3) <<
> +				data->oversampling_setting) + 2) >> 2;
> +
> +	x1 = (cali->AC3 * data->b6) >> 13;
> +	x2 = (cali->B1 * ((data->b6 * data->b6) >> 12)) >> 16;
> +	x3 = (x1 + x2 + 2) >> 2;
> +	b4 = (cali->AC4 * (unsigned long)(x3 + 32768)) >> 15;
> +
> +	b7 = ((unsigned long)raw_pressure - b3) *
> +				(50000 >> data->oversampling_setting);
> +	p = ((b7 < 0x80000000) ? ((b7 << 1) / b4) : ((b7 / b4) * 2));
> +
> +	x1 = p >> 8;
> +	x1 *= x1;
> +	x1 = (x1 * 3038) >> 16;
> +	x2 = (-7357 * p) >> 16;
> +	p += (x1 + x2 + 3791) >> 4;
> +	*pressure = p;
> +	return 0;
> +}
> +
Personally  I'd be inclined to just give this device
a sysfs interface and get rid of the input hooks.
> +static struct attribute *bmp085_attributes[] = {
> +	&dev_attr_oversampling.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bmp085_attr_group = {
> +	.attrs = bmp085_attributes,
> +};
> +
> +static void bmp085_poll(struct input_polled_dev *ipdev)
> +{
> +	struct bmp085_data *bmp085 = ipdev->private;
> +	long pressure_read, temperature;
> +
> +	mutex_lock(&bmp085->lock);
> +	if (!bmp085_read_sensor(bmp085, &pressure_read, &temperature)) {
> +		input_report_abs(ipdev->input, ABS_MISC, temperature);
gah. the lack of a suitable type for temperature should have been
a fairly strong hint that hwmon isn't the right place for this one.

> +		input_report_abs(ipdev->input, ABS_PRESSURE, pressure_read);
What exactly is abs_pressure defined as? I'm thinking it is meant to
be for pressure sensitive buttons not air pressure??

> +		input_sync(ipdev->input);
> +	}
> +	mutex_unlock(&bmp085->lock);
> +}
> +
> +static int __devinit bmp085_input_init(struct bmp085_data *bmp085)
> +{
> +	int status;
> +	struct input_polled_dev *ipdev;
> +
> +	ipdev = input_allocate_polled_device();
> +	if (!ipdev) {
> +		dev_dbg(&bmp085->client->dev, "error creating input device\n");
> +		return -ENOMEM;
> +	}
> +	ipdev->poll = bmp085_poll;
> +	ipdev->poll_interval = 1000; /* ms */
if you are limiting polling to once a second then definitely
makes sense to just go with a sysfs interface.

> +	ipdev->private = bmp085;
> +
> +	ipdev->input->name = "Bosch BMP085 Pressure Sensor";
> +	ipdev->input->phys = "bmp085/input0";
> +	ipdev->input->id.bustype = BUS_HOST;
> +
> +	set_bit(EV_ABS, ipdev->input->evbit);
> +
> +	input_set_abs_params(ipdev->input, ABS_PRESSURE, 70000, 110000, 0, 0);
> +	input_set_abs_params(ipdev->input, ABS_MISC, 0 , 650, 0, 0);
> +
> +	status = input_register_polled_device(ipdev);
> +	if (status) {
> +		dev_dbg(&bmp085->client->dev,
> +		"error registering input device\n");
> +	input_free_polled_device(ipdev);
> +	goto exit;
> +	}
> +
> +	bmp085->ipdev = ipdev;
> +exit:
> +	return status;
> +}
> +static int bmp085_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct bmp085_data *bmp085_data;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_dbg(&client->dev, "adapter doesn't support I2C\n");
> +		return -ENODEV;
> +	}
> +
> +	bmp085_data = kzalloc(sizeof(struct bmp085_data), GFP_KERNEL);
> +	if (!bmp085_data) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +	bmp085_data->client = client;
> +
> +	/* default settings after POR */
> +	bmp085_data->oversampling_setting = 0x00;
> +
> +	i2c_set_clientdata(client, bmp085_data);
> +
> +	/* Initialize the BMP085 chip */
> +	bmp085_init_client(client);
> +
> +	err = bmp085_input_init(bmp085_data);
> +	if (err)
> +		goto exit_free;
> +
> +	/* Register sysfs hooks */
> +	err = sysfs_create_group(&client->dev.kobj, &bmp085_attr_group);
> +	if (err)
> +		dev_err(&client->dev,
> +			"failed to create sysfs entries\n");
> +
> +	return 0;
> +
> +exit_free:
> +	kfree(bmp085_data);
> +exit:
> +	return err;
> +}
> +
> +static int bmp085_remove(struct i2c_client *client)
> +{
> +	struct bmp085_data *bmp085 = i2c_get_clientdata(client);
> +
> +	pr_info("bmp085 remove\n");
> +	sysfs_remove_group(&client->dev.kobj, &bmp085_attr_group);
> +	input_unregister_polled_device(bmp085->ipdev);
> +	kfree(bmp085);
> +	return 0;
> +}
> +
> +static void bmp085_init_client(struct i2c_client *client)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	bmp085_get_calibration_data(client);
> +	data->version = i2c_smbus_read_byte_data(client, BMP085_VERSION_REG);
> +	data->next_temp_measurement = 0;
> +	data->oversampling_setting = 3;
> +	mutex_init(&data->lock);
> +	pr_info("BMP085 ver. %d.%d initialized\n",
> +			(data->version & 0x0F), (data->version & 0xF0) >> 4);
> +}
> +
> +static const struct i2c_device_id bmp085_id[] = {
> +	{ "bmp085", 0 },
> +	{ }
> +};
> +
> +static struct i2c_driver bmp085_driver = {
> +	.driver = {
> +		.name	= "bmp085",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe		= bmp085_probe,
> +	.remove		= bmp085_remove,
> +	.id_table	= bmp085_id,
> +};
> +
> +static int __init bmp085_init(void)
> +{
> +	return i2c_add_driver(&bmp085_driver);
> +}
> +
> +static void __exit bmp085_exit(void)
> +{
> +	i2c_del_driver(&bmp085_driver);
> +}
> +
> +MODULE_AUTHOR("Christoph Mair, Shubhrajyoti");
> +MODULE_DESCRIPTION("BMP085 driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(bmp085_init);
> +module_exit(bmp085_exit);
> +

