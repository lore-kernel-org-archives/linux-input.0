From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: BUG in sermouse driver
Date: Mon, 10 Mar 2008 10:13:16 -0400
Message-ID: <20080310100940.ZZRA012@mailhub.coreip.homeip.net>
References: <20080310093039.GA26118@localhost.localdomain> <Pine.LNX.4.64.0803101130060.18589@twin.jikos.cz> <20080310120137.GB29197@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:18961 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYCJONV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2008 10:13:21 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1897540wff.4
        for <linux-input@vger.kernel.org>; Mon, 10 Mar 2008 07:13:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080310120137.GB29197@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, Ondrej Zajicek <santiago@crfreenet.org>, linux-input@vger.kernel.org

Hi,

On Mon, Mar 10, 2008 at 01:01:37PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > There is a bug in sermouse driver that inputattach program terminates 
> > > during suspend (or resume) to ram hence mouse does not work afer resume. 
> > > When i execute inputattach after resume, the mouse is working.
> > 
> > I know that Pavel (added to CC) knows where the problem is (improper fake 
> > signal handling around try_to_freeze() call), I guess he'd be able to 
> > provide a patch to test.
> 
> I don't have a patch ready, but I believe we localized the problem to
> serport_ldisc_read().
> 
>         wait_event_interruptible(serport->wait,
> +test_bit(SERPORT_DEAD,&serport->flags));
> 
> It does interruptible wait, but does not expect signals. We tried
> something like:
> 
> do {
>         wait_event_interruptible(serport->wait, test_bit(SERPORT_DEAD,&serport->flags));
> } while (try_to_freeze());
> 
> ...but that did not help IIRC.

I think the current behavior is correct one. The device 99% of the
time needs to be re-initialized after suspend to ram so returning
from read is sane thing to do, this allows us to singnal userspace
that device needs attention.

As far as userspace goes we could either try to get inputattach
reinitialize device or just make sure that inputattach is called
again from resume scripts.

-- 
Dmitry
