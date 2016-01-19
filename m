From: Andrea <andrea.deangelis93@gmail.com>
Subject: keyboard problem on linux
Date: Tue, 19 Jan 2016 14:34:26 +0100
Message-ID: <569E3B62.6050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38322 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbcASNec (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 08:34:32 -0500
Received: by mail-wm0-f53.google.com with SMTP id b14so171307991wmb.1
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2016 05:34:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

[1.] i've a problem with keyboard of my notebook HP Pavilion 15 ab062nl; 
CTRL SHIFT and ALT buttons not works as they should. in particular, it 
is as if these keys are pressed and released alone.
isn't an hardware problem, because on windows 10 and windows 8.1 i 
haven't these problems, is only a linux problem (all distro).

[2.] the bug is always active, every time i start a linux Distro (also 
from live, and also without DE/WM) i've this problem with keyboard, the 
only way to fix temporarily the bug, is pressing the only Left SHIFT key 
for some seconds, then all problems disappear indefinitely, and in any 
case, if i shutdown or if i reboot the PC, the problem recurs.
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1532746

[4.] this is the output of "cat /proc/version" command using the last 
mainline kernel version:

Linux version 4.4.0-040400-lowlatency (kernel@gomeisa) (gcc version 
5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2) ) #201601101930 SMP PREEMPT Mon 
Jan 11 00:38:46 UTC 201

[5.] i haven't Oops error messages
