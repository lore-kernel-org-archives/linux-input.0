From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 09:13:01 -0800
Message-ID: <20111114171300.GB12659@core.coreip.homeip.net>
References: <4EC10878.20109@edigma.com>
 <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
 <4EC13B0F.2080509@edigma.com>
 <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
 <4EC1427D.2090703@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59316 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963Ab1KNRNH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 12:13:07 -0500
Received: by pzk36 with SMTP id 36so12863394pzk.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 09:13:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4EC1427D.2090703@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Mon, Nov 14, 2011 at 04:31:57PM +0000, Nuno Santos wrote:
> On 11/14/2011 04:09 PM, David Herrmann wrote:
> >On Mon, Nov 14, 2011 at 5:00 PM, Nuno Santos<nsantos@edigma.com>  wrote:
> >>Hi David,
> >>
> >>Thanks for your reply.
> >>
> >>The best way probably is using sysfs. Register one sysfs attribute per
> >>value and configure your callbacks.
> >>There are several other subsystems that provide wrappers for them. If
> >>you could be more specific about the user-space interaction or
> >>configuration values, then we could also be more specific (hopefully
> >>;)).
> >>
> >>sysfs? Need to dig about it. Is there any typical example I can look in
> >>kernel source? If you could point me one that would be great.
> >Almost every driver uses it. Look for "DEVICE_ATTR" in the driver
> >sources or drivers/input/input.c for instance.
> Ok. I'll look for that.
> >>What do I need to exchange between the kernel and the user space is between
> >>a simple byte exchange and a whole structure of several bytes.
> >>
> >>Do you know the concept of IOCTLS in windows? Basicly that's what looking
> >>after.
> >No, sorry. I don't.
> No problem.
> >
> >>I need to be able to communicate to and from the device from the an
> >>application build in Qt. So, there must be something really generic that I
> >>can call from the application environment. In windows I use window API to
> >>call IOCTLS interaction.
> >Why? I thought this thing is an input device? Why does an application
> >have to modify a running device? Is this modification local to the
> >application<->device interface or does it also affect all other
> >running applications that use this device?
> Yes, it is an multitouch overlay input device. However all the
> processing is done on the host side. The device delivers raw data
> into the system and all the tracking and touch information is
> processed on the kernel side. The control panel for this device
> shows the input data and permits some parameter change. In order to
> visualize that data I need to be able to get a complete structure
> from it. When I change a parameter it will reflect the change to the
> input being reported to all the applications that use that input
> device.
> >
> >If it is a configuration value to put the device into a different
> >state or similar, then you can use a sysfs attribute. The user can
> >change this with "echo<value>  >/sys/class/input/inputX/<attribute>"
> For setting new simple values I see I can use this interface, but
> two questions arise. How can I send a structure with this interface?

Yes, using binary attributes.

> Can I fopen this sys file and send the whole structure thru this
> mechanism. What about receiving data from the device?

Depend on the kind of data you need to get. Is the device state as
delivered through input device is not enough? Then maybe you don't want
to use input interface but rather use something like hiddev or hidraw
for direct access to the device, do the needed processing in userspace
and then use uinput to route the events back to kernel for distribution.

However so far we managed to do contact tracking in kernel...

What I do not want to have is custom input driver ioctls; I want clients
to work off declared input capabilities aas much as possible.

Thanks.

-- 
Dmitry
