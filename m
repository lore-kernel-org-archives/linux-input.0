From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 17:09:04 +0100
Message-ID: <CANq1E4SMr1HWXSV3Fc6mB8oCWEJv63i_QZFQLMYCBqCdYsDZxA@mail.gmail.com>
References: <4EC10878.20109@edigma.com>
	<CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
	<4EC13B0F.2080509@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58762 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1KNQJG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 11:09:06 -0500
Received: by wwe5 with SMTP id 5so4596183wwe.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 08:09:05 -0800 (PST)
In-Reply-To: <4EC13B0F.2080509@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

On Mon, Nov 14, 2011 at 5:00 PM, Nuno Santos <nsantos@edigma.com> wrote:
> Hi David,
>
> Thanks for your reply.
>
> The best way probably is using sysfs. Register one sysfs attribute per
> value and configure your callbacks.
> There are several other subsystems that provide wrappers for them. If
> you could be more specific about the user-space interaction or
> configuration values, then we could also be more specific (hopefully
> ;)).
>
> sysfs? Need to dig about it. Is there any typical example I can look in
> kernel source? If you could point me one that would be great.

Almost every driver uses it. Look for "DEVICE_ATTR" in the driver
sources or drivers/input/input.c for instance.

> What do I need to exchange between the kernel and the user space is between
> a simple byte exchange and a whole structure of several bytes.
>
> Do you know the concept of IOCTLS in windows? Basicly that's what looking
> after.

No, sorry. I don't.

> I need to be able to communicate to and from the device from the an
> application build in Qt. So, there must be something really generic that I
> can call from the application environment. In windows I use window API to
> call IOCTLS interaction.

Why? I thought this thing is an input device? Why does an application
have to modify a running device? Is this modification local to the
application<->device interface or does it also affect all other
running applications that use this device?

If it is a configuration value to put the device into a different
state or similar, then you can use a sysfs attribute. The user can
change this with "echo <value> >/sys/class/input/inputX/<attribute>"

> With my best regards,
>
> Nuno

It would be really nice if you could elaborate a bit more. Tell me
what the device does and what access is needed from userspace. Then we
could try to point you to the interfaces.

Regards
David
