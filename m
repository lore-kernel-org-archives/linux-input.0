From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH] drm: bridge: DRM_SIL_SII8620 should depend on, not
 select INPUT
Date: Sun, 21 Jul 2019 00:22:11 -0700
Message-ID: <20190721072211.GB7992@innovation.ch>
References: <CGME20190701033927epcas2p2d7d0b611a0d32b7b208acc787069a83a@epcas2p2.samsung.com>
 <8baa25c0-498b-d321-4e6a-fe987a4989ba@infradead.org>
 <a7edece4-fec4-5811-27a9-ca6c275a4c40@samsung.com>
 <d01a9ad5-edcd-81ec-6528-9b6a4e9a8754@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d01a9ad5-edcd-81ec-6528-9b6a4e9a8754@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Inki Dae <inki.dae@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


  Hi Andrzej,

On Mon, Jul 01, 2019 at 11:26:25AM +0200, Andrzej Hajda wrote:
> On 01.07.2019 11:23, Andrzej Hajda wrote:
> > On 01.07.2019 05:39, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> A single driver should not enable (select) an entire subsystem,
> >> such as INPUT, so change the 'select' to "depends on".
> >>
> >> Fixes: d6abe6df706c ("drm/bridge: sil_sii8620: do not have a dependency of RC_CORE")
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Inki Dae <inki.dae@samsung.com>
> >> Cc: Andrzej Hajda <a.hajda@samsung.com>
> >> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> >> Cc: dri-devel@lists.freedesktop.org
> >> ---
> >> Linus has written this a couple of times in the last 15 years or so,
> >> but my search fu cannot find it.  And there are a few drivers in the
> >> kernel tree that do this, but we shouldn't be adding more that do so.
> >
> > The proper solution has been already posted [1], but it has not been
> > applied yet to input tree?
> >
> > Randy are there chances your patchset will appear in ML in near future,
> > or should I merge your sii8620 patch alone?
> 
> 
> Ups, I used wrong surname, I meant Ronald, added him input ML to cc.

Looks like the applespi patches got merged, but they were changed at
the last minute to remove the imply's that lead to the Kconfig
dependency on the changes here. And I'm guessing for that reason the
patch [1] was not sent with that pull request in the end.

In short it seems to me that it would be best now if you sent a pull
request for patch [1] and Arnd Bergmann's followup patch that was
discussed in the last few days [2]. Sorry for all the delay.


  Cheers,

  Ronald


> > [1]:
> > https://lore.kernel.org/lkml/20190419081926.13567-2-ronald@innovation.ch/

[2] https://lore.kernel.org/lkml/20190718134240.2265724-1-arnd@arndb.de/


> > Regards
> >
> > Andrzej
> >
> >
> >
> >>  drivers/gpu/drm/bridge/Kconfig |    3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> --- lnx-52-rc7.orig/drivers/gpu/drm/bridge/Kconfig
> >> +++ lnx-52-rc7/drivers/gpu/drm/bridge/Kconfig
> >> @@ -83,10 +83,9 @@ config DRM_PARADE_PS8622
> >>  
> >>  config DRM_SIL_SII8620
> >>  	tristate "Silicon Image SII8620 HDMI/MHL bridge"
> >> -	depends on OF
> >> +	depends on OF && INPUT
> >>  	select DRM_KMS_HELPER
> >>  	imply EXTCON
> >> -	select INPUT
> >>  	select RC_CORE
> >>  	help
> >>  	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
> >>
> >>
> >>
> >>
> 
