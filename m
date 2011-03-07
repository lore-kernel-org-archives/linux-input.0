From: Alan Ott <alan@signal11.us>
Subject: Re: libudev, a question about the enumerate API.
Date: Mon, 07 Mar 2011 11:01:21 -0500
Message-ID: <4D750151.7070904@signal11.us>
References: <20110223235053.ae9d6b0a.ospite@studenti.unina.it> <AANLkTik7pPUYou9OwD0E5r-Wr3a67kQZPToDepZH8pLu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:49326 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755077Ab1CGQBW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Mar 2011 11:01:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 48EFC1CCAC07
	for <linux-input@vger.kernel.org>; Mon,  7 Mar 2011 11:01:22 -0500 (EST)
In-Reply-To: <AANLkTik7pPUYou9OwD0E5r-Wr3a67kQZPToDepZH8pLu@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-hotplug@vger.kernel.org, linux-input@vger.kernel.org

On 03/07/2011 10:27 AM, Kay Sievers wrote:
> The usual enumeration in udev never uses the device tree in
> /sys/devices/, only the subsystem lists /sys/{class,bus}/. We could
> have something to enumerate all child devices of a given device. It's
> not simple, but could be made working.
>    

Hi Kay,

The documentation in Documentation/sysfs-rules.txt seems to warn against 
using /sys/class and sys/bus:

- devices are only "devices"
   There is no such thing like class-, bus-, physical devices,
   interfaces, and such that you can rely on in userspace. Everything is
   just simply a "device". Class-, bus-, physical, ... types are just
   kernel implementation details which should not be expected by
   applications that look for devices in sysfs.

...
       - all elements of a devpath must be real directories. Symlinks
         pointing to /sys/devices must always be resolved to their real
         target and the target path must be used to access the device.
         That way the devpath to the device matches the devpath of the
         kernel used at event time.
       - using or exposing symlink values as elements in a devpath string
         is a bug in the application

...

       - accessing attributes reached by a symlink pointing to another 
device,
         like the "device"-link, is a bug in the application

...

- Hierarchy in a single device tree
   There is only one valid place in sysfs where hierarchy can be examined
   and this is below: /sys/devices.

and more...

I figured that this document was probably out of date, since even 
libudev uses /sys/class. What's your take on this document?

Alan.


