From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux-next: Tree for July 30
Date: Fri, 1 Aug 2008 15:23:52 -0400
Message-ID: <20080801151758.ZZRA012@mailhub.coreip.homeip.net>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au> <20080731104437.5e5669bc.akpm@linux-foundation.org> <20080731141302.ZZRA012@mailhub.coreip.homeip.net> <200807312048.57575.rjw@sisk.pl> <20080731145023.ZZRA012@mailhub.coreip.homeip.net> <alpine.LFD.1.10.0807311207000.3277@nehalem.linux-foundation.org> <20080731151625.ZZRA012@mailhub.coreip.homeip.net> <20080731194207.GA12233@anvil.corenet.prv> <alpine.LFD.1.10.0808011201480.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808011201480.3277@nehalem.linux-foundation.org>
Sender: linux-next-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 01, 2008 at 12:12:19PM -0700, Linus Torvalds wrote:
> 
> Ok, I apparently missed this whole subthread yesterday, only getting back 
> to it when going over my old queues.
> 
> On Thu, 31 Jul 2008, Dmitry Torokhov wrote:
> > 
> > Input: paper over a bug in Synaptics X driver
> 
> Yeah, it's not pretty, but how about moving that EV_KEY thing into the 
> switch() statement?

I want to to be visually separated. It is not a hot path so extra
comparison won't hurt us.

> Also, the printk could certainly be a bit more useful.

I think I will follow Andrew's advice and point people to a page on
kernel.org (to be written).

> have that four-deep indentation by just splitting that horrible function 
> up a bit.
> 
> IOW, start off with a patch like the appended,

Makes sense. Signed-off-by please ;)

-- 
Dmitry
