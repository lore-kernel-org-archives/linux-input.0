From: Jeffrey Brown <jeffbrown@android.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Fri, 16 Sep 2011 16:10:28 -0700
Message-ID: <CAMu+ixj4wpnF7rOaqhY8O-SZNvpJkEV1X3sa0uGkRceN=+A5dw@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
 <20110913080911.GA4986@polaris.bitmath.org> <CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36307 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab1IPXLJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 19:11:09 -0400
Received: by wwf22 with SMTP id 22so5673943wwf.1
        for <linux-input@vger.kernel.org>; Fri, 16 Sep 2011 16:11:08 -0700 (PDT)
In-Reply-To: <CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com

I disagree with this assignment somewhat because it creates ambiguities=
=2E

On Tue, Sep 13, 2011 at 7:13 AM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> =A0* Touch interface without screen should have POINTER only to
> indicate pointer needed and to treat absolute coordinates as relative
> movement. =A0Relative movement is product's default behavior as
> documented in its own manual and what I think should be advertised by
> default.

Yes.

> =A0* Pen interface without screen should have both POINTER and DIRECT=
 to
> indicate pointer needed and to treat absolute coordinates as absolute
> movement.

No.  DIRECT should not be set because the Pen is not directly touching
the objects on a screen.  The motions must still be translated through
some indirect means (a mapping function) onto the plane of the screen.

Therefore should only specify POINTER.

> =A0* Touch interfaces with screen should have DIRECT only to indicate=
 no
> pointer displayed and absolute coordinates as absolute movement.
> =A0* Pen interface with screen should have DIRECT only to indicate no
> pointer displayed and absolute coordinates as absolute movement.
> * A Pen+Touch touchscreen (only the wacom_w8001.c), should have DIREC=
T
> only to indicate no pointer displayed and absolute coordinates as
> absolute movement.

Yes, but not for this reason.  Touch interfaces with screen should
have DIRECT to indicate that touches are directly upon objects on the
screen.

It happens that the absolute coordinates of a tablet are usually
mapped 1-1 with the screen, but that's not what is meant by a direct
input device.  It's the usage that matters, not the mapping function
itself.

Note that a tablet's mapping function need not be precisely 1-1.  It
could be constrained to part of a window on the display, or it could
be rotated or skewed with respect to the display.  This is a
fundamental difference between direct and indirect input devices.  The
mapping function for a direct input devices must be a natural mapping
based on what is actually seen and directly touches.  The mapping
function for an indirect input device can be almost anything because a
pointer is being used to provide visual feedback so it is not
constrained by the physical position of objects on screen.

> Assuming we all agree on those combination, then in the patch the
> Graphire and Intuos tablets are missing a DIRECT, the touchscreens ar=
e
> correct, and the Bamboo's need to add DIRECT for the PEN interface
> only.

I disagree.

A touchscreen is DIRECT.
A tablet or trackpad is INDIRECT (and POINTER).

=46urther absolute/relative distinctions need to be made by tool.
=46inger / mouse on tablet uses relative motion.  Pen uses absolute
motion.  Essentially the tool types qualify the mapping function used
by indirect devices.

This isn't a concern for direct devices because there's really only
one sensible mapping function to use... touch the thing under the
finger.  :)

Jeff.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
