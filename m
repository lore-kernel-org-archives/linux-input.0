From: Adam Goode <adam@spicenitz.org>
Subject: Problem with Das Keyboard 4 in N-key rollover mode
Date: Wed, 15 Oct 2014 23:15:56 -0400
Message-ID: <CADN=WdrqExP36Drz-8ZLi=jU0Ga9Zdsw6LKqm3oJphD2-kM7=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:62888 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbaJPDQR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 23:16:17 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so2163770obc.37
        for <linux-input@vger.kernel.org>; Wed, 15 Oct 2014 20:16:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a Das Keyboard 4 and it has a USB N-key rollover mode. When I
am holding backslash (but no other key that I have discovered!) then
every press and release of the spacebar leads to another backslash
keydown/keyup sequence. I also cannot repeat backslash by holding it
down.

This is with Fedora 21, though I have observed the same issues with
CentOS 7. Windows 8.1 does not have this problem. Standard 6-key
rollover does not have this problem (it is switchable on the keyboard
with a hotkey).

Below are some dumps. Here is what I typed:

backslash down
space down
space up
backslash up



Here is evtest, you can see the spurious BACKSLASH events:

Event: time 1413429154.248555, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70031
Event: time 1413429154.248555, type 1 (EV_KEY), code 43 (KEY_BACKSLASH), value 1
Event: time 1413429154.248555, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70032
Event: time 1413429154.248555, type 1 (EV_KEY), code 43 (KEY_BACKSLASH), value 0
Event: time 1413429154.248555, -------------- SYN_REPORT ------------
Event: time 1413429155.745546, type 4 (EV_MSC), code 4 (MSC_SCAN), value 7002c
Event: time 1413429155.745546, type 1 (EV_KEY), code 57 (KEY_SPACE), value 1
Event: time 1413429155.745546, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70031
Event: time 1413429155.745546, type 1 (EV_KEY), code 43 (KEY_BACKSLASH), value 1
Event: time 1413429155.745546, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70032
Event: time 1413429155.745546, type 1 (EV_KEY), code 43 (KEY_BACKSLASH), value 0
Event: time 1413429155.745546, -------------- SYN_REPORT ------------
Event: time 1413429155.858578, type 4 (EV_MSC), code 4 (MSC_SCAN), value 7002c
Event: time 1413429155.858578, type 1 (EV_KEY), code 57 (KEY_SPACE), value 0
Event: time 1413429155.858578, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70031
Event: time 1413429155.858578, type 1 (EV_KEY), code 43 (KEY_BACKSLASH), value 1
Event: time 1413429155.858578, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70032
Event: time 1413429155.858578, type 1 (EV_KEY), code 43 (KEY_BACKSLASH), value 0
Event: time 1413429155.858578, -------------- SYN_REPORT ------------


Here is hiddump:


003:047:001:DESCRIPTOR         1413429180.935271
 05 01 09 80 A1 01 85 02 09 81 09 82 09 83 15 00
 25 01 75 01 95 03 81 06 75 05 95 01 81 01 06 00
 FF 09 01 85 01 15 00 26 FF 00 75 08 95 07 B1 00
 C0 05 0C 09 01 A1 01 85 03 15 00 25 01 09 B5 09
 B6 09 B7 09 CD 09 E2 09 E5 09 E7 09 E9 09 EA 0A
 52 01 0A 53 01 0A 54 01 0A 55 01 0A 83 01 0A 8A
 01 0A 92 01 0A 94 01 0A 21 02 0A 23 02 0A 24 02
 0A 25 02 0A 26 02 0A 27 02 0A 2A 02 75 01 95 18
 81 02 C0

003:047:000:DESCRIPTOR         1413429180.935654
 05 01 09 06 A1 01 05 07 19 E0 29 E7 15 00 25 01
 75 01 95 08 81 02 19 00 29 67 95 68 81 02 05 08
 19 01 29 05 15 00 25 01 75 01 95 05 91 02 75 03
 95 01 91 01 C0

Starting dumping interrupt transfer stream
with 1 minute timeout.

003:047:000:STREAM             1413429182.598393
 00 00 00 00 00 00 00 02 00 00 00 00 00 00

003:047:000:STREAM             1413429183.876383
 00 00 00 00 00 00 10 02 00 00 00 00 00 00

003:047:000:STREAM             1413429183.995389
 00 00 00 00 00 00 00 02 00 00 00 00 00 00

003:047:000:STREAM             1413429185.301376
 00 00 00 00 00 00 00 00 00 00 00 00 00 00



I am no HID expert, but I will try to figure this out. I would
appreciate any help.



Thanks,

Adam
