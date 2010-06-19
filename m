From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Sun, 20 Jun 2010 01:15:50 +0200
Message-ID: <4C1D4FA6.6030607@tudelft.nl>
References: <4C0E0E51.8050709@tudelft.nl> <201006192316.32360.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:51558 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0FSXPz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jun 2010 19:15:55 -0400
In-Reply-To: <201006192316.32360.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Op 19-06-10 23:16, Rafael J. Wysocki schreef:
> On Tuesday, June 08, 2010, =C3=89ric Piel wrote:
>> Hello,
>> I haven't investigated much yet, but I have the feeling that since
>> 2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I pre=
ss
>> it (normally assigned to take screenshot in gnome), nothing happens =
(no
>> input event received in userspace) and no key on the keyboard works
>> afterwards, until I press Alt. Actually the keys work, but behave as=
 if
>> the sysrq key was kept pressed (can be seen in dmesg, or by pressing=
 "b").
>>
>> Looking at the log, a potential culprit is commit
>> 97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq as =
a
>> separate input handler). Probably the logic of "have to press all th=
e
>> keys at the same time" changed to "have to press the keys one after =
each
>> other". So pressing alt and later on pressing PrintScreen leads to a=
 SysRq.
>>
>> Does anybody else see this behaviour? Any suggestion on how to solve
>> this bug? I'll try reverting the commit and report if it fixes the
>> problem (the git revert fails so I've got to fix the conflict manual=
ly).
>=20
> Is this still a problem with 2.6.35-rc3?
The bug is still in 2.6.35-rc3. The patch that fixes this regression is
in the "for-linus" branch of the input tree, but I think Dmitry hasn't
yet sent a pull request to Linus.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
