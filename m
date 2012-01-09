From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for selecting clockid for
 event time stamps.
Date: Mon, 9 Jan 2012 10:04:21 -0800
Message-ID: <20120109180421.GE15083@core.coreip.homeip.net>
References: <1325907639-3004-1-git-send-email-john.stultz@linaro.org>
 <CAGS+omBC8LVkFWbhW59XLoS=4PqN2hL6BQsREFDUf6kux5WDXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42570 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab2AISE2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 13:04:28 -0500
Received: by iaeh11 with SMTP id h11so6923763iae.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2012 10:04:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGS+omBC8LVkFWbhW59XLoS=4PqN2hL6BQsREFDUf6kux5WDXQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Brian Swetland <swetland@google.com>, Colin Cross <ccross@android.com>, Dima Zavin <dima@android.com>

On Sat, Jan 07, 2012 at 02:42:32PM +0800, Daniel Kurtz wrote:
> On Sat, Jan 7, 2012 at 11:40 AM, John Stultz <john.stultz@linaro.org>=
 wrote:
> > =A0static void evdev_pass_event(struct evdev_client *client,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct inp=
ut_event *event)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct inp=
ut_event *event,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ktime_t mo=
no, ktime_t real)
> > =A0{
> > + =A0 =A0 =A0 struct timespec ts;
> > +
> > + =A0 =A0 =A0 if (client->timestamp_clkid =3D=3D CLOCK_MONOTONIC)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts =3D ktime_to_timespec(mono);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts =3D ktime_to_timespec(real);
> > + =A0 =A0 =A0 event->time.tv_sec =3D ts.tv_sec;
> > + =A0 =A0 =A0 event->time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
>=20
> Maybe just:
>=20
>  event->time =3D (client->timestamp_clkid =3D=3D CLOCK_MONOTONIC) ?
>                       ktime_to_timeval(mono) : ktime_to_timeval(real)=
;
>=20
> Either way, lgtm...
>=20
> Reviewed-by: Daniel Kurtz <djkurtz@google.com>
>=20

I'm OK with the patch but do we actually have a buy-in from
Android/Chrome folks for this? If they will actually use it I'll apply
it, otherwise I'll sit on it.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
