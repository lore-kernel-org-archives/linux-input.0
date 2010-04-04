From: Alexander Lam <lambchop468@gmail.com>
Subject: Bug: Short reset of ps/2 mouse causes Synaptics touchpad misdetection
Date: Sun, 4 Apr 2010 11:58:06 -0400
Message-ID: <s2ydfb03c971004040858p6872d1f4p3fc0f8dac1fbd2e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43384 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563Ab0DDP61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Apr 2010 11:58:27 -0400
Received: by gwb19 with SMTP id 19so844778gwb.19
        for <linux-input@vger.kernel.org>; Sun, 04 Apr 2010 08:58:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

Please CC: me when replying

I have filed a bug on the kernel bug tracker, #15636,
https://bugzilla.kernel.org/show_bug.cgi?id=15636.

Description:
The commit
     commit 4a299bf591bc5bef3bde8316e603b9eaec5a7696
     author:    Dmitry Torokhov <dmitry.torokhov@gmail.com>
     date:    Fri, 25 Dec 2009 05:40:24 +0000 (21:40 -0800)
     Input: speed up suspend/shutdown for PS/2 mice and keyboards

     Instead of doing full-blown reset while suspending or shutting down
     the box use lighter form of reset that should take less time.

(I didn't do a full bisection, but I reversed this just this commit on a hunch,
and it made my problems go away)

Causes ~50% misdetection rate of the Synaptics touchpad upon reboot on an Acer
Aspire One AOA150.

Sometimes, the touchpad is detected as a plain mouse, and sometimes it is
detected as a Synaptics device.

Relevant dmesg sections:
Good Boot:
Mar  6 12:29:30 lamtop kernel: [    3.201052] Synaptics Touchpad, model: 1, fw:
7.2, id: 0x1c0b1, caps: 0xd04771/0xa40000
Mar  6 12:29:30 lamtop kernel: [    3.263016] input: SynPS/2 Synaptics TouchPad
as /devices/platform/i8042/serio2/input/input6


Bad Boot:
Feb 12 08:16:12 lamtop kernel: [    4.060365] input: PS/2 Generic Mouse as
/devices/platform/i8042/serio2/input/input6


I am posting this to the list because there hasn't been any movement on this
bug since last week when it was filed. It also appears that the server
hosting the mailing list that the kernel input bugs are assigned to is down
(no ping, no nmap results to email ports)

--
Alexander Lam
