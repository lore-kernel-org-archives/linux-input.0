From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Mon, 19 Sep 2011 18:05:48 -0700
Message-ID: <CAMu+ixh_Am6vNn6oz4NEiaZ6+4UYXp=smu7BCekYze7S_L0hng@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
 <20110913080911.GA4986@polaris.bitmath.org> <CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
 <20110914071524.GA3422@polaris.bitmath.org> <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
 <20110916105036.GA4455@polaris.bitmath.org> <CANRwn3TstEAhgt5=Sxu6KMOyu3rtC9CCeQWU7Qa5-jRXUfgBdw@mail.gmail.com>
 <20110917112114.GA3015@polaris.bitmath.org> <4E77D2FE.8060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52115 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1ITBG3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 21:06:29 -0400
Received: by wwf22 with SMTP id 22so29626wwf.1
        for <linux-input@vger.kernel.org>; Mon, 19 Sep 2011 18:06:28 -0700 (PDT)
In-Reply-To: <4E77D2FE.8060709@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Mon, Sep 19, 2011 at 4:40 PM, Chase Douglas <chasedouglas@gmail.com> wrote:
> I think these are the clearest definitions I've seen of these
> properties. It would be good to get them documented in
> Documentation/input. Henrik, would you be able to do this?

Agreed, but I feel we also need some clarity around the desired
interpretations of different tools in relation to direct / indirect
motion and these bits.

For example:

BTN_TOOL_FINGER / MT_FINGER:
- Positions are absolute is INPUT_PROP_DIRECT, or relative otherwise.
- Shows a pointer only if INPUT_PROP_POINTER is set.

(IMHO, relative motion should be preferred for touch pads that are not
physically coupled to a particular display.  Trackpad-like vs.
tablet-like behavior, especially if "hovering" is not supported or if
the touch pad is small.)

BTN_TOOL_PEN / BTN_TOOL_BRUSH / MT_PEN:
- Positions are always one-to-one with screen coordinates regardless
of INPUT_PROP_DIRECT.  If INPUT_PROP_DIRECT is set then we can take it
as a stronger indication of the pen being coupled to a particular
display (rather than spanning all displays or being bound to a
specific window, perhaps).
- Shows a pointer only if INPUT_PROP_POINTER is set.

BTN_TOOL_MOUSE / BTN_TOOL_LENS:
- Positions are always relative, regardless of INPUT_PROP_DIRECT.
- Shows a pointer, regardless of INPUT_PROP_POINTER.

We should also define heuristics for legacy devices that don't set
either INPUT_PROP_DIRECT or INPUT_PROP_POINTER.

Jeff.
