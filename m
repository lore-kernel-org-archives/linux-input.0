From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] Input: synaptics - add multitouch packet support
Date: Sat, 18 Dec 2010 18:54:08 +0100
Message-ID: <20101218175408.GA1709@polaris.bitmath.org>
References: <1292683981-6908-1-git-send-email-rydberg@euromail.se>
 <1292683981-6908-2-git-send-email-rydberg@euromail.se>
 <AANLkTimrNrfTXGh675_8zhOg_+9+NKgOmzJq9rafyh+6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimrNrfTXGh675_8zhOg_+9+NKgOmzJq9rafyh+6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: linux-input@vger.kernel.org

Hi Chris,

Thanks for you comments.

> > While in MT mode and two or three fingers are touching, two sets of
> > data are sent. =A0The first is a new format buffer with lower resol=
ution
> > reporting of stationary finger and the second is standard data form=
at
> > reporting movement.
>=20
> We should probably update this comment and remove parts that mention
> stationary and movement.  It appears to be doing finger tracking and
> first packet is always first touch... except we are getting reports
> that clickpads/integrated button pads may not be consistently like
> this.

Yes, good point. Will update.
=20
> This tracking is partly why type B protocol is being used in later pa=
tches.

The original thought was that the two points corresponded well to the
two fingers, only sometimes in the wrong order. The solution then was
to use the tracking module to order them appropriately. As it turned
out that the fingers are not followed that well after all, the whole
idea fell flat, so we resorted to only sending the bounding rectangle,
which requires no tracking.

All in all, this patchset contains enough information to resolve
jumping and clickpad issues in user space, at the same time as it
keeps compatibility with mousedev and older hardware. We know there
are still issues, but I see no real reason to postpone these changes
any further.

Thanks,
Henrik
