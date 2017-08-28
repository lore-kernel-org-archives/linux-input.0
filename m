From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: don't build m68kspkr when mach_beep is
 undefined
Date: Mon, 28 Aug 2017 09:50:31 -0700
Message-ID: <20170828165031.GD12195@dtor-ws>
References: <20170824144427.23873-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170824144427.23873-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Aug 24, 2017 at 04:44:27PM +0200, Alexandre Belloni wrote:
> mach_beep is defined arch/m68k/kernel/setup_mm.c which is compiled only
> when MMU is selected.
> 
> To avoid linking errors, make INPUT_M68K_BEEP depend on MMU.

Hmm, can we maybe pull mach_beep from setup_mm.c to setup.c? MMU
dependency seems to be artificial.

> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/input/misc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 3872488c3fd7..7a44f633a413 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -178,7 +178,7 @@ config INPUT_SPARCSPKR
>  
>  config INPUT_M68K_BEEP
>  	tristate "M68k Beeper support"
> -	depends on M68K
> +	depends on M68K && MMU
>  
>  config INPUT_MAX77693_HAPTIC
>  	tristate "MAXIM MAX77693/MAX77843 haptic controller support"
> -- 
> 2.14.1
> 

Thanks.

-- 
Dmitry
