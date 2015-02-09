From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Mon, 9 Feb 2015 15:25:05 +0200
Message-ID: <20150209132505.GG1480@lahna.fi.intel.com>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
 <20150119153758.GA18115@mail.corp.redhat.com>
 <20150120100548.GG1850@lahna.fi.intel.com>
 <20150120175645.f0f95b83da0355b8fdc7dd0d@ao2.it>
 <20150121101654.GM1850@lahna.fi.intel.com>
 <20150127154559.5baae4c2d2540f6f4362e3c6@ao2.it>
 <20150206170013.90a20c05fae6393ea92312df@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34702 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760281AbbBIN1S (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Feb 2015 08:27:18 -0500
Content-Disposition: inline
In-Reply-To: <20150206170013.90a20c05fae6393ea92312df@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>

On Fri, Feb 06, 2015 at 05:00:13PM +0100, Antonio Ospite wrote:
> Last doubt, now that I am fixing the DSDT I am going to add an
> Interrupt resource, but what is the correct way to specify its value?
> Pin 3 of GPO2 is mapped to IRQ 220 by the mainline kernel, so I added
> this:
> 
>   Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
>   {
>     0x000000DC,
>   }
> 
> And it works, but doesn't this rely on the way linux maps interrupt
> numbers? Is this going to be OS agnostic? My doubt arises from the
> fact that on the Android kernel the same pin is mapped to IRQ
> 389.

You should specify GpioInt() instead and turn it to interrupt using
gpiod_to_irq().
