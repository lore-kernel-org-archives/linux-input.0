From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on
 Thinkpad Tablet 10
Date: Mon, 2 Feb 2015 12:00:31 +0200
Message-ID: <20150202100031.GP22740@lahna.fi.intel.com>
References: <54CCEE3D.9040306@m-labs.hk>
 <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
 <54CD9D0D.20402@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17556 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbbBBKAe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2015 05:00:34 -0500
Content-Disposition: inline
In-Reply-To: <54CD9D0D.20402@m-labs.hk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastien Bourdeauducq <sb@m-labs.hk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Sun, Feb 01, 2015 at 11:27:09AM +0800, Sebastien Bourdeauducq wrote:
> Hi,
> 
> On Sunday, February 01, 2015 04:39 AM, Benjamin Tissoires wrote:
> >Mika sent a patch recently which should solve your problem.
> >Can you give a try to the following patch?
> >https://patchwork.kernel.org/patch/5709961/
> 
> With this patch and IRQF_TRIGGER_LOW | IRQF_ONESHOT, I get an interrupt
> flood and the kernel disables the interrupt line. I have reverted it to
> IRQF_TRIGGER_FALLING | IRQF_ONESHOT, and the i2c_hid initialization
> completes successfully.

That shouldn't happen :-(

On all the panels I've tried, with or without GPIO, turning the
interrupt to active low works. How about Windows, have you tried if it
works there?

> The next problem is that the tablet has product ID 0x0114 and this is not
> recognized by the wacom_wac driver. I have added those entries in it:
> 
> static const struct wacom_features wacom_features_0x114 =
> 	{ "Wacom ISDv4 114", 26202, 16325, 255, 0,
> 	  TABLETPCE, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> ...
> #define ANY_DEVICE_WACOM(prod)						\
> 	HID_DEVICE(HID_BUS_ANY, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
> 	.driver_data = (kernel_ulong_t)&wacom_features_##prod
> ...
> { ANY_DEVICE_WACOM(0x114) },
> 
> I am just guessing here and copied the existing entry for product ID 0x116.
> I don't know if those numbers are correct - also, should I have used the
> existing USB_DEVICE_WACOM macro instead of defining ANY_DEVICE_WACOM?
> 
> After those changes, I'm able to move the mouse pointer only once (and to
> the correct position) using the stylus, after which the digitizer crashes
> and becomes inoperable until a reboot. Unloading and reloading i2c_hid
> results in a "failed to reset device" message.
> 
> I have copied my DSDT entry below.
> 
> Thanks,
> Sebastien
> 
> Device (DIGI)
> {
>     Name (_ADR, Zero)  // _ADR: Address
>     Name (_HID, "WCOM0008")  // _HID: Hardware ID
>     Name (_CID, "PNP0C50")  // _CID: Compatible ID
>     Name (_DDN, "Digitizer")  // _DDN: DOS Device Name
>     Name (_UID, One)  // _UID: Unique ID
>     Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             I2cSerialBus (0x0009, ControllerInitiated, 0x00061A80,
>                 AddressingMode7Bit, "\\_SB.I2C3",
>                 0x00, ResourceConsumer, ,
>                 )
>             GpioInt (Level, ActiveLow, Exclusive, PullUp, 0x0000,
>                 "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>                 )
>                 {   // Pin list
>                     0x0038
>                 }

Yup, looks pretty much what I've seen.

Can you send output of /sys/kernel/debug/gpio when after the kernel has
disabled the interrupt?

>         })
>         Return (RBUF)
>     }
