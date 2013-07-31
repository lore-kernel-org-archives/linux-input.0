From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC 2/8] HID: usbhid: update LED fields unlocked
Date: Wed, 31 Jul 2013 10:28:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307311027510.18809@pobox.suse.cz>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com> <1373908217-16748-3-git-send-email-dh.herrmann@gmail.com> <CAN+gG=GzgSKXarfDfL9pWVaR8Ayb7rr-my030M7iKu_TaDOPCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45508 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab3GaI2W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Jul 2013 04:28:22 -0400
In-Reply-To: <CAN+gG=GzgSKXarfDfL9pWVaR8Ayb7rr-my030M7iKu_TaDOPCg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Tue, 16 Jul 2013, Benjamin Tissoires wrote:

> > Report fields can be updated from HID drivers unlocked via
> > hid_set_field(). It is protected by input_lock in HID core so only a
> > single input event is handled at a time. USBHID can thus update the field
> > unlocked and doesn't conflict with any HID vendor/device drivers. Note,
> > many HID drivers make heavy use of hid_set_field() in that way.
> >
> > But usbhid also schedules a work to gather multiple LED changes in a
> > single report. Hence, we used to lock the LED field update so the work can
> > read a consistent state. However, hid_set_field() only writes a single
> > integer field, which is guaranteed to be allocated all the time. So the
> > worst possible race-condition is a garbage read on the LED field.
> >
> > Therefore, there is no need to protect the update. In fact, the only thing
> > that is prevented by locking hid_set_field(), is an LED update while the
> > scheduled work currently writes an older LED update out. However, this
> > means, a new work is scheduled directly when the old one is done writing
> > the new state to the device. So we actually _win_ by not protecting the
> > write and allowing the write to be combined with the current write. A new
> > worker is still scheduled, but will not write any new state. So the LED
> > will not blink unnecessarily on the device.
> >
> > Assume we have the LED set to 0. Two request come in which enable the LED
> > and immediately disable it. The current situation with two CPUs would be:
> >
> >   usb_hidinput_input_event()       |      hid_led()
> >   ---------------------------------+----------------------------------
> >     spin_lock(&usbhid->lock);
> >     hid_set_field(1);
> >     spin_unlock(&usbhid->lock);
> >     schedule_work(...);
> >                                       spin_lock(&usbhid->lock);
> >                                       __usbhid_submit_report(..1..);
> >                                       spin_unlock(&usbhid->lock);
> >     spin_lock(&usbhid->lock);
> >     hid_set_field(0);
> >     spin_unlock(&usbhid->lock);
> >     schedule_work(...);
> >                                       spin_lock(&usbhid->lock);
> >                                       __usbhid_submit_report(..0..);
> >                                       spin_unlock(&usbhid->lock);
> >
> > With the locking removed, we _might_ end up with (look at the changed
> > __usbhid_submit_report() parameters in the first try!):
> >
> >   usb_hidinput_input_event()       |      hid_led()
> >   ---------------------------------+----------------------------------
> >     hid_set_field(1);
> >     schedule_work(...);
> >                                       spin_lock(&usbhid->lock);
> >     hid_set_field(0);
> >     schedule_work(...);
> >                                       __usbhid_submit_report(..0..);
> >                                       spin_unlock(&usbhid->lock);
> >
> >                                       ... next work ...
> >
> >                                       spin_lock(&usbhid->lock);
> >                                       __usbhid_submit_report(..0..);
> >                                       spin_unlock(&usbhid->lock);
> >
> > As one can see, we no longer send the "LED ON" signal as it is disabled
> > immediately afterwards and the following "LED OFF" request overwrites the
> > pending "LED ON".
> >
> > It is important to note that hid_set_field() is not atomic, so we might
> > also end up with any other value. But that doesn't matter either as we
> > _always_ schedule the next work with a correct value and schedule_work()
> > acts as memory barrier, anyways. So in the worst case, we run
> > __usbhid_submit_report(..<garbage>..) in the first case and the following
> > __usbhid_submit_report() will write the correct value. But LED states are
> > booleans so any garbage will be converted to either 0 or 1 and the remote
> > device will never see invalid requests.
> >
> > Why all this? It avoids any custom locking around hid_set_field() in
> > usbhid and finally allows us to provide a generic hidinput_input_event()
> > handler for all HID transport drivers.
> >
> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> > ---
> 
> Hi David,
> 
> that was a very good commit message!
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I love this patch :) Thanks David, thanks Benjamin.

-- 
Jiri Kosina
SUSE Labs
