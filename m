From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] HID: i2c-hid: Add support for ACPI GPIO interrupts
Date: Tue, 24 Feb 2015 09:42:30 +0200
Message-ID: <20150224074230.GF1758@lahna.fi.intel.com>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
 <1424699565-138045-4-git-send-email-mika.westerberg@linux.intel.com>
 <20150223153502.GF27578@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150223153502.GF27578@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Feb 23, 2015 at 10:35:02AM -0500, Benjamin Tissoires wrote:
> On Feb 23 2015 or thereabouts, Mika Westerberg wrote:
> > The HID over I2C specification allows to have the interrupt for a HID
> > device to be GPIO instead of directly connected to the IO-APIC.
> > 
> > Add support for this so that when the driver does not find proper interrupt
> > number from the I2C client structure we check if it has ACPI GpioInt()
> > resource listed in _CRS. If it is found we convert it to an interrupt
> > number and use it instead.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> 
> I know this has been already discussed, so don't take this as a request
> for a change. I however hoped that the acpi subsystem would provide the
> irq directly in the i2c client without having to deal with it in
> i2c_hid. For me, declaring the GPIO as an interrupt means that the irq
> should be created in the first place. However, if we also have access to
> the gpio, that means that we can read the value of it, which is better in
> our case. So I am fine with all the solutions - as long as it works :)

I understand your point.

It would be nice to do it that way but it is not so simple.

For example if we have some button array that has several GpioInts
listed, we convert the first to an interrupt but the driver needs to
handle all the rest itself (taking the one converted interrupt into
account).

Another problem that I can think of is to determine who is responsible
in releasing the GPIO and at which point. We cannot just use devm_* APIs
because no driver has been probed yet.

Also if the driver needs to use the interrupt as GPIO for reading its
value we would first need to release it (because it has been requested
by the core code), then re-request it, read the value and then somehow
release it back so that the core code can release it...

That's why I think it is better to let drivers handle these themselves
as they like.

Of course if someone has good idea how to do this properly in the core
code, I'm all ears.

> I don't know enough of the use of gpios in acpi to properly review the
> code. So I'll just add my:
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks :-)
