From: Arkadiusz =?utf-8?q?Mi=C5=9Bkiewicz?= <a.miskiewicz@gmail.com>
Subject: autodetecting usb keyboard and required modules from shell
Date: Fri, 14 Oct 2011 23:08:33 +0200
Message-ID: <201110142308.33646.a.miskiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58810 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab1JNVIh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Oct 2011 17:08:37 -0400
Received: by eye27 with SMTP id 27so1524668eye.19
        for <linux-input@vger.kernel.org>; Fri, 14 Oct 2011 14:08:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hi,

I'm trying to find a simple way to detect that usb keyboard is being us=
ed in=20
running system (so the required modules are already loaded etc) and the=
n=20
figure out which modules drive that keyboard.

The hard part is that I'm trying to do that from shell by simply lookin=
g into=20
procfs or sysfs. (no usbutils, no udev available).

/proc/bus/input/devices looks like good place to start but how to disti=
nguish=20
keyboards there from other devices (for example my usb keyboard is name=
d=20
"Winbond Electronics Corp Hermon USB hidmouse Device" there) ?

I see that kernel reports some keyboards as "USB HID v1.00 Keyboard" fo=
r=20
example but does it report that info somewhere in sysfs?

Any hints welcome.

Thanks,
--=20
Arkadiusz Mi=C5=9Bkiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
