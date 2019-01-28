From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v2] drm/bridge: sil_sii8620: make remote control
 optional.
Date: Mon, 28 Jan 2019 11:53:38 +0100
Message-ID: <d7e8493b-a1fc-3f7d-c715-5f72f15f9320@samsung.com>
References: <20190124072125.GA28127@innovation.ch>
        <CGME20190125013406epcas3p2971d09f6836084e51cbf5d326593a93e@epcas3p2.samsung.com>
        <20190125013355.GA6722@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125013355.GA6722@innovation.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 25.01.2019 02:33, Ronald Tschalär wrote:
> commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> However, this causes problems with other drivers, in particular an input
> driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> commit):
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
> According to the docs and general consensus, select should only be used
> for non user-visible symbols, but both RC_CORE and INPUT are
> user-visible. Furthermore almost all other references to INPUT
> throughout the kernel config are depends, not selects. For this reason
> the first part of this change reverts commit d6abe6df706c.
>
> In order to address the original reason for commit d6abe6df706c, namely
> that not all boards use the remote controller functionality and hence
> should not need have to deal with RC_CORE, the second part of this
> change now makes the remote control support in the driver optional and
> contingent on RC_CORE being defined. And with this the hard dependency
> on INPUT also goes away as that is only needed if RC_CORE is defined
> (which in turn already depends on INPUT).


Thanks for fixing it, this seems to be a best way to deal with it, more
comments below.


>
> CC: Inki Dae <inki.dae@samsung.com>
> CC: Andrzej Hajda <a.hajda@samsung.com>
> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
> Resending this, as I somehow managed to forget to cc dri-devel.
> Apologies for the duplication.
>
> Changes in v2:
>  - completely remove dependencies on both RC_CORE and INPUT in Kconfig,
>  - make remote control functionality in driver contingent on RC_CORE
>    being defined
>
>  drivers/gpu/drm/bridge/Kconfig       |  2 --
>  drivers/gpu/drm/bridge/sil-sii8620.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2fee47b0d50b..a11198a36005 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -85,8 +85,6 @@ config DRM_SIL_SII8620
>  	depends on OF
>  	select DRM_KMS_HELPER
>  	imply EXTCON
> -	select INPUT
> -	select RC_CORE


Shouldn't you put here "imply RC_CORE"? To avoid RC_CORE as module and
sii8620 built-in.


>  	help
>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
>  
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 0cc293a6ac24..dee47752791e 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -66,7 +66,9 @@ enum sii8620_mt_state {
>  struct sii8620 {
>  	struct drm_bridge bridge;
>  	struct device *dev;
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  	struct rc_dev *rc_dev;
> +#endif
>  	struct clk *clk_xtal;
>  	struct gpio_desc *gpio_reset;
>  	struct gpio_desc *gpio_int;
> @@ -1756,6 +1758,7 @@ static void sii8620_send_features(struct sii8620 *ctx)
>  	sii8620_write_buf(ctx, REG_MDT_XMIT_WRITE_PORT, buf, ARRAY_SIZE(buf));
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
>  {
>  	bool pressed = !(scancode & MHL_RCP_KEY_RELEASED_MASK);
> @@ -1774,6 +1777,12 @@ static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
>  
>  	return true;
>  }
> +#else
> +static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
> +{
> +	return false;
> +}
> +#endif
>  
>  static void sii8620_msc_mr_set_int(struct sii8620 *ctx)
>  {
> @@ -2097,6 +2106,7 @@ static void sii8620_cable_in(struct sii8620 *ctx)
>  	enable_irq(to_i2c_client(ctx->dev)->irq);
>  }
>  
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  {
>  	struct rc_dev *rc_dev;
> @@ -2126,6 +2136,11 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>  	}
>  	ctx->rc_dev = rc_dev;
>  }
> +#else
> +static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
> +{
> +}
> +#endif
>  
>  static void sii8620_cable_out(struct sii8620 *ctx)
>  {
> @@ -2214,9 +2229,11 @@ static int sii8620_attach(struct drm_bridge *bridge)
>  
>  static void sii8620_detach(struct drm_bridge *bridge)
>  {
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
>  
>  	rc_unregister_device(ctx->rc_dev);
> +#endif
>  }


In two cases you create stub functions, in the third you put ifdefs
inside function, some lack of consistency.

I wonder if it wouldn't be better to create stubs just for rc_core
functions, the best would be to put stubs into rc-core.h, but if the
case of 'optional rc-core' is too rare you can put stubs into the driver:

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c
b/drivers/gpu/drm/bridge/sil-sii8620.c

index a6e8f4591e63..6ca838d30f93 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -35,6 +35,13 @@
 
 #include "sil-sii8620.h"
 
+#if !IS_ENABLED(CONFIG_RC_CORE)
+#define rc_unregister_device(dev) ({ (void)(dev); })
+#define rc_allocate_device(type) ({ NULL; })
+#define rc_keydown(...) ({ })
+#define rc_keyup(...) ({ })
+#endif
+
 #define SII8620_BURST_BUF_LEN 288
 #define VAL_RX_HDMI_CTRL2_DEFVAL VAL_RX_HDMI_CTRL2_IDLE_CNT(3)

Regards

Andrzej


>  
>  static int sii8620_is_packing_required(struct sii8620 *ctx,
