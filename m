From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 11:32:25 +0100
Message-ID: <20111115103225.GA8074@polaris.bitmath.org>
References: <4EC10878.20109@edigma.com>
 <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
 <4EC13B0F.2080509@edigma.com>
 <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
 <4EC1427D.2090703@edigma.com>
 <20111114171300.GB12659@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:49807 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab1KOKcf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 05:32:35 -0500
Received: from iph3.telenor.se (iph3.telenor.se [195.54.127.134])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 6B08F14217
	for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 11:32:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111114171300.GB12659@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nuno Santos <nsantos@edigma.com>, linux-input@vger.kernel.org

> > >>I need to be able to communicate to and from the device from the an
> > >>application build in Qt. So, there must be something really generic that I
> > >>can call from the application environment. In windows I use window API to
> > >>call IOCTLS interaction.
> > >Why? I thought this thing is an input device? Why does an application
> > >have to modify a running device? Is this modification local to the
> > >application<->device interface or does it also affect all other
> > >running applications that use this device?
> > Yes, it is an multitouch overlay input device. However all the
> > processing is done on the host side. The device delivers raw data
> > into the system and all the tracking and touch information is
> > processed on the kernel side. The control panel for this device
> > shows the input data and permits some parameter change. In order to
> > visualize that data I need to be able to get a complete structure
> > from it. When I change a parameter it will reflect the change to the
> > input being reported to all the applications that use that input
> > device.
> > >
> > >If it is a configuration value to put the device into a different
> > >state or similar, then you can use a sysfs attribute. The user can
> > >change this with "echo<value>  >/sys/class/input/inputX/<attribute>"
> > For setting new simple values I see I can use this interface, but
> > two questions arise. How can I send a structure with this interface?
> 
> Yes, using binary attributes.
> 
> > Can I fopen this sys file and send the whole structure thru this
> > mechanism. What about receiving data from the device?
> 
> Depend on the kind of data you need to get. Is the device state as
> delivered through input device is not enough? Then maybe you don't want
> to use input interface but rather use something like hiddev or hidraw
> for direct access to the device, do the needed processing in userspace
> and then use uinput to route the events back to kernel for distribution.
> 
> However so far we managed to do contact tracking in kernel...
> 
> What I do not want to have is custom input driver ioctls; I want clients
> to work off declared input capabilities aas much as possible.

Right. Unless we are talking about haptic feedback or leds,
information really flows one way, so there should be no reason to send
anything back to the kernel. For detected but anonymous touches, we
have MT protocol A in the input subsystem. If your raw data does not
even contain detected touches, I would try hidraw, as Dmitry
suggested.

Thanks,
Henrik
