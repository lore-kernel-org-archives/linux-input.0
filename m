From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Fri, 13 Jan 2017 22:14:29 +0100
Message-ID: <3299526.TfQehjsslS@wuerfel>
References: <20170110121718.2992211-1-arnd@arndb.de> <1484162868.2884.77.camel@synaptics.com> <c2cfe90e-521c-1e51-b2f0-8a9d97d0b683@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2cfe90e-521c-1e51-b2f0-8a9d97d0b683@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Christopher Heiny <cheiny@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Lyude Paul <thatslyude@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thursday, January 12, 2017 4:42:55 PM CET Andrew Duggan wrote:
> On 01/11/2017 11:27 AM, Christopher Heiny wrote:
> > On Wed, 2017-01-11 at 18:48 +0100, Benjamin Tissoires wrote:
> > Actually, long, long ago (well before I got yanked off the RMI4 driver
> > project for a 'short term emergency' two and a half years ago -
> > fortunately Andrew was more than able to take it over) it worked that
> > way.  If you had the bus, a physical driver, and the sensor driver
> > running, you could build the functions as modules and attach them via
> > udev or insert them later.
> >
> > We had this working on the bench at one point, but fairly early in the
> > submission process seem to have just assumed it would keep working and
> > stopped regression testing on that feature.  There have been an whole
> > lot of changes since then, and somewhere along the line functions-as-
> > loadable-modules stopped working.  Since we weren't testing it anymore,
> > it wasn't caught.
> >
> 
> We made the decision to disable support for function drivers as modules 
> after running into a few technical challenges which happened during 
> initialization. The priority was to get the driver upstreamed so we put 
> off getting function drivers working as modules until there was a 
> compelling reason to do so. But, we left the structure mostly intact if 
> we decided to do so. Here are the messages which describe what we 
> discovered at the time:
> 
> https://lkml.org/lkml/2015/11/10/92
> https://lkml.org/lkml/2015/11/12/652
> 
> I'm basically coming to the same conclusion I had back then. Getting 
> loadable modules for function drivers to work would add complexity for 
> not a lot of benefit based on the current state of the driver and how it 
> is currently being used. I'm also not sure we will reach the critical 
> mass of function drivers where there is a significant benefit of not 
> having to load them all.

I think the main benefit of splitting out the function drivers would
be simpler handling of the Kconfig dependencies. Each function driver
can simply 'select' the core so that gets built-in whenever one of
the functions is, and the other functions can have external dependencies
like the bus drivers do.

> >>> a candidate for cleanup there and once you remove it (by calling
> >>> rmi_driver_probe() instead of rmi_register_transport_device()
> >>> to oversimplify the idea), the actual probing for the function
> >>> drivers becomes much easier to do right.
> >>>
> >> Agree, that would simplify the code a lot. I just don't know how
> >> important it is for other users of RMI4 to have a modular solution or
> >> if
> >> the monolithic approach is a consensus now. The modular solution is
> >> currently disabled, but we can "always" switch back with a small
> >> effort.
> >>
> >> My opinion on this matter is that there is no need for the modular
> >> functions, but others might have a different opinion.
> 
> Just to clarify, this is proposing that the rmi_physical device be 
> removed and we just calling the equivalent functions from the context of 
> the transport? Basically, what Bjorn suggested here last year:
> 
> https://lkml.org/lkml/2016/4/21/781

Right. I think that should simplify the core enough that separating
it from the function drivers is straightforward.

I still don't get the part about blocking on user space as
mentioned in https://lkml.org/lkml/2015/11/10/92. There should
not be any requirement for the probe() function to wait for the
child device to get used, the probe just needs to add the child
to the bus as any other bus driver does, and from there it gets
used once the driver is loaded (or never, if the driver doesn't
exist).

	Arnd
