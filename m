From: Eduard Hasenleithner <ehasenle@gmail.com>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED support
Date: Thu, 31 Mar 2011 22:01:08 +0200
Message-ID: <AANLkTin4MFfE5D9iVWjs_HZDJ5Ebq9vyfmQBDy-rUtfv@mail.gmail.com>
References: <1301225280-5642-1-git-send-email-eduard@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54795 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162Ab1CaUBJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 16:01:09 -0400
Received: by yxs7 with SMTP id 7so1127027yxs.19
        for <linux-input@vger.kernel.org>; Thu, 31 Mar 2011 13:01:08 -0700 (PDT)
In-Reply-To: <1301225280-5642-1-git-send-email-eduard@hasenleithner.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Cc: linux-input@vger.kernel.org

Hi

Since there have already passed some days after posting this patch, I
want to ask about the general potential of inclusion into the linux
input subsystem.

Every now and than, input devices are built which have small LCD/LED
displays on it. AFAIK, there exists no (Intel approved USB-) standard
for these devices, they just use some Control URBs.

One example is the Intous4, for which I submitted the patch. Another
example is the Saitek X52 pro, for which I wrote a simple user-space
library for setting the LCD. With both devices it became obvious that
in the linux kernel, no direct support for this (unofficial) class of
devices is available yet. The X52 is an example, but not the direct
topic for this discussion, since the event device is not "grabbed" (at
least when I last checked), which means that URBs can be sent to the
device even when being registered with the input subsystem.

Currently I identified following possible methods for solving the task:
* URBs via USB raw device to physical usb device
* LED IOCTL via evdev to wacom.ko
* IOCTLs via USB raw device to wacom.ko (i.e. this patch)
* IOCTLs via evdev to wacom.ko
* Control URBs via evdev to wacom.ko

In the next sections I iterate over the individual methods. At the end
of each section I summarize good (+) and bad (-) properties.

==== URBs via USB raw device to physical USB device ====
There already exist some implementations using this method. The
general (and severe) problem with this method is, that the kernel
driver has to be unloaded before the images can be changed.
+ No changes in input subsystem required
+ No changes in input device driver needed
- Need for input device driver unload

==== LED IOCTL via evdev to wacom.ko ====
This method requires the input subsystem to be aware of input devices
with LEDs and OLED matrix displays. This could either be an extension
to the existing LED ioctl (unlikely) or a completely new
(matrix-)Display IOCTL.
+ Generic user-space tool can be implemented
- Requires changes in input subsystem
- Future proof IOCTL interface nearly impossible to specify

==== IOCTLs via USB raw device to wacom.ko ====
This is my currently preferred method. This method has been invented
by Nicolas Hirsch, and has been included to the linuxwacom tree. AFAIK
there were no efforts yet to get it into the main kernel tree.
I completely rewrote this patch, because a few adaptations were needed
for the 2.6.38 kernel, and I did not want to have the image
de-interleaving code in the kernel. (In a next version of the patch I
should put a "thanks to Nicolas" into a source comment).

For changing LED images, the commands travel in the following way to the tablet:
xsetwacom => wacom xorg-input-driver => wacom linux kernel driver
+ Requires no changes in input subsystem
+ It is possible to supply external kernel module for older kernel releases

==== IOCTLs via evdev to wacom.ko ====
This is is basically the previous method, but routed over the input
event device instead of using the raw USB device.
+ Removes the need to consult "/sys" for mapping the event device to
the raw USB device
- No possibility for compilation of externel wacom kernel driver for
older kernels

==== Control URBs via evdev to wacom.ko ====
This is probably a "bad idea". The idea is to let the input kernel
driver expose a restricted subset of Control URBs by means of the
input event device.
+ It is supposed that only very few lines of codes needed in input driver.
+ Most of the development happens in the user-space; kernel driver
patches frequency supposed to be almost zero after initial patch
- Might provide "hole" for several security related bugs
- No possibility for compilation of external wacom kernel driver for
older kernels

Comments and suggestions for further methods are welcome.

thanks,
Eduard
