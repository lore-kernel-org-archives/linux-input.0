From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Sat, 19 Jun 2010 23:16:32 +0200
Message-ID: <201006192316.32360.rjw@sisk.pl>
References: <4C0E0E51.8050709@tudelft.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C0E0E51.8050709@tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?q?=C3=89ric_Piel?= <E.A.B.Piel@tudelft.nl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tuesday, June 08, 2010, =C3=89ric Piel wrote:
> Hello,
> I haven't investigated much yet, but I have the feeling that since
> 2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I pres=
s
> it (normally assigned to take screenshot in gnome), nothing happens (=
no
> input event received in userspace) and no key on the keyboard works
> afterwards, until I press Alt. Actually the keys work, but behave as =
if
> the sysrq key was kept pressed (can be seen in dmesg, or by pressing =
"b").
>=20
> Looking at the log, a potential culprit is commit
> 97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq as a
> separate input handler). Probably the logic of "have to press all the
> keys at the same time" changed to "have to press the keys one after e=
ach
> other". So pressing alt and later on pressing PrintScreen leads to a =
SysRq.
>=20
> Does anybody else see this behaviour? Any suggestion on how to solve
> this bug? I'll try reverting the commit and report if it fixes the
> problem (the git revert fails so I've got to fix the conflict manuall=
y).

Is this still a problem with 2.6.35-rc3?

Rafael
