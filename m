From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Wed, 4 May 2016 15:58:46 -0700
Message-ID: <20160504225846.GA17403@dtor-ws>
References: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34933 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbcEDW6u (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 18:58:50 -0400
Content-Disposition: inline
In-Reply-To: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org, jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org

Hi Jeffrey,

On Fri, Apr 29, 2016 at 05:45:13PM +0800, jeffrey.lin wrote:
> Raydium I2C touch driver.
> 

In my previous e-mail I requested you to enumerate changes that are made
to the driver, compared to the previous version(s). There were also a
few questions that I did not get answer for.

Also:

> +static int raydium_i2c_query_ts_info(struct raydium_data *ts)
> +{
> +	struct i2c_client *client = ts->client;
> +	int error, retry_cnt;
> +
> +	for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
> +		error = raydium_i2c_read(client, CMD_DATA_BANK,
> +			sizeof(ts->obj), (void *)&ts->obj);
> +			ts->obj.data_bank_addr =
> +				get_unaligned_le32(&ts->obj.data_bank_addr);
> +
> +		if (!error) {
> +			error = raydium_i2c_read(client, CMD_QUERY_BANK,
> +				sizeof(ts->query_bank_info),
> +				(void *)&ts->query_bank_info);
> +			if (!error) {
> +				error = raydium_i2c_read_message(client,
> +					ts->query_bank_info, sizeof(ts->info),
> +					(void *)&ts->info);
> +
> +				ts->info.hw_ver =
> +					get_unaligned_le32(&ts->info.hw_ver);
> +				ts->info.ft_ver =
> +					get_unaligned_le16(&ts->info.ft_ver);
> +				ts->info.x_max =
> +					get_unaligned_le16(&ts->info.x_max);
> +				ts->info.y_max =
> +					get_unaligned_le16(&ts->info.y_max);
> +				return 0;
> +			}
> +		}
> +	}
> +	dev_err(&client->dev, "Get touch data failed: %d\n", error);
> +
> +	return -EINVAL;
> +}
> +
> +static int raydium_i2c_fastboot(struct i2c_client *client)
> +{
> +	static const u8 boot_cmd[] = { 0x50, 0x00, 0x06, 0x20 };
> +	u8 buf[HEADER_SIZE];
> +	int error;
> +
> +	error = raydium_i2c_read_message(client,
> +		get_unaligned_be32(boot_cmd),
> +		sizeof(boot_cmd), buf);

I still can't figure out the logic in read/write mesage handling. Here
we see that device is supposedly reporting data_bank_addr as LE integer,
but query_bank_info is returned in native CPU endianness. With fastboot
command we assume that we are dealing with BE-encoded data and convert
it to CPU-endianness before using it.

However in raydium_i2c_read_message() we convert from CPU endianness to
BE and this comfuses me (does the device really return data in one
endianness but accepts in another endianness?

By the way, why do you have raydium_i2c_read_message() handle reads
above MAX_PKG_SIZE? There are no callers that want it.

Thanks.

-- 
Dmitry
