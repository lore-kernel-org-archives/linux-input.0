From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Add support for GPIO interrupts
Date: Tue, 27 Jan 2015 17:21:27 +0200
Message-ID: <20150127152127.GV1451@lahna.fi.intel.com>
References: <20150126161356.GJ1451@lahna.fi.intel.com>
 <20150126163929.GL23313@leverpostej>
 <20150127101610.GK1451@lahna.fi.intel.com>
 <20150127103925.GB17721@leverpostej>
 <20150127105931.GN1451@lahna.fi.intel.com>
 <20150127111458.GD17721@leverpostej>
 <20150127113041.GP1451@lahna.fi.intel.com>
 <20150127143334.GF17721@leverpostej>
 <20150127144127.GT1451@lahna.fi.intel.com>
 <20150127150606.GI17721@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150127150606.GI17721@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 27, 2015 at 03:06:06PM +0000, Mark Rutland wrote:
> On Tue, Jan 27, 2015 at 02:41:27PM +0000, Mika Westerberg wrote:
> > On Tue, Jan 27, 2015 at 02:33:34PM +0000, Mark Rutland wrote:
> > > Ok, that allays my fear w.r.t. ordering of the resources.
> > > 
> > > As I see it, the fact that we convert GpioInt entries to GPIOs rather
> > > than irqs when parsing _CRS is the issue here, and to me it makes no
> > > sense that we do so. Were we to treat them as interrupts, the binding is
> > > fine as-is, and we'd do the same thing in DT and ACPI.
> > > 
> > > The reason GpioInt is separate from GpioIo is that a GpioInt _is_ an
> > > interrupt (which happens to be backed by a GPIO), and is not something
> > > that necessarily makes sense as a GPIO.
> > 
> > I would rather say that GpioInt *is* a GPIO. That can then used as an
> > interrupt but it should not prevent you from using it as GPIO instead.
> > For example if you just want to poll that something is 0 or 1. That
> > should be possible as well and nothing say that you cannot do that for
> > GpioInt().
> 
> >From my POV a GpioInt is logically an interrupt, or it would be a
> GpioIo. That doesn't necessarily mean it's invalid to try to query its
> state as a GPIO, but I do not think that it makes sense to handle it by
> default as a GPIO given that it was handed to us as a GpioInt so that it
> can be used as an interrupt.
> 
> If it's just the case that ACPI and DT differ w.r.t. how this case (an
> interrupt line wired to a GPIO) is described, that in itself is fine;
> different standards have different models.
> 
> However, I do not think we must change the DT binding and violate
> established DT practice simply becuase on the ACPI side things are
> different (nor would it make sense to do things the other way around).
> If the two have different rules, then we should handle those rules
> separately rather than trying to force the two together when they
> clearly don't fit.

I agree.

> In the driver that can easily be achieved with separate probe paths.

Yes, that's what this patch is doing. It has different paths for
interrupt and GPIO cases. If we find that there is an interrupt number
already, then we use that directly.

If not we try to look for a GPIO which we could use as an interrupt.

The reason why this is not done only in the ACPI probe path is that
there is nothing ACPI specific in gpiod_get() and friends.

> W.R.T. the DT binding, I do not think it makes sense to pretend this
> is also an ACPI binding.
