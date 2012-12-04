From: Arthur Skowronek <eisensheng@gmail.com>
Subject: Re: PROBLEM: ACRUX USB GAMEPAD reports wrong value on axis 0 in
 certain state
Date: Tue, 4 Dec 2012 23:23:36 +0100
Message-ID: <CA+yuk4Z7Tps=vnXqaieqQ-D3FZX=sB2W9hLMFUeOOP2wGkx9Dg@mail.gmail.com>
References: <CA+yuk4Z5PJzVc+r6hD6+eKM6QJt9tdUem9L1ROHg=TDAX1td9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42667 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2LDWXh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 17:23:37 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4514495oag.19
        for <linux-input@vger.kernel.org>; Tue, 04 Dec 2012 14:23:36 -0800 (PST)
In-Reply-To: <CA+yuk4Z5PJzVc+r6hD6+eKM6QJt9tdUem9L1ROHg=TDAX1td9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

unfortunately the problem is still there with linux 3.6.8 and using
any of available calibration tools (jstest, jstest-gtk) won't fix the
issue with the 0 axis. Please help me with this issue, thank you very
much.


Greetings,
Arthur

2012/11/23 Arthur Skowronek <eisensheng@gmail.com>:
> Dear List,
>
> I have 4 of the acrux usb game pad lying around here and all of them
> show the same behavior.
>
> [1.] One line summary of the problem:
> The driver reports a bad value for the axis 0 whenever I move the
> stick to far to the right and only this direction and only this axis
> is affected.
>
> [2.] Full description of the problem/report:
> Whenever I move the 0 axis stick to far to the right, the driver
> reports a value of -32767 to the program which is clearly wrong since
> this value means the stick is far to the left. This is the only axis
> affected by this strange behavior. This can also be seen on
> <http://youtu.be/ZbTaqA1ROSY>.
>
> [3.] Keywords (i.e., modules, networking, kernel):
> Game pad, USB HID
>
> [4.] Kernel version (from /proc/version):
> Linux version 3.6.7-1-ARCH (tobias@T-POWA-LX) (gcc version 4.7.2 (GCC)
> ) #1 SMP PREEMPT Sun Nov 18 10:11:22 CET 2012
>
> [7.] Environment
> <http://pastebin.com/Y2eShgX0>
>
> Thank you very much
>
> Greetings,
> Arthur S.
