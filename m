From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Wed, 13 Apr 2011 11:30:24 +0100
Message-ID: <4DA57B40.2000402@cam.ac.uk>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40286 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087Ab1DMK2f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 06:28:35 -0400
In-Reply-To: <20110413095049.10407.35173.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.jf.intel.com>
Cc: linux-input@vger.kernel.org

On 04/13/11 10:51, Alan Cox wrote:
> From: Joseph Lai <joseph_lai@wistron.com>
> 
> This driver is registered as an input device. An IRQ is required in this
> basic driver configuration.
For others, description of changes is at the top of mpu3050.c
Basically, driver has been stripped of sysfs interfaces entirely to
aid merging.

Couple of trivial nitpicks/comments inline.

...
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

Could just fix the length in this. You only ever use it with the value 6.
Hardly seems worth it's own function.  I guess this may be because it gets
used for other things in the full version?  If so it doesn't do any harm
here so might as well leave it alone.
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
> +	coords->x = buffer[0];
> +	coords->x = coords->x << 8 | buffer[1];

Better to use le16_tocpu or similar rather than
hand rolling these.

> +	coords->y = buffer[2];
> +	coords->y = coords->y << 8 | buffer[3];
> +	coords->z = buffer[4];
> +	coords->z = coords->z << 8 | buffer[5];
> +	dev_dbg(&client->dev, "%s: x %d, y %d, z %d\n", __func__,
> +					coords->x, coords->y, coords->z);
> +}
> +
...
