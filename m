From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Date: Wed, 23 Jan 2019 09:45:56 +0100
Message-ID: <20190123084556.gsospl6joh53qnzs@wunner.de>
References: <20190122141311.10445-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122141311.10445-1-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> INPUT. However, this causes problems with other drivers, in particular
> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> future commit):
> 
>   drivers/clk/Kconfig:9:error: recursive dependency detected!
>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> 
> According to the docs, select should only be used for non-visible
> symbols. Furthermore almost all other references to INPUT throughout the
> kernel config are depends, not selects. Hence this change.
> 
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I think this needs to be merged through the input tree as a prerequisite
for the applespi.c driver (keyboard + touchpad driver for 2015+ MacBook,
MacBook Air and MacBook Pro which uses SPI instead of USB) to avoid
breaking the build.  Adding Dmitry.

Thanks,

Lukas


> ---
>  drivers/gpu/drm/bridge/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..eabedc83f25c 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
>  config DRM_SIL_SII8620
>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
>  	depends on OF
> +	depends on INPUT
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
>  	select RC_CORE
>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
