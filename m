From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Tue, 15 Mar 2011 15:14:41 +0530
Message-ID: <4D7F3509.80401@ti.com>
References: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46683 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755998Ab1COJou (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 05:44:50 -0400
Received: by mail-yw0-f42.google.com with SMTP id 1so246620ywh.1
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2011 02:44:49 -0700 (PDT)
In-Reply-To: <20110309134552.32007.52489.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Hello Joseph / Alan,
Some minor comments.

On Wednesday 09 March 2011 07:17 PM, Alan Cox wrote:
> From: Joseph Lai<joseph_lai@wistron.com>
>
> This driver is registered as an input device with sysfs control
> interface, but it still can output 3 axes data in non-interrupt mode.
>
> This is primarily an input device but can also be used as for other things.
> It thus exposes the power control (so you can keep power on when you want) and
> x/y/z co-ordinates directly.
>
> If IIO ever gets upstream the assumption is that the non-input side would move
> to IIO.
>
> Signed-off-by: Joseph Lai<joseph_lai@wistron.com>
>
> [Cleaned up PM_RUNTIME defines]
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/input/misc/Kconfig   |   10 +
>   drivers/input/misc/Makefile  |    1
>   drivers/input/misc/mpu3050.c |  493 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 504 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/input/misc/mpu3050.c
>
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 3b595b8..db92371 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -464,4 +464,14 @@ config INPUT_BMA023
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called bma023.
>
> +config INPUT_MPU3050
> +	tristate "MPU3050 Triaxial gyroscope sensor"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to support InvenSense MPU3050
> +	  connected via an I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mpu3050.
> +
>   endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index aa2fd2e..216824c 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
>   obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
>   obj-$(CONFIG_INPUT_M68K_BEEP)		+= m68kspkr.o
>   obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+= max8925_onkey.o
> +obj-$(CONFIG_INPUT_MPU3050)		+= mpu3050.o
>   obj-$(CONFIG_INPUT_PCAP)		+= pcap_keys.o
>   obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
>   obj-$(CONFIG_INPUT_PCF8574)		+= pcf8574_keypad.o
> diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
> new file mode 100644
> index 0000000..86fe397
> --- /dev/null
> +++ b/drivers/input/misc/mpu3050.c
Can we name it mpu3050_i2c . The thought in my mind is that the mpu3000 
looks similar and it supports spi.
May be mpu3200 is also worth a look.

> @@ -0,0 +1,493 @@
> +/*
> + * mpu3050.c - MPU3050 Tri-axis gyroscope driver
> + *
> + * Copyright (C) 2011 Wistron Co.Ltd
> + * Joseph Lai<joseph_lai@wistron.com>
> + *
> + * This program is based on bma023.c.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + */
> +
> +#include<linux/module.h>
> +#include<linux/init.h>
> +#include<linux/interrupt.h>
> +#include<linux/platform_device.h>
> +#include<linux/mutex.h>
> +#include<linux/err.h>
> +#include<linux/i2c.h>
> +#include<linux/input.h>
> +#include<linux/delay.h>
> +#include<linux/slab.h>
> +#include<linux/pm_runtime.h>
> +
> +#define MPU3050_CHIP_ID_REG	0x00
> +#define MPU3050_CHIP_ID		0x69
> +#define MPU3050_XOUT_H		0x1D
> +#define MPU3050_PWR_MGM		0x3E
> +#define MPU3050_PWR_MGM_POS	6
> +#define MPU3050_PWR_MGM_MASK	0x40
> +
> +#define MPU3050_AUTO_DELAY	1000
> +
> +#define MPU3050_MIN_VALUE	-32768
> +#define MPU3050_MAX_VALUE	32767
> +
> +struct axis_data {
> +	s16 x;
> +	s16 y;
> +	s16 z;
> +};
> +
> +struct mpu3050_sensor {
> +	struct i2c_client *client;
> +	struct device *dev;
> +	struct input_dev *idev;
> +	struct mutex lock;
> +};
> +
> +/**
> + *	mpu3050_xyz_read_reg	-	read the axes values
> + *	@buffer: provide register addr and get register
> + *	@length: length of register
> + *
> + *	Reads the register values in one transaction or returns a negative
> + *	error code on failure/
> + */
> +static int mpu3050_xyz_read_reg(struct i2c_client *client,
> +			       u8 *buffer, int length)
> +{
> +	struct i2c_msg msg[] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.len = 1,
> +			.buf = buffer,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = length,
> +			.buf = buffer,
> +		},
> +	};
> +	return i2c_transfer(client->adapter, msg, 2);
> +}
> +
> +/**
> + *	mpu3050_read_xyz	-	get co-ordinates from device
> + *	@client: i2c address of sensor
> + *	@coords: co-ordinates to update
> + *
> + *	Return the converted X Y and Z co-ordinates from the sensor device
> + */
> +static void mpu3050_read_xyz(struct i2c_client *client,
> +				struct axis_data *coords)
> +{
> +	u8 buffer[6];
> +	buffer[0] = MPU3050_XOUT_H;
> +	mpu3050_xyz_read_reg(client, buffer, 6);
Could we check the return type . Other wise the errors reported by the 
i2c transfer gets lost.
> +	coords->x = buffer[0];
> +	coords->x = coords->x<<  8 | buffer[1];
> +	coords->y = buffer[2];
> +	coords->y = coords->y<<  8 | buffer[3];
> +	coords->z = buffer[4];
> +	coords->z = coords->z<<  8 | buffer[5];
> +	dev_dbg(&client->dev, "%s: x %d, y %d, z %d\n", __func__,
> +					coords->x, coords->y, coords->z);
> +}
> +
> +/**
> + *	mpu3050_set_power_mode	-	set the power mode
> + *	@client: i2c client for the sensor
> + *	@val: value to switch on/off of power, 1: normal power, 0: low power
> + *
> + *	Put device to normal-power mode or low-power mode.
> + */
> +static void mpu3050_set_power_mode(struct i2c_client *client, u8 val)
> +{
> +	u8 value;
> +	value = i2c_smbus_read_byte_data(client, MPU3050_PWR_MGM);
> +	value = (value&  ~MPU3050_PWR_MGM_MASK) |
> +		(((val<<  MPU3050_PWR_MGM_POS)&  MPU3050_PWR_MGM_MASK) ^
> +		 MPU3050_PWR_MGM_MASK);
> +	i2c_smbus_write_byte_data(client, MPU3050_PWR_MGM, value);
<snip>
> +/**
> + *	mpu3050_probe	-	device detection callback
> + *	@client: i2c client of found device
> + *	@id: id match information
> + *
> + *	The I2C layer calls us when it believes a sensor is present at this
> + *	address. Probe to see if this is correct and to validate the device.
> + *
> + *	If present install the relevant sysfs interfaces and input device.
> + */
> +static int __devinit mpu3050_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct mpu3050_sensor *sensor;
> +	int ret;
> +	sensor = kzalloc(sizeof(struct mpu3050_sensor), GFP_KERNEL);
> +	if (!sensor) {
> +		dev_err(&client->dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +	sensor->dev =&client->dev;
> +	sensor->client = client;
> +	i2c_set_clientdata(client, sensor);
> +
> +	ret = i2c_smbus_read_byte_data(client, MPU3050_CHIP_ID_REG);
> +	if (ret<  0) {
> +		dev_err(&client->dev, "failed to detect device\n");
> +		goto failed_free;
> +	}
> +	if (ret != MPU3050_CHIP_ID) {
> +		dev_err(&client->dev, "unsupported chip id\n");
> +		goto failed_free;
> +	}
> +
> +	mutex_init(&sensor->lock);
> +
> +	ret = sysfs_create_group(&client->dev.kobj,&mpu3050_group);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to create attribute group\n");
> +		goto failed_free;
> +	}
> +
> +	pm_runtime_set_active(&client->dev);
> +
> +	ret = mpu3050_register_input_device(sensor);
> +	if (ret)
> +		dev_err(&client->dev, "only provide sysfs\n");
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev, MPU3050_AUTO_DELAY);
> +
> +	dev_info(&client->dev, "%s registered\n", id->name);
> +	return 0;
> +
> +failed_free:
> +	kfree(sensor);
> +	return ret;
> +}
> +
> +/**
> + *	bma023_remove	-	remove a sensor
A typo here maybe.
> + *	@client: i2c client of sensor being removed
> + *
> + *	Our sensor is going away, clean up the resources.
> + */
> +static int __devexit mpu3050_remove(struct i2c_client *client)
> +{
> +	struct mpu3050_sensor *sensor = i2c_get_clientdata(client);
> +
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +
> +	if (sensor->idev)
> +		mpu3050_unregister_input_device(sensor);
> +	sysfs_remove_group(&client->dev.kobj,&mpu3050_group);
> +	kfree(sensor);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +/**
> + *	mpu3050_suspend		-	called on device suspend
> + *	@client: i2c client of sensor
> + *	@mesg: actual suspend type
> + *
> + *	Put the device into sleep mode before we suspend the machine.
> + */
> +static int mpu3050_suspend(struct i2c_client *client, pm_message_t mesg)
> +{
> +	mpu3050_set_power_mode(client, 0);
> +	return 0;
> +}
> +
> +/**
> + *	mpu3050_resume		-	called on device resume
> + *	@client: i2c client of sensor
> + *
> + *	Put the device into powered mode on resume.
> + */
> +static int mpu3050_resume(struct i2c_client *client)
> +{
> +	mpu3050_set_power_mode(client, 1);
> +	msleep(100);  /* wait for gyro chip resume */
> +	return 0;
> +}
> +#else
> +#define mpu3050_suspend NULL
> +#define mpu3050_resume NULL
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME
> +static int mpu3050_runtime_suspend(struct device *dev)
> +{
> +	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
> +	mpu3050_set_power_mode(sensor->client, 0);
> +	return 0;
> +}
> +
> +static int mpu3050_runtime_resume(struct device *dev)
> +{
> +	struct mpu3050_sensor *sensor = dev_get_drvdata(dev);
> +	mpu3050_set_power_mode(sensor->client, 1);
Could we use the #define here.
> +	msleep(100);  /* wait for gyro chip resume */
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mpu3050_pm = {
> +	.runtime_suspend = mpu3050_runtime_suspend,
> +	.runtime_resume  = mpu3050_runtime_resume,
> +};
> +#endif
> +
> +static const struct i2c_device_id mpu3050_ids[] = {
> +	{ "mpu3050", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mpu3050_ids);
> +
> +static struct i2c_driver mpu3050_i2c_driver = {
> +	.driver	= {
> +		.name	= "mpu3050",
> +#ifdef CONFIG_PM_RUNTIME
> +		.pm		=&mpu3050_pm,
> +#endif
> +	},
> +	.probe		= mpu3050_probe,
> +	.remove		= __devexit_p(mpu3050_remove),
> +	.suspend	= mpu3050_suspend,
> +	.resume		= mpu3050_resume,
Could we move these to .pm suspend resume.Then since we do the same 
things may we can can consider having only one function.
And populating them in the respective
does

+static const struct dev_pm_ops mpu3050_pm = {
+	.runtime_suspend = mpu3050_runtime_suspend,
+	.runtime_resume  = mpu3050_runtime_resume,
+	.suspend	=  mpu3050_runtime_suspend,
+	.resume		= mpu3050_runtime_resume,
+};


-	.suspend	= mpu3050_suspend,
-	.resume		= mpu3050_resume,

Work for you?
> +	.id_table	= mpu3050_ids,
> +};
> +
> +static int __init mpu3050_init(void)
> +{
> +	return i2c_add_driver(&mpu3050_i2c_driver);
> +}
> +module_init(mpu3050_init);
> +
> +static void __exit mpu3050_exit(void)
> +{
> +	i2c_del_driver(&mpu3050_i2c_driver);
> +}
> +module_exit(mpu3050_exit);
> +
> +MODULE_AUTHOR("Wistron Corp.");
> +MODULE_DESCRIPTION("MPU3050 Tri-axis gyroscope driver");
> +MODULE_LICENSE("GPL");
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

