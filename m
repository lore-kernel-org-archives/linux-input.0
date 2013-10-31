From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 04/19] input: sh_keysc: Enable the driver on all ARM
 platforms
Date: Thu, 31 Oct 2013 00:54:53 -0700
Message-ID: <20131031075453.GB2098@core.coreip.homeip.net>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383086274-11049-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 29, 2013 at 11:37:39PM +0100, Laurent Pinchart wrote:
> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> COMPILE_TEST.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index c1edd39..28d75c7 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -525,7 +525,7 @@ config KEYBOARD_SUNKBD
>  
>  config KEYBOARD_SH_KEYSC
>  	tristate "SuperH KEYSC keypad support"
> -	depends on SUPERH || ARCH_SHMOBILE
> +	depends on SUPERH || ARM || COMPILE_TEST
>  	help
>  	  Say Y here if you want to use a keypad attached to the KEYSC block
>  	  on SuperH processors such as sh7722 and sh7343.
> -- 
> 1.8.1.5
> 

-- 
Dmitry
