From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Tue, 15 Nov 2011 11:07:46 -0800
Message-ID: <4EC2B882.10503@gmail.com>
References: <4EC10878.20109@edigma.com> <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com> <4EC13B0F.2080509@edigma.com> <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com> <4EC1427D.2090703@edigma.com> <20111114171300.GB12659@core.coreip.homeip.net> <20111115103225.GA8074@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44840 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab1KOTHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 14:07:51 -0500
Received: by ywt32 with SMTP id 32so3819411ywt.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 11:07:51 -0800 (PST)
In-Reply-To: <20111115103225.GA8074@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nuno Santos <nsantos@edigma.com>, linux-input@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>

On 11/15/2011 02:32 AM, Henrik Rydberg wrote:
>>>>> I need to be able to communicate to and from the device from the an
>>>>> application build in Qt. So, there must be something really generic that I
>>>>> can call from the application environment. In windows I use window API to
>>>>> call IOCTLS interaction.
>>>> Why? I thought this thing is an input device? Why does an application
>>>> have to modify a running device? Is this modification local to the
>>>> application<->device interface or does it also affect all other
>>>> running applications that use this device?
>>> Yes, it is an multitouch overlay input device. However all the
>>> processing is done on the host side. The device delivers raw data
>>> into the system and all the tracking and touch information is
>>> processed on the kernel side. The control panel for this device
>>> shows the input data and permits some parameter change. In order to
>>> visualize that data I need to be able to get a complete structure
>>> from it. When I change a parameter it will reflect the change to the
>>> input being reported to all the applications that use that input
>>> device.
>>>>
>>>> If it is a configuration value to put the device into a different
>>>> state or similar, then you can use a sysfs attribute. The user can
>>>> change this with "echo<value>  >/sys/class/input/inputX/<attribute>"
>>> For setting new simple values I see I can use this interface, but
>>> two questions arise. How can I send a structure with this interface?
>>
>> Yes, using binary attributes.
>>
>>> Can I fopen this sys file and send the whole structure thru this
>>> mechanism. What about receiving data from the device?
>>
>> Depend on the kind of data you need to get. Is the device state as
>> delivered through input device is not enough? Then maybe you don't want
>> to use input interface but rather use something like hiddev or hidraw
>> for direct access to the device, do the needed processing in userspace
>> and then use uinput to route the events back to kernel for distribution.
>>
>> However so far we managed to do contact tracking in kernel...
>>
>> What I do not want to have is custom input driver ioctls; I want clients
>> to work off declared input capabilities aas much as possible.
> 
> Right. Unless we are talking about haptic feedback or leds,
> information really flows one way, so there should be no reason to send
> anything back to the kernel. For detected but anonymous touches, we
> have MT protocol A in the input subsystem. If your raw data does not
> even contain detected touches, I would try hidraw, as Dmitry
> suggested.

We may want to look into creating a mechanism for taking raw bitmap data
and assigning touch points. ALPS trackpads and apparently Nuno's device
provide raw data and need touch point recognition processing.

Perhaps we could take the code in the ALPS driver and generalize it?

-- Chase
