From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] Input: Add infrastrucutre for selecting clockid for
 event time stamps.
Date: Mon, 9 Jan 2012 10:48:54 -0800
Message-ID: <CAKdAkRRHn53LHDsNgwM2PYwKex6n5Z87MLQQbWoo07AsJvb9eg@mail.gmail.com>
References: <1325907639-3004-1-git-send-email-john.stultz@linaro.org>
	<CAGS+omBC8LVkFWbhW59XLoS=4PqN2hL6BQsREFDUf6kux5WDXQ@mail.gmail.com>
	<20120109180421.GE15083@core.coreip.homeip.net>
	<CAGS+omDkkH_cVQV4CvF1iz-aSRdNTGcsEghXU3MNBLAgsp7jFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59654 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932525Ab2AISsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 13:48:55 -0500
Received: by eaad14 with SMTP id d14so2174880eaa.19
        for <linux-input@vger.kernel.org>; Mon, 09 Jan 2012 10:48:54 -0800 (PST)
In-Reply-To: <CAGS+omDkkH_cVQV4CvF1iz-aSRdNTGcsEghXU3MNBLAgsp7jFA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@google.com>
Cc: John Stultz <john.stultz@linaro.org>, Dima Zavin <dima@android.com>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Brian Swetland <swetland@google.com>, Colin Cross <ccross@android.com>

On Mon, Jan 9, 2012 at 10:39 AM, Daniel Kurtz <djkurtz@google.com> wrot=
e:
>
> On Jan 10, 2012 2:04 AM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com=
>
> wrote:
>>
>> On Sat, Jan 07, 2012 at 02:42:32PM +0800, Daniel Kurtz wrote:
>> > On Sat, Jan 7, 2012 at 11:40 AM, John Stultz <john.stultz@linaro.o=
rg>
>> > wrote:
>> > > =A0static void evdev_pass_event(struct evdev_client *client,
>> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
input_event *event)
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
input_event *event,
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ktime_t=
 mono, ktime_t real)
>> > > =A0{
>> > > + =A0 =A0 =A0 struct timespec ts;
>> > > +
>> > > + =A0 =A0 =A0 if (client->timestamp_clkid =3D=3D CLOCK_MONOTONIC=
)
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts =3D ktime_to_timespec(mono);
>> > > + =A0 =A0 =A0 else
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts =3D ktime_to_timespec(real);
>> > > + =A0 =A0 =A0 event->time.tv_sec =3D ts.tv_sec;
>> > > + =A0 =A0 =A0 event->time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC=
;
>> >
>> > Maybe just:
>> >
>> > =A0event->time =3D (client->timestamp_clkid =3D=3D CLOCK_MONOTONIC=
) ?
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ktime_to_timeval(mono)=
 : ktime_to_timeval(real);
>> >
>> > Either way, lgtm...
>> >
>> > Reviewed-by: Daniel Kurtz <djkurtz@google.com>
>> >
>>
>> I'm OK with the patch but do we actually have a buy-in from
>> Android/Chrome folks for this? If they will actually use it I'll app=
ly
>> it, otherwise I'll sit on it.
>
> Chrome/Chromium OS: yes.=A0 That's me.=A0 We would definitely like to=
 start
> using this. But we haven't done so yet. If you want to sit on it, we =
could
> get back to you when we've tested it out.
>
> But it might not be for a little while, as I am suddenly very busy :)
>

Actually, I expect your productivity to skyrocket - suddenly you'll
have a few sleepless nights you'll have nothing else to do but code
when you not trying to calm her down ;)

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
