From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/9] IR: Kconfig fixes
Date: Wed, 28 Jul 2010 23:31:59 +0300
Message-ID: <1280349119.8891.6.camel@maxim-laptop>
References: <1280330051-27732-1-git-send-email-maximlevitsky@gmail.com>
	 <1280330051-27732-2-git-send-email-maximlevitsky@gmail.com>
	 <20100728103617.4b0207b9.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100728103617.4b0207b9.randy.dunlap@oracle.com>
Sender: linux-media-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>
List-Id: linux-input@vger.kernel.org

On Wed, 2010-07-28 at 10:36 -0700, Randy Dunlap wrote: 
> On Wed, 28 Jul 2010 18:14:03 +0300 Maxim Levitsky wrote:
> 
> > Move IR drives below separate menu.
> > This allows to disable them.
> > Also correct a typo.
> > 
> > Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> > ---
> >  drivers/media/IR/Kconfig |   14 +++++++++++---
> >  1 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/media/IR/Kconfig b/drivers/media/IR/Kconfig
> > index e557ae0..99ea9cd 100644
> > --- a/drivers/media/IR/Kconfig
> > +++ b/drivers/media/IR/Kconfig
> > @@ -1,8 +1,10 @@
> > -config IR_CORE
> > -	tristate
> > +menuconfig IR_CORE
> > +	tristate "Infrared remote controller adapters"
> >  	depends on INPUT
> >  	default INPUT
> >  
> > +if IR_CORE
> > +
> >  config VIDEO_IR
> >  	tristate
> >  	depends on IR_CORE
> > @@ -16,7 +18,7 @@ config LIRC
> >  	   Enable this option to build the Linux Infrared Remote
> >  	   Control (LIRC) core device interface driver. The LIRC
> >  	   interface passes raw IR to and from userspace, where the
> > -	   LIRC daemon handles protocol decoding for IR reception ann
> > +	   LIRC daemon handles protocol decoding for IR reception and
> >  	   encoding for IR transmitting (aka "blasting").
> >  
> >  source "drivers/media/IR/keymaps/Kconfig"
> > @@ -102,3 +104,9 @@ config IR_MCEUSB
> >  
> >  	   To compile this driver as a module, choose M here: the
> >  	   module will be called mceusb.
> > +
> > +
> > +
> > +
> > +
> > +endif #IR_CORE
> 
> I don't think that those extra blank lines are a fix...
Sure.
This patch series wasn't meant to be prefect, I rushed it a bit out of
dour.
When I split the patches, I forgot to remove that whitespace.

Other that that, any more comments?

Best regards,
Maxim Levitsky
