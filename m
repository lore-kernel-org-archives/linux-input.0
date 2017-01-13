From: "Martyn Welch" <martyn.welch@collabora.co.uk>
Subject: =?utf-8?q?Fwd=3A?= USB Touchscreen displaying cursor in Weston
Date: Fri, 13 Jan 2017 17:04:05 +0000
Message-ID: <543c-58790880-77-7b732580@37883435>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56840 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdAMREG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Jan 2017 12:04:06 -0500
Received: from korma.collabora.co.uk (korma.collabora.co.uk [46.235.227.235])
        by bhuna.collabora.co.uk (Postfix) with ESMTP id 943C7264CFC
        for <linux-input@vger.kernel.org>; Fri, 13 Jan 2017 17:04:05 +0000 (GMT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Good start, typo in email address :-/

-------- Original Message -------- 
Subject: USB Touchscreen displaying cursor in Weston 
Date: Friday, 13 January, 2017 17:02 GMT 
From: "Martyn Welch" <martyn.welch@collabora.co.uk> 
To: inux-input@vger.kernel.org, linux-usb@vger.kernel.org 
 
 
I'm currently looking into an issue we are having with a USB touchscreen controller causing Weston to display a cursor when plugged in.

The device is an "Elo TouchSystems 2216 AccuTouch USB Touchmonitor Interface", which is being handled by hid-generic.

Weston (via libinput) is detecting this device as a mouse:

Jan 12 12:38:36 GE00409729044C weston[387]: [12:38:36.674] input device 'EloTouchSystems,Inc Elo TouchSystems 2216 AccuTouch® USB Touchmonitor Interface', /dev/input/event5 is tagged by udev as: Mouse
Jan 12 12:38:36 GE00409729044C weston[387]: [12:38:36.676] input device 'EloTouchSystems,Inc Elo TouchSystems 2216 AccuTouch® USB Touchmonitor Interface', /dev/input/event5 is a pointer caps

Looking at the device capabilities and properties:

    # cat /sys/class/input/event5/device/capabilities/abs
    100 3
    # cat /sys/class/input/event5/device/capabilities/key
    10000 0 0 0 0 0 0 0 0
    # cat /sys/class/input/event5/device/properties 
    0

I think I'm right in saying that this device is providing ABS_X, ABS_Y, ABS_MISC and BTN_LEFT (or BTN_MOUSE as they are the same code).

So, looking at the code paths in libinput I believe this is being detected as a "VMware's USB mouse".

>From what I understand, a touchscreen should be claiming BTN_TOUCH rather than BTN_LEFT, which seems to be the case as a second device that I have access to (Dialogue Technology Corp. PenMount USB) which is working.

I see that the PenMount device has a routine that patches up some of the button mapping. Is that what I need to do for this device as well?

Thanks in advance,

Martyn

