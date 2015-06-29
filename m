From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input :Optimize input_dev_release_keys function
Date: Mon, 29 Jun 2015 12:46:31 -0700
Message-ID: <20150629194631.GF22166@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1435254817-41989-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34648 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbbF2Tqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2015 15:46:35 -0400
Received: by iebmu5 with SMTP id mu5so122136690ieb.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2015 12:46:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435254817-41989-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

On Thu, Jun 25, 2015 at 10:53:37AM -0700, Anshul Garg wrote:
> From: Anshul Garg <aksgarg1989@gmail.com>
> 
> input_dev_release_keys : Use for_each_set_bit instead
> of testing every bit upto KEY_MAX as it is more clean
> and more optimized.
> 
> input_estimate_events_per_packet : Use bitmap_weight
> to get set bits count for EV_REL type instead of using
> loop and also use for_each_set_bit for EV_ABS event for
> more optimized code.
> 
> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
> ---
>  drivers/input/input.c |   28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index e0b7b8e..9459f8b 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -682,12 +682,9 @@ static void input_dev_release_keys(struct input_dev *dev)
>  	int code;
>  
>  	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
> -		for (code = 0; code <= KEY_MAX; code++) {
> -			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
> -			    __test_and_clear_bit(code, dev->key)) {
> -				input_pass_event(dev, EV_KEY, code, 0);
> -			}
> -		}
> +		for_each_set_bit(code, dev->keybit, KEY_MAX)

That should have been KEY_CNT (as KEY_MAX is a valid keycode and you do
not want to skip it), I fixed it up locally and applied.

Thanks.

> +			input_pass_event(dev, EV_KEY, code, 0);
> +		memset(dev->key, 0, sizeof(dev->key));
>  		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
>  	}
>  }
> @@ -1986,21 +1983,16 @@ static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
>  	events = mt_slots + 1; /* count SYN_MT_REPORT and SYN_REPORT */
>  
>  	if (test_bit(EV_ABS, dev->evbit)) {
> -		for (i = 0; i < ABS_CNT; i++) {
> -			if (test_bit(i, dev->absbit)) {
> -				if (input_is_mt_axis(i))
> -					events += mt_slots;
> -				else
> -					events++;
> -			}
> +		for_each_set_bit(i, dev->absbit, ABS_CNT) {
> +			if (input_is_mt_axis(i))
> +				events += mt_slots;
> +			else
> +				events++;
>  		}
>  	}
>  
> -	if (test_bit(EV_REL, dev->evbit)) {
> -		for (i = 0; i < REL_CNT; i++)
> -			if (test_bit(i, dev->relbit))
> -				events++;
> -	}
> +	if (test_bit(EV_REL, dev->evbit))
> +		events += bitmap_weight(dev->relbit, REL_CNT);
>  
>  	/* Make room for KEY and MSC events */
>  	events += 7;
> -- 
> 1.7.9.5
> 
> 
> ---
> This email has been checked for viruses by Avast antivirus software.
> https://www.avast.com/antivirus
> 

-- 
Dmitry
