From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH] HID: i2c-hid: Support batch read of input events from
 fifo
Date: Fri, 9 May 2014 10:23:30 +0300
Message-ID: <20140509072330.GN3722@lahna.fi.intel.com>
References: <1399555929-10870-1-git-send-email-archana.patni@linux.intel.com>
 <CAN+gG=HQwkqcyvDfK_unSuKRVOt4dyoPDK5Rz0GswrTKL1OMEg@mail.gmail.com>
 <c6f3b822-9995-4f29-b3d4-2d6b9de7d57b@email.android.com>
 <CAN+gG=GsnnkF0T_HQe-g2WX0V2GdTKKGytSU4rZF_RAwKtWCKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23588 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaEIHXf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 May 2014 03:23:35 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=GsnnkF0T_HQe-g2WX0V2GdTKKGytSU4rZF_RAwKtWCKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Archana Patni <archana.patni@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Archana Patni <archana.patni@intel.com>, Subramony Sesha <subramony.sesha@intel.com>

On Thu, May 08, 2014 at 05:34:49PM -0400, Benjamin Tissoires wrote:
> On Thu, May 8, 2014 at 2:10 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> >
> >
> > On May 8, 2014 3:28:23 PM GMT+01:00, Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:
> >>On Thu, May 8, 2014 at 9:32 AM, Archana Patni
> >><archana.patni@linux.intel.com> wrote:
> >>> Some i2c_hid devices like a sensor hub have built-in fifos which
> >>> can accumulate input events in their buffers and trigger an interrupt
> >>> at end of a user defined event like fifo full or a timeout. The
> >>current
> >>> implementation reads one event at a time in the IRQ handler leading
> >>to
> >>> several hundred interrupts being necessary to flush the fifo.
> >>>
> >>> This patch changes the threaded IRQ handler to keep input events
> >>until
> >>> there are no input events left to read. In the normal case, this will
> >>> invoke one additional call to fetch an input event to check for no
> >>pending
> >>> events and terminate the loop.
> >>
> >>I must say, I don't like this patch.
> >>It seems to me that it will solve your problem but will break other
> >>devices. Nothing in the spec says what happens if the host tries to
> >>read while the interrupt line is *not* asserted. I can easily imagine
> >>several scenarios where the device would hang until the next available
> >>data, or will just fail.
> >>
> >>So the proper way according to the spec is to check the status of the
> >>interrupt line. This line is the responsibility of the device to be
> >>asserted and we should rely on it to know if we can read again.
> >>
> >>However, a quick check on the interrupt API did not provide me the
> >>function I would like, so I guess this is something to be work on.
> > In general it is not possible to check the interrupt state. Some interrupt devices
> >  simply don't provide any means of reading it.  Generally a hybrid of a gpio and an
> >  interrupt is needed to do this. They don't technically need to be on the same pin
> >  though they often are...
> 
> OK, that's what I was afraid of. :(
> 
> Mika, you mentioned in the early tests that you had some devices not
> using GPIOs but ACPI IRQ. Are the latest ones still following this?

Yes.

Typically it is always GPIO line but you can route it directly to ioapic
with some magic done by BIOS.

> Would it be costly to export the gpio alongside the irq for the
> devices not using a generic interrupt but a GPIO?

We have systems where you can select from BIOS menu whether GPIO or IRQ
resource is passed. However, looks like vendors are passing IRQ only
(just checked Asus T100 and there is no GPIO option at all).

> If the gpio can be exported, then we can rely on it to get the other
> events.

Ideally, you would only have GPIO entry in the table and you could use
it as both a GPIO and an IRQ.
