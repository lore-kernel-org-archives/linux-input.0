From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/7] rtc: arm: imx: snvs: change use syscon to access
 register
Date: Sat, 16 May 2015 16:04:22 +0200
Message-ID: <20150516140422.GL3338@piout.net>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
 <1431696990-23078-3-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431696990-23078-3-git-send-email-Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: lznuaa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On 15/05/2015 at 21:36:25 +0800, Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote :
> From: Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> snvs included rtc, on/off key, power-off module
> change to syscon to access register
> 
> Signed-off-by: Frank Li <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/rtc/rtc-snvs.c | 124 +++++++++++++++++++++----------------------------
>  1 file changed, 54 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index 0479e80..4e85fbe 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -18,14 +18,16 @@
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>  #include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  /* These register offsets are relative to LP (Low Power) range */
Shouldn't you remove that comment ?

> -#define SNVS_LPCR		0x04
> -#define SNVS_LPSR		0x18
> -#define SNVS_LPSRTCMR		0x1c
> -#define SNVS_LPSRTCLR		0x20
> -#define SNVS_LPTAR		0x24
> -#define SNVS_LPPGDR		0x30
> +#define SNVS_LPCR		0x38
> +#define SNVS_LPSR		0x4c
> +#define SNVS_LPSRTCMR		0x50
> +#define SNVS_LPSRTCLR		0x54
> +#define SNVS_LPTAR		0x58
> +#define SNVS_LPPGDR		0x64
>  
>  #define SNVS_LPCR_SRTC_ENV	(1 << 0)
>  #define SNVS_LPCR_LPTA_EN	(1 << 1)
> @@ -37,31 +39,35 @@
>  
>  struct snvs_rtc_data {
>  	struct rtc_device *rtc;
> -	void __iomem *ioaddr;
> +	struct regmap *snvs;
>  	int irq;
>  	spinlock_t lock;

This lock can probably be removed, if I'm not mistaken the only use left
is its initialization.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
