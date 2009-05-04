From: =?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?=
	<sergey.belyashov@gmail.com>
Subject: Autocentering support for Logitech G25 Racing Wheel and others with
	ID 046d:c294
Date: Mon, 4 May 2009 13:01:02 +0400
Message-ID: <bb829a0b0905040201r7623ddcam2601ce9f92939c20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:56449 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbZEDJBE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 May 2009 05:01:04 -0400
Received: by ewy24 with SMTP id 24so3728812ewy.37
        for <linux-input@vger.kernel.org>; Mon, 04 May 2009 02:01:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hello
     Some months ago I send patch which adds autocentering for
Logitech MOMO Wheel. Now I have access to Logitech G25 Racing Wheel
and test autocentering for it. I write patch for current kernel to
support autocentering for G25 in legacy mode (this device supports
other modes, but after switching device reconnects with ID 0xc299 and
FF support comes out) and others Logitech (Driving Force, Formula
Force Ex etc) wheels with ID 046d:c294.

========================================================================================
--- linux-source/drivers/hid/hid-lgff.c  2008-12-25 02:26:37.000000000 +0300
+++ linux-source/drivers/hid/hid-lgff.c.old      2009-04-24
12:31:26.000000000 +0400
@@ -61,7 +61,7 @@
        { 0x046d, 0xc219, ff_rumble },
        { 0x046d, 0xc283, ff_joystick },
        { 0x046d, 0xc286, ff_joystick },
-       { 0x046d, 0xc294, ff_joystick },
+       { 0x046d, 0xc294, ff_wheel },
        { 0x046d, 0xc295, ff_joystick },
        { 0x046d, 0xca03, ff_wheel },
 };

========================================================================================
Signed-off-by: Sergey Belyashov <Sergey.Belyashov@gmail.com>
