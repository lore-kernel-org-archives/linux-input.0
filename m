From: Boris Savelev <boris.savelev@gmail.com>
Subject: keyboard doesn't work with acpi on lenovo s10-3c
Date: Sat, 27 Nov 2010 20:28:51 +0300
Message-ID: <AANLkTimZxNOuuK2+uEUF_RbHus1dgFRA6usMuYzrGjoD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51798 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab0K0R3O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 12:29:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Hello!

When I run linux on my netbook lenovo s10-3c -- keyboard doesn't work!
keyboard works perfectly in bios, in grub (or lilo), in windows, but
not in linux.
I try linux kernel 2.6.35, 2.6.36, 2.6.37-rc2 -- no way. keyboard doesn't work
I upgrade BIOS up to 3CCN13WW. keyboard doesn't work
All keys are disabled, numlock, capslock... It's seems like keyboard
haven't power.
with Google I find topic [1] where solution is add to kernel opts
'noapic acpi=off' -- Viola! keyboard work. But battery state,
powersaving, powerbutton and other usefull things doesn't work.
So this is not a workaround...
Also I try all variants for kernel opts from [2] -- keyboard works
only with 'noapic acpi=off'
I report bug in ubuntu [3] where you can see dmesg and other usefull
thinks about my problem.
What I can do for my netbook?
How can I help to make linux better?-)

Links:
[1] http://s10lenovo.com/viewtopic.php?f=47&t=4482
[2] https://wiki.ubuntu.com/DebuggingACPI
[3] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/677633

-- 
Boris
