From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/1] Input - alps: Fix button reporting on the V2 Alps
 protocol
Date: Thu, 30 Jul 2015 16:11:32 +0200
Message-ID: <20150730141132.GC26714@pali>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <1438202726-5100-1-git-send-email-cpaul@redhat.com>
 <1438202726-5100-2-git-send-email-cpaul@redhat.com>
 <55BA2BDD.90108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38076 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbbG3OLf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 10:11:35 -0400
Received: by wibxm9 with SMTP id xm9so70657179wib.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 07:11:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <55BA2BDD.90108@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: cpaul@redhat.com, Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thursday 30 July 2015 15:51:25 Hans de Goede wrote:
> Hi Chandler,
>=20
> On 29-07-15 22:45, cpaul@redhat.com wrote:
> >From: Stephen Chandler Paul <cpaul@redhat.com>
> >
> >The data concerning which buttons on the touchpad are held down or n=
ot
> >are in the fourth packet we receive from the mouse, not the first.
> >
> >Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> >---
> >  drivers/input/mouse/alps.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> >index 113d6f1..e2f9b25 100644
> >--- a/drivers/input/mouse/alps.c
> >+++ b/drivers/input/mouse/alps.c
> >@@ -254,9 +254,9 @@ static void alps_process_packet_v1_v2(struct psm=
ouse *psmouse)
> >  	/* Non interleaved V2 dualpoint has separate stick button bits */
> >  	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
> >  	    priv->flags =3D=3D (ALPS_PASS | ALPS_DUALPOINT)) {
> >-		left |=3D packet[0] & 1;
> >-		right |=3D packet[0] & 2;
> >-		middle |=3D packet[0] & 4;
> >+		left |=3D packet[3] & 1;
> >+		right |=3D packet[3] & 2;
> >+		middle |=3D packet[3] & 4;
> >  	}
> >
> >  	alps_report_buttons(dev, dev2, left, right, middle);
>=20
> Thanks for taking a look at the recordings, but the above patch is wr=
ong,
> if you look slightly higher in the lps_process_packet_v1_v2() functio=
n there
> is this:
>=20
> if (priv->proto_version =3D=3D ALPS_PROTO_V1) {
> ...
> } else {
> 	left =3D packet[3] & 1;
> 	right =3D packet[3] & 2;
> 	middle =3D packet[3] & 4;
> }
>=20
> So with your patch for the devices in question the entire code flow
> becomes:
>=20
> 	left =3D packet[3] & 1;
> 	right =3D packet[3] & 2;
> 	middle =3D packet[3] & 4;
> 	left |=3D packet[3] & 1;
> 	right |=3D packet[3] & 2;
> 	middle |=3D packet[3] & 4;
>=20
> Which is not really helpful for the devices for which I added
> commit 92bac83dd:
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t/drivers/input/mouse/alps.c?id=3D92bac83dd79e60e65c475222e41a992a70434=
beb
>=20
> and will cause these devices to regress.
>=20
> Since Hans de Bruin's laptop is a Dell Latitude D430 and I saw
> the same problem and tested my patch on a Dell Latitude D630,
> it seems the use of the low bits of packet[0] to report the
> trackpoint buttons separately when the touchpad is active is
> a Dell specific thing, so I believe that a patch to only
> activate this code block on Dell's is the right solution for
> the regression Douglas is seeing.
>=20
> I'll write such a patch and post it shortly.
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20

Hans, can you check ec and e7 registers if are same or if they differs?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
