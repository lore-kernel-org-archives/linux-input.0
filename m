From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge: sil_sii8620: depend on INPUT instead of
 selecting it.
Date: Thu, 24 Jan 2019 00:17:35 +0200
Message-ID: <20190123221735.GE4675@pendragon.ideasonboard.com>
References: <20190122141311.10445-1-ronald@innovation.ch>
 <20190123084556.gsospl6joh53qnzs@wunner.de>
 <20190123220342.GC179701@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123220342.GC179701@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lukas Wunner <lukas@wunner.de>, Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Dmity,

On Wed, Jan 23, 2019 at 02:03:42PM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 23, 2019 at 09:45:56AM +0100, Lukas Wunner wrote:
> > On Tue, Jan 22, 2019 at 06:13:11AM -0800, Ronald Tschalär wrote:
> >> commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> >> sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> >> INPUT. However, this causes problems with other drivers, in particular
> >> an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> >> future commit):
> >> 
> >>   drivers/clk/Kconfig:9:error: recursive dependency detected!
> >>   drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
> >>   drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
> >>   drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
> >>   drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
> >>   drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
> >>   drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
> >>   drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
> >>   drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK
> >> 
> >> According to the docs, select should only be used for non-visible
> >> symbols. Furthermore almost all other references to INPUT throughout the
> >> kernel config are depends, not selects. Hence this change.
> 
> I think this is not as cut and dry. We should be able to select needed
> subsystems (such as INPUT, USB, etc) even if they are user visible.

Semantically, maybe, but given the current state of Kconfig this results
in a recursive dependencies nightmare. It's a no-go.

> User, when enabling a piece of hardware, does not need to know ultimate
> details of all subsystems the driver might need ti function.
> 
> It looks like one of the drivers implies MFD_INTEL_LPSS_PCI, maybe
> treating imply the same as select when detecting circular dependency is
> wrong as we are allowed to deselect implied dependencies?
> 
> >> 
> >> CC: Inki Dae <inki.dae@samsung.com>
> >> CC: Andrzej Hajda <a.hajda@samsung.com>
> >> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> > 
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > 
> > I think this needs to be merged through the input tree as a prerequisite
> > for the applespi.c driver (keyboard + touchpad driver for 2015+ MacBook,
> > MacBook Air and MacBook Pro which uses SPI instead of USB) to avoid
> > breaking the build.  Adding Dmitry.
> 
> I have no idea what applespi.c is (it is definitely not in my tree), so
> I think it should be merged through the same tree that the original
> commit was introduced through.
> 
> >> ---
> >>  drivers/gpu/drm/bridge/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >> index 2fee47b0d50b..eabedc83f25c 100644
> >> --- a/drivers/gpu/drm/bridge/Kconfig
> >> +++ b/drivers/gpu/drm/bridge/Kconfig
> >> @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
> >>  config DRM_SIL_SII8620
> >>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >>  	depends on OF
> >> +	depends on INPUT
> >>  	select DRM_KMS_HELPER
> >>  	imply EXTCON
> >> -	select INPUT
> >>  	select RC_CORE
> 
> Keeping "select RC_CORE" is wrong though, as the driver appears to be
> working find without RC. Maybe it should be stubbed out?

It should definitely not be select'ed as it's a user-visible symbol. My
preference would be to simply revert d6abe6df706c. If we want (and can)
work without RC core then it should be stubbed out.

Commit d6abe6df706c states

    And some boards not using remote controller device don't really
    need to know that RC_CORE config should be enabled to use sil_sii8620
    driver only for HDMI.

The same reasoning applies to INPUT, if we agree that depending on
RC_CORE is confusing for users, then depending on INPUT is confusing as
well. There's not reason to apply different standards to INPUT and
RC_CORE, depending on one and selecting the other doesn't make much
sense.

-- 
Regards,

Laurent Pinchart
