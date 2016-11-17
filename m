From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: raydium_i2c_ts: fix spelling mistake in dev_err
 message
Date: Wed, 16 Nov 2016 17:20:14 -0800
Message-ID: <20161117012014.GC8133@dtor-ws>
References: <20161116184030.10486-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33821 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932393AbcKQBUR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 20:20:17 -0500
Content-Disposition: inline
In-Reply-To: <20161116184030.10486-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jeffrey Lin <jeffrey.lin@rad-ic.com>, Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 16, 2016 at 06:40:30PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake "failied" to "failed" in
> dev_err message.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/raydium_i2c_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
> index a99fb5c..2658afa 100644
> --- a/drivers/input/touchscreen/raydium_i2c_ts.c
> +++ b/drivers/input/touchscreen/raydium_i2c_ts.c
> @@ -669,7 +669,7 @@ static int raydium_i2c_do_update_firmware(struct raydium_data *ts,
>  
>  		if (ts->boot_mode == RAYDIUM_TS_MAIN) {
>  			dev_err(&client->dev,
> -				"failied to jump to boot loader: %d\n",
> +				"failed to jump to boot loader: %d\n",
>  				error);
>  			return -EIO;
>  		}
> -- 
> 2.10.2
> 

-- 
Dmitry
