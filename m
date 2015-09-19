From: Aleksa Sarai <cyphar@cyphar.com>
Subject: MacBook8,1 (2015) HID Hardware Support
Date: Sun, 20 Sep 2015 03:10:16 +1000
Message-ID: <CAOviyajKA-s4Y6a5OfJmtO7H2Uc4bxCZ0dwCnAzA0K=odjegMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38819 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbbISRKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2015 13:10:17 -0400
Received: by igxx6 with SMTP id x6so35768748igx.1
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2015 10:10:17 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, jikos@kernel.org
Cc: Jochen Radmacher <jradmacher@gmx.de>, Yang Hongyang <burnef@gmail.com>, coldnew.tw@gmail.com, George Hilios <ghilios@gmail.com>, Janez Urevc <janez@janezurevc.name>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

I've been trying to get Linux installed on a MacBook8,1 (not the pro)
and have had trouble getting keyboard input to work, despite
a4a2c54560f2c57b88ba0283f141b44f594c2337 ("HID: apple: Add support for
the 2015 Macbook Pro") and d58069265c9d15c04c9e3832cd1d9dffe9d4d5f6
("Input: bcm5974 - add support for the 2015 Macbook Pro"). Even
compiling it into the kernel itself or forcing hid-apple module
loading in both initramfs and init did not help. One would assume (I
did) it's because the hardware is different to the MacBookPro12,1.
However, looking at the product and vendor ID:

Apple Internal Keyboard / Trackpad:

Product ID: 0x0272
Vendor ID: 0x05ac (Apple Inc.)
Version: 6.22
Manufacturer: Apple Inc.
Location ID: 0x01000000

It seems that this hardware was added to hid-apple as
USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI in both of the above linked
commits, so what gives? Is there some peculiarity with this hardware?
Am I not reading the above patches correctly? I'd be happy to test any
patches you'd like to throw at me.

-- 
Aleksa Sarai (cyphar)
www.cyphar.com
