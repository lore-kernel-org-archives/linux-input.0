From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 4/6 v2] HID: magicmouse: remove axis data filtering
Date: Tue, 31 Aug 2010 22:34:01 +0200
Message-ID: <4C7D6739.5000601@euromail.se>
References: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com> <1283280068-12285-4-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:53278 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754073Ab0HaUfZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 16:35:25 -0400
In-Reply-To: <1283280068-12285-4-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/31/2010 08:41 PM, Chase Douglas wrote:

> The Magic Mouse device is very precise. No driver filtering of input
> data needs to be performed.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> Acked-by: Michael Poole <mdpoole@troilus.org>
> ---


I am still not sure this is a good idea. Bandwidth from MT devices is a big
deal. A statement roughly how much data comes out of mtdev (which does the
filtering for type A devices) before and after this change would be reassuring.

Cheers,
Henrik

>  drivers/hid/hid-magicmouse.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 98bbc53..0fe2464 100644
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


