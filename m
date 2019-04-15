From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v4 1/2] drm/bridge: sil_sii8620: make remote control
 optional.
Date: Sun, 14 Apr 2019 23:50:44 -0700
Message-ID: <20190415065044.GA14097@innovation.ch>
References: <20190407050358.2976-1-ronald@innovation.ch>
 <CGME20190407050410epcas1p3ec1f887f8ccf8ff4495f4557437cd594@epcas1p3.samsung.com>
 <20190407050358.2976-2-ronald@innovation.ch>
 <c861091d-f659-614d-65f4-6fe983885e09@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c861091d-f659-614d-65f4-6fe983885e09@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-input@vger.kernel.org


  Hi Andrzej,

On Wed, Apr 10, 2019 at 11:42:50AM +0200, Andrzej Hajda wrote:
> On 07.04.2019 07:03, Ronald Tschalär wrote:
> > commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
> > of RC_CORE) changed the driver to select both RC_CORE and INPUT.
> > However, this causes problems with other drivers, in particular an input
> > driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
> > commit):
> >
> >   drivers/clk/Kconfig:9:error: recursive dependency detected!
> >   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> >   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> >   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> >   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> >   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> >   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> >   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> >   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> >
> > According to the docs and general consensus, select should only be used
> > for non user-visible symbols, but both RC_CORE and INPUT are
> > user-visible. Furthermore almost all other references to INPUT
> > throughout the kernel config are depends, not selects. For this reason
> > the first part of this change reverts commit d6abe6df706c.
> >
> > In order to address the original reason for commit d6abe6df706c, namely
> > that not all boards use the remote controller functionality and hence
> > should not need have to deal with RC_CORE, the second part of this
> > change now makes the remote control support in the driver optional and
> > contingent on RC_CORE being defined. And with this the hard dependency
> > on INPUT also goes away as that is only needed if RC_CORE is defined
> > (which in turn already depends on INPUT).
[snip]
> What about:
> 
> ---------
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 8840f396a7b6..298189067929 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -86,8 +86,7 @@ config DRM_SIL_SII8620
>         depends on OF
>         select DRM_KMS_HELPER
>         imply EXTCON
> -       select INPUT
> -       select RC_CORE
> +       imply RC_CORE
>         help
>           Silicon Image SII8620 HDMI/MHL bridge chip driver.
>  
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c
> b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 0cc293a6ac24..df0f9dbbe839 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -1762,10 +1762,8 @@ static bool sii8620_rcp_consume(struct sii8620
> *ctx, u8 scancode)
>  
>         scancode &= MHL_RCP_KEY_ID_MASK;
>  
> -       if (!ctx->rc_dev) {
> -               dev_dbg(ctx->dev, "RCP input device not initialized\n");
> +       if (!IS_ENABLED(RC_CORE) || !ctx->rc_dev)
>                 return false;
> -       }
>  
>         if (pressed)
>                 rc_keydown(ctx->rc_dev, RC_PROTO_CEC, scancode, 0);
> @@ -2102,6 +2100,9 @@ static void sii8620_init_rcp_input_dev(struct
> sii8620 *ctx)
>         struct rc_dev *rc_dev;
>         int ret;
>  
> +       if (!IS_ENABLED(RC_CORE))
> +               return;
> +
>         rc_dev = rc_allocate_device(RC_DRIVER_SCANCODE);
>         if (!rc_dev) {
>                 dev_err(ctx->dev, "Failed to allocate RC device\n");
> @@ -2216,6 +2217,9 @@ static void sii8620_detach(struct drm_bridge *bridge)
>  {
>         struct sii8620 *ctx = bridge_to_sii8620(bridge);
>  
> +       if (!IS_ENABLED(RC_CORE))
> +               return;
> +
>         rc_unregister_device(ctx->rc_dev);
>  }
> -----------
> 
> Less changes, no conditional compilation - better compiler coverage,
> more readable.

This works for me (with RC_CORE replaced with CONFIG_RC_CORE). Sending
a new patch that includes this shortly.


  Cheers,

  Ronald
