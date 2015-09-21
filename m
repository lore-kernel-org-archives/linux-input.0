From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 29/38] Input: touchscreen: atmel: remove invalid check
Date: Mon, 21 Sep 2015 10:10:41 -0700
Message-ID: <20150921171041.GI17389@dtor-ws>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <1442842450-29769-30-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35206 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbbIURKp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 13:10:45 -0400
Content-Disposition: inline
In-Reply-To: <1442842450-29769-30-git-send-email-a.hajda@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org

Hi Andrzej,

On Mon, Sep 21, 2015 at 03:34:01PM +0200, Andrzej Hajda wrote:
> byte_offset is unsigned.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index c562205..c577f95 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1267,7 +1267,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data,
>  
>  			byte_offset = reg + i - cfg_start_ofs;
>  
> -			if (byte_offset >= 0 && byte_offset < config_mem_size) {
> +			if (byte_offset < config_mem_size) {

I'd rather we kept the check as is: it documents the expected range even
if one of the checks is always true. If you search the archives you'll
find Linus has also pretty strong opinion about these checks actually
being useful from documenting POV.


>  				*(config_mem + byte_offset) = val;
>  			} else {
>  				dev_err(dev, "Bad object: reg:%d, T%d, ofs=%d\n",
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
