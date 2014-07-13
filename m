From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 05:45:22 +0200
Message-ID: <201407130545.23004.marex@denx.de>
References: <53C1F7DE.3060102@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53C1F7DE.3060102-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, teg-B22kvLQNl6c@public.gmane.org, Mischa.Jonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, richard-/L3Ra7n9ekc@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liqin Chen <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sunday, July 13, 2014 at 05:07:10 AM, Chen Gang wrote:
> Several drivers need 'devm_ioremap_resource' which need HAS_IOMEM enabled.
> So let them depend on HAS_IOMEM.
> 
> The related error (with allmodconfig under score):
> 
>     MODPOST 1365 modules
>   ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
>   ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko]
> undefined! ERROR: "devm_ioremap_resource"
> [drivers/staging/iio/adc/mxs-lradc.ko] undefined! ERROR:
> "devm_ioremap_resource" [drivers/pwm/pwm-clps711x.ko] undefined! ERROR:
> "devm_ioremap_resource" [drivers/input/serio/olpc_apsp.ko] undefined!
> ERROR: "devm_ioremap_resource" [drivers/input/serio/arc_ps2.ko] undefined!

This stuff should go through different trees, so I'd suggest to split this into 
multiple patches. Thanks for catching this stuff !

Best regards,
Marek Vasut
