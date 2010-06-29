From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Tue, 29 Jun 2010 00:07:17 -0700
Message-ID: <20100629070717.GD19712@core.coreip.homeip.net>
References: <4C0E0E51.8050709@tudelft.nl>
 <201006192316.32360.rjw@sisk.pl>
 <4C1D4FA6.6030607@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35850 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab0F2HHY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 03:07:24 -0400
Content-Disposition: inline
In-Reply-To: <4C1D4FA6.6030607@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Jun 20, 2010 at 01:15:50AM +0200, =C9ric Piel wrote:
> Op 19-06-10 23:16, Rafael J. Wysocki schreef:
> > On Tuesday, June 08, 2010, =C9ric Piel wrote:
> >> Hello,
> >> I haven't investigated much yet, but I have the feeling that since
> >> 2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I p=
ress
> >> it (normally assigned to take screenshot in gnome), nothing happen=
s (no
> >> input event received in userspace) and no key on the keyboard work=
s
> >> afterwards, until I press Alt. Actually the keys work, but behave =
as if
> >> the sysrq key was kept pressed (can be seen in dmesg, or by pressi=
ng "b").
> >>
> >> Looking at the log, a potential culprit is commit
> >> 97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq a=
s a
> >> separate input handler). Probably the logic of "have to press all =
the
> >> keys at the same time" changed to "have to press the keys one afte=
r each
> >> other". So pressing alt and later on pressing PrintScreen leads to=
 a SysRq.
> >>
> >> Does anybody else see this behaviour? Any suggestion on how to sol=
ve
> >> this bug? I'll try reverting the commit and report if it fixes the
> >> problem (the git revert fails so I've got to fix the conflict manu=
ally).
> >=20
> > Is this still a problem with 2.6.35-rc3?
> The bug is still in 2.6.35-rc3. The patch that fixes this regression =
is
> in the "for-linus" branch of the input tree, but I think Dmitry hasn'=
t
> yet sent a pull request to Linus.
>=20

The fix should be in mainline now.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
