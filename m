From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add ic type 0x03
Date: Mon, 21 Sep 2015 09:25:25 -0700
Message-ID: <20150921162525.GE17389@dtor-ws>
References: <6BDEAA47-E505-451C-B2C3-F82099D24737@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35903 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbbIUQZ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 12:25:28 -0400
Content-Disposition: inline
In-Reply-To: <6BDEAA47-E505-451C-B2C3-F82099D24737@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 21, 2015 at 10:14:13AM +0800, duson wrote:
> The 0x03 is valid 3000 serial ic type too.
> 
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fa94530..16ac595 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -102,6 +102,7 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
>  		*validpage_count = 512;
>  		break;
>  	case 0x09:
> +	case 0x03:
>  		*validpage_count = 768;
>  		break;
>  	case 0x0D:
> -- 
> 1.7.9.5
> 

-- 
Dmitry
