From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Making KEY_UNKNOWN really useful to userland
Date: Wed, 30 May 2007 21:53:05 -0300
Message-ID: <20070531005305.GC6883@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net> <200705282316.32173.dtor@insightbb.com> <20070529130528.GB12935@khazad-dum.debian.net> <d120d5000705300657s3a50a93el6c0771288ac80ebb@mail.gmail.com> <20070530152444.GD17530@khazad-dum.debian.net> <d120d5000705300904j54eaa18al4cf1db8f7f13b97b@mail.gmail.com> <20070530172420.GA6883@khazad-dum.debian.net> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 30 May 2007, Dmitry Torokhov wrote:
> On 5/30/07, Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> >It is trivial to guarantee that KEY_PROG is unique for a single input
> >device (keyboard), but it certainly won't work across multiple devices.
> >Userspace has to know what kind of input device it is talking to to map
> >them to something, but since the input layer already provides this
> >information, I was not going to raise a fuss about it.  I figure it is
> >the price of not increasing even more the keycode table.
> 
> Actually I try to discourage people from using input_id during device
> discovery but rather tell them to analyze capability bits and then decide
> if their application is interested in that particular input device. I
> think input_id should pretty much only used by udev & co. to adjust
> default kernel setup for the needs of local installation (fix keymap,
> adjust absmax, etc).

It is likely going to be used by something like udev, or an init script, or
a thinkpad-configurator helper, or whatever.  Sounds like the sort of stuff
that should be paying attention to input_id anyway.

We don't appear to have deployed a good kernel-userland interface that
allows us to have generic "press an unknown key and tell me what you want it
to do" application in userland, but if we do please correct me.  If
KEY_UNKNOWN was always required to send a EV_MSC MSC_RAW/MSC_SCAN, then we
would have one.

Maybe we can add that requirement and driver changes (if any, for all I know
most drivers might already be generating such events) for 2.6.23?  I bet
Richard would like that one a lot.  Richard?

Such functionality makes most of my requests for new keycodes irrelevant, so
I will just trim that down.

> >That said, how is one to know which hardware key was translated to
> >KEY_UNKNOWN, so that he can inform the user to remap that key?  Should I
> >send another event together with KEY_UNKNOWN that has the raw keycode?
> >Which one?
> 
> You may try using EV_MSC/MSC_SCAN. You can even send it all the time, not
> only for KEY_UNKNOWN.

Will do, thanks.  And I will send it all the time, that will force people to
properly implement code that can deal with them in userland.

What is the exact difference between MSC_RAW and MSC_SCAN?  Which one can be
used as an index to reprogram the keymap using the IOCTLs?

> I guess we have different opinions. For me KEY_UNKNOWN is better because
> it encourages user to adjust keymap table in the kernel at startup (or at
> hotplug time) and then rest of userspace does not need to be aware at all

If we add a requirement and fix all EV_KEY drivers to always report the scan
code (or raw code, I still don't know which is which) that allows an
userspace application to know what keymap position to change to fix that
key, so that we can have an app that:

1. gets a EV_KEY KEY_UNKNOWN and its related EV_MSC MSC_? event
2. offers the user to map it, now that it knows how to do so.

(note that, for the above to work right, the application must really tap
into all input devices so that it knows exactly which one is reporting the
event, etc).

I will readly agree with you, KEY_UNKNOWN will definately be the right
choice for anything that is not a functional key and which doesn't have
something like FN_foo already in input.h (and maybe even if does have a
FN_foo keycode already in input.h).

> Consider ejecting a CD tray. You have a laptop with a key that maked eject
> CD. Because it is a new laptop there are no proper mapping yet so some
> adjustments are needed. With your scenario the kernel emits KEY_PROG26.
> User has first to adjust X keymap to map KEY_PROG26 to EjectCD event
> (simplifying). Then he goes into text console only to find out that his
> curses-based CD player does not recognize that key and also needs to be
> adjusted. And so on. Finally all applications are made aware of KEY_PROG26
> amd user is happy. Couple of weeks later he goes and buys an external
> keyboard and it turns out that eject CD there is actually KEY_PROG21 so he
> need to go through second round of mapping for all applications. Not only
> that but button with volume increase happens to generate KEY_PROG26. Now
> what?

Yes, that is the problem with non-functional keys if we don't have a
position-specific keycode for all of them (like FN_F1).

> Now consider in-kernel remapping to functional scancdes that I propose:
> user says that that key should generate KEY_EJECTCD and it starts working
> in all appliations recognizing that event. Adding the second keyboard into
> mix does not mess up the first one.

I got your point.  So, we should have PROG* free for the user to assign to
keys, but never use it by default.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
