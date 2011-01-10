From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add new button type
Date: Mon, 10 Jan 2011 11:19:16 -0800
Message-ID: <20110110191916.GA30413@core.coreip.homeip.net>
References: <20110110140131.11536.46959.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57027 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab1AJTTW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jan 2011 14:19:22 -0500
Received: by pwj3 with SMTP id 3so2738324pwj.19
        for <linux-input@vger.kernel.org>; Mon, 10 Jan 2011 11:19:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110110140131.11536.46959.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: x86@kernel.org, linux-input@vger.kernel.org, jekyll_lai@wistron.com

On Mon, Jan 10, 2011 at 02:01:32PM +0000, Alan Cox wrote:
> From: Jekyll Lai <jekyll.lai@gmail.com>
> 
> This patch added a new switch event, SW_ROTATE_LOCK, which is used on one
> of the Moorestown platforms.

Could we get a bit more explanation (preferably right in input.h) as to
what exactly this switch conveys to userspace? I guess it disables
portrait->landscape screen transition on the phone?

Thanks.

> 
> Signed-off-by: Jekyll Lai <jekyll_lai@wistron.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  arch/x86/platform/mrst/mrst.c |    2 ++
>  include/linux/input.h         |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/arch/x86/platform/mrst/mrst.c b/arch/x86/platform/mrst/mrst.c
> index a9686c3..cc749dc 100644
> --- a/arch/x86/platform/mrst/mrst.c
> +++ b/arch/x86/platform/mrst/mrst.c
> @@ -822,6 +822,8 @@ static struct gpio_keys_button gpio_button[] = {
>  	{KEY_CAMERA_FOCUS,	-1, 1, "camera_half",	EV_KEY, 0, 20},
>  	{SW_KEYPAD_SLIDE,	-1, 1, "MagSw1",	EV_SW,  0, 20},
>  	{SW_KEYPAD_SLIDE,	-1, 1, "MagSw2",	EV_SW,  0, 20},
> +	{KEY_HOMEPAGE,		-1, 1, "home_btn",	EV_KEY, 0, 20},
> +	{SW_ROTATE_LOCK,	-1, 1, "rot_lock",	EV_SW, 0, 20},
>  };
>  
>  static struct gpio_keys_platform_data mrst_gpio_keys = {
> diff --git a/include/linux/input.h b/include/linux/input.h
> index c4e9d91..79fc30e 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -802,6 +802,7 @@ struct input_keymap_entry {
>  #define SW_CAMERA_LENS_COVER	0x09  /* set = lens covered */
>  #define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
>  #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
> +#define SW_ROTATE_LOCK		0x0c  /* set = rotate lock */
>  #define SW_MAX			0x0f
>  #define SW_CNT			(SW_MAX+1)
>  
> 

-- 
Dmitry
