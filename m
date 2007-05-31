From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Making KEY_UNKNOWN really useful to userland
Date: Thu, 31 May 2007 09:48:42 -0300
Message-ID: <20070531124842.GC6299@khazad-dum.debian.net>
References: <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com> <20070530152444.GD17530@khazad-dum.debian.net> <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com> <20070530172420.GA6883@khazad-dum.debian.net> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com> <20070531005305.GC6883@khazad-dum.debian.net> <1180607825.2693.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1180607825.2693.17.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thu, 31 May 2007, Richard Hughes wrote:
> On Wed, 2007-05-30 at 21:53 -0300, Henrique de Moraes Holschuh wrote:
> > Maybe we can add that requirement and driver changes (if any, for all
> > I know most drivers might already be generating such events) for
> > 2.6.23?  I bet Richard would like that one a lot.  Richard?
> 
> To be honest, I've got lost in all the discussion about hotkeys. What is
> the plan for a typical acpi driver?
> 
> i.e. what do you want a driver to emit given two scenarios:
> 
> * A acpi event that is always the same on all models?
>    KEY_BRIGHTNESSUP?

When one should be sent, yes.  It has the same problem as a volume
up/down/mute key that "just works" in firmware: you don't want to have two
things trying to mess with the display brightness every time a brightness
key is pressed.

SOME keys have the added aggravation that they really, really should be
sending ACPI events instead (brightness up/down is one: it is an ACPI 3.0a
event), but to really get that to work, we need to improve how ACPICA talks
to other ACPI modules to selectively disable some functions.

But that's not a problem that affects every hot key in every platform out
there, so I consider them to be the exceptions that define the rule :-p

> * an acpi event that is different on every laptop model?
>    KEY_PROG1? KEY_UNKNOWN?

EV_KEY KEY_UNKNOWN + EV_MSC MSC_SCAN (or MSC_RAW??) + EV_SYN for *unmarked*
keys.  Then you just ask the user if he wants to map that scan code to some
other keycode in userspace, if you want.

For thinkpad-acpi, I don't send ACPI events for stuff I will be sending a
meaningful input event, just like you asked me to (and I don't send events
if nothing has the input device open).  So you get ACPI events if nothing is
listening to the input device, OR if the key is unmapped or mapped to
KEY_UNKNOWN.

I will send the scan code always in thinkpad-acpi, but that is hardly
necessary I suppose.

Note that the scan code is the same for press and release (it is the same
key).  So anything that wants to know if a key was pressed or released
better use the EV_KEY to know it (as it should, since it *is* in the same
event block for a damn good reason :p ).

Oh, and the thinkpad firmware 'weirdness' of needing one to enable/disable
OS hot key support still applies, of course (the hotkey mask).

> Tell me what do to, and I'll resync my trees and resubmit patches.

I am on it on the thinkpad-acpi side, so at least for that, you don't have
to worry.  I am still waiting an answer about which event is the correct one
to output scancodes, but the thinkpad-acpi GIT tree is already updated with
the above, tentively using MSC_SCAN to report scan codes.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
