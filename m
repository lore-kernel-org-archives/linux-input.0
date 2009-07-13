From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] input: add Hold on/off and volume event keys
Date: Tue, 14 Jul 2009 00:56:40 +0200
Message-ID: <4A5BBBA8.7080303@marcansoft.com>
References: <4A5A0251.8010803@marcansoft.com> <20090713034359.GB10819@dtor-d630.eng.vmware.com> <4A5B0582.4010709@marcansoft.com> <20090713165221.GB28063@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:54774 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbZGMW4n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2009 18:56:43 -0400
In-Reply-To: <20090713165221.GB28063@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
>>> On Sun, Jul 12, 2009 at 05:33:37PM +0200, Hector Martin wrote:
>>>> Recent Acer laptops produce key events when the Hold button on the media
>>>> control panel is activated and deactivated. These events are relevant
>>>> for software that wishes to interact with the media panel beyond just
>>>> using the media control keys.
>>> What exactly is supposed to happen when you press hold key? Also, is it
>>> tuly a key or a switch?
>> It's a toggle-button: you hit it once to enable the hold, and again to
>> disable it. It produces a press-release scancode pair when it is
>> enabled, and a press-release scancode pair for a different scancode when
>> it is released. It also has direct hardware effects (LED turns on and
>> the rest of the buttons on the media panel stop responding). This hold
>> state cannot be queried using the Acer proprietary hardware interfaces,
>> which is why reacting to these two different scancodes is the only way
>> of knowing what the actual Hold state is.
> 
> Hmm... you still need to query the state somehow at startup, otherwise
> how do you know what behavior user expects before she presses hold
> button for the first time.
> 
> What exactly does your application do when Hold is engaged?

The specific use case is covered by just getting hold on/off
notifications - the current state does not matter, only that it was
"recently" changed. The firmware does not reliably report the other
information when hold was recently disengaged. Apparently it does a
little LED blink and that blink sometimes can get picked up by the
software as an actual volume event (clearly due to crappy EC firmware -
what should be a purely visual effect isn't). In fact, if you repeatedly
toggle Hold in rapid succession sometimes that broken off state can even
be latched as the current state and stick there. The only way to work
around this (either in userspace or in the kernel) is to react to the
Hold-off event and ignore any changes in the volume value for about a
second afterwards, possibly correcting a sudden jump to volume 0 afterwards.

The actual Hold functionality operates in hardware, so it doesn't really
matter whether we know if Hold is engaged initially or not. All I care
about is the side effects when the state transitions. Again, yes, I know
this is fugly. Shame on whoever made this hardware/firmware.

I need to listen for key input events in my daemon anyway. For example,
Mute is reported the usual way, not via this "volume change"
notification - worse, there's a regular mute key on the keyboard which
does *not* affect the "media control" mute state, but they both report
the same scancode. So software needs to specifically check for Mute key
events: if it sees the hardware state has changed, it needs to update
the software ALSA state to match the hardware, whereas if the hardware
state is the same (the other mute key was used), it needs to toggle the
hardware state and make the ALSA state match. More ugliness. I figure if
I have to listen to key events anyway it wouldn't hurt to just make the
extra three scancodes that I need key events too (they already are,
anyway - just not mapped to correct KEY_* values because there aren't any).

> 
>> This behavior is also shared by a few other keys (bluetooth toggle, WiFi
>> toggle, touchpad enable toggle), but for Bluetooth and WiFi the state
>> *can* be queried from their hardware (and they already work as rfkill
>> devices via the acer-wmi driver and can even be toggled by software, so
>> I just map both scancodes to the existing KEY_BLUETOOTH and KEY_WLAN
>> events which no one is reacting to anyway). I don't see a use for
>> software to react to the touchpad enable key.
>>
>>>> There's also a volume notification key event that replaces the usual
>>>> volume-up/down events when the panel is in software-controlled mode.
>>>> Software can react to this to detect volume level changes instead of
>>>> polling.
>>>>
>>> No, I don't think this kind of notification belongs to input layer.
>> It's a key event delivered by the EC just like all other keyboard events
>> (the EC is also the keyboard controller, as is typical). Where else
>> would it belong? To the kernel it just looks like yet another PS/2
>> keyboard scancode. Short of somehow hooking into the atkbd driver from
>> the acer-wmi driver to special-case this key, I don't see what other way
>> there is of dealing with this. Of course it's ugly, but I didn't design
>> this hardware :)
> 
> It is kernels task to convert ugly hardware implementations into a nice
> abstractions ;) Really, this kind notification does not belong to the
> input layer, same as with battery notification and network card
> pluggin/unplugging. Since it is delivered through keyboard controller
> I think you'll need to hack into i8042 interrupt routine and "syphon"
> off data from there.

Well, it's actually pretty close to volume change notifications though.
In fact, this "volume notification" replaces the usual volume up/down
keys (it gets triggered in almost exactly the same way) except, when in
this mode, it fixes a broken case: normal volume up/down notifications
are not properly issued when the volume slider is dragged from a
non-endpoint position to a non-endpoint position, while this generic
"changed" notification is when in this mode.

Either way, I wonder what the ideal kernel interface for this kind of
hardware is. For input only it sounds like, in fact, input would be a
good candidate: have an axis that represents the position of the
hardware volume slider. However, this doesn't take into account changing
that volume level in software (in reaction to, say, manually using
alsamixer). Does the input layer offer "feedback" functions like this
able to tell a hardware axis to go to a certain value? Do you think this
might be the way to go? Mute could probably be represented by a switch
in the same way... but I'm not sure I'm comfortable hacking the keyboard
driver for this.

Otherwise, do you have a better suggestion for just feeding the "change"
notification to software? Currently, for the actual value
getting/setting I'm just using sysfs files (as is already done for other
acer-wmi functions - I'm just adding on to the existing driver). This
doesn't take into account actively notifying userspace of the change though.

I'm not too comfortable with making more intrusive changes to the kernel
at the moment, and as you can see a lot of this is working around weird
Acer quirks, which is why I was trying to go for the obvious
implementation with simple kernel changes (add the relevant hardware
support to acer-wmi, add the two input events, and then make hal map the
scancodes right and have a daemon do the job of syncing keyboard events,
media state, and ALSA together). This is all Acer-specific anyway
(unless we want to develop some sort of kernel standard for
"volume/media widgets" and a generic daemon for it), so dealing with
bugs and oddities in userspace isn't that bad.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

