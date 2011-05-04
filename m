From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH CORRECTED] Add a driver to support InvenSense mpu3050
 gyroscope chip.
Date: Wed, 04 May 2011 10:42:27 +0100
Message-ID: <4DC11F83.30707@cam.ac.uk>
References: <20110504091043.32677.62360.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:58434 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab1EDJkF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 05:40:05 -0400
In-Reply-To: <20110504091043.32677.62360.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On 05/04/11 10:11, Alan Cox wrote:
> (Forgot to refresh the patch before posting the last copy)
>=20
Hi Alan,

Given I didn't even notice the no irq error handling was wrong,
my Ack of this still stands ;) (assuming there are no other changes?)
> --
>=20
> From: Joseph Lai <joseph_lai@wistron.com>
>=20
> This driver is registered as an input device. An IRQ is required in t=
his
> basic driver configuration.
>=20
> Signed-off-by: Joseph Lai <joseph_lai@wistron.com>
> [Cleaned up PM_RUNTIME defines]
> [Revised version with corrected no IRQ error handling]
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>=20
>  drivers/input/misc/Kconfig   |   10 +
>  drivers/input/misc/Makefile  |    1=20
>  drivers/input/misc/mpu3050.c |  450 ++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 461 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/misc/mpu3050.c
>=20
>=20
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index f9cf088..ce6eed1 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -467,4 +467,14 @@ config INPUT_XEN_KBDDEV_FRONTEND
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called xen-kbdfront.
> =20
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
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefil=
e
> index e3f7984..c1a6917 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+=3D ixp4xx-beepe=
r.o
>  obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+=3D keyspan_remote.o
>  obj-$(CONFIG_INPUT_M68K_BEEP)		+=3D m68kspkr.o
>  obj-$(CONFIG_INPUT_MAX8925_ONKEY)	+=3D max8925_onkey.o
> +obj-$(CONFIG_INPUT_MPU3050)		+=3D mpu3050.o
>  obj-$(CONFIG_INPUT_PCAP)		+=3D pcap_keys.o
>  obj-$(CONFIG_INPUT_PCF50633_PMU)	+=3D pcf50633-input.o
>  obj-$(CONFIG_INPUT_PCF8574)		+=3D pcf8574_keypad.o
> diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu305=
0.c
> new file mode 100644
> index 0000000..f96b7bd
> --- /dev/null
> +++ b/drivers/input/misc/mpu3050.c
> @@ -0,0 +1,450 @@
> +/*
> + * mpu3050.c - MPU3050 Tri-axis gyroscope driver
> + *
> + * Copyright (C) 2011 Wistron Co.Ltd
> + * Joseph Lai <joseph_lai@wistron.com>
> + *
> + * Trimmed down by Alan Cox <alan@linux.intel.com> to produce this v=
ersion
> + *
> + * This is a 'lite' version of the driver, while we consider the rig=
ht way
> + * to present the other features to user space. In particular it req=
uires the
> + * device has an IRQ, and it only provides an input interface, so is=
 not much
> + * use for device orientation. A fuller version is available from th=
e Meego
> + * tree.
> + *
> + * This program is based on bma023.c.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
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
> + *	Reads the register values in one transaction or returns a negativ=
e
> + *	error code on failure.
> + */
> +static int mpu3050_xyz_read_reg(struct i2c_client *client,
> +			       u8 *buffer, int length)
> +{
> +	/* Annoying we can't make this const because the i2c layer doesn't
> +	   declare input buffers const */
> +	char cmd =3D MPU3050_XOUT_H;
> +	struct i2c_msg msg[] =3D {
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D 0,
> +			.len =3D 1,
> +			.buf =3D &cmd,
> +		},
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D I2C_M_RD,
> +			.len =3D length,
> +			.buf =3D buffer,
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
> + *	Return the converted X Y and Z co-ordinates from the sensor devic=
e
> + */
> +static int mpu3050_read_xyz(struct i2c_client *client,
> +				struct axis_data *coords)
> +{
> +	u16 buffer[3];
> +	int ret;
> +
> +	ret =3D mpu3050_xyz_read_reg(client, (u8 *)buffer, 6);
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "co-ordinate read failed\n");
> +		return ret;
> +	}
> +	coords->x =3D be16_to_cpu(buffer[0]);
> +	coords->y =3D be16_to_cpu(buffer[1]);
> +	coords->z =3D be16_to_cpu(buffer[2]);
> +	dev_dbg(&client->dev, "%s: x %d, y %d, z %d\n", __func__,
> +					coords->x, coords->y, coords->z);
> +	return 0;
> +}
> +
> +/**
> + *	mpu3050_set_power_mode	-	set the power mode
> + *	@client: i2c client for the sensor
> + *	@val: value to switch on/off of power, 1: normal power, 0: low po=
wer
> + *
> + *	Put device to normal-power mode or low-power mode.
> + */
> +static void mpu3050_set_power_mode(struct i2c_client *client, u8 val=
)
> +{
> +	u8 value;
> +	value =3D i2c_smbus_read_byte_data(client, MPU3050_PWR_MGM);
> +	value =3D (value & ~MPU3050_PWR_MGM_MASK) |
> +		(((val << MPU3050_PWR_MGM_POS) & MPU3050_PWR_MGM_MASK) ^
> +		 MPU3050_PWR_MGM_MASK);
> +	i2c_smbus_write_byte_data(client, MPU3050_PWR_MGM, value);
> +}
> +
> +/**
> + *	mpu3050_sample		-	read the mpu3050 and create an event
> + *	@sensor: MPU3050 sensor
> + *
> + *	Read a sample from the device and add it to the input layer event=
s.
> + *	We hold the sensor lock to keep the various I=C2=B2C transactions=
 apart.
> + */
> +static int mpu3050_sample(struct mpu3050_sensor *sensor)
> +{
> +	struct axis_data axis;
> +	int ret;
> +
> +	mutex_lock(&sensor->lock);
> +	ret =3D mpu3050_read_xyz(sensor->client, &axis);
> +	mutex_unlock(&sensor->lock);
> +
> +	if (ret =3D=3D 0) {
> +		input_report_abs(sensor->idev, ABS_X, axis.x);
> +		input_report_abs(sensor->idev, ABS_Y, axis.y);
> +		input_report_abs(sensor->idev, ABS_Z, axis.z);
> +		input_sync(sensor->idev);
> +	}
> +	return ret;
> +}
> +
> +/**
> + *	mpu3050_interrupt_thread	-	handle an IRQ
> + *	@irq: interrupt numner
> + *	@data: the sensor
> + *
> + *	Called by the kernel single threaded after an interrupt occurs. R=
ead
> + *	the sensor data and generate an input event for it.
> + */
> +static irqreturn_t mpu3050_interrupt_thread(int irq, void *data)
> +{
> +	mpu3050_sample(data);
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + *	mpu3050_input_open	-	called on input event open
> + *	@input: input dev of opened device
> + *
> + *	The input layer calls this function when input event is opened. T=
he
> + *	function will push the device to resume. Then, the device is read=
y
> + *	to provide data.
> + */
> +static int mpu3050_input_open(struct input_dev *input)
> +{
> +	struct mpu3050_sensor *sensor =3D input_get_drvdata(input);
> +	pm_runtime_get(sensor->dev);
> +	/* Ensure we have valid data for one shot users */
> +	mpu3050_sample(sensor);
> +	return 0;
> +}
> +
> +/**
> + *	mpu3050_input_close	-	called on input event close
> + *	@input: input dev of closed device
> + *
> + *	The input layer calls this function when input event is closed. T=
he
> + *	function will push the device to suspend.
> + */
> +static void mpu3050_input_close(struct input_dev *input)
> +{
> +	struct mpu3050_sensor *sensor =3D input_get_drvdata(input);
> +	pm_runtime_put(sensor->dev);
> +}
> +
> +
> +/**
> + *	mpu3050_unregister_input_device	-	remove input dev
> + *	@sensor: sensor to remove from input
> + *
> + *	Free the interrupt and input device for the sensor. We must free
> + *	the interrupt first
> + */
> +static void mpu3050_unregister_input_device(struct mpu3050_sensor *s=
ensor)
> +{
> +	struct i2c_client *client =3D sensor->client;
> +	free_irq(client->irq, sensor);
> +	input_unregister_device(sensor->idev);
> +	sensor->idev =3D NULL;
> +}
> +
> +/**
> + *	mpu3050_register_input_device	-	remove input dev
> + *	@sensor: sensor to remove from input
> + *
> + *	Add an input device to the sensor. This will be used to report
> + *	events from the sensor itself.
> + */
> +static int mpu3050_register_input_device(struct mpu3050_sensor *sens=
or)
> +{
> +	struct i2c_client *client =3D sensor->client;
> +	struct input_dev *idev;
> +	int ret;
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "no interrupt assigned\n");
> +		return -ENXIO;
> +	}
> +	sensor->idev =3D input_allocate_device();
> +	idev =3D sensor->idev;
> +	if (!idev) {
> +		dev_err(&client->dev, "failed to allocate input device\n");
> +		ret =3D -ENOMEM;
> +		goto failed_alloc;
> +	}
> +	idev->name =3D "MPU3050";
> +	idev->open =3D mpu3050_input_open;
> +	idev->close =3D mpu3050_input_close;
> +	idev->id.bustype =3D BUS_I2C;
> +	idev->dev.parent =3D &client->dev;
> +	idev->evbit[0] =3D BIT_MASK(EV_ABS);
> +	input_set_abs_params(idev, ABS_X, MPU3050_MIN_VALUE,
> +			MPU3050_MAX_VALUE, 0, 0);
> +	input_set_abs_params(idev, ABS_Y, MPU3050_MIN_VALUE,
> +			MPU3050_MAX_VALUE, 0, 0);
> +	input_set_abs_params(idev, ABS_Z, MPU3050_MIN_VALUE,
> +			MPU3050_MAX_VALUE, 0, 0);
> +	input_set_drvdata(idev, sensor);
> +	ret =3D input_register_device(idev);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to register input device\n");
> +		goto failed_reg;
> +	}
> +	ret =3D request_threaded_irq(client->irq, NULL,
> +			mpu3050_interrupt_thread, IRQF_TRIGGER_RISING,
> +				"mpu_int", sensor);
> +	if (ret) {
> +		dev_err(&client->dev, "can't get IRQ %d, ret %d\n",
> +				client->irq, ret);
> +		goto failed_irq;
> +	}
> +	return 0;
> +failed_irq:
> +	input_unregister_device(idev);
> +	return ret;
> +failed_reg:
> +	if (idev)
> +		input_free_device(idev);
> +failed_alloc:
> +	return ret;
> +}
> +
> +/**
> + *	mpu3050_probe	-	device detection callback
> + *	@client: i2c client of found device
> + *	@id: id match information
> + *
> + *	The I2C layer calls us when it believes a sensor is present at th=
is
> + *	address. Probe to see if this is correct and to validate the devi=
ce.
> + *
> + *	If present install the relevant sysfs interfaces and input device=
=2E
> + */
> +static int __devinit mpu3050_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct mpu3050_sensor *sensor;
> +	int ret;
> +	sensor =3D kzalloc(sizeof(struct mpu3050_sensor), GFP_KERNEL);
> +	if (!sensor) {
> +		dev_err(&client->dev, "failed to allocate driver data\n");
> +		return -ENOMEM;
> +	}
> +	sensor->dev =3D &client->dev;
> +	sensor->client =3D client;
> +	i2c_set_clientdata(client, sensor);
> +
> +	mpu3050_set_power_mode(client, 1);
> +	msleep(10);
> +	ret =3D i2c_smbus_read_byte_data(client, MPU3050_CHIP_ID_REG);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to detect device\n");
> +		goto failed_free;
> +	}
> +	if (ret !=3D MPU3050_CHIP_ID) {
> +		dev_err(&client->dev, "unsupported chip id\n");
> +		goto failed_free;
> +	}
> +
> +	mutex_init(&sensor->lock);
> +
> +	pm_runtime_set_active(&client->dev);
> +
> +	ret =3D mpu3050_register_input_device(sensor);
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
> + *	mpu3050_remove	-	remove a sensor
> + *	@client: i2c client of sensor being removed
> + *
> + *	Our sensor is going away, clean up the resources.
> + */
> +static int __devexit mpu3050_remove(struct i2c_client *client)
> +{
> +	struct mpu3050_sensor *sensor =3D i2c_get_clientdata(client);
> +
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +
> +	if (sensor->idev)
> +		mpu3050_unregister_input_device(sensor);
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
> +static int mpu3050_suspend(struct i2c_client *client, pm_message_t m=
esg)
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
> +	struct mpu3050_sensor *sensor =3D dev_get_drvdata(dev);
> +	mpu3050_set_power_mode(sensor->client, 0);
> +	return 0;
> +}
> +
> +static int mpu3050_runtime_resume(struct device *dev)
> +{
> +	struct mpu3050_sensor *sensor =3D dev_get_drvdata(dev);
> +	mpu3050_set_power_mode(sensor->client, 1);
> +	msleep(100);  /* wait for gyro chip resume */
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mpu3050_pm =3D {
> +	.runtime_suspend =3D mpu3050_runtime_suspend,
> +	.runtime_resume  =3D mpu3050_runtime_resume,
> +};
> +#endif
> +
> +static const struct i2c_device_id mpu3050_ids[] =3D {
> +	{ "mpu3050", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mpu3050_ids);
> +
> +static struct i2c_driver mpu3050_i2c_driver =3D {
> +	.driver	=3D {
> +		.name	=3D "mpu3050",
> +#ifdef CONFIG_PM_RUNTIME
> +		.pm		=3D &mpu3050_pm,
> +#endif
> +	},
> +	.probe		=3D mpu3050_probe,
> +	.remove		=3D __devexit_p(mpu3050_remove),
> +	.suspend	=3D mpu3050_suspend,
> +	.resume		=3D mpu3050_resume,
> +	.id_table	=3D mpu3050_ids,
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
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
