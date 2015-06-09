From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH v2 0/2] Input: xpad: fix 360 wireless controller blinking LEDs
Date: Wed, 10 Jun 2015 00:56:17 +0200
Message-ID: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38398 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbbFIW43 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 18:56:29 -0400
Received: by wibdq8 with SMTP id dq8so29674250wib.1
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2015 15:56:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

this series is based on the changes discussed in
"[PATCH 0/7] Input: xpad: Fix wireless controller connection and leds".
It incorporates the discussed improvements, while leaving the conroversal parts out. 
So only the constantly blinking LED on the Xbox360 Wireless controller is fixed. 
But hopefully there is now a better chance to get this merged.

v2 changes:
- fix mail subject
- correct modulus in xpad_send_led_command

Pavel Rojtberg (1):
  Input: xpad: re-send LED command on present event

Pierre-Loup A. Griffais (1):
  Input: xpad: set the LEDs properly on XBox Wireless controllers

 drivers/input/joystick/xpad.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 12 deletions(-)

-- 
1.9.1

