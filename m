From: Filip Wieladek <wattos@gmail.com>
Subject: Writing a Kernel driver for logitech G710+
Date: Sun, 12 May 2013 09:31:47 +0200
Message-ID: <CAKyRBAs4PHiBvYnW9RDjjmEZs22-5oXUYECp7EFDdYuOUQd5YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34681 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab3ELHcI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 May 2013 03:32:08 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so3665525pdj.40
        for <linux-input@vger.kernel.org>; Sun, 12 May 2013 00:32:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I wanted to implement a kernel level driver for the keyboard G710+. I
know that there was previous discussions here:
http://www.spinics.net/lists/linux-input/msg25572.html but these did
not lead to any results yet.

I have written my first draft of the keyboard driver (available here
https://github.com/Wattos/logitech-g710-linux-driver) and now have
couple of questions, since I am most likely doing some things
incorrectly since this is my first time writing a kernel driver.

Firstly, The device registers as two different hid devices with their
own driver each. One device gets the "real" keyboard presses, and the
other one gets the macro keys and is also responsible for
communicating with the keyboard (e.g. setting the led backlight
level).  That might not sound like a terribly big issue, but it
complicates things in user space. My guess is that it is due to the
interface descriptors ( lsusb output -
https://github.com/K900/g710/blob/master/lsusb). The problem in
userspace comes from the fact that I am surfacing additional
properties (e.g. setting backlight level...), and it is more
convoluted for the userspace program to pick the correct "device". It
would even become more complex with multiple of these (granted, I
don't think anyone connects two the same keyboards...)

Secondly, I am handling the raw even of the macro key manually.
Instead I have the feeling that I should be using input_mapping and
let the generic hid driver do its magic. The input events for the
macro keys look very similar to media buttons on the keyboard which
actually work out of the box. I have captured the calls to the
input_mapping here:
https://github.com/Wattos/logitech-g710-linux-driver/blob/master/info/keypresses
along with the raw events made by the keyboard. As previously
discussed, input mapping is being called for two devices. I think the
interesting output are the last lines :

usage->hid & HID_USAGE 0x3 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x3 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x3 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000
usage->hid & HID_USAGE 0x4 usage->hid & HID_USAGE_PAGE 0xff000000

but these look mostly the same without any distinction (most drivers
in the kernel source do not seem to have that issue and distinguish
the functionality on the HID_USAGE). Is there a better way to handle
the keyboard presses than manually in the kernel?

Thirdly, the keyboard seems to send out a keypress (keydown) event
when it is connected, but never a release event. This greatly confuses
userspace, blasting 6666 indefinitely. That is also why I have that
"first" event hack in the raw_event handler. Would there be a better
way of doing that?

Lest but not least, I would like the driver to be merged to upstream
once all the issues are ironed out. Would the driver have to be
integrated into lg.c or is it fine for it to be stand alone? Could you
also provide me with some generic feedback before I do a pull request
on github? I still need to change the formatting and coding style to
be conform with the other code, but apart from that, I would really
like to have some feedback. After all, this is my first effort in
writing a linux kernel driver.

I appreciate any input. Thanks,
Fil
