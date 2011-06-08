From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Wed, 8 Jun 2011 18:33:20 +0800
Message-ID: <BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
	<20110602144146.GB3508@nautilus.holoscopio.com>
	<BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
	<20110603124428.GA2379@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:56604 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab1FHKdV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jun 2011 06:33:21 -0400
Received: by yie30 with SMTP id 30so115356yie.19
        for <linux-input@vger.kernel.org>; Wed, 08 Jun 2011 03:33:20 -0700 (PDT)
In-Reply-To: <20110603124428.GA2379@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

2011/6/3 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> You should use the device capabilities, like what events it does
> generate. If it does generate X and Y axis events, that's the right
> device.

Did you mean ABS_X and ABS_Y? Actually it is.
The android framework detects the touch device by:

    // Is this an old style single-touch driver?
     if (test_bit(BTN_TOUCH, key_bitmask)
             && test_bit(ABS_X, abs_bitmask) && test_bit(ABS_Y, abs_bitmask)) {
         device->classes |= CLASS_TOUCHSCREEN;
     }

However, the output of getevent -p shows

add device 2: /dev/input/event7
  name:     "HID TOUCH HID Touch Panel"
  events:
    SYN (0000): 0000  0001  0003  0004
    KEY (0001): 0110  0111  0112
    ABS (0003): 0000  value 1428, min 0, max 4095, fuzz 0 flat 0
                0001  value 1066, min 0, max 4095, fuzz 0 flat 0
    MSC (0004): 0004

add device 3: /dev/input/event6
  name:     "HID TOUCH HID Touch Panel"
  events:
    SYN (0000): 0000  0001  0003  0004
    KEY (0001): 0140  014a  014b
    ABS (0003): 0000  value 0, min 0, max 4095, fuzz 0 flat 0
                0001  value 0, min 0, max 4095, fuzz 0 flat 0
    MSC (0004): 0004

Only event6 supports BTN_TOUCH, so it is detected
as the touch device. However, that's wrong --
event7 is the right touch device.

By removing the check test_bit(BTN_TOUCH, key_bitmask),
event7 is correctly detected and touchscreen now works.

But I still have questions:

* Is it intended to NOT support BTN_TOUCH in event7?
* Why two devices are detected by the kernel,
  while there is only one touchscreen?

-- 
Chih-Wei
Android-x86 project
http://www.android-x86.org
