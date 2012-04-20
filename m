From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 12:45:44 +0200
Message-ID: <201204201245.44981.oneukum@suse.de>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com> <201204200957.34154.oneukum@suse.de> <CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35287 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2DTKtw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 06:49:52 -0400
In-Reply-To: <CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Freitag, 20. April 2012, 12:17:51 schrieb Ming Lei:
> On Fri, Apr 20, 2012 at 3:57 PM, Oliver Neukum <oneukum@suse.de> wrote:
> >
> > You are racing with hid_irq_out(). It calls hid_submit_out()
> > under lock. So if hid_irq_out() is running between dropping
> > the lock and usb_unlink_urb() you may kill the newly submitted
> > urb, not the old urb that has timed out.
> 
> Yes, it is the race I missed, :-(
> 
> > You must make sure that between the times you check usbhid->last_out
> > and calling unlink hid_submit_out() cannot be called.
> > You can't just drop the lock (at least on SMP)
> 
> Looks it is not easy to avoid the race if the lock is to be dropped.
> 
> So how about not acquiring the lock during unlinking as below?
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index aa1c503..b437223 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -429,7 +429,8 @@ static void hid_irq_out(struct urb *urb)
>                          urb->status);
>         }
> 
> -       spin_lock_irqsave(&usbhid->lock, flags);
> +       if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
> +               spin_lock_irqsave(&usbhid->lock, flags);
> 
>         if (unplug)
>                 usbhid->outtail = usbhid->outhead;
> @@ -438,12 +439,14 @@ static void hid_irq_out(struct urb *urb)
> 
>         if (usbhid->outhead != usbhid->outtail && !hid_submit_out(hid)) {
>                 /* Successfully submitted next urb in queue */
> -               spin_unlock_irqrestore(&usbhid->lock, flags);
> +               if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
> +                       spin_unlock_irqrestore(&usbhid->lock, flags);
>                 return;
>         }

No. This introduces a race where you can drop a lock you've not taken
and vice versa.
And why are you using per cpu structures here?

To be blunt, I'd prefer a guarantee that allows usb_unlink_urb() to be
called with spinlocks held.

Well, if we can't get a good usb_unlink_urb() then the lock must be dropped.
Your idea of setting a flag is good.

You'd do in hid_irq_out():

if (usbhid->outhead != usbhid->outtail && !usbhid->timeout_detected && !hid_submit_out(hid))

and you set usbhid->timeout_detected under lock. That way we can never
accidentally kill a new urb. This however means that then we need to kill the
urb and restart the queue preferably from a workqueue and this must be handled
in suspend/resume/close/pre-/postreset/disconnect

As I said, I'd very much appreciate sane semantics for usb_unlink_urb().

	Regards
		Oliver
