From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Tue, 29 Mar 2016 12:52:44 +0300
Message-ID: <20160329095244.GI2099@lahna.fi.intel.com>
References: <CA+V1LzrL6G1FJ6qXuTuiQQiMrZnj_QaHbGhFwBxpJrB9J=ZSGw@mail.gmail.com>
 <56EF459E.8000808@gmail.com>
 <CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbcC2Jwt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 05:52:49 -0400
Content-Disposition: inline
In-Reply-To: <CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: Gregor Riepl <onitake@gmail.com>, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

On Sun, Mar 27, 2016 at 12:05:27AM +0000, sergk sergk2mail wrote:
> Hi Mika, Benjamin, Antonio.
> Kindly would like to invite all of you to this thread because it is
> very closely to http://www.spinics.net/lists/linux-input/msg35935.html
>  : About Goodix-TS on Bay Trail, and ACPI and interrupts
> Let me briefly summarize:
> 1) I have wrote driver that loads FW into the TS chip (icn8228), I am
> able to get polling mode, primary task at the moment is - to setup IRQ
> mode.
> 2) No ACPI, but at the moment I do not take care because just taken
> and guessed all info and passed it hardcoded in my prototype of the
> chipone driver. - later I will back to ACPI moment or if it is not
> possible to setup IRQ in 1) without 2 - priorities will be changed.
> 
> DSDT for chipone icn8528 on Chuwi Vi10 (Baytrail Z3736F) is
> here:http://www.spinics.net/lists/linux-i2c/msg23520.html

It claims to be I2C-HID compatible device so I think it should just use
i2c-hid.c which should handle setting up interrupt automatically. Not
sure about loading the firmware but I suppose it is the job of the
higher level HID driver who knows the details.

> Please assists with in setuping IRQ mode for TS driver, possible IRQ
> is gpio based.
> What I have obtained from Android:  SB_GPO1 : gpio base 102 - > this
> means that gpio controller is used!
> Looking for corresponding gpiochip inside Linux 4.2.2 kernel: I have
> discovered suitable (the same amount of ngpio) this one: chip382,
> label: INT33FC:01.
> Also guessing (enumerating all)  gpios via userspace kernel interface
> I have discovered that gpios: 393 and 391,392 - blank off/on
> touchscreen by setting /sys/class/gpio39X/value to 0/1.
> 
> Here is my draft debug code of the driver prototype for Chipone
> icn8528 and irq NOT setuped at the moment :(.
> I think it should be gpio based, in Android it is so:  cat /proc/interrupts
> 
> 389  29 3 0 0  VLV-GPIO-gpio icn85xx_ts.
> 
> Inside my code irq setuping:
> IRQ begin:
> https://gitlab.com/SergK/icn8528/blob/master/myicn.c#L1393
> 
> icn85xx_request_irq
> https://gitlab.com/SergK/icn8528/blob/master/myicn.c#L993

In order to use GPIO as interrupt you need to first request and
configure it like:

	struct gpio_desc *desc;
	int irq;
	
	desc = gpiod_get(dev, NULL, GPIOD_IN);
	irq = gpiod_to_irq(desc);

	request_irq(irq, ...);
	
But in you case, looking at the DSDT there is one Interrupt() resource
below the TCS5 device. That should be handled automatically by the I2C
core and filled in client->irq.
