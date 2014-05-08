From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Support batch read of input events from fifo
Date: Thu, 8 May 2014 17:34:49 -0400
Message-ID: <CAN+gG=GsnnkF0T_HQe-g2WX0V2GdTKKGytSU4rZF_RAwKtWCKA@mail.gmail.com>
References: <1399555929-10870-1-git-send-email-archana.patni@linux.intel.com>
	<CAN+gG=HQwkqcyvDfK_unSuKRVOt4dyoPDK5Rz0GswrTKL1OMEg@mail.gmail.com>
	<c6f3b822-9995-4f29-b3d4-2d6b9de7d57b@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59196 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbaEHVeu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 17:34:50 -0400
Received: by mail-lb0-f175.google.com with SMTP id l4so4411605lbv.6
        for <linux-input@vger.kernel.org>; Thu, 08 May 2014 14:34:49 -0700 (PDT)
In-Reply-To: <c6f3b822-9995-4f29-b3d4-2d6b9de7d57b@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Archana Patni <archana.patni@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Mika Westerberg <mika.westerberg@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

On Thu, May 8, 2014 at 2:10 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> On May 8, 2014 3:28:23 PM GMT+01:00, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
>>On Thu, May 8, 2014 at 9:32 AM, Archana Patni
>><archana.patni@linux.intel.com> wrote:
>>> Some i2c_hid devices like a sensor hub have built-in fifos which
>>> can accumulate input events in their buffers and trigger an interrupt
>>> at end of a user defined event like fifo full or a timeout. The
>>current
>>> implementation reads one event at a time in the IRQ handler leading
>>to
>>> several hundred interrupts being necessary to flush the fifo.
>>>
>>> This patch changes the threaded IRQ handler to keep input events
>>until
>>> there are no input events left to read. In the normal case, this will
>>> invoke one additional call to fetch an input event to check for no
>>pending
>>> events and terminate the loop.
>>
>>I must say, I don't like this patch.
>>It seems to me that it will solve your problem but will break other
>>devices. Nothing in the spec says what happens if the host tries to
>>read while the interrupt line is *not* asserted. I can easily imagine
>>several scenarios where the device would hang until the next available
>>data, or will just fail.
>>
>>So the proper way according to the spec is to check the status of the
>>interrupt line. This line is the responsibility of the device to be
>>asserted and we should rely on it to know if we can read again.
>>
>>However, a quick check on the interrupt API did not provide me the
>>function I would like, so I guess this is something to be work on.
> In general it is not possible to check the interrupt state. Some interrupt devices
>  simply don't provide any means of reading it.  Generally a hybrid of a gpio and an
>  interrupt is needed to do this. They don't technically need to be on the same pin
>  though they often are...

OK, that's what I was afraid of. :(

Mika, you mentioned in the early tests that you had some devices not
using GPIOs but ACPI IRQ. Are the latest ones still following this?
Would it be costly to export the gpio alongside the irq for the
devices not using a generic interrupt but a GPIO?

If the gpio can be exported, then we can rely on it to get the other events.

I don't know how much weight Microsoft put on the GPIO in the spec,
but they definitively talk about GPIO. I hope that general interrupts
regarding i2c_hid were just a temporary solution until ACPI5 devices
were more widely used. So maybe they implemented this optimization for
true GPIO interrupts (just guessing).

Cheers,
Benjamin
