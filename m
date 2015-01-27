From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Add support for GPIO interrupts
Date: Tue, 27 Jan 2015 12:16:10 +0200
Message-ID: <20150127101610.GK1451@lahna.fi.intel.com>
References: <1422282573-18215-1-git-send-email-mika.westerberg@linux.intel.com>
 <1422282573-18215-2-git-send-email-mika.westerberg@linux.intel.com>
 <20150126143723.GI23313@leverpostej>
 <20150126144729.GG1451@lahna.fi.intel.com>
 <20150126145000.GJ23313@leverpostej>
 <20150126151637.GH1451@lahna.fi.intel.com>
 <20150126160044.GK23313@leverpostej>
 <20150126161356.GJ1451@lahna.fi.intel.com>
 <20150126163929.GL23313@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150126163929.GL23313@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 26, 2015 at 04:39:30PM +0000, Mark Rutland wrote:
> What I don't follow is why GpioInt seems to be translated as a GPIO
> rather than as an interrupt which happens to be backed by a GPIO. Were
> it not for that, the DT and ACPI cases would align better.

Because it *is* a GPIO.

In my experience we have had two kinds of interrupts that the devices
are connected to: pins connected directly to the interrupt controller
(IO-APIC or whatever), and pins connected to the GPIO controller. This
is the later.

Now, the device in question has following resources:

	Name (_CRS, ResourceTemplate () {
		I2cSerialBus (0x004C, ControllerInitiated, 0x00061A80,
		    AddressingMode7Bit, "\\_SB.PCI0.I2C6",
		    0x00, ResourceConsumer,,)
		GpioInt (Level, ActiveLow, Shared, PullDefault, 0x0000,
		    "\\_SB.GPO0", 0x00, ResourceConsumer,,)
		    {
			0x004C
		    }
	})

The GpioInt() above refers to GPIO controller ("\_SB.GPO0") and its pin
number 0x4c.

Normally I would do this in the driver regardless of where it is
described (DT, ACPI, whatnot):

	desc = gpiod_get(dev, NULL);
	gpiod_direction_input(desc);
	irq = gpiod_to_irq(desc);

Then the "irq" can be used for request_irq() and friends.

Note how both DT and ACPI cases align just fine.

If the above is not the right way to use GPIOs as interrupt, can you
please tell me how it is done then?

BTW, passing NULL to gpiod_get() implies property named "gpios" in DT
(which is why I added it to the documentation).
