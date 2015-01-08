From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Optimize Auto Repeat Loop
Date: Thu, 8 Jan 2015 13:50:47 -0800
Message-ID: <20150108215047.GE23256@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1420724333-54148-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:38155 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbbAHVuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 16:50:52 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so11885022iec.9
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 13:50:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420724333-54148-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

On Thu, Jan 08, 2015 at 05:38:53AM -0800, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> As input_pass_values function is called everytime when EV_SYN is sent
> from input driver or input event buffer becomes full. So avoid running
> auto repeat code if input device doesn't support EV_KEY and EV_REP
> event type.
> 
> Signed-off-by: Anshul Garg <anshul.g@samsung.com>

Applied, thank you.

> ---
>  drivers/input/input.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 213e3a1..601171b 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -152,12 +152,14 @@ static void input_pass_values(struct input_dev *dev,
>  	add_input_randomness(vals->type, vals->code, vals->value);
>  
>  	/* trigger auto repeat for key events */
> -	for (v = vals; v != vals + count; v++) {
> -		if (v->type == EV_KEY && v->value != 2) {
> -			if (v->value)
> -				input_start_autorepeat(dev, v->code);
> -			else
> -				input_stop_autorepeat(dev);
> +	if (test_bit(EV_KEY, dev->evbit) && test_bit(EV_REP, dev->evbit)) {
> +		for (v = vals; v != vals + count; v++) {
> +			if (v->type == EV_KEY && v->value != 2) {
> +				if (v->value)
> +					input_start_autorepeat(dev, v->code);
> +				else
> +					input_stop_autorepeat(dev);
> +			}
>  		}
>  	}
>  }
> -- 
> 1.7.9.5
> 
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> http://www.avast.com
> 

-- 
Dmitry
