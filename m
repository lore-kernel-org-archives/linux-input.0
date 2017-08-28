From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 1/4] Input: Add new property INPUT_PROP_JOYDEV_IGNORE
Date: Tue, 29 Aug 2017 00:08:08 +0200
Message-ID: <1503958088.12938.28.camel@hadess.net>
References: <20170824231153.8809-1-roderick@gaikai.com>
         <20170824231153.8809-2-roderick@gaikai.com>
         <1503650742.12938.4.camel@hadess.net>
         <CANndSKk4LqEu_48VG+b4eQUjMRjLJ4=uzEyuL3d5X6vKq_dMkg@mail.gmail.com>
         <20170828211604.GI12195@dtor-ws>
         <CANndSKmuKVOBrEhT6t0XEnrX9Oov9fvWQ2vyRSOWjOJQwTkWiA@mail.gmail.com>
         <20170828213845.GJ12195@dtor-ws>
         <CANndSKnAMwubc=FShVwZhz7Mmy=QKcqPcF5JxZNGNSEiFGq9Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34815 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1WIK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Aug 2017 18:08:10 -0400
In-Reply-To: <CANndSKnAMwubc=FShVwZhz7Mmy=QKcqPcF5JxZNGNSEiFGq9Zw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Mon, 2017-08-28 at 15:02 -0700, Roderick Colenbrander wrote:
> On Mon, Aug 28, 2017 at 2:38 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Aug 28, 2017 at 02:35:15PM -0700, Roderick Colenbrander
> > wrote:
> > > On Mon, Aug 28, 2017 at 2:16 PM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Aug 28, 2017 at 02:08:54PM -0700, Roderick Colenbrander
> > > > wrote:
> > > > > On Fri, Aug 25, 2017 at 1:45 AM, Bastien Nocera <hadess@hades
> > > > > s.net> wrote:
> > > > > > On Thu, 2017-08-24 at 16:11 -0700, Roderick Colenbrander
> > > > > > wrote:
> > > > > > > From: Roderick Colenbrander <roderick.colenbrander@sony.c
> > > > > > > om>
> > > > > > > 
> > > > > > > This new property can be set on input devices to
> > > > > > > blacklist them
> > > > > > > from getting picked up by joydev. This is meant for
> > > > > > > devices, which
> > > > > > > pass joydev its heuristics, but for which there is no
> > > > > > > good generic
> > > > > > > way of updating the heuristics.
> > > > > > 
> > > > > > I can't make sense of that last sentence, and the
> > > > > > possessive for
> > > > > > "heuristics" (here and below in the documentation) is, IMO,
> > > > > > unnecessary.
> > > > > > 
> > > > > > > Signed-off-by: Roderick Colenbrander <roderick.colenbrand
> > > > > > > er@sony.com>
> > > > > > > ---
> > > > > > >  Documentation/input/event-codes.rst    | 9 +++++++++
> > > > > > >  include/uapi/linux/input-event-codes.h | 1 +
> > > > > > >  2 files changed, 10 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/Documentation/input/event-codes.rst
> > > > > > > b/Documentation/input/event-codes.rst
> > > > > > > index a8c0873..ae8c546 100644
> > > > > > > --- a/Documentation/input/event-codes.rst
> > > > > > > +++ b/Documentation/input/event-codes.rst
> > > > > > > @@ -356,6 +356,15 @@ can report through the rotational
> > > > > > > axes (absolute
> > > > > > > and/or relative rx, ry, rz).
> > > > > > >  All other axes retain their meaning. A device must not
> > > > > > > mix
> > > > > > >  regular directional axes and accelerometer axes on the
> > > > > > > same event
> > > > > > > node.
> > > > > > > 
> > > > > > > +INPUT_PROP_JOYDEV_IGNORE
> > > > > > > +------------------------
> > > > > > > +
> > > > > > > +The joydev interface uses heuristics to determine
> > > > > > > whether it should
> > > > > > > expose an
> > > > > > > +input device through joydev. Some devices pass its
> > > > > > > heuristics, but
> > > > > > > don't
> > > > > > > +make sense to expose. In some cases the generic
> > > > > > > heuristics can be
> > > > > > > updated,
> > > > > > > +but in other cases this is not easy. The
> > > > > > > INPUT_PROP_JOYDEV_IGNORE
> > > > > > > flag can
> > > > > > > +be set by drivers to explicit request blacklisting by
> > > > > > > joydev.
> > > > > > 
> > > > > > The "don't make sense to expose" is not what we're trying
> > > > > > to do here
> > > > > > though. The problem is rather that "we used not to show
> > > > > > this device
> > > > > > through joydev, but programs using joydev are limited and
> > > > > > usually not
> > > > > > updated so we should only show what we used to".
> > > > > > 
> > > > > 
> > > > > Thanks, I will change the wording. Originally I wrote it like
> > > > > this,
> > > > > because I thought joydev applications could not determine at
> > > > > all which
> > > > > axes were being used except for 'an axis number' and for that
> > > > > reason
> > > > > thought that the match function had some heuristics (e.g.
> > > > > filtering
> > > > > out touchpad devices and others), making sure a joystick has
> > > > > buttons
> > > > > etcetera. I wasn't aware of JSIOCGAXMAP, which does allow
> > > > > applications
> > > > > to get more information about a device, but you can't easily
> > > > > determine
> > > > > if something is e.g. a motion sensor device you would need to
> > > > > do a
> > > > > string compare on known strings or make assumptions if you
> > > > > see a
> > > > > device with axes, but no buttons.
> > > > 
> > > > Sorry for the delay, but exposing the internal kernel decisions
> > > > to
> > > > userspace is not something that we need to do. Why would
> > > > userspace care
> > > > to see this in device properties?
> > > > 
> > > > Also, this whole thing puts knowledge of interfaces into the
> > > > drivers,
> > > > and driver should not care at all what interfaces kernel might
> > > > implement. Do drivers need to be aware that there is SysRq
> > > > handler? Or
> > > > that on some versions of ChromeOS there is a handler that bumps
> > > > up
> > > > CPU frequency in response to user activity?
> > > > 
> > > > If you really want to stop joydev from attaching to some
> > > > devices then
> > > > the decision should go in joydev itself, not spread across
> > > > multiple
> > > > drivers.
> > > > 
> > > > Thanks.
> > > > 
> > > > --
> > > > Dmitry
> > > 
> > > Correct user space should not have to be aware. Originally the
> > > patch
> > > add a composite device flag, but that term was more loaded and
> > > needed
> > > ioctls. That field would have made sense for user space, but this
> > > flag
> > > not, we just piggy-backed on the the properties field in the
> > > input_dev.
> > > 
> > > In my case of ds3/ds4 to fix old applications, I want to
> > > blacklist
> > > joydev in some way, but joydev doesn't have access to enough
> > > information except for INPUT_PROP_ACCELEROMETER which I think you
> > > felt
> > > was not narrow enough in scope.
> > > 
> > > Would the solution be to add some new private quirks/flags field
> > > to
> > > 'struct input_dev', which joydev could use? Or is there another
> > > solution you have in mind.
> > 
> > What kind of data joydev is missing? There is the input_id with
> > bus,
> > vendor, product and version, device capabilities, plus you have
> > full
> > access to the input device itself, so you can look up name, phys,
> > etc.
> > 
> > Thanks.
> > 
> > --
> > Dmitry
> 
> 
> Thanks for getting back so quickly. The input_dev has all the
> information as you could do something with product / vendor ids,
> which
> I wanted to avoid as there are 5 DS4 ids I need to handle and 2 DS3
> ids. We still want to expose the 'gamepad' subdevice, but not the
> motion device (INPUT_PROP_ACCELEROMETER), so it would be quite some
> logic. Overall I thought it would be cleaner to not have this device
> knowledge in joydev and maybe expose a new flag.

Apart from the fact that the INPUT_PROP_JOYDEV_IGNORE property is made
visible in user-space (it could be there as a debug mechanism to show
why the device is not exported through joydev), I think having the
device driver tell joydev not to export it is the right mechanism.

The problem of devices having sub-components exported through joydev
should only exist when 1) the device driver is extended to be more
capable (like the DS4 accelerometers), 2) the device driver is extended
to support more hardware (whether a simple vid/pid combination, or
something more involved) 3) new device drivers are added.

joydev changes are thus kept to a minimum, the drivers (and their
changes) are self-sufficient.
