From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v3 1/4] drm/bridge: sil_sii8620: depend on INPUT instead
 of selecting it.
Date: Wed, 27 Mar 2019 17:07:43 -0700
Message-ID: <20190328000743.GB24753@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <CGME20190327014824epcas2p1f79a41c58f76150f7324169805f506f0@epcas2p1.samsung.com>
 <20190327014807.7472-2-ronald@innovation.ch>
 <9fd8af5b-20ed-5dca-7d5c-98f2926b9b0c@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9fd8af5b-20ed-5dca-7d5c-98f2926b9b0c@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: linux-input@vger.kernel.org


  Hi Andrzej,

On Wed, Mar 27, 2019 at 03:13:37PM +0100, Andrzej Hajda wrote:
> +cc: dri-devel
> 
> On 27.03.2019 02:48, Ronald Tschalär wrote:
> > commit d6abe6df706c66d803e6dd4fe98c1b6b7f125a56 (drm/bridge:
> > sil_sii8620: do not have a dependency of RC_CORE) added a dependency on
> > INPUT. However, this causes problems with other drivers, in particular
> > an input driver that depends on MFD_INTEL_LPSS_PCI (to be added in a
> > future commit):
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
> > According to the docs, select should only be used for non-visible
> > symbols. Furthermore almost all other references to INPUT throughout the
> > kernel config are depends, not selects. Hence this change.
> >
> > CC: Inki Dae <inki.dae@samsung.com>
> > CC: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> 
> This is drm bridge driver, next time please cc it to dri-devel ML also.

Ok. Though as noted in the cover letter, the patch here is meant as a
placeholder till the real thing being discussed on dri-devel is
finalized. I was trying to avoid cross-posting too much, hence the
separate submission on dri-devel.

> Anyway this is not the solution we have agreed to.
> 
> Why have you abandoned the patch [1]? It needed just some minor
> polishing, as I wrote in response to this mail.
> 
> [1]:
> https://lore.kernel.org/lkml/20190124082423.23139-1-ronald@innovation.ch/T/#mf620df0b1583096a214d8e2e690387078583472f

It seems your mail client doesn't like me :-) I got neither of your
responses. Sorry, I should've checked the archives when I didn't hear
anything. In any case thank you for your review, and I will update
that patch and send out a new version shortly.


  Cheers,

  Ronald


> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 2fee47b0d50b..eabedc83f25c 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -83,9 +83,9 @@ config DRM_PARADE_PS8622
> >  config DRM_SIL_SII8620
> >  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >  	depends on OF
> > +	depends on INPUT
> >  	select DRM_KMS_HELPER
> >  	imply EXTCON
> > -	select INPUT
> >  	select RC_CORE
> >  	help
> >  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
> 
> 
