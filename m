From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Silead DMI driver
Date: Fri, 28 Apr 2017 11:33:21 +0200
Message-ID: <20170428113321.2ceb103b@endymion>
References: <20170424132356.044ae04f@endymion>
        <20170424165935.GA12374@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170424165935.GA12374@dtor-ws>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, 24 Apr 2017 09:59:35 -0700, Dmitry Torokhov wrote:
> On Mon, Apr 24, 2017 at 01:23:56PM +0200, Jean Delvare wrote:
> > As a side note, the comment about the init sequence says: "after i2c
> > core is initialized and i2c bus itself is ready" but I don't think
> > there is any actual guarantee on the latter. I see no dependency on
> > the i2c bus driver, only on the i2c core. What i2c bus driver are we
> > talking about and how can you be sure it is already loaded at that
> > point? (Not that it should matter but I'm curious.)
> 
> We are talking about the i2c bus in the Linux driver model sense, i.e.
> 
> 	extern struct bus_type i2c_bus_type;
> 
> No I2C hardware is needed at this time.

Thanks for the clarification. The wording is misleading then, in my
views at least, i2c_bus_type belongs to the i2c core, so "after i2c
core is initialized" would be enough.

> > To make things worse, I see that this driver registers a bus notifier
> > unconditionally. So it will be registered on virtually _every_ x86
> > system out there, and will kick in and perform DMI checks for every I2C
> > device being added, even though most people don't need it at all. Is
> > there any excuse for not checking the DMI data _before_ registering the
> > bus notifier, so the whole thing can be skipped on the 99% of systems
> > where it is irrelevant? That wouldn't solve the undue memory
> > consumption but at least it would limit the impact on boot time.
> 
> If you take a look at next you will see that we no longer register bus
> notifier unconditionally.

I did not think of looking there, my bad. Indeed I see this is already
fixed, which is good.

> I also thought that Hans was going to annotate
> most of the items as __initconst so that unneeded memory can be
> discarded after boot, but for that some other patches to device
> properties should trickle through various subsystems. In the end you'll
> end up with just the properties for the board you need.

That's better, but won't you still have to live with
silead_ts_dmi_notifier_call() and silead_ts_dmi_add_props() loaded
forever, and the notification hook enabled,  even if you don't have any
Silead touchscreen on your x86 system? I can't see how a
notification-based implementation could clean up everything, as you
supposedly don't know when you will be called (which is my main concern
about this implementation - you should be able to run the fixup code
once and be done with it.)

> > I have to say I don't understand the whole complexity of the design. As
> > I understand it, the properties which are being added are only consumed
> > by the "silead" touchscreen driver. I see no necessity to add the
> > missing properties before that driver is even loaded. Can't you just
> > look for the ACPI companion device at the time the silead driver tries
> > to bind to the i2c device, and add the missing properties before
> > performing the actual probe? This would be so much simpler. What am I
> > missing?
> 
> So the idea is that I am trying to make drivers in input/
> platform-independent, and move platform quirks out of them. With generic
> device properties we can finally move away from ad-hoc platform data,
> and rely on proper bindings, and that ensures at least some engineering
> control.
> 
> So while looking for the ACPI companion device might be indeed very
> easy, it pushes dependencies on ACPI and platform knowledge into the
> generic driver, which I am trying to avoid. I believe
> drivers/platform/x86/ is a good place to stash all x86 platform quirks.

While this is a laudable goal, how will it scale in practice? I mean,
most drivers do need quirks in one form or another. Are we really going
to double the number of "drivers" (as in .c files and modules) and
Kconfig options to cleanly separate quirks from the device drivers
proper?

>From my perspective, you are solving the problem that all users of a
driver shouldn't have to pay for platforms which did get things wrong,
but your solution causes all users of the platform to pay the overhead
instead. Which is statistically a much larger number of people. If we
are going to be unfair, we might as well go for the most simple
solution.

So I'm sorry but I can't see how your approach is better than just
ifdef'd platform-specific code in the device driver, as we have been
doing so far.

> I agree that tying this up with I2C bus notifier might not be the best
> solution overall (it was simply available tight at this time) and we
> could look into hooking this up into ACPI device enumeration to supply
> missing properties.

I have a hard time understanding how you did not come up with this idea
first, to be honest. If the problem you need to solve is caused by
missing data in the ACPI tables, injecting the missing data at the ACPI
level would seem to be the most straightforward way to go. Fixing the
problem as close as possible to its source. But I will admit I am not
familiar enough with the ACPI subsystem implementation to say if that
can be done today or if preparatory work is needed.

> > PS: I hope this code will die, but if it stays, I see that you call
> > to_i2c_client() on the notified device without checking if it is an
> > i2c_client. It could be an i2c_adapter instead, and then you are
> > forcibly mapping a struct i2c_client on top of a struct i2c_adapter.
> > Good luck when you will access client->name a few lines later...
> > i2c_verify_client() is what you want to use instead of to_i2c_client()
> > in that situtation.
> 
> That is also should be fixed in -next. Because i2c_adapter structure is
> big enough so that looking up client->name in adapter is not going to
> blow up, nor will it likely to match, it was decided it could stay till
> next merge window.

I'm speechless. If you believe that this kind of bug isn't worth fixing
quickly, I'll go disable that piece of cra^H^Hode from the opeSUSE
kernel for the time being. And then, go figure if/when anyone will
remember to re-enable it once it is in an acceptable state.

I thought the rule about upstream kernel code acceptance was that you
should get things right first, no matter how much time and how many
iterations it takes, and then we commit the result. Apparently this has
changed while I was not looking :-(

-- 
Jean Delvare
SUSE L3 Support
