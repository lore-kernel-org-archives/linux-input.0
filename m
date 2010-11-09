From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add keycodes for touchpad on/off keys
Date: Mon, 8 Nov 2010 23:39:54 -0800
Message-ID: <20101109073953.GA14177@core.coreip.homeip.net>
References: <1289220130.5418.109.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48958 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab0KIHkB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 02:40:01 -0500
Received: by ywc21 with SMTP id 21so4026715ywc.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 23:40:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289220130.5418.109.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Nov 08, 2010 at 12:42:10PM +0000, Bastien Nocera wrote:
> Some laptops will have a "touchpad toggle" soft button, which
> expects user-space to turn off the touchpad themselves, some
> other devices will do this in hardware, but send key events telling
> us that the touchpad has been turned off/on.
> 
> KEY_TOUCHPAD_ON/KEY_TOUCHPAD_OFF will be used by user-space to
> show a popup with the status of the touchpad.
> 
> Signed-Off-By: Bastien Nocera <hadess@hadess.net>
> ---
>  include/linux/input.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 896a922..46dca75 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -545,6 +545,10 @@ struct input_absinfo {
>  #define KEY_CONTEXT_MENU	0x1b6	/* GenDesc - system context menu */
>  #define KEY_MEDIA_REPEAT	0x1b7	/* Consumer - transport control */
>  
> +#define KEY_TOUCHPAD_TOGGLE	0x1b8	/* Ask user-space to switch the touchpad off */

Just off or is it true toggle?

> +#define KEY_TOUCHPAD_ON		0x1b9	/* Tell user-space touchpad is now on */
> +#define KEY_TOUCHPAD_OFF	0x1ba	/* As above but off */

I do not like the idea that keycodes are limited to signalling the
state. Either they can also request the transition to given state or we
need to find some other way to communicate the state.

Thanks.

-- 
Dmitry
