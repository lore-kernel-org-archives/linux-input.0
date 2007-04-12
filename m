From: Barton C Massey <bart@cs.pdx.edu>
Subject: Re: [PATCH] don't invert mightymouse hwheel
Date: Thu, 12 Apr 2007 14:25:09 -0700
Message-ID: <200704122125.l3CLP9aQ005277@wezen.cs.pdx.edu>
References: <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz>
	<1176330232.27324.7.camel@johannes.berg>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-reply-to: Your message of "Thu, 12 Apr 2007 18:04:07 +0200."
	<Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>, "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-input@vger.kernel.org

In message <Pine.LNX.4.64.0704121800000.19492@jikos.suse.cz> you wrote:
> On Thu, 12 Apr 2007, Johannes Berg wrote:
> 
> > This is not true. With this X configuration:
> > 
> >     Section "InputDevice"
> >         Identifier  "EvDev"
> >         Driver      "evdev"
> >         Option      "SendCoreEvents"    "true"
> >         Option      "evBits"            "+1-2"
> >         Option      "keyBits"           "~272-287"
> >         Option      "relBits"           "~0-2 ~6 ~8"
> >         Option      "Pass"              "3"
> >     EndSection
> > I can scroll up in a window by moving my finger up, and scroll left in a
> > window by moving my finger right. That makes no sense, this patch therefore
> > removes the INVERT_HWHEEL quirk from the USB mightymouse.
> 
> Johannes, Bart, 
> 
> I unfortunately don't have the hardware in question to test with. This X 
> configuration is of course perfectly valid.
> 
> Bart, as you wrote the original patch which inverted the wheel, could you 
> provide some more information please? It seems to me that you guys have 
> different versions of mightymouse ... but I wouldn't believe they would 
> have the same PID :)

Give me a day or so to check all this out.  I don't think
looking at the X behavior is too useful: too many place that
the direction can be swapped.  Instead, look which way the
bits coming directly out of evdev point.  IIRC I set things
up so that positive X was the same as on other evdev
devices.  Is the supplied X config swapping the X axis with
this line?

  > >         Option      "evBits"            "+1-2"

One possible source of confusion is that Iceweasel scrolls
backward by default (on all devices, not just MM).  You can
fix this by changing a setting in the Iceweasel config.

	Bart
