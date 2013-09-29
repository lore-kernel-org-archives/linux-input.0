From: "v1kt0p.rus@gmail.com" <v1kt0p.rus@gmail.com>
Subject: How write driver for gamepad, that detected by usbhid but not work
 correctly?
Date: Sun, 29 Sep 2013 12:22:48 +0300
Message-ID: <5247F168.10008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:64857 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab3I2JWw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Sep 2013 05:22:52 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so2063861eek.28
        for <linux-input@vger.kernel.org>; Sun, 29 Sep 2013 02:22:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have "Genesis to USB adapter" and two genesis gamepads. On windows it 
is work correctly. On linux do not work "left" and "up" buttons on 
D-pad, and two gamepads appear as one with double buttons.
At first I tried to write usb driver(usb_register), but when I connect 
gamepad system choose usbhid driver not my. When I unplug gamepad system 
call "probe" in my driver, but then immediately call "disconnect". Is 
there a way to force the system to choose my driver first?
Than I tried to write hid driver(hid_register_driver), but "probe" is 
not called. I can not find documentation describing how to make a 
working driver for hid, it exists at all?
What is the correct way to write a driver for the gamepad? What am I 
doing wrong?
