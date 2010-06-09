From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Tue, 8 Jun 2010 17:37:42 -0700
Message-ID: <201006081737.43007.dmitry.torokhov@gmail.com>
References: <4C0E0E51.8050709@tudelft.nl> <4C0ECA4C.9020806@tudelft.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56626 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0FIAhs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jun 2010 20:37:48 -0400
Received: by pvg16 with SMTP id 16so2251876pvg.19
        for <linux-input@vger.kernel.org>; Tue, 08 Jun 2010 17:37:48 -0700 (PDT)
In-Reply-To: <4C0ECA4C.9020806@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tuesday, June 08, 2010 03:55:08 pm =C3=89ric Piel wrote:
> Op 08-06-10 11:33, =C3=89ric Piel schreef:
> > Hello,
> > I haven't investigated much yet, but I have the feeling that since
> > 2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I pr=
ess
> > it (normally assigned to take screenshot in gnome), nothing happens=
 (no
> > input event received in userspace) and no key on the keyboard works
> > afterwards, until I press Alt. Actually the keys work, but behave a=
s if
> > the sysrq key was kept pressed (can be seen in dmesg, or by pressin=
g
> > "b").
> >=20
> > Looking at the log, a potential culprit is commit
> > 97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq as=
 a
> > separate input handler). Probably the logic of "have to press all t=
he
> > keys at the same time" changed to "have to press the keys one after=
 each
> > other". So pressing alt and later on pressing PrintScreen leads to =
a
> > SysRq.
> >=20
> > Does anybody else see this behaviour? Any suggestion on how to solv=
e
> > this bug? I'll try reverting the commit and report if it fixes the
> > problem (the git revert fails so I've got to fix the conflict manua=
lly).
>=20
> I can confirm this regression is due to
> 97f5f0cd8cd0a05449cbb77d1e6f02e026875802: the reverting patch below
> fixes it. And, as long as you don't press alt since boot, PrintScreen
> works fine. So it is likely due to not taking into account key releas=
es.
>=20
> Dmitry, do you have a better fix? I'll be happy to test it if needed.
>=20

Not yet, but I see the effects you are describing... Stay tuned...

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
