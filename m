From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property
Date: Tue, 07 Jul 2015 09:56:29 +0300
Message-ID: <9389528.5qtaECVqX7@avalon>
References: <1436180132-26190-1-git-send-email-geert+renesas@glider.be> <15966074.zDS67FO48r@avalon> <20150707002621.GD13326@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150707002621.GD13326-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Simon,

On Tuesday 07 July 2015 09:26:21 Simon Horman wrote:
> On Mon, Jul 06, 2015 at 04:29:33PM +0300, Laurent Pinchart wrote:
> > On Monday 06 July 2015 12:55:32 Geert Uytterhoeven wrote:
> > > Replace the deprecated generic "adi,adxl34x" compatible value by the
> > > adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
> > > i2c: Deprecate adi,adxl34x compatible string").
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > 
> > > ---
> > > Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
> > > support"), which is in v4.2-rc1.
> > > 
> > > This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
> > > property".
> 
> It appears to me that this will cause a regression when booting old kernels
> with new dts blobs. For that reason think we should consider v1
> of this change coupled with a schedule to remove use of the deprecated
> compat string.

That's the forward compatibility that Geert mentioned, is that really an 
issue, especially on this board ?

> > > v2:
> > >   - Drop deprecated "adi,adxl34x"
> > > 
> > > ---
> > > 
> > >  arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> > > b/arch/arm/boot/dts/sh73a0-kzm9g.dts index
> > > 24b4cd24dceb2f9e..7fc5602810ad0da1 100644
> > > --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> > > +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> > > @@ -206,7 +206,7 @@
> > >  	};
> > >  	
> > >  	accelerometer@1d {
> > > -		compatible = "adi,adxl34x";
> > > +		compatible = "adi,adxl345";
> > >  		reg = <0x1d>;
> > >  		interrupt-parent = <&irqpin3>;
> > >  		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
