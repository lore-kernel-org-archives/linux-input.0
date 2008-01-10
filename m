From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/6] Build system and MAINTAINERS entry for WM97xx touchscreen drivers
Date: Thu, 10 Jan 2008 16:41:18 +0100
Message-ID: <20080110154118.GC15361@uranus.ravnborg.org>
References: <1199965870-4629-1-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-2-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-3-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-4-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-5-git-send-email-broonie@opensource.wolfsonmicro.com> <1199965870-4629-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760006AbYAJPln@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1199965870-4629-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, Liam Girdwood <liam.girdwood@wolfsonmicro.com>
List-Id: linux-input@vger.kernel.org

Hi Mark.

On Thu, Jan 10, 2008 at 11:51:10AM +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
> ---
>  MAINTAINERS                        |    9 ++++++
>  drivers/input/touchscreen/Kconfig  |   52 ++++++++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/Makefile |   17 +++++++++++
>  3 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 35d4097..864d3b7 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -4,6 +4,8 @@
>  
>  # Each configuration option enables a list of files.
>  
> +wm97xx-ts-objs := wm97xx-core.o
Use 
wm97xx-ts-y := wm97xx-core.o

> +
>  obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
>  obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
>  obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corgi_ts.o
> @@ -19,3 +21,18 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
>  obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
>  obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
> +obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
> +obj-$(CONFIG_TOUCHSCREEN_WM97XX_PXA)	+= pxa-wm97xx.o
> +
> +ifeq ($(CONFIG_TOUCHSCREEN_WM9713),y)
> +wm97xx-ts-objs += wm9713.o
> +endif
So this becomes:
wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713) += wm9713.o

Same for the other two assignments.

	Sam


> +
> +ifeq ($(CONFIG_TOUCHSCREEN_WM9712),y)
> +wm97xx-ts-objs += wm9712.o
> +endif
> +
> +ifeq ($(CONFIG_TOUCHSCREEN_WM9705),y)
> +wm97xx-ts-objs += wm9705.o
> +endif
> +
