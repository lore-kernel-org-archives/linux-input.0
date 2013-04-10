From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Date: Wed, 10 Apr 2013 16:25:24 +0900
Message-ID: <20130410072522.GB30873@verge.net.au>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
 <2096590.pSU6Gke5Ke@avalon>
 <20130409082833.GE18478@verge.net.au>
 <CABYn4sxYo6h5ZLQRPJcQ1iGhgGFLTaK9y=vNfcHa_4ED1FuKYA@mail.gmail.com>
 <20130409150103.GA27787@verge.net.au>
 <20130410065157.GB21515@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130410065157.GB21515@core.coreip.homeip.net>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 09, 2013 at 11:51:57PM -0700, Dmitry Torokhov wrote:
> On Wed, Apr 10, 2013 at 12:01:06AM +0900, Simon Horman wrote:
> > [ Cc Dimitry Torokhov ]
> > 
> > On Tue, Apr 09, 2013 at 11:23:51AM +0200, Bastian Hecht wrote:
> > > Hi Simon,
> > > 
> > > 2013/4/9 Simon Horman <horms@verge.net.au>:
> > > > On Mon, Apr 08, 2013 at 04:17:20PM +0200, Laurent Pinchart wrote:
> > > >> Hi Bastian,
> > > >>
> > > >> Thanks for the patch.
> > > >>
> > > >> On Monday 08 April 2013 14:52:26 Bastian Hecht wrote:
> > > >> > We add the possiblity to hand over a GPIO number for the reset pin.
> > > >> > This way we can remove existing board code that takes care of it and
> > > >> > group this information properly in the platform data or in the device
> > > >> > tree confguration.
> > > >> >
> > > >> > The implementation is analogous to the cy8ctmg110 driver, thanks.
> > > >> >
> > > >> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> > > >>
> > > >> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > >
> > > > Bastian, I'm unclear on which tree this will go through.
> > > > Please let me know if it is mine.
> > > 
> > > To be honest, no idea. If it doesn't have to be a maintainer of
> > > linux-input, I would be glad if you could take up that patch in your
> > > tree, yes. And for your information, I don't rely on it until the pfc
> > > DT version is merged. Then it would be nice to have it for the
> > > touchscreen in the arma reference implementation.
> > 
> > Dimitry,
> > 
> > you seem to have signed-off on most of the st1232 I see in the git history.
> > Could you take this patch?
> 
> Yes, I will, once feedback is addressed.

Great, thanks.
Please let me know if you need anything from me.
