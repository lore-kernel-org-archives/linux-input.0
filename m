From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: Tree for July 30
Date: Thu, 7 Aug 2008 11:50:31 -0700
Message-ID: <20080807115031.6e136ecf.akpm@linux-foundation.org>
References: <20080730170635.f737ffe9.sfr@canb.auug.org.au>
	<20080731104437.5e5669bc.akpm@linux-foundation.org>
	<20080731141302.ZZRA012@mailhub.coreip.homeip.net>
	<200807312048.57575.rjw@sisk.pl>
	<20080731145023.ZZRA012@mailhub.coreip.homeip.net>
	<alpine.LFD.1.10.0807311207000.3277@nehalem.linux-foundation.org>
	<20080731151625.ZZRA012@mailhub.coreip.homeip.net>
	<20080731194207.GA12233@anvil.corenet.prv>
	<20080731131056.eecc4826.akpm@linux-foundation.org>
	<20080807140357.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080807140357.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-next-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: torvalds@linux-foundation.org, rjw@sisk.pl, bzolnier@gmail.com, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 7 Aug 2008 14:11:09 -0400
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Thu, Jul 31, 2008 at 01:10:56PM -0700, Andrew Morton wrote:
> > 
> > If that works then great.  But I think the printk could be improved. 
> > Please provide sufficient information so that users (not programmers)
> > can go off and fix things up without needing to email kernel developers.
> > 
> > One suitable approach would be
> > 
> > 	printk("see http://userweb.kernel.org/~dtor/read-this.txt")
> > 
> 
> Ok, I made a small page here:
> 
> 	http://userweb.kernel.org/~dtor/eviocgbit-bug.html

You need to mv that file.  It's actually at
http://userweb.kernel.org/~dtor/eviogcbit-bug.html

And

     evdev.c(EVIOCGBIT): Suspicious buffer size 511, limiting output to 64
     bytes. See http://userweb.kernel.org/~dtor/eviocgbit-bug.html 

will get a 404.

typo: s/distribbution/distribution/

The text looks good.  A user would come away wondering which packages
need to be updated.  Do we have a suitable text pattern whcih will help
them?

On a fedora system I have

y:/home/akpm> rpm -qa|grep -i syna
synaptics-0.14.6-2.fc8

So "the synaptics package" would be a suitably distro-neutral description.

`rpm -qa|grep -i tslib' comes up blank so I don't know about that one.

> If you think this is sufficient I'd like to put the patch with the
> warning in 2.6.27 so people and distributions could start updarting
> affected programs.

Sure.  It'd make sense to get that warning into 2.6.25.x and 2.6.26.x
as well, to accelerate the process a bit.
