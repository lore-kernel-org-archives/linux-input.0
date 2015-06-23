From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input :Optimize input_dev_release_keys function
Date: Tue, 23 Jun 2015 11:57:20 -0700
Message-ID: <20150623185720.GC40168@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1435082903-41017-1-git-send-email-aksgarg1989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35272 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126AbbFWS5Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 14:57:25 -0400
Received: by igblr2 with SMTP id lr2so60271584igb.0
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2015 11:57:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435082903-41017-1-git-send-email-aksgarg1989@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, anshul.g@samsung.com

On Tue, Jun 23, 2015 at 11:08:23AM -0700, Anshul Garg wrote:
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
> +			input_pass_event(dev, EV_KEY, code, 0);
> +		memset(dev->keybit, 0, sizeof(dev->keybit));

I do not think this will work, you are resetting wrong bitmap.
dev->keybit represents keys the device is capable of sending while
dev->key represents keys that are currently pressed. Once your code is
ran you should not get any more key events.

How was this tested?

Thanks.

-- 
Dmitry
