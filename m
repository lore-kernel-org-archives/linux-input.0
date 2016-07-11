From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: cros_ec: Add MKBP event support
Date: Mon, 11 Jul 2016 17:37:36 +0100
Message-ID: <20160711163736.GB1611@dell>
References: <1467364076-20172-1-git-send-email-enric.balletbo@collabora.com>
 <1467364076-20172-2-git-send-email-enric.balletbo@collabora.com>
 <CAOesGMgXoHxDv0An6OTp+qg4BK+Zvom_rtAhFHfF726Y0RHHDQ@mail.gmail.com>
 <CAOesGMjPaztVQPYEvGdHkQDDJYsw2bLSnaz5R_e5hsHYDZZsvw@mail.gmail.com>
 <86858048-FA33-4AC7-A7DD-3BEF5160CAFB@gmail.com>
 <CAOesGMgRxVdYrqUj2KfUsmgrwi+bPGr7T8QvmqZYzmwWs-xayQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMgRxVdYrqUj2KfUsmgrwi+bPGr7T8QvmqZYzmwWs-xayQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Vic Yang <victoryang@google.com>, Gwendal Grignou <gwendal@chromium.org>, Brian Norris <briannorris@chromium.org>, Randall Spangler <rspangler@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-input@vger.kernel.org

On Tue, 05 Jul 2016, Olof Johansson wrote:

> On Tue, Jul 5, 2016 at 2:00 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On July 5, 2016 1:55:44 PM PDT, Olof Johansson <olof@lixom.net> wro=
te:
> >>On Tue, Jul 5, 2016 at 1:54 PM, Olof Johansson <olof@lixom.net> wro=
te:
> >>> On Fri, Jul 1, 2016 at 2:07 AM, Enric Balletbo i Serra
> >>> <enric.balletbo@collabora.com> wrote:
> >>>> From: Vic Yang <victoryang@google.com>
> >>>>
> >>>> Newer revisions of the ChromeOS EC add more events besides the
> >>keyboard
> >>>> ones. So handle interrupts in the MFD driver and let consumers
> >>register
> >>>> for notifications for the events they might care.
> >>>>
> >>>> To keep backward compatibility, if the EC doesn't support MKBP
> >>event, we
> >>>> fall back to the old MKBP key matrix host command.
> >>>>
> >>>> Signed-off-by: Vic Yang <victoryang@google.com>
> >>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >>>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>> Cc: Randall Spangler <rspangler@chromium.org>
> >>>> Cc: Vincent Palatin <vpalatin@chromium.org>
> >>>> Cc: Benson Leung <bleung@chromium.org>
> >>>
> >>> Probably easiest to merge this through the MFD tree due to the
> >>> overlaps, so for that purpose:
> >>>
> >>> Acked-by: Olof Johansson <olof@lixom.net>
> >>
> >>Argh, I just noticed that the second patch is an input patch, not
> >>another MFD patch. Either way, I'm OK with this going through the
> >>input tree if that's easiest. If so, you should probably wait for a=
n
> >>ack from Lee as well.
> >
> > Hmm, I thought I already acked input portion to go through MFD tree=
=2E.. or am I confusing this with some other patch?
>=20
> Oh, then we're all set. That patch didn't thread with this one in my
> mailbox so I didn't see the comment thread on it.
=20
Yes, same for me.

> Lee, all yours.

Err, nice, ta!  =3D;-)

Eric,

Please resubmit this set 'threaded' so I might take proper care of
it.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
