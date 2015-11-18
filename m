From: Ioan-Adrian Ratiu <adi-VBHIVgTnVYLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Wed, 18 Nov 2015 23:05:44 +0200
Message-ID: <20151118230544.5c6f0c26@adipc>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
	<alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1511182137020.20111-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: pinglinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Nov 2015 21:37:42 +0100 (CET)
Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, 18 Nov 2015, Ioan-Adrian Ratiu wrote:
> 
> > The critical section protected by usbhid->lock in hid_ctrl() is too
> > big and in rare cases causes a recursive deadlock because of its call
> > to hid_input_report().
> > 
> > This deadlock reproduces on newer wacom tablets like 056a:033c because
> > the wacom driver in its irq handler ends up calling hid_hw_request()
> > from wacom_intuos_schedule_prox_event() in wacom_wac.c. What this means
> > is that it submits a report to reschedule a proximity read through a
> > sync ctrl call which grabs the lock in hid_ctrl(struct urb *urb)
> > before calling hid_input_report(). When the irq kicks in on the same
> > cpu, it also tries to grab the lock resulting in a recursive deadlock.
> > 
> > The proper fix is to shrink the critical section in hid_ctrl() to
> > protect only the instructions which modify usbhid, thus move the lock
> > after the hid_input_report() call and the deadlock dissapears.  
> 
> I think the proper fix actually is to spin_lock_irqsave() in hid_ctrl(), 
> isn't it?
> 

That was my first attempt, yes, but the deadlock still happens with interrupts
disabled. It is very weird, I know. I tried many configurations, like disabling
PREEMPT_RT and other stuff which might affect the call stack in this case, but
the only two methods which actually avoid the deadlock are:

1. don't call wacom_intuos_schedule_prox_event() / hid_hw_request() from the
wacom driver

2. shrink the critical region to not cover hid_input_report() inside hid_ctrl()

I am very open to any ideas on how to better fix this, just to be able to use a
mainline kernel with my device without out of tree patching :)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
