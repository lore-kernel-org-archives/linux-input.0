From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Wed, 11 Jan 2017 17:54:11 +0100
Message-ID: <4430320.ODnESzmqU3@wuerfel>
References: <20170110121718.2992211-1-arnd@arndb.de> <4257703.BL932J6KbN@wuerfel> <20170111162828.GA7997@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdAKQyV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 11:54:21 -0500
In-Reply-To: <20170111162828.GA7997@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lyude Paul <thatslyude@gmail.com>

On Wednesday, January 11, 2017 5:28:28 PM CET Benjamin Tissoires wrote:
> Yep, it was initially written that way, and IIRC there was some issues
> depending on how the drivers were compiled. For example, if rmi4_core is
> Y and some functions are m, you can't load the device initially, so you
> send a -EPROBE_DEFER, but how can you be sure that the function will
> ever be loaded?

I'm not sure if I understand your problem correctly, but normally
the way it's done is that the bus driver notifies user space that
a new device has appeared on the bus, and udev looks for the right
driver for the device, using a MODULE_DEVICE_TABLE list. Once the
driver gets loaded, it binds to the device.

> Given that we need to have all the functions loaded during probe, we
> decided to switch to a monolithic rmi4_core driver that has everything
> it needs inside.

If everything is in one module, you can probably get rid of at
least part of the bus abstraction as well and just call the functions
directly.

Looking through the driver some more, I also find the
'rmi_driver rmi_physical_driver' concept very odd, you seem to
have a device on the bus that is actually just another representation
of the parent device and that creates another set of devices for
the functions. Either I misunderstand what this is for, or you have
a candidate for cleanup there and once you remove it (by calling
rmi_driver_probe() instead of rmi_register_transport_device()
to oversimplify the idea), the actual probing for the function
drivers becomes much easier to do right.

	Arnd
