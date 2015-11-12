From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 01/26] Input: synaptics-rmi4 - embed the function modules
 in rmi_core
Date: Thu, 12 Nov 2015 13:32:33 -0800
Message-ID: <56450571.70200@synaptics.com>
References: <1446766578-30160-1-git-send-email-aduggan@synaptics.com>
 <20151109230635.GC9155@dtor-ws>
 <CAN+gG=G32y=Xp2jpfF7F+F=1-UxeEdX8+ikUNacCXFYmVu14RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:32039 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752426AbbKLVce (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Nov 2015 16:32:34 -0500
In-Reply-To: <CAN+gG=G32y=Xp2jpfF7F+F=1-UxeEdX8+ikUNacCXFYmVu14RQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On 11/10/2015 01:03 AM, Benjamin Tissoires wrote:
> On Tue, Nov 10, 2015 at 12:06 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Nov 05, 2015 at 03:36:18PM -0800, Andrew Duggan wrote:
>>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>
>>> the function modules can not be auto-loaded by udev. So at boot, the
>>> functions are not there and the device is not properly populated.
>>> Force the functions to be embedded in rmi_core so that when the touchpad
>>> is there, the functions are there too.
>> There is nothing inherently different in RMI compared to other buses.
>> kmod package simply needs to be aware of it.
>>
> I can't help but thinking that it is slightly different though. We
> register one RMI bus like the others, but then, the only driver
> (rmi-driver) on the bus needs to enumerate the device and attach other
> kernel modules on demand. It looks as if the rmi device is an other
> internal bus. But the current implementation only allows the functions
> to be loaded during the probe of the rmi_device.
>
> During this probe, we can't block to wait for userspace to load the
> various modules, and so we are screwed. The solution would be to allow
> deferring the loading of the various functions, which basically comes
> down to create a sub-bus per device.
>
> The way I see it is:
> - for 90 % of the cases, RMI4 will be used for touchpads in general
> laptops. Distributions will likely enable 2D sensors, F30, fingerprint
> readers, and maybe a few others. I don't think we want to chase all
> the initrd tools to include the various RMI modules or people will
> have a non functional touchpad.
> - for the rest (embedded, phones, etc,...), these projects usually
> already configure their own kernels and they can decide whether or not
> they want to include which function depending on the actual hardware.
>
> I am not saying that having autoloading is a bad thing. I just can't
> see the interest for the general use case, and I can see the nightmare
> to maintain the autoloading :).
>
> Cheers,
> Benjamin

Conceptually, I like the idea of having functions as modules. That way 
you can only load the function drivers which match your device. But, as 
Benjamin points out supporting that really complicates initialization. 
Especially, when individual functions add capabilities to a single input 
device. If loading a module gets delayed then the input device can get 
registered with an incomplete set of capabilities which could cause 
userspace to misidentify the device. It looks like the input device's 
capabilities will get updated after the module has loaded. But, 
userspace doesn't seem to get a notification that those capabilities 
have changed. I guess one option would be to delete and recreate the 
input device if the capabilities change. Unless there is a better way to 
generate a notification?

I've been looking into getting modules working the last couple of days 
and I haven't really found a good solution. I tried adding the 
appropriate modalias and uevent entries to the function drivers and 
setting up the various fields in mod_devicetable.h and file2alias.c so 
that udev would automatically load the modules when the device is 
created. I haven't gotten this method to work so I am probably missing 
something. But, there is no guarantee that the module will be loaded 
before the input device is registered.

I also tried adding a call to request_module() to load the module just 
before registering the function driver. It works, but there is no 
guarantee that the module will be ready when we do the register. 
Especially, if we don't want to wait and use the _nowait version of 
request_module.

We could change the initialization process to be more asynchronous. We 
could record which functions have modules (based on the return value of 
request_module) and then register for notifications when the function 
driver modules load. Only after all of the modules have loaded do we 
register the input device.

But, these solutions add a lot of complexity and I'm not sure it is 
worth it given the size and number of function drivers. Like Benjamin 
said, on general laptops there will be a few extra function drivers in 
the core. While more resource constrained systems like phones usually 
don't support modules and will have only the function drivers enabled in 
the config which exist on the device. Unless there is a better approach 
I haven't found, I am inclined to just go ahead and include function 
drivers in the core. At least for now.

Andrew
