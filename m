From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 09:57:34 +0200
Message-ID: <201204200957.34154.oneukum@suse.de>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com> <201204191811.33994.oneukum@suse.de> <CACVXFVPZQNNvGk0cn4XWDTKd_s71V0Yd9nZJ3nkEg1Qh7W+B5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55421 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754114Ab2DTIBk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 04:01:40 -0400
In-Reply-To: <CACVXFVPZQNNvGk0cn4XWDTKd_s71V0Yd9nZJ3nkEg1Qh7W+B5g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Freitag, 20. April 2012, 04:10:09 schrieb Ming Lei:
> On Fri, Apr 20, 2012 at 12:11 AM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Donnerstag, 19. April 2012, 15:51:04 schrieb Ming Lei:
> >> The URB complete handler may be called by usb_unlink_urb directly,
> >> so deadlock will be triggered in __usbhid_submit_report since
> >> usbhid->lock is to be acquired in ctrl/out URB complete handler
> >> but it is hold before calling usb_unlink_urb.
> >>
> >> This patch avoids the deadlock by releasing the lock before
> >> calling usb_unlink_urb.
> >>
> >> CC: <stable@vger.kernel.org>
> >> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> >> ---
> >>  drivers/hid/usbhid/hid-core.c |   16 ++++++++++------
> >>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> >> index aa1c503..b5d07da 100644
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -543,11 +543,13 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
> >>                        * the queue is known to run
> >>                        * but an earlier request may be stuck
> >>                        * we may need to time out
> >> -                      * no race because this is called under
> >> -                      * spinlock
> >> +                      * release spinlock to avoid deadlock.
> >>                        */
> >> -                     if (time_after(jiffies, usbhid->last_out + HZ * 5))
> >> +                     if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
> >> +                             spin_unlock(&usbhid->lock);
> >>                               usb_unlink_urb(usbhid->urbout);
> >> +                             spin_lock(&usbhid->lock);
> >
> > The problem indeed exists on some HCDs.
> > I am afraid if you drop the lock there you introduce a race whereby
> > you might unlink the wrong request.
> 
> The complete handler is called just one time per one submit in either

Indeed.

> irq path or unlink path. Secondly, usb_unlink_urb itself is race free.
> Finally, usb_unlink_urb was always the last function called inside
> __usbhid_submit_report.

But under spinlock.
 
> So I don't see any races can be introduced by the patch.

You are racing with hid_irq_out(). It calls hid_submit_out()
under lock. So if hid_irq_out() is running between dropping
the lock and usb_unlink_urb() you may kill the newly submitted
urb, not the old urb that has timed out.
You must make sure that between the times you check usbhid->last_out
and calling unlink hid_submit_out() cannot be called.
You can't just drop the lock (at least on SMP)

	Regards
		Oliver
