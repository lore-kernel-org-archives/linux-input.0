From: Jean Delvare <jdelvare@suse.de>
Subject: Silead DMI driver
Date: Mon, 24 Apr 2017 13:23:56 +0200
Message-ID: <20170424132356.044ae04f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi all,

I'm looking at drivers/platform/x86/silead_dmi.c which is being added
to kernel v4.11 and I do not like what I see.

This driver is for very specific hardware. Most users won't need it.
Still this driver can only be built into the kernel, no modular option
available.

Apparently this first issue is caused by the necessity to add the
notifier at a specific point in the init sequence. Do I understand
correctly that the I2C device will be instantiated by the ACPI core as
it enumerates devices found in the ACPI tables, and you want to add the
missing properties at that exact point of the init sequence?

As a side note, the comment about the init sequence says: "after i2c
core is initialized and i2c bus itself is ready" but I don't think
there is any actual guarantee on the latter. I see no dependency on
the i2c bus driver, only on the i2c core. What i2c bus driver are we
talking about and how can you be sure it is already loaded at that
point? (Not that it should matter but I'm curious.)

To make things worse, I see that this driver registers a bus notifier
unconditionally. So it will be registered on virtually _every_ x86
system out there, and will kick in and perform DMI checks for every I2C
device being added, even though most people don't need it at all. Is
there any excuse for not checking the DMI data _before_ registering the
bus notifier, so the whole thing can be skipped on the 99% of systems
where it is irrelevant? That wouldn't solve the undue memory
consumption but at least it would limit the impact on boot time.

I have to say I don't understand the whole complexity of the design. As
I understand it, the properties which are being added are only consumed
by the "silead" touchscreen driver. I see no necessity to add the
missing properties before that driver is even loaded. Can't you just
look for the ACPI companion device at the time the silead driver tries
to bind to the i2c device, and add the missing properties before
performing the actual probe? This would be so much simpler. What am I
missing?

PS: I hope this code will die, but if it stays, I see that you call
to_i2c_client() on the notified device without checking if it is an
i2c_client. It could be an i2c_adapter instead, and then you are
forcibly mapping a struct i2c_client on top of a struct i2c_adapter.
Good luck when you will access client->name a few lines later...
i2c_verify_client() is what you want to use instead of to_i2c_client()
in that situtation.

-- 
Jean Delvare
SUSE L3 Support
