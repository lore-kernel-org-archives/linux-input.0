From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Tue, 14 Oct 2008 11:58:20 -0400
Message-ID: <20081014115820.21cd3d98@infradead.org>
References: <1223993968942@dmwebmail.dmwebmail.chezphil.org>
	<20081014104442.ZZRA012@mailhub.coreip.homeip.net>
	<20081014111236.2495140c@infradead.org>
	<20081014112912.ZZRA012@mailhub.coreip.homeip.net>
	<20081014113749.75278492@infradead.org>
	<20081014114658.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45807 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbYJNP6Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 11:58:16 -0400
In-Reply-To: <20081014114658.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Phil Endecott <phil_dubhl_endecott@chezphil.org>, linux-input <linux-input@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 14 Oct 2008 11:48:37 -0400
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, Oct 14, 2008 at 11:37:49AM -0400, Arjan van de Ven wrote:
> > On Tue, 14 Oct 2008 11:29:55 -0400
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > > On Tue, Oct 14, 2008 at 11:12:36AM -0400, Arjan van de Ven wrote:
> > > > On Tue, 14 Oct 2008 10:54:36 -0400
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > > On Tue, Oct 14, 2008 at 03:19:28PM +0100, Phil Endecott wrote:
> > > > > > What can be done about this?  Is it unreasonable for the
> > > > > > mouse probing to take 2 seconds?  Should it not be holding
> > > > > > the conflicting lock while it is probing?  Does the platform
> > > > > > matching code really need to hold the lock when it's just
> > > > > > comparing the string names of the device and driver?
> > > > > >
> > > > 
> > > > the real thing is to not wait on this while booting;
> > > > my fastboot git tree has the patches to fix that part..
> > > > 
> > > 
> > > Could you please be more specific?
> > \
> > oh btw you could make the mouse be exempt from this waiting that'd
> > be a much simpler/nicer solution ;-)
> > 
> 
> Like I said, mouse probing is done in kseriod which is a separate
> thread. If you look at the trace psmouse_init returned way way before,
> its pcspkr got stuck for some reason (after completing
> pcspkr_probe)...
but without that locking issue we still have the delay.
Because you run as a probe, and the kernel code waits until ALL probes
are done:
        /* wait for the known devices to complete their probing */
        while (driver_probe_done() != 0)
                msleep(100);


if the serio stuff wouldn't run as a "probe"... we wouldn't wait on it 
before mounting the root fs.

(and whoever comes up with "but I have my root fs on my mouse....
"LALALALALALA" <fingers in ears>)


> 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
