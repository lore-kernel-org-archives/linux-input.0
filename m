From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: atari - Enable the 102nd key for German keyboards
Date: Sat, 17 Jan 2015 14:12:44 -0800
Message-ID: <20150117221244.GA38334@dtor-ws>
References: <1421517725-31970-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421517725-31970-1-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>, linux-input@vger.kernel.org, linux-m68k@vger.kernel.org, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 17, 2015 at 07:02:05PM +0100, Geert Uytterhoeven wrote:
> From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> Acked-by: Thorsten Glaser <tg@mirbsd.org>
> Tested-by: Stefan Niestegge <beetle@atari.org>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thank you.

> ---
>  drivers/input/keyboard/atakbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/atakbd.c b/drivers/input/keyboard/atakbd.c
> index 10bcd4ae5402..f1235831283d 100644
> --- a/drivers/input/keyboard/atakbd.c
> +++ b/drivers/input/keyboard/atakbd.c
> @@ -170,7 +170,7 @@ static unsigned char atakbd_keycode[0x72] = {	/* American layout */
>  	[93]	 = KEY_KPASTERISK,
>  	[94]	 = KEY_KPPLUS,
>  	[95]	 = KEY_HELP,
> -	[96]	 = KEY_BACKSLASH,	/* FIXME: '<' */
> +	[96]	 = KEY_102ND,
>  	[97]	 = KEY_KPASTERISK,	/* FIXME */
>  	[98]	 = KEY_KPSLASH,
>  	[99]	 = KEY_KPLEFTPAREN,
> -- 
> 1.9.1
> 

-- 
Dmitry
