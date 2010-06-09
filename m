From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Wed, 9 Jun 2010 01:30:14 -0700
Message-ID: <20100609083014.GA13304@core.coreip.homeip.net>
References: <4C0E0E51.8050709@tudelft.nl>
 <4C0ECA4C.9020806@tudelft.nl>
 <201006081737.43007.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47364 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab0FIIaV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Jun 2010 04:30:21 -0400
Received: by pvg16 with SMTP id 16so2379326pvg.19
        for <linux-input@vger.kernel.org>; Wed, 09 Jun 2010 01:30:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201006081737.43007.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, Jun 08, 2010 at 05:37:42PM -0700, Dmitry Torokhov wrote:
> On Tuesday, June 08, 2010 03:55:08 pm =C9ric Piel wrote:
> > Op 08-06-10 11:33, =C9ric Piel schreef:
> > > Hello,
> > > I haven't investigated much yet, but I have the feeling that sinc=
e
> > > 2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I =
press
> > > it (normally assigned to take screenshot in gnome), nothing happe=
ns (no
> > > input event received in userspace) and no key on the keyboard wor=
ks
> > > afterwards, until I press Alt. Actually the keys work, but behave=
 as if
> > > the sysrq key was kept pressed (can be seen in dmesg, or by press=
ing
> > > "b").
> > >=20
> > > Looking at the log, a potential culprit is commit
> > > 97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq =
as a
> > > separate input handler). Probably the logic of "have to press all=
 the
> > > keys at the same time" changed to "have to press the keys one aft=
er each
> > > other". So pressing alt and later on pressing PrintScreen leads t=
o a
> > > SysRq.
> > >=20
> > > Does anybody else see this behaviour? Any suggestion on how to so=
lve
> > > this bug? I'll try reverting the commit and report if it fixes th=
e
> > > problem (the git revert fails so I've got to fix the conflict man=
ually).
> >=20
> > I can confirm this regression is due to
> > 97f5f0cd8cd0a05449cbb77d1e6f02e026875802: the reverting patch below
> > fixes it. And, as long as you don't press alt since boot, PrintScre=
en
> > works fine. So it is likely due to not taking into account key rele=
ases.
> >=20
> > Dmitry, do you have a better fix? I'll be happy to test it if neede=
d.
> >=20
>=20
> Not yet, but I see the effects you are describing... Stay tuned...
>=20

Eric, could you tell me if the following fixes the problem for you?

Thanks!

--=20
Dmitry

Input: sysrq - fix "stuck" SysRq mode

This shoud fix the problem with SysRq mode staying half-way enabled
and interfereing with normal PrtScrn operation after user presses ALT
for the first time.

Reported-by: =C9ric Piel <E.A.B.Piel@tudelft.nl>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/sysrq.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)


diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index c046075..5bf3618 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -579,8 +579,12 @@ static bool sysrq_filter(struct input_handle *hand=
le, unsigned int type,
 	case KEY_RIGHTALT:
 		if (value)
 			sysrq_alt =3D code;
-		else if (sysrq_down && code =3D=3D sysrq_alt_use)
-			sysrq_down =3D false;
+		else {
+			if (sysrq_down && code =3D=3D sysrq_alt_use)
+				sysrq_down =3D false;
+
+			sysrq_alt =3D 0;
+		}
 		break;
=20
 	case KEY_SYSRQ:
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
