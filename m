From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] i2c-hid: explicitly cast parametrs to follow
 specifiers
Date: Wed, 4 Sep 2013 13:17:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041317030.3684@pobox.suse.cz>
References: <1372163081-11394-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50448 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755744Ab3IDLRZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 07:17:25 -0400
In-Reply-To: <1372163081-11394-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Tue, 25 Jun 2013, Andy Shevchenko wrote:

> The vendor and product parameters are defined as __u32, but used as short int.
> Let's do an explicit casting for them.

Is this fixing any compiler warning you have seen?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 879b0ed..d595f2a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1009,7 +1009,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
>  
>  	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
> -		 client->name, hid->vendor, hid->product);
> +		 client->name, (short int)hid->vendor, (short int)hid->product);
>  
>  	ret = hid_add_device(hid);
>  	if (ret) {
> -- 
> 1.8.3.1
> 

-- 
Jiri Kosina
SUSE Labs
