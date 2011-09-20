From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Mon, 19 Sep 2011 19:49:22 -0700
Message-ID: <4E77FF32.5050806@gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com> <20110913080911.GA4986@polaris.bitmath.org> <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com> <20110914071524.GA3422@polaris.bitmath.org> <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com> <20110916105036.GA4455@polaris.bitmath.org> <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com> <20110917112114.GA3015@polaris.bitmath.org> <4E77D2FE.8060709@gmail.com> <CAMu+ixh_Am6vNn6oz4NEiaZ6+4UYXp=smu7BCekYze7S_L0hng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53448 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1ITCt2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 22:49:28 -0400
Received: by gxk6 with SMTP id 6so51463gxk.19
        for <linux-input@vger.kernel.org>; Mon, 19 Sep 2011 19:49:27 -0700 (PDT)
In-Reply-To: <CAMu+ixh_Am6vNn6oz4NEiaZ6+4UYXp=smu7BCekYze7S_L0hng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On 09/19/2011 06:05 PM, Jeffrey Brown wrote:
> On Mon, Sep 19, 2011 at 4:40 PM, Chase Douglas <chasedouglas@gmail.com> wrote:
>> I think these are the clearest definitions I've seen of these
>> properties. It would be good to get them documented in
>> Documentation/input. Henrik, would you be able to do this?
> 
> Agreed, but I feel we also need some clarity around the desired
> interpretations of different tools in relation to direct / indirect
> motion and these bits.
> 
> For example:
> 
> BTN_TOOL_FINGER / MT_FINGER:
> - Positions are absolute is INPUT_PROP_DIRECT, or relative otherwise.
> - Shows a pointer only if INPUT_PROP_POINTER is set.

This is actually my main grip with INPUT_PROP_POINTER. It really means
"the touchscreen and display are not integrated". A device may not have
INPUT_PROP_POINTER set (touchscreen and display are integrated), but may
still want to show the pointer (for example, you may want a cursor to
show when you are hovering). But, the name is set now.

I suppose my point in bringing this up is that the properties are
descriptions of the device, not specifications of what the evdev
consumer must do with the data. We can provide best-practices
guidelines, though, which is really what this list is.

> (IMHO, relative motion should be preferred for touch pads that are not
> physically coupled to a particular display.  Trackpad-like vs.
> tablet-like behavior, especially if "hovering" is not supported or if
> the touch pad is small.)
> 
> BTN_TOOL_PEN / BTN_TOOL_BRUSH / MT_PEN:
> - Positions are always one-to-one with screen coordinates regardless
> of INPUT_PROP_DIRECT.  If INPUT_PROP_DIRECT is set then we can take it
> as a stronger indication of the pen being coupled to a particular
> display (rather than spanning all displays or being bound to a
> specific window, perhaps).

Evdev doesn't know about displays, and it's well outside what it can do.
I don't think it helps to say that INPUT_PROP_DIRECT has extra meaning
in this case.

> - Shows a pointer only if INPUT_PROP_POINTER is set.
> 
> BTN_TOOL_MOUSE / BTN_TOOL_LENS:
> - Positions are always relative, regardless of INPUT_PROP_DIRECT.
> - Shows a pointer, regardless of INPUT_PROP_POINTER.

To condense all of the above, we can generalize the rules to:

* INPUT_PROP_DIRECT only has meaning for BTN_TOOL_FINGER etc.
* INPUT_PROP_POINTER only has meaning for BTN_TOOL_PEN / BTN_TOOL_BRUSH etc.

> We should also define heuristics for legacy devices that don't set
> either INPUT_PROP_DIRECT or INPUT_PROP_POINTER.

The above generalization should take care of this.

-- Chase
