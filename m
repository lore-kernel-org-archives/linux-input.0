From: Philip Milev <milev.philip@gmail.com>
Subject: Tpad SYN1ef7 PNP0f13
Date: Thu, 9 Nov 2017 08:14:03 +0200
Message-ID: <CAOKfEHC3VkfcL1r6A=a0PEJ-xFNFVzM1aUZcXzQCLN__Kv45=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:49022 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbdKIGOF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Nov 2017 01:14:05 -0500
Received: by mail-wm0-f48.google.com with SMTP id p75so14687030wmg.3
        for <linux-input@vger.kernel.org>; Wed, 08 Nov 2017 22:14:05 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I can report the following for the 1ef7 touchpad:

[   11.464056] psmouse serio1: synaptics: queried max coordinates: x
[..5636], y [..4634]
[   11.494632] psmouse serio1: synaptics: queried min coordinates: x
[1360..], y [1298..]
[   11.494640] psmouse serio1: synaptics: Your touchpad (PNP: SYN1ef7
PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi
are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[   11.554756] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xf00123/0x840300/0x12e800/0x0, board id: 3114, fw
id: 1805562
[   11.592940] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio1/input/input9

My machine is hp envy 15 ah150na

Linux linuxbox 4.13.11-gentoo #14 SMP Wed Nov 8 21:08:01 EET 2017
x86_64 AMD A10-8700P Radeon R6, 10 Compute Cores 4C+6G AuthenticAMD
GNU/Linux

Please provide details if you need more information.

Thank you and keep up the good work!

Philip
