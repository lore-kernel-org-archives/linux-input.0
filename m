From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 16:07:44 +0200
Message-ID: <201204201607.44723.oneukum@suse.de>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com> <201204201245.44981.oneukum@suse.de> <CACVXFVPzFeC8xbsVfYeYKsZXwQ05437EY4-H49PAiajyvdG91A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51808 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab2DTOLv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 10:11:51 -0400
In-Reply-To: <CACVXFVPzFeC8xbsVfYeYKsZXwQ05437EY4-H49PAiajyvdG91A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Freitag, 20. April 2012, 14:53:24 schrieb Ming Lei:
> On Fri, Apr 20, 2012 at 6:45 PM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Freitag, 20. April 2012, 12:17:51 schrieb Ming Lei:
> >> On Fri, Apr 20, 2012 at 3:57 PM, Oliver Neukum <oneukum@suse.de> wrote:
> >> >
> >> > You are racing with hid_irq_out(). It calls hid_submit_out()
> >> > under lock. So if hid_irq_out() is running between dropping
> >> > the lock and usb_unlink_urb() you may kill the newly submitted
> >> > urb, not the old urb that has timed out.
> >>
> >> Yes, it is the race I missed, :-(
> >>
> >> > You must make sure that between the times you check usbhid->last_out
> >> > and calling unlink hid_submit_out() cannot be called.
> >> > You can't just drop the lock (at least on SMP)
> >>
> >> Looks it is not easy to avoid the race if the lock is to be dropped.
> >>
> >> So how about not acquiring the lock during unlinking as below?
> >>
> >> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> >> index aa1c503..b437223 100644
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -429,7 +429,8 @@ static void hid_irq_out(struct urb *urb)
> >>                          urb->status);
> >>         }
> >>
> >> -       spin_lock_irqsave(&usbhid->lock, flags);
> >> +       if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
> >> +               spin_lock_irqsave(&usbhid->lock, flags);
> >>
> >>         if (unplug)
> >>                 usbhid->outtail = usbhid->outhead;
> >> @@ -438,12 +439,14 @@ static void hid_irq_out(struct urb *urb)
> >>
> >>         if (usbhid->outhead != usbhid->outtail && !hid_submit_out(hid)) {
> >>                 /* Successfully submitted next urb in queue */
> >> -               spin_unlock_irqrestore(&usbhid->lock, flags);
> >> +               if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
> >> +                       spin_unlock_irqrestore(&usbhid->lock, flags);
> >>                 return;
> >>         }
> >
> > No. This introduces a race where you can drop a lock you've not taken
> > and vice versa.
> 
> The flag is defined as per cpu variable, so it can't changed during the two
> test_cpu_bit in complete handler and can't cause the races you mentioned.

Yes, you are right. It looks safe, but no longer understandable.
You need a big, fat comment to explain the problem and the solution.

	Regards
		Oliver
