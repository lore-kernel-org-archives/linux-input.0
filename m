From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] CHROMIUM: elants_i2c.c: Disable idle mode before
 firmware upgrade procedure.
Date: Thu, 23 Jul 2015 15:16:49 -0700
Message-ID: <20150723221649.GG12733@dtor-ws>
References: <1437444625-9703-1-git-send-email-james.chen@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34912 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbbGWWQy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 18:16:54 -0400
Received: by pabkd10 with SMTP id kd10so2858570pab.2
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2015 15:16:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1437444625-9703-1-git-send-email-james.chen@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "james.chen" <james.chen@emc.com.tw>
Cc: Herman Lin <herman.lin@emc.com.tw>, linux-input@vger.kernel.org, charliemooney@chromium.org

Hi James,

On Tue, Jul 21, 2015 at 10:10:25AM +0800, james.chen wrote:
> From: "james.chen" <james.chen@emc.com.tw>
> 
> This patch is disable idle mode before firmware upgrade procedure.
> 
> BUG=chrome-os-partner:39373
> TEST= Test Elan touchscreen on cyan project(kernel 3.18) without problems.
> 
> Signed-off-by: james.chen <james.chen@emc.com.tw>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 0efd766..6d3570e 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -605,6 +605,7 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
>  	const u8 enter_iap[] = { 0x45, 0x49, 0x41, 0x50 };
>  	const u8 enter_iap2[] = { 0x54, 0x00, 0x12, 0x34 };
>  	const u8 iap_ack[] = { 0x55, 0xaa, 0x33, 0xcc };
> +	const u8 close_idle[] = {0x54, 0x2c, 0x01, 0x01};
>  	u8 buf[HEADER_SIZE];
>  	u16 send_id;
>  	int page, n_fw_pages;
> @@ -617,8 +618,13 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
>  	} else {
>  		/* Start IAP Procedure */
>  		dev_dbg(&client->dev, "Normal IAP procedure\n");
> +		/* Close idle mode */
> +		error = elants_i2c_send(client, close_idle, sizeof(close_idle));
> +		if (error)
> +			dev_err(&client->dev, "Failed close idle: %d\n", error);
> +		msleep(60);
>  		elants_i2c_sw_reset(client);
> -
> +		msleep(20);

Are you sure that this delay is also needed? We have the following in
elants_i2c_sw_reset():

	/*
	 * We should wait at least 10 msec (but no more than 40) before
	 * sending fastboot or IAP command to the device.
	 */
	msleep(30);

so additional 20 msec will push us out of the 40 msec window...

>  		error = elants_i2c_send(client, enter_iap, sizeof(enter_iap));
>  	}
>  
> -- 
> 1.8.3.2
> 

Thanks.

-- 
Dmitry
