From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-hid: explicitly cast parametrs to follow specifiers
Date: Tue, 06 Aug 2013 14:43:56 +0300
Message-ID: <1375789436.403.16.camel@smile>
References: <1372163081-11394-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21828 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424Ab3HFLoJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Aug 2013 07:44:09 -0400
In-Reply-To: <1372163081-11394-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, 2013-06-25 at 15:24 +0300, Andy Shevchenko wrote: 
> The vendor and product parameters are defined as __u32, but used as short int.
> Let's do an explicit casting for them.

Jiri, Benjamin, any comment on this?

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

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
