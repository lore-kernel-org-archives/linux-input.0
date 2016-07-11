From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: cros_ec: Add MKBP event support
Date: Mon, 11 Jul 2016 17:39:36 +0100
Message-ID: <20160711163936.GC1611@dell>
References: <1467364076-20172-1-git-send-email-enric.balletbo@collabora.com>
 <1467364076-20172-2-git-send-email-enric.balletbo@collabora.com>
 <CAOesGMgXoHxDv0An6OTp+qg4BK+Zvom_rtAhFHfF726Y0RHHDQ@mail.gmail.com>
 <CAOesGMjPaztVQPYEvGdHkQDDJYsw2bLSnaz5R_e5hsHYDZZsvw@mail.gmail.com>
 <86858048-FA33-4AC7-A7DD-3BEF5160CAFB@gmail.com>
 <CAOesGMgRxVdYrqUj2KfUsmgrwi+bPGr7T8QvmqZYzmwWs-xayQ@mail.gmail.com>
 <20160711163736.GB1611@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37062 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030609AbcGKQie (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 12:38:34 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so25496978wmg.0
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2016 09:38:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160711163736.GB1611@dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Vic Yang <victoryang@google.com>, Gwendal Grignou <gwendal@chromium.org>, Brian Norris <briannorris@chromium.org>, Randall Spangler <rspangler@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Benson Leung <bleung@chromium.org>

On Mon, 11 Jul 2016, Lee Jones wrote:

> On Tue, 05 Jul 2016, Olof Johansson wrote:
>=20
> > On Tue, Jul 5, 2016 at 2:00 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On July 5, 2016 1:55:44 PM PDT, Olof Johansson <olof@lixom.net> w=
rote:
> > >>On Tue, Jul 5, 2016 at 1:54 PM, Olof Johansson <olof@lixom.net> w=
rote:
> > >>> On Fri, Jul 1, 2016 at 2:07 AM, Enric Balletbo i Serra
> > >>> <enric.balletbo@collabora.com> wrote:
> > >>>> From: Vic Yang <victoryang@google.com>
> > >>>>
> > >>>> Newer revisions of the ChromeOS EC add more events besides the
> > >>keyboard
> > >>>> ones. So handle interrupts in the MFD driver and let consumers
> > >>register
> > >>>> for notifications for the events they might care.
> > >>>>
> > >>>> To keep backward compatibility, if the EC doesn't support MKBP
> > >>event, we
> > >>>> fall back to the old MKBP key matrix host command.
> > >>>>
> > >>>> Signed-off-by: Vic Yang <victoryang@google.com>
> > >>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > >>>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.co=
m>
> > >>>> Cc: Randall Spangler <rspangler@chromium.org>
> > >>>> Cc: Vincent Palatin <vpalatin@chromium.org>
> > >>>> Cc: Benson Leung <bleung@chromium.org>
> > >>>
> > >>> Probably easiest to merge this through the MFD tree due to the
> > >>> overlaps, so for that purpose:
> > >>>
> > >>> Acked-by: Olof Johansson <olof@lixom.net>
> > >>
> > >>Argh, I just noticed that the second patch is an input patch, not
> > >>another MFD patch. Either way, I'm OK with this going through the
> > >>input tree if that's easiest. If so, you should probably wait for=
 an
> > >>ack from Lee as well.
> > >
> > > Hmm, I thought I already acked input portion to go through MFD tr=
ee... or am I confusing this with some other patch?
> >=20
> > Oh, then we're all set. That patch didn't thread with this one in m=
y
> > mailbox so I didn't see the comment thread on it.
> =20
> Yes, same for me.
>=20
> > Lee, all yours.
>=20
> Err, nice, ta!  =3D;-)
>=20
> Eric,
>=20
> Please resubmit this set 'threaded' so I might take proper care of
> it.

Wait!  Ignore that.  I got mixed up with what Olof said and the way
things looked in my inbox.  The two patches are in fact threaded.
I'll look to see to them later in the week.  Please bear with me.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
