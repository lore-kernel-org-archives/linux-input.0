From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: Game Controllers
Date: Thu, 2 May 2013 16:09:42 +0200
Message-ID: <CANq1E4QstEwpxEReYOsmJhPMED+eWv3SBSEMzYMNVq5Ywme38g@mail.gmail.com>
References: <CAFmpkyiqcwhbJc2A+Ntyisc_CD2z9ssBUQDv6TKvQCX4ES8DOQ@mail.gmail.com>
	<2483279.JlnWrOX8Uv@dtor-d630.eng.vmware.com>
	<CAFmpkyiS+L6OsGmobjHqqJ8AFNNiDk4DYYFo_1GQx2kV_dam1Q@mail.gmail.com>
	<20130502083547.279d08a3cbd7a115489de4b7@studenti.unina.it>
	<CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:64278 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759870Ab3EBOJn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 May 2013 10:09:43 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so687567ief.12
        for <linux-input@vger.kernel.org>; Thu, 02 May 2013 07:09:43 -0700 (PDT)
In-Reply-To: <CAFmpkygZ+xvpwp9KQr6O4emk2f1Bn0EBS0WeN1ji0qVUJz2rwA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Todd

On Thu, May 2, 2013 at 3:46 PM, Todd Showalter <todd@electronjump.com> wrote:
> On Thu, May 2, 2013 at 2:35 AM, Antonio Ospite <ospite@studenti.unina.it> wrote:
>> On Mon, 29 Apr 2013 20:46:47 -0400
>> Todd Showalter <todd@electronjump.com> wrote:
>>>
>>>     My proposed standard gamepad is:
>>>
>>> - left stick (2d vector, each component [-1.0f .. 1.0f])
>>> - right stick (2d vector, each component [-1.0f .. 1.0f])
>>> - left trigger (1d vector, [-1.0f .. 1.0f])
>>> - right trigger (1d vector, [-1.0f .. 1.0f])
>>> - dpad
>>> - start button
>>> - system button (home on wii, ps on ps3, glowy x on xbox 360)
>>> - four face buttons (north, south, east, west)
>>> - two shoulder buttons
>>> - two stick click buttons
>>
>> The "Share" button on DualShock4?
>
> [reordered a bit for clarity after snipping]
>
>     What I'm proposing is a standard gamepad that developers can
> assume is mostly supported on most available hardware.  Most real
> gamepads will be a superset of the proposed standard, and it would be
> nice if there was some canonical set of keysyms and axis indicies for
> common extended functionality, but my main concern is that if a
> developer checks for BTN_SOUTH they get the button at the bottom of
> the right-hand face button cluster of the gamepad, whether it's the
> (x) on Sony gamepads, the (A) on Microsoft gamepads, the (b) on
> Nintendo gamepads, the (o) on the Ouya gamepad, the yellow button on
> the old Gravis gamepad, or whatever.
>
>     Likewise, I want the left stick to map to the same two axis
> indicies on all gamepad, and so forth.  My goal here is that *unless*
> you are going to use features specific to a gamepad, you don't have to
> care who made it or what specific model it is.  I want most games to
> be able to say "ah, a gamepad, excellent", and just use it without
> having to parse the results of calling ioctl() with EVIOCGNAME.
>
>     So, I'd be happy if there was a keysym for SHARE, and extra axis
> values for all the pressure sensitive buttons on ps4, and a keysym for
> the BACK button on xbox controllers and so forth, but I wouldn't call
> SHARE and BACK part of the standard gamepad because they're not yet
> something that has an analog on most available hardware.  I suppose if
> you conflate BACK with SELECT you could make an argument that it was
> on nearly everything, but SHARE is still only a proposed button on a
> gamepad for a console that hasn't shipped, and for which I presume we
> don't have drivers yet.
>
>>>     I'm aware that the xbox and xbox 360 controllers are already
>>> largely mapped this way, but the ps3 controller is not, at least from
>>> what I can tell, and I have no other gamepad hardware to test.  My
>>> goal here is to make it so that something reading an evdev gamepad
>>> stream doesn't need to know what kind of hardware device is backing it
>>> *if* all the reader cares about is the standard gamepad functionality.
>>
>> WRT the PS3 controllers the problem is the HID descriptor, it should be
>> rewritten to expose saner event codes, and/or a .input_mapping callback
>> should be added. I can give some hints about how to proceed if anyone is
>> up to it; it would something along the line of
>> drivers/hid/hid-ps3remote.c
>
>     That would be a great start; right now, at least on my machine,
> the PS3 controller produces events that don't seem to map sanely at
> all.
>
>>>     The analogy here is mice; while you can get mice with variable DPI
>>> settings, macro engines and loads of buttons or scroll wheels, normal
>>> applications don't have to query the mouse type to know how the core
>>> functionality is mapped.  If all I want in a game is the left stick
>>> for movement, the bottom face button for jump and the right face
>>> button for shoot, I shouldn't have to be querying the controller to
>>> figure out how those are mapped.  I should be able to take ABS_X and
>>> ABS_Y for the left stick, BTN_SOUTH for jump and BTN_EAST for shoot,
>>> and it should map to the proper buttons and stick regardless of
>>> whether the player has an xbox controller, a logitech controller, a
>>> ps3 controller or a wiimote with a classic controller plugged in.
>>>
>>
>> BTW have you looked at the joystick driver/API?
>> (Documentation/input/joystick.txt), it allows some form of remapping
>> and calibration to have normalized axis values across different
>> controllers but I don't know it that suits what you have in mind.
>
>     I've read those, and our game engine currently uses libjsw, which
> is IIRC a thin wrapper around that, but it isn't really very useful in
> practise.  The problem with it is that when the game discovers a
> gamepad, all it knows is that it now has access to an unlabelled bag
> of axis values and buttons.  There's no way (at least that I've found)
> to determine *in code* how those axis and button values map onto the
> hardware, so you either have to build up a database of device strings
> and check them against the output of JSIOCGNAME, or you have to ask
> the player to go through a gamepad setup phase.  Neither of these are
> desirable.
>
>     The player expects (quite reasonably) to be able to plug in a
> gamepad and have it Just Work.
>
>     From the game point of view, working with JSIOCGNAME is lousy,
> because it means that anything that isn't in my name->mapping table is
> unsupported.  If next year Microsoft releases an XBox 720 gamepad
> that's all but identical to the 360 controller, and the kernel gets
> support for it, our game won't know what to do with it because when we
> shipped the game that gamepad wasn't in the translation table.  Or for
> that matter, if the player has a MadCatz controller we've never seen
> that's really just an XBox controller, but it happens to have a
> different identifier string, well, fail.
>
>     Using evdev raw has the same problem for us right now, with the
> additional problem that we need dangerously elevated privileges to
> access it.
>
>     What I'm hoping for is to get a standardized gamepad coming out of
> evdev in such a way that systems like Wayland and X11 can expose them
> to programs through their standard event passing systems without
> having to massage them unduly, and without throwing us into the same
> sea of   The ultimate goal here is that if someone builds a living
> room PC with Linux on it, plugs it in to their TV and plugs in a
> couple of gamepads, games running on the system can access the gamepad
> information as easily as they access mouse information.  No querying
> vendor and device ID or identifier strings, no looking things up in
> mapping tables.
>
>     I think we're within reach of that.  I've been talking to the
> Wayland folks about this, and they seem amenable to the idea.  On the
> kernel side it's really just a matter of making sure all gamepads map
> like so:
>
> left stick: ABS_X, ABS_Y
> right stick: ABS_RX, ABS_RY
> dpad: ABS_HAT0X, ABS_HAT0Y
> left trigger: ABS_Z
> right trigger: ABS_RZ
> start button: BTN_START
> system button: BTN_SYSTEM
> four face buttons: BTN_NORTH, BTN_EAST, BTN_SOUTH, BTN_WEST
> two shoulder buttons: BTN_TL, BTN_TR
> two stick click buttons: BTN_THUMBL, BTN_THUMBR

What do you do with devices that don't provide these buttons? (like
the Wii Remote) What do you do with HID devices which include the
mapping in their HID-descriptor (you need fixup HID-descriptors for
each and every incompatible device..)? What do you do with input
devices that are half gamepad, half mouse (or whatever..)?

The thing is, I doubt that there is a good "generic" gamepad idea that
we can use as a model. Yes, the three major gamepads may be very
similar, but the kernel supports a lot more devices. Are you only
interested in GamePad-like devices? What do you want to do with
devices that can be used as a gamepad, but also as another device? If
you change them, you might make their "native" mapping very weird.
For instance, the WiiRemote can be used as gamepad (expecially if used
with extension devices), but also as a totally different input device
with accelerometer and IR cam. So you can map the extension
analog-button as ABS_X/Y, but that means, the accelerometer cannot be
mapped as ABS_X/Y. So this means the accelerometer API breaks (and is
inconsistent with other devices). And so on...

So please, go ahead and fix all the broken drivers that report wrong
values. I think everyone here would appreciate that a lot. But you
must know that it is hard work. You need to check all the different
device-revisions, verify that other devices don't break just because
your gamepad-revision returns other values. You might need
backwards-compatible keymaps, module-flags and so on.
Many of the device drivers were written by hobby-developers so their
devices work. Many of them might not be around anymore or only have
time to fix bugs.

So if you want reliable gamepads, the easiest way is a user-space
mapping based on device-names. This guarantees you get the expected
buttons. Adding support for new devices is a matter of few lines of
code. And it normally takes >1 month for a device driver gets included
in the kernel, so you have enough time adding the support to your
user-space side.
This also allows you to easily support devices that are no gamepads,
but would make sense with your applications.

I would really appreciate, if you help fixing those drivers instead of
using the user-space mappings. But I just want to warn you, that it is
more work than you might think.

Cheers
David
