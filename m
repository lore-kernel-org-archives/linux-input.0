From: simon@mungewell.org
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Wed, 13 Apr 2011 11:03:04 -0400
Message-ID: <9bf2cf8dbd98b3e026d79af99277db63.squirrel@host171.canaca.com>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:55034 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab1DMPDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 11:03:07 -0400
In-Reply-To: <20110413095049.10407.35173.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.jf.intel.com>
Cc: linux-input@vger.kernel.org

Hi Alan,

> +#define MPU3050_XOUT_H		0x1D

Is this via the FIFO mentioned in the product brief, or directly to the
sensor register. A quick look for a datasheet didn't find a I2C register
listing...

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

This assumes a number of things, mainly that the interrupt latency is fast
enough that the 'NEXT' measurement does not overwrite the 'CURRENT' sample
whilst it is being read. This could lead to corrupt values.

Without a detailed datasheet for the MPU3050 I can't say for certain; but
usually there is another register which is set when a measurement is
taken. This can be cleared before and accessed after reading the XYZ
values to confirm that they have not been corrupted.

Also some I2C hosts (such as the Intel SCH) don't support I2C block
read/writes, and thus the access will be broken into separate reads/writes
and be much slower.

Hope I'm not speaking out of turn,
Simon.

