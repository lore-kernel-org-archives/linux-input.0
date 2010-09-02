From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] input: add ABS definitions for 16 pressure sensitve
 pads
Date: Thu, 2 Sep 2010 11:40:27 +0200
Message-ID: <20100902094027.GL17833@buzzloop.caiaq.de>
References: <1281195497-6957-1-git-send-email-daniel@caiaq.de>
 <20100813033933.GE2661@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:46411 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0IBJkc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 05:40:32 -0400
Content-Disposition: inline
In-Reply-To: <20100813033933.GE2661@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Sorry for the long delay. 

On Thu, Aug 12, 2010 at 08:39:33PM -0700, Dmitry Torokhov wrote:
> On Sat, Aug 07, 2010 at 05:38:17PM +0200, Daniel Mack wrote:
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  include/linux/input.h           |   19 ++++++++++++++++++-
> >  include/linux/mod_devicetable.h |    2 +-
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 896a922..b88d965 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -709,13 +709,30 @@ struct input_absinfo {
> >  #define ABS_MT_TRACKING_ID	0x39	/* Unique ID of initiated contact */
> >  #define ABS_MT_PRESSURE		0x3a	/* Pressure on contact area */
> >  
> > +#define ABS_PAD0		0x40	/* pressure sensitive pads */
> > +#define ABS_PAD1		0x41
> > +#define ABS_PAD2		0x42
> > +#define ABS_PAD3		0x43
> > +#define ABS_PAD4		0x44
> > +#define ABS_PAD5		0x45
> > +#define ABS_PAD6		0x46
> > +#define ABS_PAD7		0x47
> > +#define ABS_PAD8		0x48
> > +#define ABS_PAD9		0x49
> > +#define ABS_PAD10		0x4a
> > +#define ABS_PAD11		0x4b
> > +#define ABS_PAD12		0x4c
> > +#define ABS_PAD13		0x4d
> > +#define ABS_PAD14		0x4e
> > +#define ABS_PAD15		0x4f
> > +
> 
> I do not think this is the direction I want to go. Even though the
> default size of the input devices (thanks to your work) is half of what
> it is used to be I do not think we should be assing such anonymous event
> types. How about creating separate vent devices that would report
> ABS_PRESSURE for these?  Obviously you need userspace to understand such
> compound device, the same as with new ABS_PAD* types.
> 
> I guess we need to increase numer of available event devices from 32 to
> something larger (dynamic dev_t?) first...

Hmm, I really don't know. As I mentioned before, the names for the
input controls my driver uses doesn't quite reflect the actual usage, or
the silk screen printed on the buttons of the devices, repectively.

So I tend to just use axes as anonymous indexes and assume the userspace
will map that to an appropriate function. And with this approach, I
actually do have enough address space available already.

I just considered adding these extra types for clearer definition of
what the do, but I agreee - it's actually quite some hazzle and the
impact to the userspace layer does not actually justify that.


Thanks,
Daniel

