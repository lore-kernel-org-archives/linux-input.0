From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Tue, 24 Apr 2012 20:57:28 +0200
Message-ID: <201204242057.29100.oliver@neukum.org>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com> <201204241622.08411.oneukum@suse.de> <CACVXFVM_p=VZ76zX89CppbeXFh-bhTwqzU6FWHzuaJa2bYcBUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:42166 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503Ab2DXTBb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 15:01:31 -0400
In-Reply-To: <CACVXFVM_p=VZ76zX89CppbeXFh-bhTwqzU6FWHzuaJa2bYcBUA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

Am Dienstag, 24. April 2012, 17:46:41 schrieb Ming Lei:
> On Tue, Apr 24, 2012 at 10:22 PM, Oliver Neukum <oneukum@suse.de> wrote:
> > Am Dienstag, 24. April 2012, 06:19:00 schrieb Ming Lei:
> >
> >> @@ -486,11 +494,15 @@ static void hid_ctrl(struct urb *urb)
> >>
> >>       if (usbhid->ctrlhead != usbhid->ctrltail && !hid_submit_ctrl(hid)) {
> >>               /* Successfully submitted next urb in queue */
> >> +             if (status != -ECONNRESET)
> >> +                     spin_unlock(&usbhid->unlink_lock);
> >>               spin_unlock(&usbhid->lock);
> >>               return;
> >>       }
> >>
> >>       clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> >> +     if (status != -ECONNRESET)
> >> +             spin_unlock(&usbhid->unlink_lock);
> >>       spin_unlock(&usbhid->lock);
> >>       usb_autopm_put_interface_async(usbhid->intf);
> >>       wake_up(&usbhid->wait);
> >
> > Now you race against a double time out
> >
> > CPU A                                                           CPU B
> >
> > __usbhid_submit_report()
> > time_after()
> > usb_unlink_urb()
> > -- this has to go to the hardware -->
> >                                                                        hid_irq_out()
> >                                                                        if (status != -ECONNRESET)
> >                                                                        --> no lock
> >                                                                        hid_submit_out()
> > __usbhid_submit_report()
> > time_after()
> >                                                                        usb_submit_urb()
> 
> This submit won't happen because HID_OUT_RUNNING is not cleared.

I may be dense, but as far as I can tell a resubmit will happen, exactly if
HID_OUT_RUNNING is _not_ cleared.

	Regards
		Oliver

