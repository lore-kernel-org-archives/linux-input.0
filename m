From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 18/18] Input: tps6507x-ts - simplify function return logic
Date: Fri, 2 Oct 2015 11:20:12 -0700
Message-ID: <20151002182012.GM8437@dtor-ws>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-19-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35992 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbJBSUP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 14:20:15 -0400
Content-Disposition: inline
In-Reply-To: <1443793229-22363-19-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org

On Fri, Oct 02, 2015 at 03:40:29PM +0200, Javier Martinez Canillas wrote:
> The invoked function already returns zero on success or a negative
> errno code so there is no need to open code the logic in the caller.
> 
> This also fixes the following make coccicheck warning:
> 
> drivers/input/touchscreen/tps6507x-ts.c:57:5-8: WARNING: end returns can be simplified
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 

Applied, thank you.

> ---
> 
>  drivers/input/touchscreen/tps6507x-ts.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index 4ffd829d1990..a340bfccdfb6 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -50,14 +50,7 @@ struct tps6507x_ts {
>  
>  static int tps6507x_read_u8(struct tps6507x_ts *tsc, u8 reg, u8 *data)
>  {
> -	int err;
> -
> -	err = tsc->mfd->read_dev(tsc->mfd, reg, 1, data);
> -
> -	if (err)
> -		return err;
> -
> -	return 0;
> +	return tsc->mfd->read_dev(tsc->mfd, reg, 1, data);
>  }
>  
>  static int tps6507x_write_u8(struct tps6507x_ts *tsc, u8 reg, u8 data)
> -- 
> 2.4.3
> 

-- 
Dmitry
