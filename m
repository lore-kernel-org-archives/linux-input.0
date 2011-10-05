From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: evdev - use monotonic clock for event timestamps
Date: Wed, 5 Oct 2011 15:55:05 +0800
Message-ID: <CAGS+omAj9z2-Au2HABtDKHQGRBNVxXygF2cz+L8UMeTHRrMjbA@mail.gmail.com>
References: <1317624200-9762-1-git-send-email-djkurtz@chromium.org> <20111003090641.GA5615@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31963 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757895Ab1JEHz1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 03:55:27 -0400
Received: from wpaz17.hot.corp.google.com (wpaz17.hot.corp.google.com [172.24.198.81])
	by smtp-out.google.com with ESMTP id p957tRxZ015976
	for <linux-input@vger.kernel.org>; Wed, 5 Oct 2011 00:55:27 -0700
Received: from iadj38 (iadj38.prod.google.com [10.12.136.38])
	by wpaz17.hot.corp.google.com with ESMTP id p957tPOl021798
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 5 Oct 2011 00:55:25 -0700
Received: by iadj38 with SMTP id j38so2566473iad.5
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 00:55:25 -0700 (PDT)
In-Reply-To: <20111003090641.GA5615@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Mon, Oct 3, 2011 at 5:06 PM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
>
> Hi Daniel,
>
> > Using wallclock time for event timestamps subjects inter-event timi=
ng to
> > ntp and other clock adjustments. =A0This complicates userspace driv=
ers
> > that use these timestamps to calculate velocities, or while process=
ing
> > state transitions.
> >
> > Instead, use the kernel monotonic clock for event timestamps, which=
 is
> > at least guaranteed never to go backwards.
> >
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> > =A0drivers/input/evdev.c | =A0 =A05 ++++-
> > =A01 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > index 4cf2534..118f936 100644
> > --- a/drivers/input/evdev.c
> > +++ b/drivers/input/evdev.c
> > @@ -94,8 +94,11 @@ static void evdev_event(struct input_handle *han=
dle,
> > =A0 =A0 =A0 struct evdev *evdev =3D handle->private;
> > =A0 =A0 =A0 struct evdev_client *client;
> > =A0 =A0 =A0 struct input_event event;
> > + =A0 =A0 struct timespec now;
> >
> > - =A0 =A0 do_gettimeofday(&event.time);
> > + =A0 =A0 getrawmonotonic(&now);
> > + =A0 =A0 event.time.tv_sec =3D now.tv_sec;
> > + =A0 =A0 event.time.tv_usec =3D now.tv_nsec/1000;
> > =A0 =A0 =A0 event.type =3D type;
> > =A0 =A0 =A0 event.code =3D code;
> > =A0 =A0 =A0 event.value =3D value;
> > --
> > 1.7.3.1
>
> Good thing per se, but reporting time relative to boot instead of
> using real time, for all input events, may cause regression on some
> obscure systems. Perhaps it is possible to improve on the desired
> monotonicity in most cases, without such a drastic change.
>
> Thanks,
> Henrik

Thanks for responding!  This is the smallest possible patch that I
could think of that illustrates what I'd like to see.  What other
options do we have to achieve the same affect?

I understand your concern about breaking random drivers, and am hoping
that someon on this list could indicate whether this is a real concern
or not.  To get a better feeling for possible regressions, I checked
xf86-input-evdev & -synaptics, and neither uses the evdev timestamp in
their current incarnations.  Any idea what else might be a good place
to check?

One option is to make the evdev timestamp clock source a per-driver
configuration option (controllable from userspace?).  This sounds like
it is doable, but would be significantly more complicated.

Another option would be to timestamp with monotonicraw + boottime +
sleeptime.  This would be approximately wall clock time, but without
ntp and slew adjustments.  But, I fear this would just make the rare
driver issue less obvious, since it would only become obvious when the
two clock sources started drifting apart.

-Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
