From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Wed, 11 Jan 2017 18:48:13 +0100
Message-ID: <20170111174813.GB7997@mail.corp.redhat.com>
References: <20170110121718.2992211-1-arnd@arndb.de>
 <4257703.BL932J6KbN@wuerfel>
 <20170111162828.GA7997@mail.corp.redhat.com>
 <4430320.ODnESzmqU3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4430320.ODnESzmqU3@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lyude Paul <thatslyude@gmail.com>
List-Id: linux-input@vger.kernel.org

On Jan 11 2017 or thereabouts, Arnd Bergmann wrote:
> On Wednesday, January 11, 2017 5:28:28 PM CET Benjamin Tissoires wrote:
> > Yep, it was initially written that way, and IIRC there was some issues
> > depending on how the drivers were compiled. For example, if rmi4_core is
> > Y and some functions are m, you can't load the device initially, so you
> > send a -EPROBE_DEFER, but how can you be sure that the function will
> > ever be loaded?
> 
> I'm not sure if I understand your problem correctly, but normally
> the way it's done is that the bus driver notifies user space that
> a new device has appeared on the bus, and udev looks for the right
> driver for the device, using a MODULE_DEVICE_TABLE list. Once the
> driver gets loaded, it binds to the device.
> 

I agree, but we never managed to make it properly working for RMI4. See
https://lkml.org/lkml/2015/11/5/726 where we decided to switch to a
static list of functions. Maybe we did not try hard enough, but we kept
the current bus/functions_as_drivers to be able to switch back to the
modular option,

> > Given that we need to have all the functions loaded during probe, we
> > decided to switch to a monolithic rmi4_core driver that has everything
> > it needs inside.
> 
> If everything is in one module, you can probably get rid of at
> least part of the bus abstraction as well and just call the functions
> directly.

Agree, though that means we won't be able to switch back. In the current
form it's overly engineered.

> 
> Looking through the driver some more, I also find the
> 'rmi_driver rmi_physical_driver' concept very odd, you seem to
> have a device on the bus that is actually just another representation
> of the parent device and that creates another set of devices for
> the functions. Either I misunderstand what this is for, or you have

I think you have this right.

> a candidate for cleanup there and once you remove it (by calling
> rmi_driver_probe() instead of rmi_register_transport_device()
> to oversimplify the idea), the actual probing for the function
> drivers becomes much easier to do right.
> 

Agree, that would simplify the code a lot. I just don't know how
important it is for other users of RMI4 to have a modular solution or if
the monolithic approach is a consensus now. The modular solution is
currently disabled, but we can "always" switch back with a small effort.

My opinion on this matter is that there is no need for the modular
functions, but others might have a different opinion.

Cheers,
Benjamin
