From: Artem Serebriyskiy <v.for.vandal@gmail.com>
Subject: [BUG 188481] Thinkpad Helix 2 - some special keys on keyboard has
 same scancode
Date: Sat, 26 Nov 2016 01:57:16 +0300
Message-ID: <CAJU16cM0+av6d61Q1P+6PM9P-btG45Lc_t_ruP5EB_zUAFHbbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33642 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbcKYXKG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 18:10:06 -0500
Received: by mail-oi0-f67.google.com with SMTP id f201so6635987oib.0
        for <linux-input@vger.kernel.org>; Fri, 25 Nov 2016 15:10:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi!
I've created a bug 188481
(https://bugzilla.kernel.org/show_bug.cgi?id=188481) and was told
there to write a message to linux-input mailing list. Text bellow is a
copy of bug description. All attachments are in bugzilla.

I have a notebook Thinkpad Helix 2nd gen with Ultrabook Pro Keyboard.
Some special Fn-FX keys are not working.


The basic structure is:

Keyboard has 11 special keys - Fn-F1 -> Fn-F12, without Fn-F11
Not working are - Fn-F4, F7, F8, F9, F10, F12

keyboard is a USB device (ID 17ef:6067) with 2 interfaces. One
interface reports ordinary qwerty keys, another - special keys. Both
interfaces are handled by usbhid driver. lsusb log is attached, quick
jump by searching word 'Lenovo' (without quotation marks)

Two eventX are present in /dev/input.

To find out why some keys aren't working, I did the following:

1. Run evemu-record. (Log is attached). No problems with qwerty part.
For special keys it reports correct scancode\keycode pair for working
keys, and it reports the same scancode 786433 for every non-working
special key. Thus, I can't create a rule in udev. The reported keycode
for every such special key is 240 (UNKNOWN). Attached log contains
data for all 11 keypresses.

2. Run xev, showkey, showkey -s - every utility follow the same behavior.

3. Run wireshark over usbmon. (log is attached.). Wireshask shows that
usb data is different  for every key, including those that do not
work. Below is the "Leftover Capture Data" for every special key:
Fn-F1   - 03 02 00 00
Fn-F2   - 03 04 00 00
Fn-F3   - 03 08 00 00
!>Fn-F4 - 03 00 02 00
Fn-F5   - 03 20 00 00
Fn-F6   - 03 40 00 00
!>Fn-F7 - 03 00 20 00
!>Fn-F8 - 03 00 40 00
!>Fn-F9 - 03 00 04 00
!>Fn-F10- 03 00 08 00
!>Fn-F12- 03 00 10 00
Fn-F11 - Not really a key

It seems that when second byte is 00, special key doesn't work.

I'am not sure I understand USB HID protocol. I googled and found this
description for usb hid keyboard communication:
[modifier, reserved, Key1, Key2, Key3, Key4, Key6, Key7]
however applying it here seems to make no sense.

Wireshark log is attached. necessary display filter is:
usb.addr = "1.8.2"
1.8.2 - device for special keys
1.8.1 - device for qwerty

4. I tried to enable log with "echo 8 > /proc/sys/kernel/printk", but
I didn't see any messages from usbhid driver in syslog, dmesg or in
tty. (everything except wireshark and xev was launched from ordinary
tty)

uname -a:
Linux asuka 4.9.0-040900rc6-generic #201611201731 SMP Sun Nov 20
22:33:21 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

I would be happy to provide any assistance - testing patches,
collecting more information etc. As I've no experience in kernel
development, I'm not sure I can fix that bug myself.

-- 
Sincerely yours,
Artem Serebriyskiy
