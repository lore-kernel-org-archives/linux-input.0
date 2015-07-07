From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific
 compatible property
Date: Tue, 7 Jul 2015 09:26:21 +0900
Message-ID: <20150707002621.GD13326@verge.net.au>
References: <1436180132-26190-1-git-send-email-geert+renesas@glider.be>
 <15966074.zDS67FO48r@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15966074.zDS67FO48r@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 06, 2015 at 04:29:33PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Monday 06 July 2015 12:55:32 Geert Uytterhoeven wrote:
> > Replace the deprecated generic "adi,adxl34x" compatible value by the
> > adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
> > i2c: Deprecate adi,adxl34x compatible string").
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> > ---
> > Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
> > support"), which is in v4.2-rc1.
> > 
> > This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
> > property".

It appears to me that this will cause a regression when booting old kernels
with new dts blobs. For that reason think we should consider v1
of this change coupled with a schedule to remove use of the deprecated
compat string.

> > v2:
> >   - Drop deprecated "adi,adxl34x"
> > ---
> >  arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> > b/arch/arm/boot/dts/sh73a0-kzm9g.dts index
> > 24b4cd24dceb2f9e..7fc5602810ad0da1 100644
> > --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> > +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> > @@ -206,7 +206,7 @@
> >  	};
> > 
> >  	accelerometer@1d {
> > -		compatible = "adi,adxl34x";
> > +		compatible = "adi,adxl345";
> >  		reg = <0x1d>;
> >  		interrupt-parent = <&irqpin3>;
> >  		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
