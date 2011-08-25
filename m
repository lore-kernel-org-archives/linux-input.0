From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: magicmouse: ignore 'ivalid report id' while switching
 modes
Date: Thu, 25 Aug 2011 14:22:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108251422100.13644@pobox.suse.cz>
References: <1313611182-19924-1-git-send-email-jaikumarg@android.com> <4E4D3CFC.7000700@canonical.com> <CAA8bQNjQ2s4EY=2r455z-3r7yyV0uwSjhQ6m5g2+TCyMRvu0sQ@mail.gmail.com> <4E4D426F.607@canonical.com> <4E4D68B0.8000703@canonical.com>
 <CAA8bQNgOZTqGMZhHF0MOm25ZUD5_G0i9F=rMsCOdiD3DYAWhTw@mail.gmail.com> <alpine.LNX.2.00.1108231052220.13644@pobox.suse.cz> <CAA8bQNj2vvM1F_VEQAFyRRBSVb1LUJ8y3Af5iz3c+QHhBD7aTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49285 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753321Ab1HYMW3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Aug 2011 08:22:29 -0400
In-Reply-To: <CAA8bQNj2vvM1F_VEQAFyRRBSVb1LUJ8y3Af5iz3c+QHhBD7aTg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaikumar Ganesh <jaikumarg@android.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, linux-input@vger.kernel.org

On Tue, 23 Aug 2011, Jaikumar Ganesh wrote:

> > From: Jiri Kosina <jkosina@suse.cz>
> > Subject: [PATCH] HID: magicmouse: ignore 'ivalid report id' while s=
witching modes, v2
> >
> > This is basically a more generic respin of 23746a6 ("HID: magicmous=
e: ignore
> > 'ivalid report id' while switching modes") which got reverted later=
 by
> > c3a492.
> >
> > It turns out that on some configurations, this is actually still th=
e case
> > and we are not able to detect in runtime.
> >
> > The device reponds with 'invalid report id' when feature report swi=
tching it
> > into multitouch mode is sent to it.
> >
> > This has been silently ignored before 0825411ade ("HID: bt: Wait fo=
r ACK
> > on Sent Reports"), but since this commit, it propagates -EIO from t=
he _raw
> > callback .
> >
> > So let the driver ignore -EIO as response to 0xd7,0x01 report, as t=
hat's
> > how the device reacts in normal mode.
> >
> > Sad, but following reality.
> >
> > This fixes https://bugzilla.kernel.org/show_bug.cgi?id=3D35022
> >
> > Reported-by: Chase Douglas <chase.douglas@canonical.com>
> > Reported-by: Jaikumar Ganesh <jaikumarg@android.com>
> > Tested-by: Chase Douglas <chase.douglas@canonical.com>
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > ---
> > =A0drivers/hid/hid-magicmouse.c | =A0 10 +++++++++-
> > =A01 files changed, 9 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmo=
use.c
> > index b5bdab3..f0fbd7b 100644
> > --- a/drivers/hid/hid-magicmouse.c
> > +++ b/drivers/hid/hid-magicmouse.c
> > @@ -537,9 +537,17 @@ static int magicmouse_probe(struct hid_device =
*hdev,
> > =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0report->size =3D 6;
> >
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Some devices repond with 'invalid report id' whe=
n feature
> > + =A0 =A0 =A0 =A0* report switching it into multitouch mode is sent=
 to it.
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* This results in -EIO from the _raw low-level tra=
nsport callback,
> > + =A0 =A0 =A0 =A0* but there seems to be no other way of switching =
the mode.
> > + =A0 =A0 =A0 =A0* Thus the super-ugly hacky success check below.
> > + =A0 =A0 =A0 =A0*/
> > =A0 =A0 =A0 =A0ret =3D hdev->hid_output_raw_report(hdev, feature, s=
izeof(feature),
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_FEATURE_REPORT);
> > - =A0 =A0 =A0 if (ret !=3D sizeof(feature)) {
> > + =A0 =A0 =A0 if (ret !=3D -EIO && ret !=3D sizeof(feature)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_err(hdev, "unable to request tou=
ch data (%d)\n", ret);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_stop_hw;
> > =A0 =A0 =A0 =A0}
> > --
> > 1.7.3.1
>=20
> Tested. Please push.

Okay, I have queued it with your Tested-by. Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
