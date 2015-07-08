From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific
 compatible property
Date: Wed, 8 Jul 2015 09:51:49 +0900
Message-ID: <20150708005148.GA28100@verge.net.au>
References: <1436180132-26190-1-git-send-email-geert+renesas@glider.be>
 <15966074.zDS67FO48r@avalon>
 <20150707002621.GD13326@verge.net.au>
 <9389528.5qtaECVqX7@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9389528.5qtaECVqX7@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 07, 2015 at 09:56:29AM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Tuesday 07 July 2015 09:26:21 Simon Horman wrote:
> > On Mon, Jul 06, 2015 at 04:29:33PM +0300, Laurent Pinchart wrote:
> > > On Monday 06 July 2015 12:55:32 Geert Uytterhoeven wrote:
> > > > Replace the deprecated generic "adi,adxl34x" compatible value by the
> > > > adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
> > > > i2c: Deprecate adi,adxl34x compatible string").
> > > > 
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > > ---
> > > > Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
> > > > support"), which is in v4.2-rc1.
> > > > 
> > > > This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
> > > > property".
> > 
> > It appears to me that this will cause a regression when booting old kernels
> > with new dts blobs. For that reason think we should consider v1
> > of this change coupled with a schedule to remove use of the deprecated
> > compat string.
> 
> That's the forward compatibility that Geert mentioned, is that really an 
> issue, especially on this board ?

I think it would be best to provide backwards compatibility unless there
is a compelling reason not to.
