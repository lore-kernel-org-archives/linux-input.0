From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: EVIOC mechanism for MT slots
Date: Thu, 20 Jan 2011 17:45:52 -0800
Message-ID: <AANLkTi=mwmpV-db5evGsWe3eyNJER5DOH3V326Jf74us@mail.gmail.com>
References: <4D38A4B7.7060901@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59596 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab1AUBqM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Jan 2011 20:46:12 -0500
Received: by wwi17 with SMTP id 17so135552wwi.1
        for <linux-input@vger.kernel.org>; Thu, 20 Jan 2011 17:46:11 -0800 (PST)
In-Reply-To: <4D38A4B7.7060901@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input <linux-input@vger.kernel.org>, Stephane Chatty <chatty@lii-enac.fr>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>

Hi Dmitry,

Rafi's request is a good use case for the "input: mt: Add EVIOC
mechanism for MT slots" patchset that Henrik submitted last May. From
the MT X driver experience we had in the last few months, retrieving
all active contacts, especially in the case when different tool types
are supported on the same logical port, is necessary to initialize the
tools properly.

Can you consider to merge the patchset into 2.6.38?

Thank you.

Ping

-------- Original Message --------
Subject:        Re: [PATCH 0/2] input: mt: Add EVIOC mechanism for MT s=
lots
Date:   Thu, 27 May 2010 16:12:20 -0700
=46rom:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ping Cheng <pinglinux@gmail.com>
CC:     Henrik Rydberg <rydberg@euromail.se>, Andrew Morton
<akpm@linux-foundation.org>, linux-input@vger.kernel.org,
linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>,
Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires
<tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin
<rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>


On Thursday, May 27, 2010 03:59:37 pm Ping Cheng wrote:

     On Thu, May 27, 2010 at 12:03 AM, Dmitry Torokhov

     <dmitry.torokhov@gmail.com>  wrote:
     >  On Wed, May 26, 2010 at 08:59:35AM -0700, Ping Cheng wrote:
     >>  On Tue, May 25, 2010 at 1:23 PM, Dmitry Torokhov
     >>
     >>  <dmitry.torokhov@gmail.com>  wrote:
     >>  >  On Tue, May 25, 2010 at 09:52:29PM +0200, Henrik Rydberg wr=
ote:
     >>  >>  Dmitry Torokhov wrote:
     >>  >>  >  Hi Henrik,
     >>  >>  >
     >>  >>  >  On Tue, May 25, 2010 at 01:52:57PM +0200, Henrik Rydber=
g wrote:
     >>  >>  >>  These patches are in response to the discussion about
input state
     >>  >>  >>  retrieval.
     >>  >>  >>
     >>  >>  >>  The current EVIOCGABS method does not work with MT
slots.  These
     >>  >>  >>  patches provides a mechanism where a slot is first
selected via a
     >>  >>  >>  call to EVIOCSABS, after which the corresponding MT
events can be
     >>  >>  >>  extracted with calls to EVIOCGABS.
     >>  >>  >>
     >>  >>  >>  The symmetric operation, to set the MT state via
EVIOCSABS, seems
     >>  >>  >>  to violate input data integrity, and is therefore not
     >>  >>  >>  implemented.
     >>  >>  >
     >>  >>  >  This looks sane, however the question remains - is
there any users
     >>  >>  >  for this data? Like I mentioned, I can see the need to
fetch state
     >>  >>  >  of switches and ranges of absolute axis, and even non-m=
ultitouch
     >>  >>  >  ABS values (due to the fact that some input devices,
like sliders,
     >>  >>  >  may stay in a certain position for long periods of time=
), but I
     >>  >>  >  expect multitouch data to be "refreshed" very quickly.
     >>  >>  >
     >>  >>  >  Thanks.
     >>  >>
     >>  >>  There were some voices addressing this issue, and the patc=
hes are
     >>  >>  here, available for whomever to pick up. Drop them if you =
wish, I
     >>  >>  will not send them anew.
     >>  >
     >>  >  I'll save them in my queue but will hold off applying until=
 I hear
     >>  >  userspace folks requesting such functionality.
     >>
     >>  Hi Dmitry,
     >>
     >>  You do have a valid point - the (x,y) from a touch object woul=
d most
     >>  likely change all the time. Even if the object itself is in a =
steady
     >>  state on the digitizer, i.e., without any intentional movement=
, the
     >>  electronic noise would most likely lead to some (x,y) changes.=
 So, the
     >>  chance that we need to retrieve (x,y) is rare.
     >>
     >>  However, it is possibe that when X driver starts, an object wa=
s
     >>  already on the digitizer. And the digitizer is of such a high =
quality
     >>
     >>  :), it filtered all the noises so we can not locate the touch =
without
     >>
     >>  a EVIOCGABS call.
     >>
     >>  Plus, from a pure coding/development point of view, it is not =
a bad
     >>  practice to provide the equivalent features for _MT_ support a=
s we did
     >>  for the existing input devices. At least, it doesn't hurt to m=
ake the
     >>  support consistent across devices/tools (considering touch as =
a new
     >>  input device/tool).
     >
     >  Ping,
     >
     >  I did not say that there was a problem with the patch, I agree =
with it.
     >  However if no one using this - why should we bother? Will _you_=
 utilize
     >  this functionality in Wacom X driver? If so let me know and I w=
ill merge
     >  it.

     tbh, I can not say that I will need it in my X driver for sure. Bu=
t I
     vote for it to be merged.


Well, at this point I am in "no users - no functionality" mode, so I wi=
ll
only count votes of users :P

--=20
Dmitry

On Thu, Jan 20, 2011 at 1:10 PM, Rafi Rubin <rafi@seas.upenn.edu> wrote=
:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> We've come across a little problem with filtered MT events. =A0It see=
ms there
> isn't a mechanism to request the full state. =A0If a program opens a =
device
> there's no way it can see static objects.
>
> Consider for example a board game. =A0If the user puts the pieces on =
a MT surface
> before starting the application, those pieces will not register and t=
he state of
> the game will be incorrect.
>
> If there's opposition to this request, I suggest settling the dispute=
 with a
> game of MT battleship :-)
>
> Rafi
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
