From: Jan-Matthias Braun <jan_braun@gmx.net>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Wed, 05 Dec 2012 10:12:57 +0100
Message-ID: <1462361.9xDllZxTUO@orthese>
References: <8159607.SRZZrRIPNF@orthese> <201212042311.27348.jan_braun@gmx.net> <2593830.jzurf9PFEe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:49248 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751737Ab2LEJNO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Dec 2012 04:13:14 -0500
In-Reply-To: <2593830.jzurf9PFEe@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

Am Mittwoch, 5. Dezember 2012, 01:28:53 schrieb Rafael J. Wysocki:
> On Tuesday, December 04, 2012 11:11:27 PM Jan-Matthias Braun wrote:
> > Am Donnerstag 29. November 2012, 23:28:55 schrieb Rafael J. Wysocki:
> > > On Thursday, November 29, 2012 03:03:04 PM Jan-Matthias Braun wrote:
> > > > Am Donnerstag, 29. November 2012, 01:20:04 schrieb Rafael J. Wysocki:
> > > > > On Tuesday, November 27, 2012 09:26:11 PM Jiri Kosina wrote:
> > > > > > On Sun, 25 Nov 2012, Jan-Matthias Braun wrote:
> > > > > > > I have now done a git bisection from 3.0 to 3.1 and have found commit
> > > > > > > 1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race conditions between runtime PM and system sleep (v2)
> > > > > > > to be the first one to introduce the necessity of a module reload after resume.
> > > > > 
> > > > > So with that commit your device doesn't work after resume from system suspend
> > > > > unless you reload the driver?
> > > > 
> > > > Yes. Additionally, with later kernel revisions even this won't help, but I could imagine this to be a consequence of the same problem.
> > > > 
> > > > > > > I hope that this helps in finding a solution. As I (again) don't immediatly
> > > > > > > know how to go on, I kindly ask you to give me some hints for testing/patching
> > > > > > > or even a possible solution. :-)
> > > > > 
> > > > > Can you apply the patch below to the current mainline kernel and see if it makes any
> > > > > difference, please?
> > > > 
> > > > It does: Current mainline kernel (version >3.7.0-rc7 from git) is not showing
> > > > the problem, if the patch is applied.
> > > 
> > > If you apply the patch below instead of the previous one, does it make
> > > the problem return, or is it still good?
> > 
> > again, the problem does not occur; the resume behaviour of the touchscreen is still good.
> > 
> > Thanks a lot for testing!
> 
> Well, thank you. :-)
> 
> I'll add a changelog to this patch and submit it as a fix for the issue
> you're observing.

Great! Thank you and all others involved for their time!

Jan-Matthias Braun
