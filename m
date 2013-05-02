From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 13:45:03 -0700
Message-ID: <20130502204503.GF28625@core.coreip.homeip.net>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
 <2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
 <CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
 <20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
 <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
 <20130502170103.GC28625@core.coreip.homeip.net>
 <CAFmpkygr5c-munK9ix=exq4KRgDEUbP+OP_AABuuTR1P_2V1-g@mail.gmail.com>
 <CANq1E4RRFNPZ-z86yny89hViMWREpG1f1in5O3kT8usHO57YAQ@mail.gmail.com>
 <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37811 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758893Ab3EBUpI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 16:45:08 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq8so542733pbb.19
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 13:45:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkygadXbwtyD0Pcc_K4EPqsqRq0EudX=ge6KFoaykR4CHVA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Thu, May 02, 2013 at 03:10:55PM -0400, Todd Showalter wrote:
> On Thu, May 2, 2013 at 1:54 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> 
> > How about a new input property that marks devices that follow general
> > rules as such? So for instance:
> >   INPUT_PROP_DEV_MOUSE
> >   INPUT_PROP_DEV_KEYBOARD
> >   INPUT_PROP_DEV_GAMEPAD
> >   INPUT_PROP_DEV_JOYSTICK
> > And so on. And then we can decide on a generic mapping for each. We
> > only set these properties on devices that follow the generic mapping.
> > Devices that don't have these flags set are non-generic or have weird
> > keymaps. This would also solve problems were the xserver thinks some
> > gamepads or accelerometers are a mouse (or similar).

The devices that use generic mappings are easy to identify from
userspace already (does this thing has 2 sticks? then it should be
usable as gamepad. Only one stick? Joystick or older-style pad, etc).
It is devices that incorrectly mapped with generic drivers that need
these hits and for them we also need the heuristic, either in kernel or
in userspace.

If if it map/config file driven user at least has a chance of adjusting
properties without patching and recompiling the kernel.

> 
>     That could work.  As long as I can programatically filter devices
> to get the ones with sane behaviour, I don't really have strong
> opinions about the specific method.  The /dev/input/gamepad* method
> solves the problem, but if I can march /dev/input/event* looking for
> events that advertise INPUT_PROP_DEV_GAMEPAD I think it gets me what I
> need.
> 
> > This allows user-space to detect generic devices. For all other device
> > types, they need special support, anyway. They can still use the same
> > heuristics that they use now, but we can try to provide a generic flag
> > to avoid these often wrong heuristics.
> 
>     That's the thing; while the ps3 controller has (for example) 12
> pressure sensitive buttons and a suite of accelerometers, most games
> don't care.  Even on the ps3, most games don't care.  A few do, and
> they do the extra work they need to in order to use those controls,
> but the vast majority of games want one or two analog sticks and a
> handful of buttons with known mappings.

So ignore the events you do not care about.

Again, nobody argues against needing a consistent mapping, the arguments
are against an additional in kernel interface that only does
ABS_XXX->ABS_YYY mapping.

> 
>     I'd far rather the games with special needs had to do heavy
> lifting than have the common case be complicated just because someone
> might want to use a wiimote with a balance board plugged in though a
> motion plus.
> 
>     If there was good support for racing wheels, kinect-like
> controllers and so forth, that would be nice too.  But 99% of games
> will have their input needs met just fine by the standard controller
> I'm proposing, the standard keyboard and standard mouse.

So are you arguing for /dev/input/wheel as well? And for applications
that are a bit more advanced /dev/input_wheel_with_pedals? This is not
really sustainable when we can already deliver all data through existing
interface.

> 
> > I talked with Kay (udev maintainer) and he was really opposed to huge
> > udev black/white-lists that mark devices as generic MOUSE, KEYBOARD,
> > TOUCHPAD, ... These kernel properties would really help, but require
> > agreement on a generic mapping.
> 
>     What about a /dev/input/by-type directory?
> /dev/input/by-type/gamepad could have symlinks to all the
> gamepad-supporting devices, /dev/input/by-type/mouse could symlink the
> mice, and so forth.  Or is that udev's territory?
> 
> > And as Dmitry noted, we cannot change legacy drivers due to backwards
> > compatibility. A separate /dev/input/gamepad* interface just wastes
> > resources when all you want is just a different and consistent
> > mapping.
> 
>     Could we consider a build switch?  Something where people could
> choose to build (for example) the ps3 support either in "legacy" or
> "new" form?  I'd be a little surprised to hear anyone is actually
> relying on the current ps3 mapping, and if it can't be changed and we
> can't offer alternate mappings at runtime, we could let people choose
> which mapping they want.
> 
>     Or could we have an ioctl() to flip it from legacy mode to
> canonical mode?  Or an ioctl() to query the driver for a mapping table
> that would at least tell us how to map from the legacy mapping to a
> canonical mapping?  We're talking about 8 axis index values and 12ish
> button index values, so it could fit in 20 bytes or less per supported
> legacy device.

Again, this does not have to be in kernel. The mapping has nothing to do
with hardware access.

> 
> > Why not try to create a /usr/share/gamepad/*.map filetype and let
> > distros ship these files. Your game can then parse these into a table
> > and use the mappings for all legacy gamepads.
> 
>     That's an option, but what it mostly means is angry customers
> wanting to know why their handrolled fork of TinyCore Linux doesn't
> see their PowerA Batarang XBox 360 controller.  If I can't force the
> distros to ship the updates in a timely fashion (and I'm pretty sure I
> can't...), what the customer sees is they plug their perfectly good
> controller in, /dev/input/event16 shows up, and my game just ignores
> it.  And I'm stuck responding with email and faq entries saying "step
> 1: install git...".

And this is better then cherry pick commit 1765326732afd763876348 from
next branch of input tree, recompile the kernel and see if that fixes
your issue?

> 
> > Or provide a "enable_legacy_mapping=true" module option for legacy
> > gamepad-drivers which allows to switch between different mappings
> > (even though that would be a global flag).
> 
>     I'd prefer something like this if we can't just fix things, or an
> ioctl() to toggle behaviour.
> 
> > I still think the problems with user-space mappings can be solved. And
> > we should avoid wasting kernel memory for an interface that does
> > nothing more than change button-mappings.
> 
>     I'd really like to see Linux be a good option for living room PCs;
> something you can plug into your TV, maybe install Steam or the Ouya
> store or Desura or whatever (or just use your distro's package manager
> as long as I'm dreaming), and be able to run games on it.  You can do
> that now, but there are places (gamepad input is one, sound is
> another) where the user experience and the developer experience are
> less than optimal.
> 
>     Users want to plug in a gamepad and have it just work, regardless
> of who made it.  Developers occasionally want access to he more
> esoteric parts of the gamepad hardware, but 99% of the time they just
> want standard sticks-and-buttons functionality mapped in a predictable
> way.
> 
>     As a developer, if I had to choose between the current situation
> or having all game hardware map down to a standard one-stick, two
> button controller with no access to anything else, I'd jump on the
> standard controller in a heartbeat.  A standard controller means
> there's a gigantic pile of crap I don't have to deal with every time I
> write a game.  It means once a player knows what the NORTH button is,
> it's the same in every game and on every controller, regardless of
> developer or hardware maker.
> 
>     The further away from the data source the translation to a
> standard controller is when it happens, the more likely it is to
> break.  Right now, we're fixing it at the app level, which sucks for
> everyone.  Pushing it up to a library or a set of data tables is
> better than what we have now, but only slightly.  I'm trying to get it
> pushed at least to the point where it's between Wayland/X11 and evdev,
> but even at that point it means there are inevitably going to be
> version mismatches or missing translation tables.  We can't fix the
> hardware, so the closest to the data source we can theoretically get
> to is the drivers.

And here we disagree because I believe a library (that not only does the
mapping, but also does all necessary additional transformations) is the
proper solution here. And then you write your games to that library API
and you do not need to know how exactly something was mapped to
EVENT_NORTH in your game. Maybe it comes form a gamepad and maybe it is
a key on a keyboard.

Again, the kernel will try to do the right thing and produce the correct
events for new input devices, but we are not going to introduce a copy
of evdev protocol that limits the events to "standard gamepad" ones.

Thanks.

-- 
Dmitry
