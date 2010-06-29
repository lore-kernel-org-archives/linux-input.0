From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ARM: S3C64XX: Add s3c64xx support to touchscreen driver
Date: Tue, 29 Jun 2010 00:07:09 -0700
Message-ID: <20100629070709.GC19712@core.coreip.homeip.net>
References: <4BE290E5.9050703@gmail.com>
 <20100507004030.GX2589@trinity.fluff.org>
 <20100628183041.GC7427@core.coreip.homeip.net>
 <4C290FEF.5040405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C290FEF.5040405@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, arnaud.patard@rtp-net.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 28, 2010 at 11:11:11PM +0200, Maurus Cuelenaere wrote:
>  Op 28-06-10 20:30, Dmitry Torokhov schreef:
> > On Fri, May 07, 2010 at 01:40:30AM +0100, Ben Dooks wrote:
> >> On Thu, May 06, 2010 at 11:50:29AM +0200, Maurus Cuelenaere wrote:
> >>> Add support for the s3c64xx touchscreen to the s3c2410_ts driver,
> >>> ensuring it compiles and supports the extra features such as the
> >>> interrupt generation.
> >>>
> >>> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> >> Acked-by: Ben Dooks <ben-linux@fluff.org>
> > Hmm, it looks like I slept on th epatch for too long. Is it still
> > needed? Could you please rebase it against 2.6.35-rc*?
> >
> > Thanks!
> 
> This was superseded by "Input: s3c24xx_ts - Add FEAT for Samsung
> touchscreen support" which is already in Linus' tree AFAICR.
> 
> So you can drop this.
> 

Ah, great. Thank you for letting me know.

-- 
Dmitry
