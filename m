From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Thu, 12 Jan 2017 16:42:55 -0800
Message-ID: <c2cfe90e-521c-1e51-b2f0-8a9d97d0b683@synaptics.com>
References: <20170110121718.2992211-1-arnd@arndb.de>
 <4257703.BL932J6KbN@wuerfel> <20170111162828.GA7997@mail.corp.redhat.com>
 <4430320.ODnESzmqU3@wuerfel> <20170111174813.GB7997@mail.corp.redhat.com>
 <1484162868.2884.77.camel@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484162868.2884.77.camel@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lyude Paul <thatslyude@gmail.com>
List-Id: linux-input@vger.kernel.org

On 01/11/2017 11:27 AM, Christopher Heiny wrote:
> On Wed, 2017-01-11 at 18:48 +0100, Benjamin Tissoires wrote:
>> On Jan 11 2017 or thereabouts, Arnd Bergmann wrote:
>>> On Wednesday, January 11, 2017 5:28:28 PM CET Benjamin Tissoires
>>> wrote:
>>>> Yep, it was initially written that way, and IIRC there was some
>>>> issues
>>>> depending on how the drivers were compiled. For example, if
>>>> rmi4_core is
>>>> Y and some functions are m, you can't load the device initially,
>>>> so you
>>>> send a -EPROBE_DEFER, but how can you be sure that the function
>>>> will
>>>> ever be loaded?
>>> I'm not sure if I understand your problem correctly, but normally
>>> the way it's done is that the bus driver notifies user space that
>>> a new device has appeared on the bus, and udev looks for the right
>>> driver for the device, using a MODULE_DEVICE_TABLE list. Once the
>>> driver gets loaded, it binds to the device.
>>>
>> I agree, but we never managed to make it properly working for RMI4.
>> See
>> https://lkml.org/lkml/2015/11/5/726 where we decided to switch to a
>> static list of functions. Maybe we did not try hard enough, but we
>> kept
>> the current bus/functions_as_drivers to be able to switch back to the
>> modular option,
> Actually, long, long ago (well before I got yanked off the RMI4 driver
> project for a 'short term emergency' two and a half years ago -
> fortunately Andrew was more than able to take it over) it worked that
> way.  If you had the bus, a physical driver, and the sensor driver
> running, you could build the functions as modules and attach them via
> udev or insert them later.
>
> We had this working on the bench at one point, but fairly early in the
> submission process seem to have just assumed it would keep working and
> stopped regression testing on that feature.  There have been an whole
> lot of changes since then, and somewhere along the line functions-as-
> loadable-modules stopped working.  Since we weren't testing it anymore,
> it wasn't caught.
>

We made the decision to disable support for function drivers as modules 
after running into a few technical challenges which happened during 
initialization. The priority was to get the driver upstreamed so we put 
off getting function drivers working as modules until there was a 
compelling reason to do so. But, we left the structure mostly intact if 
we decided to do so. Here are the messages which describe what we 
discovered at the time:

https://lkml.org/lkml/2015/11/10/92
https://lkml.org/lkml/2015/11/12/652

I'm basically coming to the same conclusion I had back then. Getting 
loadable modules for function drivers to work would add complexity for 
not a lot of benefit based on the current state of the driver and how it 
is currently being used. I'm also not sure we will reach the critical 
mass of function drivers where there is a significant benefit of not 
having to load them all.

>>>> Given that we need to have all the functions loaded during probe,
>>>> we
>>>> decided to switch to a monolithic rmi4_core driver that has
>>>> everything
>>>> it needs inside.
>>> If everything is in one module, you can probably get rid of at
>>> least part of the bus abstraction as well and just call the
>>> functions
>>> directly.
>> Agree, though that means we won't be able to switch back. In the
>> current
>> form it's overly engineered.
> Well, I'm not sure I agree with that. :-)  More on that later in this
> email.
>
>>>
>>> Looking through the driver some more, I also find the
>>> 'rmi_driver rmi_physical_driver' concept very odd, you seem to
>>> have a device on the bus that is actually just another
>>> representation
>>> of the parent device and that creates another set of devices for
>>> the functions. Either I misunderstand what this is for, or you have
>> I think you have this right.
>>
>>> a candidate for cleanup there and once you remove it (by calling
>>> rmi_driver_probe() instead of rmi_register_transport_device()
>>> to oversimplify the idea), the actual probing for the function
>>> drivers becomes much easier to do right.
>>>
>> Agree, that would simplify the code a lot. I just don't know how
>> important it is for other users of RMI4 to have a modular solution or
>> if
>> the monolithic approach is a consensus now. The modular solution is
>> currently disabled, but we can "always" switch back with a small
>> effort.
>>
>> My opinion on this matter is that there is no need for the modular
>> functions, but others might have a different opinion.

Just to clarify, this is proposing that the rmi_physical device be 
removed and we just calling the equivalent functions from the context of 
the transport? Basically, what Bjorn suggested here last year:

https://lkml.org/lkml/2016/4/21/781

Andrew

> The primary impetus for the original modular function design was to
> allow phone/tablet/etc manufacturers to write their own handlers for
> some functions without having to write the entire driver or hack up an
> existing monolithic driver.  This simplifies engineering for the device
> manufacturer a lot.
>
> We also hoped that other peripheral manufacturers would pick up RMI4
> for other sorts of sensors and devices - it is an open standard after
> all.  However, this didn't happen, possibly due to the complete lack of
> promotion of RMI4 as a standard.
>
> Modular functions were also intended to make it easier for community
> OSes like AOKP or Paranoid Android to get up and running on products
> where in order to fulfill their GPL obligations, the manufacturer
> simply dumped a pile of sources, which might not actually be working.
>   I'll grant that this could also be achieved with a monolithic driver.
>
> Several years ago, there also appeared to be a major trend toward
> having two or more sensors in a given product, which was a lot easier
> to manage with modular functions.  Although lots of prototypes were
> built, very few went to production - maybe even none.
>
> And finally, I wanted to enable a platform that was easy for Raspberry
> Pi type tinkering with touch sensing functions - modular functions
> isolated the parts of the RMI4 system, so the tinkerer need only learn
> the parts they wanted to putter with.
>
> Anyway, I still think modular functions have important benefits as
> outlined above, and thus the driver is not over-engineered - it simply
> (or complicatedly :-) ) has the bug that modular functions don't
> currently work.
>
> However, since I'm not very active on this project right now, and not
> likely to be in the near future, if you folks decide you want to take
> the driver structure in a different direction, I can live with that.
>
> 					Cheers,
> 						Chris
