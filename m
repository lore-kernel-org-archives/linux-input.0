From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Input+S3: extra keycodes forgotten after suspend
Date: Tue, 27 May 2008 01:52:24 -0400
Message-ID: <200805270152.25744.dtor@insightbb.com>
References: <200805162225.44284.bonbons@linux-vserver.org> <20080523044430.GA9809@anvil.corenet.prv> <20080523225714.3f0953f3@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:39653
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753829AbYE0Fwa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 May 2008 01:52:30 -0400
In-Reply-To: <20080523225714.3f0953f3@neptune.home>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>

On Friday 23 May 2008 16:57, Bruno Pr=C3=A9mont wrote:
> On Fri, 23 May 2008 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote=
:
> > > Ah, ok, great.. I think we simply need to move dritek out of the
> > > place where you put it in so it does not interfere with our effor=
ts
> > > to resume keyboard and mouse ;) I will see what I can do there..
> > >=20
> >=20
> > So what about the patch below? Does it work for you?
> >=20
> > Thanks!
>=20
> Hi Dmitry,
>=20
> Yes, this patch works for me (in combination with
> http://lkml.org/lkml/2008/5/16/430 ), see attached boot+suspend&resum=
e
> log.
>=20
> You will eventually note the following lines during resume process:
> ...
> [ =C2=A0150.588965] /usr/src/linux-2.6.25.4-orig/drivers/input/serio/=
i8042.c: 60 -> i8042 (command) [15985]
> [ =C2=A0150.588965] /usr/src/linux-2.6.25.4-orig/drivers/input/serio/=
i8042.c: 47 -> i8042 (parameter) [15985]
> [ =C2=A0150.588965] /usr/src/linux-2.6.25.4-orig/drivers/input/serio/=
i8042.c: 00 <- i8042 (interrupt, 0, 0) [15985]
> [ =C2=A0150.588965] atkbd.c: Unknown key pressed (translated set 2, c=
ode 0x0 on isa0060/serio0).
> [ =C2=A0150.588965] atkbd.c: Use 'setkeycodes 00 <keycode>' to make i=
t known.
> [ =C2=A0150.588965] /usr/src/linux-2.6.25.4-orig/drivers/input/serio/=
i8042.c: f2 -> i8042 (kbd-data) [15985]
> [ =C2=A0150.609410] /usr/src/linux-2.6.25.4-orig/drivers/input/serio/=
i8042.c: fa <- i8042 (interrupt, 0, 1) [15987]
> ...
>=20

I see. Could you please try the patch below (in addition to the other
2 you have) and see if that 00 keycode is still reported?

Thanks!=20

--=20
Dmitry

Input: atkbd - mark keyboard as disabled when suspending/unloading

This will shut off garbage that may come from KBD port during resume.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/keyboard/atkbd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: work/drivers/input/keyboard/atkbd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work.orig/drivers/input/keyboard/atkbd.c
+++ work/drivers/input/keyboard/atkbd.c
@@ -807,6 +807,8 @@ static int atkbd_activate(struct atkbd *
 static void atkbd_cleanup(struct serio *serio)
 {
 	struct atkbd *atkbd =3D serio_get_drvdata(serio);
+
+	atkbd_disable(atkbd);
 	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_BAT);
 }
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
