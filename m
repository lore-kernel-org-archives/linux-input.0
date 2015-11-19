From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Thu, 19 Nov 2015 08:47:43 +0200
Message-ID: <20151119084743.08d11238@adipc>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
	<alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz>
	<20151118230544.5c6f0c26@adipc>
	<20151118235856.GA30351@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35196 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbKSGrr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 01:47:47 -0500
Received: by wmdw130 with SMTP id w130so227278150wmd.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2015 22:47:46 -0800 (PST)
In-Reply-To: <20151118235856.GA30351@jcartwri.amer.corp.natinst.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Cc: Jiri Kosina <jikos@kernel.org>, pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Nov 2015 17:58:56 -0600
Josh Cartwright <joshc@ni.com> wrote:

> On Wed, Nov 18, 2015 at 11:05:44PM +0200, Ioan-Adrian Ratiu wrote:
> > On Wed, 18 Nov 2015 21:37:42 +0100 (CET)
> > Jiri Kosina <jikos@kernel.org> wrote:
> >   
> > > On Wed, 18 Nov 2015, Ioan-Adrian Ratiu wrote:
> > >   
> > > > The critical section protected by usbhid->lock in hid_ctrl() is too
> > > > big and in rare cases causes a recursive deadlock because of its call
> > > > to hid_input_report().
> > > > 
> > > > This deadlock reproduces on newer wacom tablets like 056a:033c because
> > > > the wacom driver in its irq handler ends up calling hid_hw_request()
> > > > from wacom_intuos_schedule_prox_event() in wacom_wac.c. What this means
> > > > is that it submits a report to reschedule a proximity read through a
> > > > sync ctrl call which grabs the lock in hid_ctrl(struct urb *urb)
> > > > before calling hid_input_report(). When the irq kicks in on the same
> > > > cpu, it also tries to grab the lock resulting in a recursive deadlock.
> > > > 
> > > > The proper fix is to shrink the critical section in hid_ctrl() to
> > > > protect only the instructions which modify usbhid, thus move the lock
> > > > after the hid_input_report() call and the deadlock dissapears.    
> > > 
> > > I think the proper fix actually is to spin_lock_irqsave() in hid_ctrl(), 
> > > isn't it?
> > >   
> > 
> > That was my first attempt, yes, but the deadlock still happens with
> > interrupts disabled. It is very weird, I know.  
> 
> I think your best course of action is to figure out why this is the
> case, instead of continuing with trying to solve the symptoms.  Do you
> have actual callstacks showing the cases where you hit?  That might be
> useful to share (your lockdep picture cuts out the callstacks).
> 
> Also, have you tried without the PREEMPT_RT patch in the picture at all?
> 
>   Josh

Yes, of course I tried it without PREEMPT_RT_FULL :) This happens on vanilla
mainline kernels (only after 4.4-rc1 which introduced support for this kind of
tablets).

I also backported all the wacom patches to 4.1 non-RT and the same deadlock
happens.

I've sent another email with some lockdep traces and printk's on a running
vanilla linux-next, maybe it didn't get through, here are the links again:

First part of lockdep report:
http://imgur.com/clLsCWe

Second part:
http://imgur.com/Wa2PzRl

Here are some printk's of mine while reproducing + debugging the issue:
http://imgur.com/SETOHT7

I'll continue to research this more in depth, but progress is slow because I
don't have much time, I'm doing this in my spare time because it's my
girlfriend's tablet.
