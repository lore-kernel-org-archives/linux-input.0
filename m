From: Daniel Eriksson <imerion@gmail.com>
Subject: [HP Pavilion x2 - 12-b003nf] Synaptics touchpad not configured by HID RMI
Date: Fri, 4 Nov 2016 02:05:53 +0100
Message-ID: <CALYLGY0iV=kJxKku2sY1CnpONjzi-FJcZEbVtaUGRJgKKZrHTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33096 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbcKDBFy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Nov 2016 21:05:54 -0400
Received: by mail-oi0-f47.google.com with SMTP id 128so124744954oih.0
        for <linux-input@vger.kernel.org>; Thu, 03 Nov 2016 18:05:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aduggan@synaptics.com, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org

Hi! I'm having some trouble with my touchpad, so I figured I'd send a
report. Details can be seen below.


[1.] One line summary of the problem:

Synaptics touchpad fail to be configured by HID RMI on a HP Pavilion
x2 (12-b003nf)


[2.] Full description of the problem/report:

Touchpad on the HP Pavilion X2 12" does nothing after boot. dmesg shows:

[    6.032160] hid-rmi 0003:06CB:7D29.0001: No 2D sensor found, giving up.
[    6.032273] hid-rmi 0003:06CB:7D29.0001: Error while initializing F11 (-19).
[    6.044758] hid-rmi 0003:06CB:7D29.0001: hiddev0,hidraw1: USB HID
v1.11 Mouse [SYNAPTICS Synaptics HIDUSB TouchPad V03] on
usb-0000:00:14.0-2.1/input0
[    6.044761] hid-rmi 0003:06CB:7D29.0001: Device failed to be
properly configured

Latest bios is installed.


[3.] Keywords


[4.] Kernel version

Linux version 4.8.6-040806-generic (kernel@tangerine) (gcc version
6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #201610310831 SMP Mon Oct 31
12:33:48 UTC 2016


[5.] Output of Oops.. message

Not applicable.


[6.] A small shell script or example program which triggers the problem

Not applicable. Problem always appears.
