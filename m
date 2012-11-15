From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c-hid: introduce HID over i2c specification implementation
Date: Thu, 15 Nov 2012 15:04:54 +0100
Message-ID: <CAN+gG=FeNBzdbBcH6uSWB_rUOS6PjyjpVSuY3b--g1mXo17fXA@mail.gmail.com>
References: <1352731379-24683-1-git-send-email-benjamin.tissoires@gmail.com>
	<alpine.LNX.2.00.1211151450140.15877@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1211151450140.15877-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, JJ Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 15, 2012 at 2:51 PM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Mon, 12 Nov 2012, Benjamin Tissoires wrote:
>
>> Microsoft published the protocol specification of HID over i2c:
>> http://msdn.microsoft.com/en-us/library/windows/hardware/hh852380.aspx
>>
>> This patch introduces an implementation of this protocol.
>>
>> This implementation does not includes the ACPI part of the specification.
>> This will come when ACPI 5.0 devices enumeration will be available.
>>
>> Once the ACPI part is done, OEM will not have to declare HID over I2C
>> devices in their platform specific driver.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Out of curiosity -- has this been tested on a real device (is there any
> such device available anyway?), or is that just the implementation of the
> defined protocol?

It has been tested on an ELAN microelectronics device (a prototype),
on an odroid-x board. That's how we figure out the bug in the
set_report command.
I think we manage to test all main features of the protocol
(get_report, irqs, hid descriptor, report descriptors, set_report).

I'm currently waiting for a Synaptics touchpad to check if it's also
working with their devices.

The thing is that HID over i2c for x86 platform will presumably
require the Haswell platform from Intel (we need ACPI 5 for
enumeration), but it would be very nice to get this in the kernel just
before hardware arrive on the market :)
However, I won't be surprise if android OEMs also start using this
specification because it won't force them to write kernel drivers...

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
