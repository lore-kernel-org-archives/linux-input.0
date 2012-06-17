From: Apostolos Bartziokas <barz621@gmail.com>
Subject: Possible bug in HID Logitech Unifying receivers
Date: Sun, 17 Jun 2012 10:23:54 +0300
Message-ID: <4FDD860A.8040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56185 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab2FQHY3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jun 2012 03:24:29 -0400
Received: by weyu7 with SMTP id u7so2944728wey.19
        for <linux-input@vger.kernel.org>; Sun, 17 Jun 2012 00:24:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello

I am having trouble with my logitech mouse which comes with a unifying 
receiver.

The mouse is not recognized on boot and i have to unplug replug the 
receiver multiple times in some cases. I tried it on an older kernel 
(2.6 series) that i had available and it worked just fine.

This problem was present in 3.3.8 and in the 3.4.2 kernel. The problem 
was also reported in Ubuntu: https://bugs.launchpad.net/ubuntu/+bug/958174

My dmesg read something like after the problem occurred:

dmesg | grep -i logitech
[    4.146194] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw2:
USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:05:00.0-1/input2
[   31.374886] logitech-djreceiver 0003:046D:C52B.0008: hiddev0,hidraw2:
USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:05:00.0-2/input2
[   40.383383] logitech-djreceiver 0003:046D:C52B.000B: hiddev0,hidraw2:
USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:05:00.0-1/input2
[   60.006344] logitech-djreceiver 0003:046D:C52B.000E: hiddev0,hidraw2:
USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:05:00.0-2/input2
[   60.015325] input: Logitech Unifying Device. Wireless PID:101a as
/devices/pci0000:00/0000:00:1c.4/0000:05:00.0/usb3/3-2/3-2:1.2/0003:046D:C52B.000E/input/input14 

[   60.015571] logitech-djdevice 0003:046D:C52B.000F: input,hidraw3: USB
HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:101a] on
usb-0000:05:00.0-2:1

Thanks in advance
