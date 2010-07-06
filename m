From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v3] input: qt602240 - Add ATMEL QT602240 touchscreen
 driver
Date: Tue, 6 Jul 2010 10:18:03 +0200
Message-ID: <20100706101803.6d13ac65@hyperion.delvare>
References: <1277725091-13456-1-git-send-email-jy0922.shim@samsung.com>
	<20100628175500.GA7427@core.coreip.homeip.net>
	<4C2956B1.8030000@samsung.com>
	<20100629131150.3c1a2005@hyperion.delvare>
	<4C32DECE.2030009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bamako.nerim.net ([62.4.17.28]:49879 "EHLO bamako.nerim.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0GFISH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Jul 2010 04:18:07 -0400
In-Reply-To: <4C32DECE.2030009@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kyungmin.park@samsung.com, rydberg@euromail.se

On Tue, 06 Jul 2010 16:44:14 +0900, Joonyoung Shim wrote:
> On 6/29/2010 8:11 PM, Jean Delvare wrote:
> > On Tue, 29 Jun 2010 11:13:05 +0900, Joonyoung Shim wrote:
> >> On 6/29/2010 2:55 AM, Dmitry Torokhov wrote:
> >>> Also, please CC Jean Delvare to make sure I2C bits look good.
> >> I add him to CC.
> > 
> > I can't comment without seeing the full patch.
> > 
> 
> Sorry for late response, you can see the full patch in follow site.
> 
> https://patchwork.kernel.org/patch/108363/

OK, overall it's OK, but your driver is vulnerable to a race condition
due to the use of i2c_master_send() and i2c_master_recv().

> +static int qt602240_read_reg(struct i2c_client *client, u16 reg)
> +{
> +	u8 buf[2];
> +	u8 val;
> +
> +	buf[0] = reg & 0xff;
> +	buf[1] = (reg >> 8) & 0xff;
> +
> +	if (i2c_master_send(client, buf, 2) != 2) {
> +		dev_err(&client->dev, "%s: i2c send failed\n", __func__);
> +		return -EIO;
> +	}
> +
> +	if (i2c_master_recv(client, &val, 1) != 1) {
> +		dev_err(&client->dev, "%s: i2c recv failed\n", __func__);
> +		return -EIO;
> +	}
> +
> +	return val;
> +}

As you don't have any locking in place, there is no guarantee that
another I2C access to the device won't happen between i2c_master_send()
which sets the register pointer and i2c_master_recv() which reads the
value back.

There are 2 ways to fix this. First way is to add locking around all
your device register accesses. Second way (much better IMHO) is to use
i2c_transfer() with 2 messages instead of i2c_master_send() +
i2c_master_recv(). i2c_transfer() is guaranteed to be atomic (as far as
the device register pointer is concerned) by i2c-core.

Same applies to qt602240_read_object_table() and
qt602240_read_message(), and maybe other functions I haven't seen.

-- 
Jean Delvare
