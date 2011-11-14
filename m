From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: Interacting with a input kernel driver from user space
Date: Mon, 14 Nov 2011 16:37:47 +0100
Message-ID: <CANq1E4SZnv0yNbmKqV-my3wanKGe4R4UW6_=z-awO6ci14xyRA@mail.gmail.com>
References: <4EC10878.20109@edigma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63099 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab1KNPhs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 10:37:48 -0500
Received: by wwe5 with SMTP id 5so4549711wwe.1
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 07:37:47 -0800 (PST)
In-Reply-To: <4EC10878.20109@edigma.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nuno Santos <nsantos@edigma.com>
Cc: linux-input@vger.kernel.org

Hi Nuno

On Mon, Nov 14, 2011 at 1:24 PM, Nuno Santos <nsantos@edigma.com> wrote:
> Hi,
>
> I'm developing a linux kernel driver for a multitouch device. Right now I
> have already touch being injected to the linux kernel subsystem and it is
> working. The problem is that I also need to interact with the device to
> change settings an so on.
>
> While the kernel is grabbing the device I can't grab it in user space, so I
> need to find a way to interact with the kernel driver.
>
> My first driver test (missile laucnher example found on the internet) had
> some extra operations that I can't find on the current model i'm using
> (usbtouchscreen driver was my starting point).
>
> It had open, close, read, write operations that I could perform from user
> space.

There are open/close callbacks but they are only called for the first
and last application that opens/closes the device.
You should avoid character-devices with special ioctl()s if you
thought about that, though.

> How can I do such things with input drivers? Is there any official way?

The best way probably is using sysfs. Register one sysfs attribute per
value and configure your callbacks.
There are several other subsystems that provide wrappers for them. If
you could be more specific about the user-space interaction or
configuration values, then we could also be more specific (hopefully
;)).

Per driver values can be provided with module-parameters. Per device
values can be provided by sysfs attributes. For per-application/user
values you probably need special character-devices.

> Thanks in advance,
>
> With my best regards,
>
> Nuno Santos

Regards
David
