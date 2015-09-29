From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add all valid ic type for i2c/smbus
Date: Mon, 28 Sep 2015 17:17:47 -0700
Message-ID: <20150929001747.GB30653@dtor-ws>
References: <A8DECB9C-843A-41B1-A3DF-965C7593ACB9@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36138 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbI2ARv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 20:17:51 -0400
Content-Disposition: inline
In-Reply-To: <A8DECB9C-843A-41B1-A3DF-965C7593ACB9@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Sep 23, 2015 at 09:26:23AM +0800, duson wrote:
> Signed-of-by: Duson Lin <dusonlin@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 16ac595..357670e 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -98,16 +98,25 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
>  			   u16 *signature_address)
>  {
>  	switch (iap_version) {
> +	case 0x00:
> +	case 0x06:
>  	case 0x08:
>  		*validpage_count = 512;
>  		break;
> -	case 0x09:
>  	case 0x03:
> +	case 0x07:
> +	case 0x09:
> +	case 0x0A:
> +	case 0x0B:
> +	case 0x0C:
>  		*validpage_count = 768;
>  		break;
>  	case 0x0D:
>  		*validpage_count = 896;
>  		break;
> +	case 0x0E:
> +		*validpage_count = 640;
> +		break;
>  	default:
>  		/* unknown ic type clear value */
>  		*validpage_count = 0;
> -- 
> 1.7.9.5
> 
> 

-- 
Dmitry
