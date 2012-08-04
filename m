From: Bernard GODARD <bernard.godard@gmail.com>
Subject: 1A34:0802 acrux gamepad is not initialized if plugged in at boot time
Date: Sat, 4 Aug 2012 15:51:00 +0200
Message-ID: <CAFxvmmdQ3=TohcYn+Bg-tNP0YGqxhobF8BvwyzjyPaj2nzdxbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:35066 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab2HDNvB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Aug 2012 09:51:01 -0400
Received: by ghrr11 with SMTP id r11so1626776ghr.19
        for <linux-input@vger.kernel.org>; Sat, 04 Aug 2012 06:51:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

This problem was initially reported here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1019587

acrux gamepad is not initialized if present at boot time. Error
message "can't reset device" appears continuously in dmesg:

[  254.607949] acrux 0003:1A34:0802.0002: can't reset device,
0000:00:1d.3-1/input0, status -32

Temporary solution is to unplug device and plug it in again. Also
there is no problem if the device is plugged in when the computer is
already in use.
Otherwise the device works well (including force feedback).

This problem has been present in several kernel versions including 3.0 and 3.5.

Let me know if you would like me to provide any additional information
or if you would like me to run some particular tests.

Thank you,
