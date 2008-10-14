From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Slow boot due perhaps to locks in mouse and platform system
Date: Tue, 14 Oct 2008 11:37:09 -0400
Message-ID: <20081014113709.5a2f2c2e@infradead.org>
References: <1223993968942@dmwebmail.dmwebmail.chezphil.org>
	<20081014104442.ZZRA012@mailhub.coreip.homeip.net>
	<20081014111236.2495140c@infradead.org>
	<20081014112912.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52832 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYJNPhH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Oct 2008 11:37:07 -0400
In-Reply-To: <20081014112912.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Phil Endecott <phil_dubhl_endecott@chezphil.org>, linux-input <linux-input@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

On Tue, 14 Oct 2008 11:29:55 -0400
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Tue, Oct 14, 2008 at 11:12:36AM -0400, Arjan van de Ven wrote:
> > On Tue, 14 Oct 2008 10:54:36 -0400
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > On Tue, Oct 14, 2008 at 03:19:28PM +0100, Phil Endecott wrote:
> > > > What can be done about this?  Is it unreasonable for the mouse
> > > > probing to take 2 seconds?  Should it not be holding the
> > > > conflicting lock while it is probing?  Does the platform
> > > > matching code really need to hold the lock when it's just
> > > > comparing the string names of the device and driver?
> > > >
> > 
> > the real thing is to not wait on this while booting;
> > my fastboot git tree has the patches to fix that part..
> > 
> 
> Could you please be more specific?

right now, the linux kernel boot will wait for this probing to be done
before mounting the root fs and then exec()ing /sbin/init.
On my test laptop this takes 7 seconds of .. nothing ;-)

the patch I have makes the kernel NOT wait for this, but just it tries
to mount root right away (and if that fails, it THEN waits and retries)

> 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
