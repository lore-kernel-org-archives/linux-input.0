From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: bma150: Only claim to support the bma180 if the
 separate iio bma180 driver is not build
Date: Sun, 13 Nov 2016 21:35:23 -0800
Message-ID: <20161114053523.GA21471@dtor-ws>
References: <20161113183407.12848-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35757 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932717AbcKNFf0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2016 00:35:26 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so8038495pga.2
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2016 21:35:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161113183407.12848-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>

Hi Hans,

On Sun, Nov 13, 2016 at 07:34:07PM +0100, Hans de Goede wrote:
> commit ef3714fdbc8d ("Input: bma150 - extend chip detection for bma180"),
> adds bma180 chip-ids to the input bma150 driver, assuming that they are
> 100% compatible, but the bma180 is not compatible with the bma150 at all,
> it has 14 bits resolution instead of 10, and it has quite different
> control registers too.
> 
> Treating the bma180 as a bma150 wrt its data registers will just result
> in throwing away the lowest 4 bits, which is not too bad. But the ctrl
> registers are a different story. Things happen to just work but supporting
> that certainly does not make treating the bma180 the same as the bma150
> right.
> 
> Since some setups depend on the evdev interface the bma150 driver offers
> on top of the bma180, we cannot simply remove the bma180 ids.
> 
> So this commit only removes the bma180 id when the bma180 iio driver,
> which does treat the bma180 properly, is enabled.
> 
> Cc: Dr. H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/misc/bma150.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index b0d4453..9fa1c9a 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -539,7 +539,11 @@ static int bma150_probe(struct i2c_client *client,
>  	}
>  
>  	chip_id = i2c_smbus_read_byte_data(client, BMA150_CHIP_ID_REG);
> -	if (chip_id != BMA150_CHIP_ID && chip_id != BMA180_CHIP_ID) {
> +	if (chip_id != BMA150_CHIP_ID
> +#ifndef CONFIG_BMA180
> +	    && chip_id != BMA180_CHIP_ID
> +#endif

Does not this break if bma180 is compiled as module? I'd rather we did

	if (chip_id != BMA150_CHIP_ID &&
            (IS_ENABLED(CONFIG_BMA180) || chip_id != BMA180_CHIP_ID)) {
		...


> +	    ) {
>  		dev_err(&client->dev, "BMA150 chip id error: %d\n", chip_id);
>  		return -EINVAL;
>  	}
> @@ -643,7 +647,9 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
>  
>  static const struct i2c_device_id bma150_id[] = {
>  	{ "bma150", 0 },
> +#ifndef CONFIG_BMA180
#if !IS_ENABLED(CONFIG_BMA180)

>  	{ "bma180", 0 },
> +#endif
>  	{ "smb380", 0 },
>  	{ "bma023", 0 },
>  	{ }
> -- 
> 2.9.3
> 

Thanks.

-- 
Dmitry
