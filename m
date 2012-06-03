From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Wiimote joystick reports no axes
Date: Sun, 3 Jun 2012 12:26:51 +0200
Message-ID: <CAOxFTcySV3g2ieHqnC312RneiAj_CzY7Nba7bMpKkqgbvyt3mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38459 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2FCK1M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jun 2012 06:27:12 -0400
Received: by vbbff1 with SMTP id ff1so2014534vbb.19
        for <linux-input@vger.kernel.org>; Sun, 03 Jun 2012 03:27:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@googlemail.com>

Hello,

I've recently started playing around with the new HID Wiimote driver,
and found out that the joystick device associated with the remote
reports no axes and 7 buttons (even in the latest linux git). I
believe that the reason for this is that the joystick is created for
the "Nintendo Wii Remote" device, but the actual axis information is
passed on by the "Nintendo Wii Remote Accelerometer" device. I would
have loved to provide a patch to fix this, but I can't grasp correctly
how the joystick device creation is delegated from hid.

-- 
Giuseppe "Oblomov" Bilotta
