From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Sat, 17 Sep 2011 13:44:16 +0200
Message-ID: <20110917114416.GB3015@polaris.bitmath.org>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
 <20110913080911.GA4986@polaris.bitmath.org>
 <CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
 <CAMu+ixj4wpnF7rOaqhY8O-SZNvpJkEV1X3sa0uGkRceN=+A5dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:39307 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab1IQLk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Sep 2011 07:40:28 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 4D058EA3A4
	for <linux-input@vger.kernel.org>; Sat, 17 Sep 2011 13:40:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAMu+ixj4wpnF7rOaqhY8O-SZNvpJkEV1X3sa0uGkRceN=+A5dw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeffrey Brown <jeffbrown@android.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com

> > =A0* Pen interface without screen should have both POINTER and DIRE=
CT to
> > indicate pointer needed and to treat absolute coordinates as absolu=
te
> > movement.
>=20
> No.  DIRECT should not be set because the Pen is not directly touchin=
g
> the objects on a screen.  The motions must still be translated throug=
h
> some indirect means (a mapping function) onto the plane of the screen=
=2E
>=20
> Therefore should only specify POINTER.

This is wrong given the intended semantics. Regardless of if DIRECT
means "absolute coordinates" or "one-to-one with screen", the result
is the same.

> > =A0* Touch interfaces with screen should have DIRECT only to indica=
te no
> > pointer displayed and absolute coordinates as absolute movement.
> > =A0* Pen interface with screen should have DIRECT only to indicate =
no
> > pointer displayed and absolute coordinates as absolute movement.
> > * A Pen+Touch touchscreen (only the wacom_w8001.c), should have DIR=
ECT
> > only to indicate no pointer displayed and absolute coordinates as
> > absolute movement.
>=20
> Yes, but not for this reason.  Touch interfaces with screen should
> have DIRECT to indicate that touches are directly upon objects on the
> screen.

A one-to-one correspondence should suffice.

> It happens that the absolute coordinates of a tablet are usually
> mapped 1-1 with the screen, but that's not what is meant by a direct
> input device.  It's the usage that matters, not the mapping function
> itself.

Precisely - it is the usage that matters here.

> Note that a tablet's mapping function need not be precisely 1-1.  It
> could be constrained to part of a window on the display, or it could
> be rotated or skewed with respect to the display.  This is a
> fundamental difference between direct and indirect input devices.  Th=
e
> mapping function for a direct input devices must be a natural mapping
> based on what is actually seen and directly touches.  The mapping
> function for an indirect input device can be almost anything because =
a
> pointer is being used to provide visual feedback so it is not
> constrained by the physical position of objects on screen.

The fundamental difference between a touchscreen and the mapping you
describe here is POINTER, not DIRECT. There is no reason why a device
physically separated from the screen, and guided by one or several
markers, cannot behave the same way as a touchscreen.

> > Assuming we all agree on those combination, then in the patch the
> > Graphire and Intuos tablets are missing a DIRECT, the touchscreens =
are
> > correct, and the Bamboo's need to add DIRECT for the PEN interface
> > only.
>=20
> I disagree.
>=20
> A touchscreen is DIRECT.
> A tablet or trackpad is INDIRECT (and POINTER).

Based on your assmumptions on the semantics, you are of course
right. Given the actual intended semantics, this is wrong. It is as
far as we get.

> Further absolute/relative distinctions need to be made by tool.
> Finger / mouse on tablet uses relative motion.  Pen uses absolute
> motion.  Essentially the tool types qualify the mapping function used
> by indirect devices.

Aggred, the pen tablets we see today behave this way, and we do not
break anything by skipping the DIRECT property here.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
