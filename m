From: Alessandro Fachin <alessandro.fachin@gmail.com>
Subject: wireless logitech rumblepad 2 and hid|udev problem
Date: Tue, 7 Oct 2014 11:03:48 +0200
Message-ID: <BEC3C426-9647-4DE2-B540-FCD061156984@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:55391 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbaJGJDv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 05:03:51 -0400
Received: by mail-wi0-f182.google.com with SMTP id n3so7163538wiv.3
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 02:03:50 -0700 (PDT)
Received: from alessandros-air.lan (adsl-ull-105-175.51-151.net24.it. [151.51.175.105])
        by mx.google.com with ESMTPSA id au4sm19936228wjc.15.2014.10.07.02.03.49
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 02:03:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I=92m encountering many problems getting work a logitech wireless contr=
oller on my QNAP.
It works properly on my laptop with a centos7 kernel 3.10:
udevd =97debug -> http://pastebin.com/nCPahDYJ=20
If I try to press any buttons I can see the correctly events  works che=
cking "cat /dev/input/event7=94

But if I try to connect to my QNAP device kernel 3.12.6 I get:
udevd -debug ->  http://pastebin.com/km5nmtxp
Any /dev/input/event* doesn=92t receive input from buttons that I press=
ed.
I also try to import all udevd*rules from centos to qnap but I have the=
 same results!

The dmesg output is the same:
http://pastebin.com/0UKuwAVx

I recompile the QNAP kernel (x86) to have the same kernel configuration=
:

# HID support
#
CONFIG_HID=3Dy
CONFIG_HID_BATTERY_STRENGTH=3Dy
CONFIG_HIDRAW=3Dy
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=3Dy
CONFIG_HID_LOGITECH=3Dy
#
# USB HID support
#
CONFIG_USB_HID=3Dy
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy

On both system the joystick support is disabled.

Any suggests will be appreciated! Best regards.=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
