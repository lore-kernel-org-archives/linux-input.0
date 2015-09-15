From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 6/6] ARM: dts: set up trigger type for edt-ft5x06
 interrupts
Date: Tue, 15 Sep 2015 08:40:58 -0700
Message-ID: <20150915154058.GA4215@atomide.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
 <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
 <20150914212426.GA9968@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150914212426.GA9968-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [150914 14:28]:
> On Sat, Sep 12, 2015 at 10:45:51AM -0700, Dmitry Torokhov wrote:
> > Now that the driver respects IRQ trigger settings from device tree, let's
> > fix them up in individual DTSes (note that the driver is still compatible
> > with older DTSes).
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/am437x-sk-evm.dts   | 2 +-
> >  arch/arm/boot/dts/imx28-tx28.dts      | 3 ++-
> >  arch/arm/boot/dts/imx53-tx53-x03x.dts | 3 ++-
> >  arch/arm/boot/dts/imx6qdl-tx6.dtsi    | 3 ++-
> >  4 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> > index c17097d..d83fdcd 100644
> > --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > @@ -471,7 +471,7 @@
> >  
> >  		reg = <0x38>;
> >  		interrupt-parent = <&gpio0>;
> > -		interrupts = <31 0>;
> > +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> 
> for AM437x SK:
> 
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> 
> Seems like there are no changes considering driver was always using
> IRQF_TRIGGER_FALLING.

Should not cause merge conflicts AFAIK:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
