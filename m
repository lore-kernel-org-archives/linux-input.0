From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 01/26] Input: synaptics-rmi4 - embed the function modules
 in rmi_core
Date: Tue, 10 Nov 2015 10:03:12 +0100
Message-ID: <CAN+gG=G32y=Xp2jpfF7F+F=1-UxeEdX8+ikUNacCXFYmVu14RQ@mail.gmail.com>
References: <1446766578-30160-1-git-send-email-aduggan@synaptics.com>
	<20151109230635.GC9155@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37545 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbbKJJDO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2015 04:03:14 -0500
In-Reply-To: <20151109230635.GC9155@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Tue, Nov 10, 2015 at 12:06 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 05, 2015 at 03:36:18PM -0800, Andrew Duggan wrote:
>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> the function modules can not be auto-loaded by udev. So at boot, the
>> functions are not there and the device is not properly populated.
>> Force the functions to be embedded in rmi_core so that when the touchpad
>> is there, the functions are there too.
>
> There is nothing inherently different in RMI compared to other buses.
> kmod package simply needs to be aware of it.
>

I can't help but thinking that it is slightly different though. We
register one RMI bus like the others, but then, the only driver
(rmi-driver) on the bus needs to enumerate the device and attach other
kernel modules on demand. It looks as if the rmi device is an other
internal bus. But the current implementation only allows the functions
to be loaded during the probe of the rmi_device.

During this probe, we can't block to wait for userspace to load the
various modules, and so we are screwed. The solution would be to allow
deferring the loading of the various functions, which basically comes
down to create a sub-bus per device.

The way I see it is:
- for 90 % of the cases, RMI4 will be used for touchpads in general
laptops. Distributions will likely enable 2D sensors, F30, fingerprint
readers, and maybe a few others. I don't think we want to chase all
the initrd tools to include the various RMI modules or people will
have a non functional touchpad.
- for the rest (embedded, phones, etc,...), these projects usually
already configure their own kernels and they can decide whether or not
they want to include which function depending on the actual hardware.

I am not saying that having autoloading is a bad thing. I just can't
see the interest for the general use case, and I can see the nightmare
to maintain the autoloading :).

Cheers,
Benjamin
