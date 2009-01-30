From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: hid-pidff bug: fails to find all required reports of saitek gamepad
Date: Fri, 30 Jan 2009 22:45:56 +0300
Message-ID: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:10479 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbZA3Tp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 14:45:59 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108466fgg.17
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2009 11:45:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, anssi.hannula@gmail.com

Hello!

After reading HID/PID specs I understood, that Saitek gamepads doesn't
require any driver -- they are PID compliant. Then, after loading
usbhid with debug messages enabled, I saw this:
[  773.716917] usbhid:hid-pidff: starting pid init
[  773.716947] usbhid:hid-pidff: found usage 0x21 from field->logical
[  773.716965] usbhid:hid-pidff: found usage 0x5a from field->logical
[  773.716983] usbhid:hid-pidff: found usage 0x73 from field->logical
[  773.717000] usbhid:hid-pidff: found usage 0x6e from field->logical
[  773.717018] usbhid:hid-pidff: found usage 0x77 from field->logical
[  773.717036] usbhid:hid-pidff: found usage 0x96 from field->logical
[  773.717075] usbhid:hid-pidff: found usage 0x7d from field->logical
[  773.717127] usbhid:hid-pidff: found usage 0x7f from field->logical
[  773.717155] usbhid:hid-pidff: 4 missing
[  773.717176] usbhid:hid-pidff: reports not ok, aborting

Definitely, HID descriptor parser has problems, which stops driver
from reading all reports. Here is hid descriptor of gamepad:
http://dmitriy.geels.googlepages.com/HIDDescriptor.html

I added some more debug messages:
http://dmitriy.geels.googlepages.com/debug.patch
Then got this:

[  773.716917] usbhid:hid-pidff: starting pid init
[  773.716937] usbhid:hid-pidff: checking field->logical == 0x000f0021
[  773.716947] usbhid:hid-pidff: found usage 0x21 from field->logical
[  773.716956] usbhid:hid-pidff: checking field->logical == 0x000f005a
[  773.716965] usbhid:hid-pidff: found usage 0x5a from field->logical
[  773.716974] usbhid:hid-pidff: checking field->logical == 0x000f0073
[  773.716983] usbhid:hid-pidff: found usage 0x73 from field->logical
[  773.716992] usbhid:hid-pidff: checking field->logical == 0x000f006e
[  773.717000] usbhid:hid-pidff: found usage 0x6e from field->logical
[  773.717009] usbhid:hid-pidff: checking field->logical == 0x000f0077
[  773.717018] usbhid:hid-pidff: found usage 0x77 from field->logical
[  773.717027] usbhid:hid-pidff: checking field->logical == 0x000f0096
[  773.717036] usbhid:hid-pidff: found usage 0x96 from field->logical
[  773.717045] usbhid:hid-pidff: checking field->logical == 0x00ff0302
[  773.717055] usbhid:hid-pidff: checking hid->collection[11].usage ==
0x00ff0302
[  773.717066] usbhid:hid-pidff: checking field->logical == 0x000f007d
[  773.717075] usbhid:hid-pidff: found usage 0x7d from field->logical
[  773.717084] usbhid:hid-pidff: checking field->logical == 0x00000000
[  773.717093] usbhid:hid-pidff: checking hid->collection[18].usage ==
0x00000000
[  773.717118] usbhid:hid-pidff: checking field->logical == 0x000f007f
[  773.717127] usbhid:hid-pidff: found usage 0x7f from field->logical
[  773.717136] usbhid:hid-pidff: checking field->logical == 0x000f0025
[  773.717145] usbhid:hid-pidff: checking field->logical == 0x000f008b
[  773.717155] usbhid:hid-pidff: 4 missing
[  773.717162] usbhid:hid-pidff: 5 missing
[  773.717169] usbhid:hid-pidff: 7 missing
[  773.717176] usbhid:hid-pidff: reports not ok, aborting

25, 8b? these are inside of required 0xab and 0x89 reports, and 0x90
is just ignored...

I don't understand yet, how to fix this bug, so I'm posting this to
maillist with hope on someones help.
