From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Thu, 19 Nov 2015 18:33:25 +0200
Message-ID: <20151119183325.265f02af@adipc>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
	<alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz>
	<20151118230544.5c6f0c26@adipc>
	<20151118235856.GA30351@jcartwri.amer.corp.natinst.com>
	<20151119084743.08d11238@adipc>
	<alpine.LNX.2.00.1511191005240.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38192 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757997AbbKSQd3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 11:33:29 -0500
Received: by wmec201 with SMTP id c201so125592234wme.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2015 08:33:28 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1511191005240.20111@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Josh Cartwright <joshc@ni.com>, pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 19 Nov 2015 10:10:19 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Thu, 19 Nov 2015, Ioan-Adrian Ratiu wrote:
> 
> > First part of lockdep report:
> > http://imgur.com/clLsCWe
> > 
> > Second part:
> > http://imgur.com/Wa2PzRl
> > 
> > Here are some printk's of mine while reproducing + debugging the issue:
> > http://imgur.com/SETOHT7  
> 
> So the real problem is that Intuos driver is calling hid_hw_request() 
> (which tries to grab the lock in usbhid_submit_report()) while handling 
> the CTRL IRQ (lock gets acquired there).
> 
> So the proper way to fix seems to be delaying the scheduling of the 
> proximity read event in wacom_intuos_inout() to workqueue.
> 
> > I'll continue to research this more in depth, but progress is slow 
> > because I don't have much time, I'm doing this in my spare time because 
> > it's my girlfriend's tablet.  
> 
> Oh, now I understand the level of severity of this bug! :-)
> 
> Thanks,
> 

Yes, exactly, you are beginning to understand! :)  When I've put my 2 variants
above to solve this deadlock, by "removing the call from wacom" at 1) I was
trying to say exactly this, removing it from the irq to a workqueue.

But please understand further my reasoning for submitting this patch. Consider
if this is a bug in the wacom driver or in the usbhid core? IMO
this is a usbhid bug: the critical region in hid_ctrl() is too big, there
is no reason for the call to hid_input_report() to be protected by
usbhid->lock.

The correct way to fix this deadlock is to fix the critical section in
usbhid, not remove the call from the wacom irq. If wacom wants to
reschedule in the irq, it should not deadlock on usbhid. "Fixing" the wacom call
would just work around the critical region bug inside usbhid.

I hope I've made myself clear this time; I really needed to explain this
patch better :( sorry.
