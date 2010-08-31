From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 4/6] HID: magicmouse: remove axis data filtering
Date: Mon, 30 Aug 2010 23:59:20 -0400
Message-ID: <1283227160.14419.53.camel@graviton>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-4-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:54068 "HELO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750913Ab0HaEbM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 00:31:12 -0400
Received: by mail-qy0-f176.google.com with SMTP id 2so6676833qyk.0
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 21:31:11 -0700 (PDT)
In-Reply-To: <1283188858-4839-4-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> The Magic Mouse device is very precise. No driver filtering of input
> data needs to be performed.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>

Acked-by: Michael Poole <mdpoole@troilus.org>

My original rationale for the fuzz setting was that the device is so
precise that it tends to spam applications, but that is probably too
policy-like for the kernel to enforce.

> ---
>  drivers/hid/hid-magicmouse.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index f3ee6ab..65ec2f8 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -357,11 +357,11 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>  		__set_bit(EV_ABS, input->evbit);
>  
>  		input_set_abs_params(input, ABS_MT_TRACKING_ID, 0, 15, 0, 0);
> -		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 4, 0);
> -		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 4, 0);
> -		input_set_abs_params(input, ABS_MT_ORIENTATION, -32, 31, 1, 0);
> +		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255, 0, 0);
> +		input_set_abs_params(input, ABS_MT_ORIENTATION, -32, 31, 0, 0);
>  		input_set_abs_params(input, ABS_MT_POSITION_X, -1100, 1358,
> -				4, 0);
> +				0, 0);
>  		/* Note: Touch Y position from the device is inverted relative
>  		 * to how pointer motion is reported (and relative to how USB
>  		 * HID recommends the coordinates work).  This driver keeps
> @@ -369,7 +369,7 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>  		 * inverse of the reported Y.
>  		 */
>  		input_set_abs_params(input, ABS_MT_POSITION_Y, -1589, 2047,
> -				4, 0);
> +				0, 0);
>  	}
>  
>  	if (report_undeciphered) {


