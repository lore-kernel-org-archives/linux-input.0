From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input:Optimize events_per_packet count calculation
Date: Sat, 13 Dec 2014 12:02:56 -0800
Message-ID: <20141213200256.GF22702@dtor-ws>
References: <1418212123-4549-1-git-send-email-anshul.g@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:58053 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbaLMUDB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Dec 2014 15:03:01 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so4160580igi.5
        for <linux-input@vger.kernel.org>; Sat, 13 Dec 2014 12:03:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1418212123-4549-1-git-send-email-anshul.g@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: anshul.g@samsung.com
Cc: linux-input@vger.kernel.org, aksgarg1989@gmail.com

On Wed, Dec 10, 2014 at 05:18:43PM +0530, anshul.g@samsung.com wrote:
> From: Anshul Garg <anshul.g@samsung.com>
> 
> This patch avoids unnecessary operations while estimating events per
> packet for an input device when event type is not set.
> 
> Signed-off-by: Anshul Garg <anshul.g@samsung.com>

Applied, thank you.

> ---
>  drivers/input/input.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 29ca0bb..8172296 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1973,18 +1973,22 @@ static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
>  
>  	events = mt_slots + 1; /* count SYN_MT_REPORT and SYN_REPORT */
>  
> -	for (i = 0; i < ABS_CNT; i++) {
> -		if (test_bit(i, dev->absbit)) {
> -			if (input_is_mt_axis(i))
> -				events += mt_slots;
> -			else
> -				events++;
> +	if (test_bit(EV_ABS, dev->evbit)) {
> +		for (i = 0; i < ABS_CNT; i++) {
> +			if (test_bit(i, dev->absbit)) {
> +				if (input_is_mt_axis(i))
> +					events += mt_slots;
> +				else
> +					events++;
> +			}
>  		}
>  	}
>  
> -	for (i = 0; i < REL_CNT; i++)
> -		if (test_bit(i, dev->relbit))
> -			events++;
> +	if (test_bit(EV_REL, dev->evbit)) {
> +		for (i = 0; i < REL_CNT; i++)
> +			if (test_bit(i, dev->relbit))
> +				events++;
> +	}
>  
>  	/* Make room for KEY and MSC events */
>  	events += 7;
> -- 
> 1.7.9.5
> 

-- 
Dmitry
