From: Robert Munteanu <robert.munteanu@gmail.com>
Subject: Redragon Asura Keyboard - All Shift, Ctrl, Alt, Win keys function as
 left shift
Date: Mon, 12 Jun 2017 16:29:59 +0300
Message-ID: <CAC8ULPYhnrubRCn9KbGeRmvASvciSXhpiSVQgVR4C_RFuM8G8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:34750 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbdFLNaB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 12 Jun 2017 09:30:01 -0400
Received: by mail-ot0-f180.google.com with SMTP id t31so66298170ota.1
        for <linux-input@vger.kernel.org>; Mon, 12 Jun 2017 06:30:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

(Note: initially sent to linux-kernel, sorry about that)

Hi,

I am trying to use the keyboard I mentioned. Most of the keys work
fine, except for Shift/Alt/Ctrl/Win. All of them are mapped a left
shift. Some notes:

1. dmesg output when plugging in the keyboard

[185765.848957] input: USB Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.0/0003:0C45:760B.0022/input/input50
[185765.905395] hid-generic 0003:0C45:760B.0022: input,hidraw3: USB
HID v1.11 Keyboard [USB Keyboard] on usb-0000:00:14.0-3/input0
[185765.949342] input: USB Keyboard as
Fwd: Redragon Asura Keyboard - All Shift, Ctrl, Alt, Win keys function
as left shift/devices/pci0000:00/0000:00:14.0/usb1/1-3/1-3:1.1/0003:0C45:760B.0023/input/input51
[185766.009474] hid-generic 0003:0C45:760B.0023:
input,hiddev0,hidraw4: USB HID v1.11 Keyboard [USB Keyboard] on
usb-0000:00:14.0-3/input1

The first input device sends absolutely no input, the second one sends
all the input.

2. Tests done using evtest

With evtest, all the mentioned keys have the following output:

Event: time 1497272760.897616, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e1
Event: time 1497272760.897616, type 1 (EV_KEY), code 42 (KEY_LEFTSHIFT), value 1

3. Information from debugs

In sys/kernel/debug/hid I have two entries:

- 0003:0C45:760B.0037
- 0003:0C45:760B.0038

I've pasted the rdesc output at

- https://pastebin.com/4VwDKRvU
- https://pastebin.com/CrBVRFBj

4. Hexdump output

I've taken the hexdump output when pressing the affected keys. The
keypresses, in order, were:

- Left Shift
- Left Ctrl
- Win
- Left Alt
- Right Alt
- Right Ctrl
- Right Shift

00000000  04 00 00 00 00 00 00 00  04 02 00 00 00 00 00 00  |................|
00000010  04 00 00 00 00 00 00 00  04 01 00 00 00 00 00 00  |................|
00000020  04 00 00 00 00 00 00 00  04 08 00 00 00 00 00 00  |................|
00000030  04 00 00 00 00 00 00 00  04 04 00 00 00 00 00 00  |................|
00000040  04 00 00 00 00 00 00 00  04 40 00 00 00 00 00 00  |.........@......|
00000050  04 00 00 00 00 00 00 00  04 10 00 00 00 00 00 00  |................|
00000060  04 00 00 00 00 00 00 00  04 20 00 00 00 00 00 00  |......... ......|

If you need more information to qualify whether this is a bug or not,
let me know. I'd be glad to test any potential fixes.

I am running kernel 4.11.2 ( openSUSE Tumbleweed x86_64 ).

Thanks,

Robert

For reference, this was initiated as a question at
https://unix.stackexchange.com/questions/370612/redragon-asura-usb-keyboard-maps-all-ctrl-alt-win-keys-to-shift-l



--
http://robert.muntea.nu/


-- 
http://robert.muntea.nu/
