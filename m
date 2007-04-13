From: Barton C Massey <bart@cs.pdx.edu>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Thu, 12 Apr 2007 17:21:57 -0700
Message-ID: <200704130021.l3D0LvVM008180@adara.cs.pdx.edu>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-reply-to: Your message of "Thu, 12 Apr 2007 14:25:09 PDT."
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

--------
> In message <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz> I wrote:
> > On Thu, 12 Apr 2007, Johannes Berg wrote:
> > 
> > > This is not true. With this X configuration:
> > > 
> > >     Section "InputDevice"
> > >         Identifier  "EvDev"
> > >         Driver      "evdev"
> > >         Option      "SendCoreEvents"    "true"
> > >         Option      "evBits"            "+1-2"
> > >         Option      "keyBits"           "~272-287"
> > >         Option      "relBits"           "~0-2 ~6 ~8"
> > >         Option      "Pass"              "3"
> > >     EndSection
> > > I can scroll up in a window by moving my finger up, and scroll left in a
> > > window by moving my finger right. That makes no sense, this patch therefore
> > > removes the INVERT_HWHEEL quirk from the USB mightymouse.
> > 
> > I unfortunately don't have the hardware in question to test with. This X 
> > configuration is of course perfectly valid.
> > 
> > Bart, as you wrote the original patch which inverted the wheel, could you 
> > provide some more information please? It seems to me that you guys have 
> > different versions of mightymouse ... but I wouldn't believe they would 
> > have the same PID :)
> 
> Give me a day or so to check all this out.  I don't think
> looking at the X behavior is too useful: too many places that
> the direction can be swapped.  Instead, look which way the
> bits coming directly out of evdev point.  IIRC I set things
> up so that positive X was the same as on other evdev
> devices.  Is the supplied X config swapping the X axis with
> this line?
> 
>   > >         Option      "evBits"            "+1-2"
> 
> One possible source of confusion is that Iceweasel scrolls
> backward by default (on all devices, not just MM).  You can
> fix this by changing a setting in the Iceweasel config.

After checking further I've found that my memory is correct.
With the patch as I originally submitted it (including the
INVERT_HWHEEL quirk):

  1) Moving the scroll ball to the right sends positive
     deltas (to /dev/input/event*), and moving it to the
     left sends negative deltas.  This is the same as the
     mouse itself, of course.

  2) You can use an xorg.conf entry as simple as

	Section "InputDevice"
	  Identifier  "MouseMightyMouse0"
	  Driver      "mouse"
	  Option      "Device" "/dev/input/mouse1"
	  Option      "Dev Name" "Mitsumi Electric Apple Optical USB Mouse"
	EndSection
				
  3) X SW (other than Iceweasel, which has the misfeature
     described earlier) just works properly.

Please don't remove the axis flip on the MM; it seems like
something most folks, including me, are quite happy with.
Instead, I'd suggest to Johannes that simplifying his X
config and/or fixing his Iceweasel config will straighten
his situation out.  (Most of that config is unnecessary at
best anyhow; I got all the button remaps right in my
original patch.)

These results are for the USB MM.  I have a Bluetooth MM
now, and am trying to find time to get it working also.
Sorry I haven't had time to do that yet.  Soon, honest.

    Bart Massey
    Assoc. Prof. Computer Science
    Portland State University
    bart@cs.pdx.edu
