From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: add new keycodes useful in mobile
	devices
Date: Fri, 23 Oct 2009 00:13:15 -0700
Message-ID: <20091023071315.GA3986@core.coreip.homeip.net>
References: <cover.1256200562.git.ext-jani.1.nikula@nokia.com> <72a6deb76f693b5e50dbfe150154e7a4724d0568.1256200562.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34028 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbZJWHNQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2009 03:13:16 -0400
Received: by pwj9 with SMTP id 9so28892pwj.21
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2009 00:13:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <72a6deb76f693b5e50dbfe150154e7a4724d0568.1256200562.git.ext-jani.1.nikula@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Jani,

On Thu, Oct 22, 2009 at 12:32:20PM +0300, Jani Nikula wrote:
> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
> 
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
> ---
>  include/linux/input.h |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 0ccfc30..3c246b1 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -595,6 +595,8 @@ struct input_absinfo {
>  #define KEY_NUMERIC_STAR	0x20a
>  #define KEY_NUMERIC_POUND	0x20b
>  
> +#define KEY_CAMERA_FOCUS	0x210

I believe that this has already been discussed and I am OK with adding
such keycode, as long and there are in-kernel users.

> +
>  /* We avoid low common keys in module aliases so they don't get huge. */
>  #define KEY_MIN_INTERESTING	KEY_MUTE
>  #define KEY_MAX			0x2ff
> @@ -677,6 +679,9 @@ struct input_absinfo {
>  #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
>  #define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
>  #define SW_VIDEOOUT_INSERT	0x08  /* set = inserted */
> +#define SW_CAMERA_LENSE_COVER	0x09  /* set = lense covered */
> +#define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
> +#define SW_PROXIMITY		0x0b  /* set = proximity sensor covered */

Don't quite like the name for this one, any alternatives?

>  #define SW_MAX			0x0f
>  #define SW_CNT			(SW_MAX+1)
>  

Thanks.

-- 
Dmitry
