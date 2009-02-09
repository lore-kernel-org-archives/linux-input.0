From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH] sh: maple: add support for Visual Memory Card devices,
 and make consequential changes to maple input drivers - 2/3 - v5
Date: Mon, 09 Feb 2009 19:17:33 +0000
Message-ID: <1234207053.6756.11.camel@localhost.localdomain>
References: <1234122069.6736.8.camel@localhost.localdomain>
	 <1234123473.6736.29.camel@localhost.localdomain>
	 <20090209065632.GA21980@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20090209065632.GA21980@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2009-02-09 at 15:56 +0900, Paul Mundt wrote:
> On Sun, Feb 08, 2009 at 08:04:33PM +0000, Adrian McMenamin wrote:
> > Change the maple bus driver to support the visual memory unit driver.
> > 
> > The maple bus driver currently only supports synchronous polling of attached devices status. These changes allow
> > the bus to handle asynchronous commands such as block reads and writes. 
> > 
> > Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
> The ordering of your patch series is a bit vague. Do the changes to the
> maple bus code need to be made before the VMU patch can be applied? Do
> the input driver changes have to be made at the same time as the changes
> to the bus code, or are they ok to leave as a separate patch after the
> bus changes?
> 
> All of these seem to have some interdependency issues that haven't been
> noted at all, making it incredibly difficult to apply incrementally. Your
> subject for the series also seems to imply you have no idea how they
> logically structure, and that you simply hacked things up until the point
> where everything worked, rather than paying attention to logical
> incremental changes to show how you got from point A to point B without
> breaking bisection along the way.
> 

You are right. I haven' made it fully clear in this post. But I did in
previous posts eg:

"This series of patches adds support for the Dreamcast Visual Memory
Unit, reworking the maple bus code to ensure it supports asynchronous
reads and writes. A consequential amendment to the keyboard driver is
also included."

I know you read them because you commented on the code.

The VMU will not work without changes in the bus code because the
existing bus code relies on periodic polling (eg the keyboard is polled
50 times a second). That plainly won't work with a block device.

(The keyboard and joystick changes are minor and consequential to
changes made to eliminate some of the memory hacks you disliked
previously)

I could have posted it all as one patch but given that there are three
different maintainers here - Greg KH for the bus code, Dmitry for the
input layer and David Woodhouse for the MTD device it seemed pretty
sensible to me to break the code up in that way.

Unfortunately the hardware is quite flaky and that causes race
conditions (eg block writes can be so slow it can look like the device
has been removed). But I have also had issues in getting the locking
right - particularly as clone devices (and I wrote the first round
against one) behave slightly differently from SEGA devices.



> We do not want to have the tree in a state where bisection is broken, nor
> do we want to apply huge monolothic changes that are unable to be clearly
> broken out.

They are broken out. As I said - bus, mtd device and input devices.

> 
> At this point the maple bus stuff I am fine with, and I have no real
> objections to the driver patches either, it is more your methodology or
> lack thereof that makes dealing with this rather taxing. If you want your
> patches applied, small incremental patches that don't leave the tree in a
> broken state are the way to go.

Small incremental patches won't work. The bus code has to change to
support the device. The device is obviously a new file and the input
changes are consequential to the bus changes.




