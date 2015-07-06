From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: bma150: use sign_extend32() for sign
 extending
Date: Mon, 6 Jul 2015 15:52:58 -0700
Message-ID: <20150706225258.GC32140@dtor-ws>
References: <1435878781-1828-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36348 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbbGFWxD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 18:53:03 -0400
Content-Disposition: inline
In-Reply-To: <1435878781-1828-1-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 03, 2015 at 01:13:01AM +0200, Martin Kepplinger wrote:
> Despite it's name, sign_extend32() is used for 16 bit values aswell.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/misc/bma150.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
> index b36831c..c278049 100644
> --- a/drivers/input/misc/bma150.c
> +++ b/drivers/input/misc/bma150.c
> @@ -333,10 +333,9 @@ static void bma150_report_xyz(struct bma150_data *bma150)
>  	y = ((0xc0 & data[2]) >> 6) | (data[3] << 2);
>  	z = ((0xc0 & data[4]) >> 6) | (data[5] << 2);
>  
> -	/* sign extension */
> -	x = (s16) (x << 6) >> 6;
> -	y = (s16) (y << 6) >> 6;
> -	z = (s16) (z << 6) >> 6;
> +	x = sign_extend32(x, 9);
> +	y = sign_extend32(y, 9);
> +	z = sign_extend32(z, 9);
>  
>  	input_report_abs(bma150->input, ABS_X, x);
>  	input_report_abs(bma150->input, ABS_Y, y);
> -- 
> 2.1.4
> 

-- 
Dmitry
