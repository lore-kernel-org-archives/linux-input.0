From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 12:56:44 -0800
Message-ID: <20101203205643.GC21277@core.coreip.homeip.net>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
 <20101203193224.GA21277@core.coreip.homeip.net>
 <AANLkTikw3HF7CUc-7Enw-SGXztmiZAPUYZEKT1ViDTic@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33356 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab0LCU4y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Dec 2010 15:56:54 -0500
Received: by ywl5 with SMTP id 5so5018633ywl.19
        for <linux-input@vger.kernel.org>; Fri, 03 Dec 2010 12:56:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikw3HF7CUc-7Enw-SGXztmiZAPUYZEKT1ViDTic@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 01:50:08PM -0600, Bill Gatliff wrote:
> Dmitry:
> 
> On Fri, Dec 3, 2010 at 1:32 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > How would the driver know if application that is opened the device
> > does not want to be aware of the events that happened before read as
> > opposed to the application that simply choses to "batch" events and
> > process them at once? The driver might not be able to retrieve the "old"
> > state of the hardware. Lets say toggle WIFI button was pressed and
> > released while application wasn't reading. Normally kernel would queue
> > the events and when userspace read the FD they'd see events, whereas in
> > your case events would be lost.
> 
> Good question.
> 
> What I'm proposing is really useful only for embedded work, where you
> have absolute control (or at least understanding) over what the
> hardware and driver stack looks like.  If one wanted to see all the
> transitions of the WiFi button (to use your example), they'd bind the
> hardware to a driver that worked that way.  The system integrator
> would make the choice, not the application.

Signficant number of drivers work in different environments as do
the applications. System integrator can not make this choice since _his_
choice might be different from another system integrator's choice.

> 
> In situations where an application wanted the accumulating behavior
> sometimes, and the stateless behavior at other times, then the system
> integrator could provide for that by using two different event
> interfaces, one for each personality.  I think...

Having a diffrent interface for certain class of devices is an option.
Accelerometers, magnetometers and other not pure HID devices might make
use of IIO and/or sysfs. In fact, most of accelerometer drivers attempt
to provide their own sysfs interfaces and among them ways to fetch
current device state. This kind of interface seems to suit your needs
best.

Note that standardizing sysfs accelerometer inteface is under
discussion and if you are interested you shoudl join it.

> 
> > I'd say applications that really want this behavior simply need to
> > go through open/read/close cycles.
> 
> Wow, that seems really, really expensive at a sampling rate of 100+Hz.

First of all - not really (this how much open is similar to your
callback anyway) and second - if it gets expensive you stop doing this.

-- 
Dmitry
