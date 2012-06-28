From: Donald Kayser <linux@kayser.net>
Subject: Re: /dev/input/by-path/<link> unreliable with MultiTouch device
Date: Thu, 28 Jun 2012 15:34:34 -0500
Message-ID: <2DE32D19-969D-44F6-BE9F-83CD2447D8E5@kayser.net>
References: <73A57920-C505-48DF-A1F2-393BF18585DC@kayser.net> <CAN+gG=F8eH-p3S3gH=_8+UZf63LcoyEU_9xu+hFcfsQwmqbWwg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from omr14.networksolutionsemail.com ([205.178.146.64]:43956 "EHLO
	omr14.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769Ab2F1Uen (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 16:34:43 -0400
Received: from cm-omr11 (mail.networksolutionsemail.com [205.178.146.50])
	by omr14.networksolutionsemail.com (8.13.8/8.13.8) with ESMTP id q5SKYhXZ008567
	for <linux-input@vger.kernel.org>; Thu, 28 Jun 2012 16:34:43 -0400
In-Reply-To: <CAN+gG=F8eH-p3S3gH=_8+UZf63LcoyEU_9xu+hFcfsQwmqbWwg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Benjamin,

> So:
> 1) between 2.6.34 and 2.6.39, Mosart devices are handled in
> hid-mosart, and since 3.0 through hid-multitouch. Using these drivers
> will allow you to have a better support of your devices.
> However I'm not 100% sure it won't create more than one input device
> if your hardware declares more than one interface.
>
> 2) Using the quirk HID_QUIRK_MULTI_INPUT is the exact opposite of what
> you want to do -> it creates several inputs when it sees several
> touches -> you then have a lot of inputs with unusable stuff.
>
I have returned to this problem today. I've turned off the QUIRK and  
added the hid_mosart driver. These devices are new so I added their  
ID's so the mosart driver would recognize them. I end up with the same  
results I had before ever trying the QUIRK: the event codes from the  
device are not ABS_X and ABS_Y, but ABS_HAT2X and ABS_HAT2Y.  These  
ABS_HAT2? events make it through the system device files and I can  
read them using the linux input API. The problem is that the xorg  
evdev driver does not process the ABS_HAT2? events. The QUIRK made the  
events change to ABS_X and ABS_Y. The usbhid driver and hid_mosart  
driver end up giving the same results with respect to the data being  
reported via linux input API.
>
> - patch your kernel (> 2.6.35) using the patches here:
> http://www.lii-enac.fr/en/architecture/linux-input/multitouch-howto.html#get
> (but I did not tested old kernel releases) -> you will get the same
> input layer for multitouch than a 3.4 kernel (the older the kernel is,
> the more intrusive it is).

I am reluctant to patch the kernel we end up qualifying for our  
systems. It is an unknown for me trying to deliver a product soon.

> - work on an udev rule that detect the physical path, and creates a
> symlink /dev/input/mosart-X

This is helpful and made it where I could get the QUIRK solution  
working okay. Without the QUIRK there isn't an entry problem in the / 
dev/input/by-path directory.

> - rely on xorg input rules system to detect your devices (though I
> don't know when they added the physical path in the configuration
> options).



I have been attempting to get the driver layer to send up ABS_X and  
ABS_Y so that evdev would work. I mod'd evdev to process the new  
events but it got screwy. I prefer to get the system to send up events  
that evdev will handle and I won't have to modify it further. I don't  
need any kind of multi-touch capability until the next major revision  
of our application software, so I am taking the shortest path to get  
there.

Thanks,
Donald

