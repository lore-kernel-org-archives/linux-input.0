From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 1/4] input: Convert struct i2c_msg initialization to C99
 format
Date: Wed, 10 Oct 2012 10:59:16 +0200
Message-ID: <20121010105916.41c78164@endymion.delvare>
References: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:23812 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab2JJI7Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 04:59:25 -0400
In-Reply-To: <1349782278-9023-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, 9 Oct 2012 17:01:17 +0530, Shubhrajyoti D wrote:
> Convert the struct i2c_msg initialization to C99 format. This makes
> maintaining and editing the code simpler. Also helps once other fields
> like transferred are added in future.
> 
> Thanks to Julia Lawall <julia.lawall@lip6.fr>  for automating the conversion
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/input/joystick/as5011.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
> index c96653b..9d869e2 100644
> --- a/drivers/input/joystick/as5011.c
> +++ b/drivers/input/joystick/as5011.c
> @@ -85,7 +85,10 @@ static int as5011_i2c_write(struct i2c_client *client,
>  {
>  	uint8_t data[2] = { aregaddr, avalue };
>  	struct i2c_msg msg = {
> -		client->addr, I2C_M_IGNORE_NAK, 2, (uint8_t *)data
> +		.addr = client->addr,
> +		.flags = I2C_M_IGNORE_NAK,
> +		.len = 2,
> +		.buf = (uint8_t *)data
>  	};
>  	int error;
>  
> @@ -98,8 +101,18 @@ static int as5011_i2c_read(struct i2c_client *client,
>  {
>  	uint8_t data[2] = { aregaddr };
>  	struct i2c_msg msg_set[2] = {
> -		{ client->addr, I2C_M_REV_DIR_ADDR, 1, (uint8_t *)data },
> -		{ client->addr, I2C_M_RD | I2C_M_NOSTART, 1, (uint8_t *)data }
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_REV_DIR_ADDR,
> +			.len = 1,
> +			.buf = (uint8_t *)data
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD | I2C_M_NOSTART,
> +			.len = 1,
> +			.buf = (uint8_t *)data
> +		}
>  	};
>  	int error;
>  

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
