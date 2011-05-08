From: David Herrmann <dh.herrmann@googlemail.com>
Subject: HID generic-bluetooth driver
Date: Sun, 8 May 2011 12:16:06 +0200
Message-ID: <BANLkTi=tUNCMyCKVEXtv0W=8jYbK-k7HMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50699 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289Ab1EHKQH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 May 2011 06:16:07 -0400
Received: by vxi39 with SMTP id 39so4814691vxi.19
        for <linux-input@vger.kernel.org>; Sun, 08 May 2011 03:16:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Hi

I am currently working on a bluetooth HID device driver during GSoC
this summer and have a small problem. My dummy HID-driver does not get
bound on new devices. My dummy driver is available at:
https://github.com/dvdhrm/xwiimote/blob/master/driver/src/hid-nintendo.c

If a new bluetooth device with exactly these PID/VID values connects,
the generic-bluetooth HID driver gets bound instead of my hid-nintendo
driver. I checked /dev/hidrawX and it returns the same PID/VID values
as I specified in my driver so these are correct.
Also, if I use /sys/class/hid/drivers/generic-bluetooth/unbind and
.../nintendo/bind I can bind my driver manually to that device.

What can I do to lower the priority of generic-bluetooth or to push my
driver in front of generic-bluetooth?

Regards
David
