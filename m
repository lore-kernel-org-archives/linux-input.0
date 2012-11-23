From: Arthur Skowronek <eisensheng@gmail.com>
Subject: PROBLEM: ACRUX USB GAMEPAD reports wrong value on axis 0 in certain state
Date: Fri, 23 Nov 2012 20:46:50 +0100
Message-ID: <CA+yuk4Z5PJzVc+r6hD6+eKM6QJt9tdUem9L1ROHg=TDAX1td9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50312 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab2KWTqv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 14:46:51 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so9216436obb.19
        for <linux-input@vger.kernel.org>; Fri, 23 Nov 2012 11:46:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear List,

I have 4 of the acrux usb game pad lying around here and all of them
show the same behavior.

[1.] One line summary of the problem:
The driver reports a bad value for the axis 0 whenever I move the
stick to far to the right and only this direction and only this axis
is affected.

[2.] Full description of the problem/report:
Whenever I move the 0 axis stick to far to the right, the driver
reports a value of -32767 to the program which is clearly wrong since
this value means the stick is far to the left. This is the only axis
affected by this strange behavior. This can also be seen on
<http://youtu.be/ZbTaqA1ROSY>.

[3.] Keywords (i.e., modules, networking, kernel):
Game pad, USB HID

[4.] Kernel version (from /proc/version):
Linux version 3.6.7-1-ARCH (tobias@T-POWA-LX) (gcc version 4.7.2 (GCC)
) #1 SMP PREEMPT Sun Nov 18 10:11:22 CET 2012

[7.] Environment
<http://pastebin.com/Y2eShgX0>

Thank you very much

Greetings,
Arthur S.
