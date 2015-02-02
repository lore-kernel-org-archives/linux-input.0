From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on
 Thinkpad Tablet 10
Date: Mon, 2 Feb 2015 15:48:05 +0200
Message-ID: <20150202134805.GT22740@lahna.fi.intel.com>
References: <54CCEE3D.9040306@m-labs.hk>
 <CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>
 <54CD9D0D.20402@m-labs.hk>
 <20150202100031.GP22740@lahna.fi.intel.com>
 <54CF7977.1090105@m-labs.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37611 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbbBBNsJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2015 08:48:09 -0500
Content-Disposition: inline
In-Reply-To: <54CF7977.1090105@m-labs.hk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastien Bourdeauducq <sb@m-labs.hk>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, Feb 02, 2015 at 09:19:51PM +0800, Sebastien Bourdeauducq wrote:
> On Monday, February 02, 2015 06:00 PM, Mika Westerberg wrote:
> >>With this patch and IRQF_TRIGGER_LOW | IRQF_ONESHOT, I get an interrupt
> >>flood and the kernel disables the interrupt line. I have reverted it to
> >>IRQF_TRIGGER_FALLING | IRQF_ONESHOT, and the i2c_hid initialization
> >>completes successfully.
> >
> >That shouldn't happen :-(
> 
> With this computer nothing is normal. Every single component except the CPU,
> display and USB has major issues under Linux.

We need to get one here then. Can you point me to the exact model?

> >On all the panels I've tried, with or without GPIO, turning the
> >interrupt to active low works. How about Windows, have you tried if it
> >works there?
> 
> Yes, the Wacom digitizer works fine under Windows.
> 
> >Can you send output of /sys/kernel/debug/gpio when after the kernel has
> >disabled the interrupt?
> 
> Attached. The kernel message I get is "byt_gpio INT33FC:00: Gpio 56
> interrupt flood, disabling".
> 
> I also get a "byt_gpio INT33FC:02: Gpio 18 interrupt flood, disabling"
> before which seems unrelated.

>  gpio-56  (?                   ) in     lo pad-79  offset:0x4f0 mux:0                  up   20k

This explains, it is low all the time.

Since it has 20k internal pull-up configured, I'm guessing something
(the digitizer) drives it low like it still has something to report. Do
you see in the dmesg if the i2c-hid.c is able to read reports from the
device?
