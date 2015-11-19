From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Thu, 19 Nov 2015 09:56:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511190937440.20111@pobox.suse.cz>
References: <1447874755-8673-1-git-send-email-adi@adirat.com> <alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz> <20151118230544.5c6f0c26@adipc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151118230544.5c6f0c26@adipc>
Sender: linux-kernel-owner@vger.kernel.org
To: Ioan-Adrian Ratiu <adi@adirat.com>
Cc: pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Nov 2015, Ioan-Adrian Ratiu wrote:

> > > The critical section protected by usbhid->lock in hid_ctrl() is too
> > > big and in rare cases causes a recursive deadlock because of its call
> > > to hid_input_report().
> > > 
> > > This deadlock reproduces on newer wacom tablets like 056a:033c because
> > > the wacom driver in its irq handler ends up calling hid_hw_request()
> > > from wacom_intuos_schedule_prox_event() in wacom_wac.c. What this means
> > > is that it submits a report to reschedule a proximity read through a
> > > sync ctrl call which grabs the lock in hid_ctrl(struct urb *urb)
> > > before calling hid_input_report(). When the irq kicks in on the same
> > > cpu, it also tries to grab the lock resulting in a recursive deadlock.
> > > 
> > > The proper fix is to shrink the critical section in hid_ctrl() to
> > > protect only the instructions which modify usbhid, thus move the lock
> > > after the hid_input_report() call and the deadlock dissapears.  
> > 
> > I think the proper fix actually is to spin_lock_irqsave() in hid_ctrl(), 
> > isn't it?
> 
> That was my first attempt, yes, but the deadlock still happens with interrupts
> disabled. 

That unfortunately however directly implies that your explanation above 
isn't actually correct description of the real problem.

So we'd better first understand the problem rather than papering it over 
with more or less random fixes.

First, have you tried to run your usecase on your system with lockdep 
enabled?

Thanks,

-- 
Jiri Kosina
SUSE Labs
