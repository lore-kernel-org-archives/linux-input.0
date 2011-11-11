From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - update OLPC XO exclusion
Date: Fri, 11 Nov 2011 10:08:22 -0800
Message-ID: <20111111180822.GA4751@core.coreip.homeip.net>
References: <20111111174957.0FE289D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64042 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab1KKSI3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Nov 2011 13:08:29 -0500
Received: by ywt32 with SMTP id 32so452080ywt.19
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2011 10:08:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111111174957.0FE289D401E@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org, dilinger@queued.net

On Fri, Nov 11, 2011 at 05:49:56PM +0000, Daniel Drake wrote:
> We have determined that the jumpiness previously seen when using
> the synaptics kernel mouse driver on OLPC XO was due to not using
> the synaptics X11 userspace driver - the xf86-input-evdev driver was
> interpreting 'finger near pad' signals as movements. Newer versions
> of xf86-input-evdev fix this issue.
> 
> Additionally, the synaptics kernel driver is now usable on this
> platform, but only when run in relative mode.
> 
> Update the comment and refine the check to allow the synaptics driver
> to run on OLPC XO in relative mode.
> 
> We will continue investigating the EC issue as time becomes available.

Signed-off-by please so I can apply.

Thanks.

> ---
>  drivers/input/mouse/synaptics.c |   13 +++++--------
>  1 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index a3bb49c..06c9ee5 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -1389,15 +1389,12 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
>  	int err = -1;
>  
>  	/*
> -	 * The OLPC XO has issues with Synaptics' absolute mode; similarly to
> -	 * the HGPK, it quickly degrades and the hardware becomes jumpy and
> -	 * overly sensitive.  Not only that, but the constant packet spew
> -	 * (even at a lowered 40pps rate) overloads the EC such that key
> -	 * presses on the keyboard are missed.  Given all of that, don't
> -	 * even attempt to use Synaptics mode.  Relative mode seems to work
> -	 * just fine.
> +	 * The OLPC XO has issues with Synaptics' absolute mode; the constant
> +	 * packet spew overloads the EC such that key presses on the keyboard
> +	 * are missed.  Given that, don't even attempt to use Absolute mode.
> +	 * Relative mode seems to work just fine.
>  	 */
> -	if (broken_olpc_ec) {
> +	if (absolute_mode && broken_olpc_ec) {
>  		psmouse_info(psmouse,
>  			     "OLPC XO detected, not enabling Synaptics protocol.\n");
>  		return -ENODEV;
> -- 
> 1.7.7.1
> 

-- 
Dmitry
