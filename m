From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [Regression 2.6.35-rc1?] Sysrq works too well (no need of alt)
Date: Tue, 08 Jun 2010 11:33:05 +0200
Message-ID: <4C0E0E51.8050709@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:43542 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0FHJdJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jun 2010 05:33:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Hello,
I haven't investigated much yet, but I have the feeling that since
2.6.35-rc1 my "Print Screen/SysRq" key works only as SysRq: if I press
it (normally assigned to take screenshot in gnome), nothing happens (no
input event received in userspace) and no key on the keyboard works
afterwards, until I press Alt. Actually the keys work, but behave as if
the sysrq key was kept pressed (can be seen in dmesg, or by pressing "b").

Looking at the log, a potential culprit is commit
97f5f0cd8cd0a05449cbb77d1e6f02e026875802 (Input: implement SysRq as a
separate input handler). Probably the logic of "have to press all the
keys at the same time" changed to "have to press the keys one after each
other". So pressing alt and later on pressing PrintScreen leads to a SysRq.

Does anybody else see this behaviour? Any suggestion on how to solve
this bug? I'll try reverting the commit and report if it fixes the
problem (the git revert fails so I've got to fix the conflict manually).

Cheers,
Eric
