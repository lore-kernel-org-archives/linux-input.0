From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] input: make mainstone-wm97xx.c depend on MACH_MAINSTONE
	instead of ARCH_PXA
Date: Mon, 16 Jun 2008 15:06:16 +0300
Message-ID: <48565738.5030907@compulab.co.il>
References: <48564133.3070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <48564133.3070609@gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Eric,

Eric Miao wrote:
> If this is totally mainstone specific.

I had a quick glance at the driver, and I think it can be generalized to work on
other PXA platforms with WM97xx codecs. If you'd like to I can try to enable it
on EM-X270 to see if I'm right.

> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> ---
>  drivers/input/touchscreen/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 565ec71..17d0623 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -228,7 +228,7 @@ config TOUCHSCREEN_WM9713
>  
>  config TOUCHSCREEN_WM97XX_MAINSTONE
>  	tristate "WM97xx Mainstone accelerated touch"
> -	depends on TOUCHSCREEN_WM97XX && ARCH_PXA
> +	depends on TOUCHSCREEN_WM97XX && MACH_MAINSTONE
>  	help
>  	  Say Y here for support for streaming mode with WM97xx touchscreens
>  	  on Mainstone systems.

-- 
Sincerely yours,
Mike.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
