From: Jonathan Beilharz <greenbigfrog@gmail.com>
Subject: X-Box One Controler (Covert Forces) no Input/Static Input
Date: Sat, 5 Dec 2015 15:12:48 +0100
Message-ID: <5662F0E0.7020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33452 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbLEOMv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Dec 2015 09:12:51 -0500
Received: by wmec201 with SMTP id c201so110362290wme.0
        for <linux-input@vger.kernel.org>; Sat, 05 Dec 2015 06:12:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, pavel@rojtberg.net

I own a "Covert Forces edition of the Xbox One controller".

The controller gets detected as the Covert Forces Controller with right 
amount of Axes and buttons but the Input (if I look at it with jstest) 
is static/ doesn't change when I move the axes or click the buttons. I 
also tried Calibrating.

Steps to reproduce:
1. Connect a "Covert Forces X-box Controller"
2. start "jstest"
3. Output is static

Example Output:
$ jstest /dev/input/js0
Driver version is 2.1.0.
Joystick (Microsoft X-Box One pad (Covert Forces)) has 8 axes (X, Y, Z, 
Rx, Ry, Rz, Hat0X, Hat0Y)
and 11 buttons (BtnX, BtnY, BtnTL, BtnTR, BtnTR2, BtnSelect, BtnThumbL, 
BtnThumbR, ?, ?, ?).
Testing ... (interrupt to exit)
Axes:  0:     0  1:     0  2:-32767  3:     0  4:     0  5:-32767 6:     
0  7:     0 Buttons:  0:off  1:off  2:off  3:off  4:off 5:off  6:off  
7:off  8:off  9:off 10:off


It would be great if someone would be able to look into this.
