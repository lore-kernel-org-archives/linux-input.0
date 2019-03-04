From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v2] drm/bridge: sil_sii8620: make remote control optional.
Date: Sun, 3 Mar 2019 18:13:25 -0800
Message-ID: <20190304021325.GA30785@innovation.ch>
References: <20190124072125.GA28127@innovation.ch>
 <20190125013355.GA6722@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190125013355.GA6722@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 24, 2019 at 05:33:55PM -0800, Ronald Tschalär wrote:
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
[snip]

Is there anything I can do to help get this reviewed and moved forward?


  Cheers,

  Ronald
