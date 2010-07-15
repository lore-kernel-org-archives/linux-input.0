From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: any value in running my kernel scanning scripts before
 release?
Date: Thu, 15 Jul 2010 18:50:20 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007151845490.11593@lynx>
References: <alpine.DEB.2.00.1007150728520.13042@lynx> <4C3F0D1B.9060403@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:39923 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934920Ab0GOWub (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jul 2010 18:50:31 -0400
In-Reply-To: <4C3F0D1B.9060403@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Greg KH <greg@kroah.com>

On Thu, 15 Jul 2010, Michal Marek wrote:

> On 07/15/2010 01:32 PM, Robert P. J. Day wrote:
> >
> >   normally i wait for the merge window, then run my kernel scanning
> > scripts and post results.  any interest in me doing that earlier?  i
> > just did a quick test and found a number of incongruities like, for
> > example:
> >
> > $ grep -r "config QT2160" *
> > drivers/input/keyboard/Kconfig:config QT2160
> > $
> >
> > $ grep -r KEYBOARD_QT2160 *
> > drivers/input/keyboard/Makefile:obj-$(CONFIG_KEYBOARD_QT2160) += qt2160.o
> > $
>
> These are plain bugs, so it's IMO OK to send fixes for these at any
> time before the final release. In the worst case, it will be merged
> after the final release.

  i wasn't suggesting that was the only example, only that it was an
obvious one.  there are others.  just for fun, here's the entire list
of references specifically from *Makefiles* to Kconfig variables that
don't exist (for whatever reason):

===== ATHEROS_AR71XX =====
./drivers/net/wireless/ath/ath9k/Makefile:ath9k-$(CONFIG_ATHEROS_AR71XX) += ahb.o
===== KEYBOARD_QT2160 =====
./drivers/input/keyboard/Makefile:obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
===== PCMCIA_IOCTL =====
./drivers/pcmcia/Makefile:pcmcia-$(CONFIG_PCMCIA_IOCTL)			+= pcmcia_ioctl.o
===== USB_ETH_FUNCTIONFS =====
./drivers/usb/gadget/Makefile:obj-$(CONFIG_USB_ETH_FUNCTIONFS)	+= g_eth_ffs.o

  in other words, none of that content is ever going to get compiled.
mercifully, there are only four examples of that left in the tree.
used to be a lot more.  clean up whatever catches your eye.

rday

p.s.  i cc'ed greg kh since i suspect he'll want to do something about
that last one.  i need sleep.

-- 

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Top-notch, inexpensive online Linux/OSS/kernel courses
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
