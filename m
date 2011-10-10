From: Daniel Drake <dsd@laptop.org>
Subject: Problem statement: Opportunistic suspend and i8042 wakeups
Date: Mon, 10 Oct 2011 20:24:08 +0100
Message-ID: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63753 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab1JJTYK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 15:24:10 -0400
Received: by wwf22 with SMTP id 22so9386753wwf.1
        for <linux-input@vger.kernel.org>; Mon, 10 Oct 2011 12:24:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, rjw@sisk.pl
Cc: Paul Fox <pgf@laptop.org>, linux-input@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org

Hi,

OLPC is still keen on getting upstream support for seamless i8042
wakeup. Since this has stagnated a bit I'm hoping that writing a
detailed overview of the situation and requirements will be useful in
finding a solution.

We're working with the already-upstream opportunistic wakeup model
described in http://lwn.net/images/pdf/suspend_blockers.pdf - this is
a shared problem space with other parties wishing to implement
opportunistic suspend with i8042-based input devices, and it is a
crucial part of the opportunistic suspend user experience.


THE DESIGN

OLPC laptops are engineered to suspend and resume very quickly.

OLPC laptops are also engineered to be somewhat operational during
suspend. That is, the screen can be left on, the wireless card is left
on during suspend, and incoming frames will wake the system, and we
also wake up on the lid switch, power button, and low battery or AC
plug/unplug event. All those wakeup events are taken care of in the
upstream kernel. The missing part of the design is that the user can
seamlessly wake the system with the keyboard and mouse too, and thats
what we need to tackle here. The overall design is that the system
suspends opportunistically to the point where the user is unaware that
the system is suspending and resuming at high frequency in the
background.

The OLPC XO-1 and XO-1.5 keyboard and mouse(touchpad) is standard
atkbd and psmouse on a serio bus connected to a i8042 chip. This
hardware is guaranteed to be left powered during suspend.

All keyboard keys behave 'regularly' in that when you press and hold a
key, the make code interrupt for that key will be repeated by the
hardware until you release it, at which point it generates a break
code interrupt. All keys behave identically.

The keyboard does not have any LEDs.

By default the system will not wake up on i8042 activity. The wakeup
is enabled with olpc_ec_wakeup_set(), all this infrastructure is
already upstream and used by the wifi, some switches, the battery/AC
driver, etc.

When enabled, the EC will wake the system up on key press events,
mouse movements and mouse clicks, but not key release events. (the key
release event behaviour could be changed if desired/necessary)

On resume, the operating system must 'simulate' an i8042 interrupt. By
this I mean it should pretend an interrupt arrived, and therefore read
the status register, see if data is present, if so read the data
register, etc. (Conveniently, the i8042 resume code already has this
behaviour). If the system does not do this, no i8042 interrupts will
be generated in resume to the wakeup event or any later input actions
from the user.

We have a userspace agent 'powerd' which keeps track of system
activity, suspends opportunistically when the system is idle, etc.

We currently have some hacky patches that we use to enable this
functionality which are working well. I've sent cleaned up versions
upstream but these have not gone beyond the discussion stages yet.

When the system resumes due to a key press or mouse movement it is
obviously of crucial importance that the wakeup event (key press,
mouse click, etc) is not lost. If the system is suspended and I press
'k' then the system must resume and that 'k' press must go through the
input layer and reach the on-screen userspace application as usual.
Otherwise, as a user unaware of the suspend, I'd be pretty confused as
to why I pressed a key but nothing appeared to happen.

This mail is written primarily in the context of the x86 XO-1 and
XO-1.5 laptops. However, we are also working on a new ARM-based laptop
known as the XO-1.75. This laptop is also following the opportunistic
suspend model, and while it does not have i8042, it does use serio (as
a child of a custom embedded controller driver at [1] that we will
submit later), atkbd and psmouse, so the majority of what is written
here also applies to the XO-1.75. But for the purpose of discussion,
lets focus on XO-1 and XO-1.5 first, where all the required bits are
already upstream.



THE PROBLEM

In addition to providing an on/off switch for this functionality,
several parts of the i8042/serio/input code behaviour need to be
changed to support this correctly and efficiently. The main problems
are that the hardware gets reset on 3 layers during suspend/resume,
and the wakeup event is discarded in the process.

1. On suspend, i8042.c calls i8042_controller_reset() which resets
various things and attempts to disable the interfaces. On resume,
i8042_controller_resume() tries to turn things on again, and then
simulates an interrupt. Apart from the simulated interrupt, we do not
want any of that behaviour on a setup where i8042 devices are to be
used as an opportunistic suspend wakeup source, since it would cause
an interruption to the user's movement of the mouse, throw away the
wakeup event, etc.

2. In addition to the above, on suspend, serio_suspend() calls the
driver's cleanup routines. For atkbd and psmouse, this attempts to
reset the keyboard/mouse state completely. On resume, serio_resume()
queues a workqueue item to reconnect the port. The effect of this is
that atkbd_reconnect() gets called at some point later, which again
disables/resets the keyboard, then enables it, and psmouse_reconnect()
does something very similar for the mouse. Again, not wanted in this
case, and likely to be one of the reasons that the wakeup reason is
lost.

3. In addition to the above, on suspend, input_dev_suspend() tries to
turn off the keyboard LEDs. We don't have any, nor do we have
num/caps/scroll lock keys, so the lights are already off and this
function has nothing to do. However, on resume, input_dev_reset() is
called. This function tries to restore the keyboard LED state, which
results in atkbd queuing a atkbd_set_leds() workqueue item in order to
tell the hardware to turn all LEDs off (even though we dont have any,
and the hardware state said they were already off). Then,
input_reset_device() releases any keys that are held. This behaviour
is particularly undesirable for us because:

 a) Our keyboard autorepeats keys at the interrupt level, but we have
keyboard autorepeat disabled in X. Anyone who has worked with first
time computer users of 6 years of age will know that children tend to
press the keys sloowly and surely at first; autorepeat is not the
behaviour we want for them. So, X looks for break codes before
processing keypresses and effectively ignores the multiple make codes
- this is how its disable-autorepeat implementation works, and this
seems like a sensible design.

 b) If I resume the system with a slightly elongated key press, the
following happens with the current behaviour of input_dev_reset()
(with the i8042/serio layers modified to not mess with device state
over suspend/resume): A make code will be generated by the hardware
since I pressed the key. This will wake the system and reach userspace
as a key press event. input_reset_device() will then fabricate a key
release event, which reaches userspace, so X then registers a
keypress/keyrelease and prints the character to the screen. Then,
because I'm still holding the key, the hardware generates another make
interrupt. Userspace receives this as a key press event. Then I
release the key, which results in a break interrupt, which gets
propagated to userspace as a key release, so X prints the character
again. So, I have just woken up the system with a key press, but
userspace has interpreted it as two key presses. This is surprisingly
easy to reproduce, and is not what we want.



IMPLEMENTATION

This is the open question - how can we adjust the above kernel
behaviour to be suitable for opportunistic suspend?

I'd welcome input here.

In my most recent set of patches I took the following approach:
http://www.spinics.net/lists/linux-input/msg16599.html
http://www.spinics.net/lists/linux-input/msg16600.html

1. The 'wakeup' property is enabled on the i8042, serio and input
devices. Before going into suspend where input wakeups are desired,
userspace must enable wakeup in sysfs on: i8042, serio0, the mouse
input device, serio1, and the keyboard input device.
2. In the suspend/resume handlers, each of the three layers above
checks to see if wakeups are enabled on its own device, and if so, the
suspend/resume handlers effectively do nothing, avoiding the triple
layer resetting described above.
3. The i8042 driver wakeup property is also used to call
olpc_ec_wakeup_set() in order to tell the EC to wake up the CPU on
input events when in suspend.

Dmitry suggested a way of simplifying this: detect at the i8042 or
serio level if this behaviour is to be enabled in a pre-suspend
handler, and if so, catch and discard all the traffic that normally
happens during suspend and resume handlers. Unfortunately this doesn't
work because:
 1. Some of the communication that happens in these suspend/resume
handlers involves getting a response back from the device. If we're
just discarding the outgoing requests, we're not going to get a
response, and this makes the code unhappy.
 2. Some of the communication that happens in the resume path happens
in workqueue items that run later (at both the serio and atkbd
levels). So some of the communication we need to drop happens after
resume has finished, I'm not sure how we would catch and discard this.
 3. The issue of the input layer releasing all our keys is left
unresolved with this approach.

I acknowledge that the patches so far posted aren't the cleanest in
the world, but I'm not really sure of a better way to do it.

Thoughts/comments/solutions?

Thanks,
Daniel



[1] http://dev.laptop.org/git/olpc-kernel/tree/drivers/input/serio/olpc_keyboard.c?h=arm-3.0-wip&id=e7ad082
