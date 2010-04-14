From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH 3/4] liss331d1: accelerometer driver
Date: Thu, 15 Apr 2010 00:34:29 +0200
Message-ID: <20100414223429.GW30807@buzzloop.caiaq.de>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
 <20100414125155.23181.56610.stgit@localhost.localdomain>
 <4BC63DC5.8040501@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BC63DC5.8040501-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel-hGVxb2UgFK3z+pZb47iToQ@public.gmane.org>
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 15, 2010 at 12:12:21AM +0200, =C9ric Piel wrote:
> Op 14-04-10 14:52, Alan Cox schreef:
> > From: Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >=20
> > The acceleremeter driver reads the x,y,z coordinate registers and p=
rovides
> > the information to user through the input layer
> >=20
> > Conversion to input device, clean up and porting of retry fixes nee=
ded
> > for AAVA done by Alan Cox.
> Hello,
>=20
> I wouldn't want to be too picky, if this driver works fine with your
> hardware and it's tested, why not, but from looking at the spec of th=
is
> chip (and at the code of this driver), it looks like it could be
> completely compatible with the lis3lv02d driver (with lis3lv02d_i2c).
> Same registers, including the WHO_AM_I register which returns 0x3B
> (which is a supported version).
>=20
> Have you tried and there were some specific incompatibilities? To me,=
 it
> looks like the only thing not in the lis3lv02d is the read with multi=
ple
> retries, and it could be easily added if necessary for your hardware.

Yes, that would be better. Also because there's also a SPI version of
the lis331dl. If support for this chip would be incorporated in the
existing driver, they would automatically be supported as well.

Daniel


> > Signed-off-by: Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >=20
> >  drivers/hwmon/Kconfig    |    8 +
> >  drivers/hwmon/Makefile   |    1=20
> >  drivers/hwmon/lis331dl.c |  286 ++++++++++++++++++++++++++++++++++=
++++++++++++
> >  3 files changed, 295 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/lis331dl.c
> >=20
> >=20
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 1fa2533..6868b9d 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1104,6 +1104,14 @@ config SENSORS_ISL29020
> >  	  Range values can be configured using sysfs.
> >  	  Lux data is accessible via sysfs.
> > =20
> > +config SENSORS_LIS331DL
> > +	tristate "STMicroeletronics LIS331DL three-axis digital accelerom=
eter"
> > +	depends on I2C
> > +	help
> > +	  If you say yes here you get support for the Accelerometer  Devi=
ces
> > +	  Device can be configured using sysfs.
> > +	  x y Z data can be   accessible via sysfs.
> > +
> >  if ACPI
> > =20
> >  comment "ACPI drivers"
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 13d6832..ebeb2a2 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_K10TEMP)	+=3D k10temp.o
> >  obj-$(CONFIG_SENSORS_LIS3LV02D) +=3D lis3lv02d.o hp_accel.o
> >  obj-$(CONFIG_SENSORS_LIS3_SPI)	+=3D lis3lv02d.o lis3lv02d_spi.o
> >  obj-$(CONFIG_SENSORS_LIS3_I2C)	+=3D lis3lv02d.o lis3lv02d_i2c.o
> > +obj-$(CONFIG_SENSORS_LIS331DL)	+=3D lis331dl.o
> >  obj-$(CONFIG_SENSORS_LM63)	+=3D lm63.o
> >  obj-$(CONFIG_SENSORS_LM70)	+=3D lm70.o
> >  obj-$(CONFIG_SENSORS_LM73)	+=3D lm73.o
> > diff --git a/drivers/hwmon/lis331dl.c b/drivers/hwmon/lis331dl.c
> > new file mode 100644
> > index 0000000..34009eb
> > --- /dev/null
> > +++ b/drivers/hwmon/lis331dl.c
> > @@ -0,0 +1,286 @@
> > +/*
> > + * lis331dl.c - ST LIS331DL  Accelerometer Driver
> > + *
> > + * Copyright (C) 2009 Intel Corp
> > + *
> > + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,=
 but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GN=
U
> > + * General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public Licen=
se along
> > + * with this program; if not, write to the Free Software Foundatio=
n, Inc.,
> > + * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +#include <linux/mutex.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/input-polldev.h>
> > +
> > +
> > +#define POLL_INTERVAL	50
> > +
> > +struct lis331dl {
> > +	struct input_polled_dev *idev;
> > +	struct i2c_client *client;
> > +	struct mutex update_lock;
> > +};
> > +
> > +static ssize_t data_rate_show(struct device *dev,
> > +			struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	int val;
> > +	int speed =3D 100;
> > +
> > +	val =3D i2c_smbus_read_byte_data(client, 0x20);
> > +	if (val & 0x80); /* 1=3D 400HZ 0=3D 100HZ */
> > +		speed =3D 400;
> > +	return sprintf(buf, "%d\n", speed);
> > +}
> > +
> > +static ssize_t power_mode_show(struct device *dev,
> > +			struct device_attribute *attr, char *buf)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	int val;
> > +
> > +	val =3D i2c_smbus_read_byte_data(client, 0x20) & 0x40;
> > +	if (val =3D=3D 0x40)
> > +		val =3D 1;
> > +	return sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static int read_with_retries(struct i2c_client *client, int r)
> > +{
> > +	int retries;
> > +	int ret;
> > +=09
> > +	for (retries =3D 0; retries < 5; retries++) {
> > +		ret =3D i2c_smbus_read_byte_data(client, r);
> > +		if (ret !=3D -ETIMEDOUT)
> > +			break;
> > +		msleep(10);
> > +	}
> > +	return ret;
> > +}
> > +
> > +static void lis331dl_poll(struct input_polled_dev *idev)
> > +{
> > +	struct input_dev *input =3D idev->input;
> > +	struct lis331dl *data =3D idev->private;
> > +	int x, y, z;
> > +	struct i2c_client *client =3D data->client;
> > +
> > +	x =3D read_with_retries(client, 0x29);
> > +	y =3D read_with_retries(client, 0x2B);
> > +	z =3D read_with_retries(client, 0x2D);
> > +
> > +	input_report_abs(input, ABS_X, x);
> > +	input_report_abs(input, ABS_Y, y);
> > +	input_report_abs(input, ABS_Z, z);
> > +	input_sync(input);
> > +}
> > +
> > +static ssize_t data_rate_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct lis331dl *data =3D i2c_get_clientdata(client);
> > +	unsigned int ret_val;
> > +	unsigned long val;
> > +
> > +	if (strict_strtoul(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&data->update_lock);
> > +
> > +	ret_val =3D i2c_smbus_read_byte_data(client, 0x20);
> > +	ret_val &=3D 0x7F;
> > +
> > +	switch (val) {
> > +	case 400:
> > +		ret_val |=3D 0x80;
> > +	case 100:
> > +		i2c_smbus_write_byte_data(client, 0x20, ret_val);
> > +		break;
> > +	default:	=09
> > +		mutex_unlock(&data->update_lock);
> > +		return -EINVAL;
> > +	}
> > +	mutex_unlock(&data->update_lock);
> > +	return count;
> > +}
> > +
> > +static ssize_t power_mode_store(struct device *dev,
> > +		struct device_attribute *attr, const  char *buf, size_t count)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	struct lis331dl *data =3D i2c_get_clientdata(client);
> > +	unsigned int ret_val;
> > +	unsigned long val;
> > +
> > +	if (strict_strtoul(buf, 10, &val))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&data->update_lock);
> > +
> > +	ret_val =3D i2c_smbus_read_byte_data(client, 0x20);
> > +	ret_val &=3D 0xBF;
> > +=09
> > +	switch(val) {
> > +	case 1:
> > +		ret_val |=3D 0x40;
> > +	case 0:
> > +		i2c_smbus_write_byte_data(client, 0x20, ret_val);
> > +		break;
> > +	default:
> > +		mutex_unlock(&data->update_lock);
> > +		return -EINVAL;
> > +	}
> > +	mutex_unlock(&data->update_lock);
> > +	return count;
> > +}
> > +
> > +static DEVICE_ATTR(data_rate, S_IRUGO | S_IWUSR,
> > +	data_rate_show, data_rate_store);
> > +static DEVICE_ATTR(power_state, S_IRUGO | S_IWUSR,
> > +	power_mode_show, power_mode_store);
> > +
> > +static struct attribute *mid_att_accelero[] =3D {
> > +	&dev_attr_data_rate.attr,
> > +	&dev_attr_power_state.attr,
> > +	NULL
> > +};
> > +
> > +static struct attribute_group m_accelero_gr =3D {
> > +	.name =3D "lis331dl",
> > +	.attrs =3D mid_att_accelero
> > +};
> > +
> > +static void accel_set_default_config(struct i2c_client *client)
> > +{
> > +	i2c_smbus_write_byte_data(client, 0x20, 0x47);
> > +}
> > +
> > +static int  lis331dl_probe(struct i2c_client *client,
> > +					const struct i2c_device_id *id)
> > +{
> > +	int res;
> > +	struct lis331dl *data;
> > +	struct input_polled_dev *idev;
> > +	struct input_dev *input;
> > +
> > +	data =3D kzalloc(sizeof(struct lis331dl), GFP_KERNEL);
> > +	if (data =3D=3D NULL) {
> > +		dev_err(&client->dev, "lis331dl: out of memory\n");
> > +		return -ENOMEM;
> > +	}
> > +	mutex_init(&data->update_lock);
> > +	i2c_set_clientdata(client, data);
> > +	data->client =3D client;
> > +
> > +	res =3D sysfs_create_group(&client->dev.kobj, &m_accelero_gr);
> > +	if (res) {
> > +		dev_err(&client->dev, "lis331dl: sysfs  group failed\n");
> > +		goto accelero_error1;
> > +	}
> > +	idev =3D input_allocate_polled_device();
> > +	if (!idev) {
> > +		res =3D -ENOMEM;
> > +		dev_err(&client->dev,
> > +			"lis331dl: unable to register input device\n");
> > +		goto accelero_error2;
> > +	}
> > +	idev->poll =3D lis331dl_poll;
> > +	idev->poll_interval =3D POLL_INTERVAL;
> > +
> > +	idev->private =3D data;
> > +	data->idev =3D  idev;
> > +
> > +	input =3D idev->input;
> > +	input->name =3D "lis331dl";
> > +	input->phys =3D "lis331dl/input0";
> > +	input->id.bustype =3D BUS_I2C;
> > +	input->dev.parent =3D &client->dev;
> > +	input->evbit[0] =3D BIT_MASK(EV_ABS);
> > +	input_set_abs_params(input, ABS_X, 0, 255, 2, 2);
> > +	input_set_abs_params(input, ABS_Y, 0, 255, 2, 2);
> > +	input_set_abs_params(input, ABS_Z, 0, 255, 2, 2);
> > +
> > +	res =3D input_register_polled_device(idev);
> > +	if (res =3D=3D 0) {
> > +		dev_info(&client->dev,
> > +			"%s lis331dl:  Accelerometer chip found",
> > +							client->name);
> > +		return 0;
> > +	}
> > +	input_free_polled_device(idev);
> > +accelero_error2:
> > +	sysfs_remove_group(&client->dev.kobj, &m_accelero_gr);
> > +accelero_error1:
> > +	i2c_set_clientdata(client, NULL);
> > +	kfree(data);
> > +	return res;
> > +}
> > +
> > +static int lis331dl_remove(struct i2c_client *client)
> > +{
> > +	struct lis331dl *data =3D i2c_get_clientdata(client);
> > +
> > +	input_unregister_polled_device(data->idev);
> > +	input_free_polled_device(data->idev);
> > +	sysfs_remove_group(&client->dev.kobj, &m_accelero_gr);
> > +	kfree(data);
> > +	return 0;
> > +}
> > +
> > +static struct i2c_device_id lis331dl_id[] =3D {
> > +	{ "i2c_accel", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, lis331dl_id);
> > +
> > +static struct i2c_driver lis331dl_driver =3D {
> > +	.driver =3D {
> > +	.name =3D "lis331dl",
> > +	},
> > +	.probe =3D lis331dl_probe,
> > +	.remove =3D lis331dl_remove,
> > +	.id_table =3D lis331dl_id,
> > +};
> > +
> > +static int __init sensor_lis331dl_init(void)
> > +{
> > +	int res;
> > +
> > +	res =3D i2c_add_driver(&lis331dl_driver);
> > +	return res;
> > +}
> > +
> > +static void  __exit sensor_lis331dl_exit(void)
> > +{
> > +	i2c_del_driver(&lis331dl_driver);
> > +}
> > +
> > +module_init(sensor_lis331dl_init);
> > +module_exit(sensor_lis331dl_exit);
> > +
> > +MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alan Cox")=
;
> > +MODULE_DESCRIPTION("STMicroelectronics LIS331DL Accelerometer Driv=
er");
> > +MODULE_LICENSE("GPL v2");
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
