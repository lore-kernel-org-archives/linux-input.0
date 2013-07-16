From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC 2/8] HID: usbhid: update LED fields unlocked
Date: Tue, 16 Jul 2013 09:46:19 +0200
Message-ID: <CAN+gG=GzgSKXarfDfL9pWVaR8Ayb7rr-my030M7iKu_TaDOPCg@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-3-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:38835 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab3GPHqV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jul 2013 03:46:21 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so344054lbi.39
        for <linux-input@vger.kernel.org>; Tue, 16 Jul 2013 00:46:19 -0700 (PDT)
In-Reply-To: <1373908217-16748-3-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>

On Mon, Jul 15, 2013 at 7:10 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Report fields can be updated from HID drivers unlocked via
> hid_set_field(). It is protected by input_lock in HID core so only a
> single input event is handled at a time. USBHID can thus update the field
> unlocked and doesn't conflict with any HID vendor/device drivers. Note,
> many HID drivers make heavy use of hid_set_field() in that way.
>
> But usbhid also schedules a work to gather multiple LED changes in a
> single report. Hence, we used to lock the LED field update so the work can
> read a consistent state. However, hid_set_field() only writes a single
> integer field, which is guaranteed to be allocated all the time. So the
> worst possible race-condition is a garbage read on the LED field.
>
> Therefore, there is no need to protect the update. In fact, the only thing
> that is prevented by locking hid_set_field(), is an LED update while the
> scheduled work currently writes an older LED update out. However, this
> means, a new work is scheduled directly when the old one is done writing
> the new state to the device. So we actually _win_ by not protecting the
> write and allowing the write to be combined with the current write. A new
> worker is still scheduled, but will not write any new state. So the LED
> will not blink unnecessarily on the device.
>
> Assume we have the LED set to 0. Two request come in which enable the LED
> and immediately disable it. The current situation with two CPUs would be:
>
>   usb_hidinput_input_event()       |      hid_led()
>   ---------------------------------+----------------------------------
>     spin_lock(&usbhid->lock);
>     hid_set_field(1);
>     spin_unlock(&usbhid->lock);
>     schedule_work(...);
>                                       spin_lock(&usbhid->lock);
>                                       __usbhid_submit_report(..1..);
>                                       spin_unlock(&usbhid->lock);
>     spin_lock(&usbhid->lock);
>     hid_set_field(0);
>     spin_unlock(&usbhid->lock);
>     schedule_work(...);
>                                       spin_lock(&usbhid->lock);
>                                       __usbhid_submit_report(..0..);
>                                       spin_unlock(&usbhid->lock);
>
> With the locking removed, we _might_ end up with (look at the changed
> __usbhid_submit_report() parameters in the first try!):
>
>   usb_hidinput_input_event()       |      hid_led()
>   ---------------------------------+----------------------------------
>     hid_set_field(1);
>     schedule_work(...);
>                                       spin_lock(&usbhid->lock);
>     hid_set_field(0);
>     schedule_work(...);
>                                       __usbhid_submit_report(..0..);
>                                       spin_unlock(&usbhid->lock);
>
>                                       ... next work ...
>
>                                       spin_lock(&usbhid->lock);
>                                       __usbhid_submit_report(..0..);
>                                       spin_unlock(&usbhid->lock);
>
> As one can see, we no longer send the "LED ON" signal as it is disabled
> immediately afterwards and the following "LED OFF" request overwrites the
> pending "LED ON".
>
> It is important to note that hid_set_field() is not atomic, so we might
> also end up with any other value. But that doesn't matter either as we
> _always_ schedule the next work with a correct value and schedule_work()
> acts as memory barrier, anyways. So in the worst case, we run
> __usbhid_submit_report(..<garbage>..) in the first case and the following
> __usbhid_submit_report() will write the correct value. But LED states are
> booleans so any garbage will be converted to either 0 or 1 and the remote
> device will never see invalid requests.
>
> Why all this? It avoids any custom locking around hid_set_field() in
> usbhid and finally allows us to provide a generic hidinput_input_event()
> handler for all HID transport drivers.
>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---

Hi David,

that was a very good commit message!

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
