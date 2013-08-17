From: Jason O <jason@projekt6.com>
Subject: [Dell Inspiron Inspiron 17R SE 7720] TouchPad detected as Generic
 Mouse
Date: Sat, 17 Aug 2013 01:07:09 -0400 (EDT)
Message-ID: <1992475041.148666.1376716029325.open-xchange@email.1and1.com>
Reply-To: Jason O <jason@projekt6.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.perfora.net ([74.208.4.194]:49410 "EHLO mout.perfora.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946Ab3HQFHL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 01:07:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have already done regression testing and opened bug reports for this bug. All
information can be found attached to the bug reports. I have tested the newest
mainline kernel and the problem still exists.

Laptop is a Dell Inspiron 17R SE.
Ubuntu: Started as 12.04, currently 13.04

>From Mainline Kernel 3.11-rc4

jason@jason-Inspiron-7720:~$ dmesg | grep Unknown
[ 20.512553] psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 50, EC=73 02
02

jason@jason-Inspiron-7720:~$ uname -a
Linux jason-Inspiron-7720 3.11.0-031100rc4-generic #201308041735 SMP Sun Aug 4
21:36:46 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux


Looking at the kernel source really quick, E7 has a match however EC does not
unless I missed something.


Bug reports

Launchpad
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1093237

kernel.org
https://bugzilla.kernel.org/show_bug.cgi?id=60739
