From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [GIT PULL][for 3.8] pull request from arch-pxa tree on input/keyboard branch
Date: Wed, 21 Nov 2012 13:34:58 +0800
Message-ID: <CAN1soZzDgmGDypbTMiFt+44xO=ZCeojHiyReaPO=vzv+Dpwz+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52788 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2KUFe7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 00:34:59 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so2077771eek.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 21:34:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Dmitry,

Please help to merge input/keyboard branch from arch-pxa git tree.
There's one patch on pxa27x keypad driver.

Regards
Haojian

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git input/keyboard

for you to fetch changes up to ff77736d37ff68c5323e2d1e3bc8d38235325aeb:

  input: pxa27x_keypad: clear initial pending interrupt (2012-11-21
13:31:25 +0800)

----------------------------------------------------------------
Vasily Khoruzhick (1):
      input: pxa27x_keypad: clear initial pending interrupt

 drivers/input/keyboard/pxa27x_keypad.c |    3 +++
 1 file changed, 3 insertions(+)
