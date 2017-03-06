From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Fix error handling
Date: Mon, 6 Mar 2017 14:17:38 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061416160.31814@cbobk.fhfr.pm>
References: <20170219120759.11162-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752907AbdCFNjk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 08:39:40 -0500
In-Reply-To: <20170219120759.11162-1-christophe.jaillet@wanadoo.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: benjamin.tissoires@redhat.com, briannorris@chromium.org, dianders@chromium.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, 19 Feb 2017, Christophe JAILLET wrote:

> According to error handling in this function, it is likely that some
> resources should be freed before returning.
> Replace 'return ret', with 'goto err'.
> 
> While at it, remove some spaces at the beginning of the lines to be more
> consistent.
> 
> 
> Fixes: ead0687fe304a ("HID: i2c-hid: support regulator power on/off")
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index d5288f3fb5ee..1a57ac2d8524 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1058,13 +1058,13 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	}
>  
>  	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
> - 	if (IS_ERR(ihid->pdata.supply)) {
> - 		ret = PTR_ERR(ihid->pdata.supply);
> - 		if (ret != -EPROBE_DEFER)
> - 			dev_err(&client->dev, "Failed to get regulator: %d\n",
> - 				ret);
> - 		return ret;
> - 	}
> +	if (IS_ERR(ihid->pdata.supply)) {
> +		ret = PTR_ERR(ihid->pdata.supply);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&client->dev, "Failed to get regulator: %d\n",
> +				ret);
> +		goto err;
> +	}

I don't see any spaces at the beginning of lines in the version that's in 
my tree ... o_O?

Therefore I've converted this patch into simple 'return ret -> goto err' 
transformation and applied on top for-4.12/i2c-hid.

Thanks,

-- 
Jiri Kosina
SUSE Labs

