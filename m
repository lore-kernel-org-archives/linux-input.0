From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix effect aborting in ff-memless
Date: Mon, 20 Jun 2016 10:33:03 -0700
Message-ID: <20160620173303.GA22426@dtor-ws>
References: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36661 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbcFTRk0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 13:40:26 -0400
Received: by mail-pa0-f51.google.com with SMTP id wo6so16458713pac.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2016 10:40:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>, Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org

On Sun, Jun 19, 2016 at 02:44:35PM +0200, Manuel Reimer wrote:
> Hello,
> 
> while debugging a problem with hid-sony I got stuck with a problem
> actually caused by ff-memless. In some situations effect aborting is
> delayed, so it may be triggered seconds after all devices have been
> destroyed, which causes the kernel to panic.
> 
> The aborting request actually gets received here:
> https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L467
> This "aborting" flag is then handled here:
> https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L376
> But before this line is reached, there is a time check to check if
> the effect actually is due to be started:
> https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L359
> 
> This time check now causes a problem if the effect, which is meant
> to be *aborted* was scheduled to be *started* some time in future
> and the device is destroyed before this time is reached.

I am not clear how this can happen. If effect hasn't actually started
playing (i.e. we have FF_EFFECT_STARTED bit set, but FF_EFFECT_PLAYING
is not yet set), then when stopping effect we do not need to do anything
except clear FF_EFFECT_STARTED (since we did not touch the hardware
yet).

Now, if FF_EFFECT_PLAYING is set, that means that play_at time is in
the past and we won't be skipping this effect in ml_get_combo_effect().

Could you please post a stack trace of the crash you observed?

> 
> My patch fixes this by setting the trigger times to "now" after
> setting the aborting flag. This way the following code deals with
> aborting the effect immediately without setting a timer for it.
> 
> There may be other ways to fix this, so I would be happy to get some
> feedback.
> 
> 
> Signed-off-by: Manuel Reimer <mail@m-reimer.de>
> 
> --- a/drivers/input/ff-memless.c	2016-05-13 16:06:29.722685021 +0200
> +++ b/drivers/input/ff-memless.c	2016-06-19 14:25:39.790375270 +0200
> @@ -463,9 +463,11 @@ static int ml_ff_playback(struct input_d
>  	} else {
>  		pr_debug("initiated stop\n");
> 
> -		if (test_bit(FF_EFFECT_PLAYING, &state->flags))
> +		if (test_bit(FF_EFFECT_PLAYING, &state->flags)) {
>  			__set_bit(FF_EFFECT_ABORTING, &state->flags);
> -		else
> +			state->play_at = jiffies;
> +			state->adj_at = jiffies;
> +		} else
>  			__clear_bit(FF_EFFECT_STARTED, &state->flags);
>  	}
> 

Thanks.

-- 
Dmitry
