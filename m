From: Chris J Arges <chris.j.arges@canonical.com>
Subject: USB Creative Technology SB Arena Headset Quirk Question
Date: Tue, 31 Jul 2012 14:08:21 -0500
Message-ID: <50182D25.3080503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:57636 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab2GaTIW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 15:08:22 -0400
Received: from cpe-72-177-11-186.austin.res.rr.com ([72.177.11.186] helo=[192.168.11.3])
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <chris.j.arges@canonical.com>)
	id 1SwHnp-0004Hr-Gt
	for linux-input@vger.kernel.org; Tue, 31 Jul 2012 19:08:21 +0000
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,
I am trying to find the best way to resolve a hardware issue with a USB
Creative Technology SB Arena Headset (0x41e:0x403).

The headset also has buttons on it which register as a keyboard:
[252903.181] (II) XINPUT: Adding extended input device "Creative
Technology SB Arena Headset" (type: KEYBOARD, id 15)

When it is plugged in, it then starts sending button 3 presses for the
entire time it is plugged in causing input from other devices to not be
useable.

Here is the current bug with more information:
https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/1007575

I'd like to help fix this, and am wondering if it makes sense to quirk
the kernel HID driver, or rather quirk the X evdev module as was
suggested by another developer.

Thanks,
--chris j arges
