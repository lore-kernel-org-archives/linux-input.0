From: Jan Kandziora <jjj@gmx.de>
Subject: Silicon Works Multi-touch Device, VID:PID 29bd:4101; some initial
 help needed tweaking/developing a driver for it
Date: Wed, 26 Oct 2016 22:01:36 +0200
Message-ID: <849deb02-0289-ba43-66fb-1d163efaedec@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:54563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932826AbcJZUBj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 16:01:39 -0400
Received: from [10.0.0.99] ([79.242.237.131]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LevUh-1cgqI325qZ-00qmXg for
 <linux-input@vger.kernel.org>; Wed, 26 Oct 2016 22:01:36 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have some POS system which I'd like to use which has an USB HID
touchscreen

	Silicon Works Multi-touch Device, VID:PID 29bd:4101

hid-multitouch claims it and opens a /dev/input/event4 on the hardware,
but no reports are coming from it when touched.

I was able to get touch data from it through /dev/hidraw0, reports are
six bytes each and have the pattern

	0x03 pressed xl xh yl yh

I then used samples/hid-example.c on the hidraw0 device, which gives

Report Descriptor Size: 761
Report Descriptor:
6 0 ff 9 1 a1 1 a1 1 15 0 26 ff 0 85 14 9 2 75 8 95 3f b1 2 c0 c0 5 d 9
4 a1 1 85 10 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95 7 81 3 75 8 9 51
95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 d2 a 81 2 46 18 6 9
31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95 7 81 3 75 8 9
51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 e2 13 81 2 46 36
b 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95 7 81 3 75
8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 d2 a 81 2 46
18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95 7 81 3
75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 d2 a 81 2
46 18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95 7 81
3 75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 d2 a 81
2 46 18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95 7
81 3 75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 d2 a
81 2 46 18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2 95
7 81 3 75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46 d2
a 81 2 46 18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81 2
95 7 81 3 75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0 46
d2 a 81 2 46 18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1 81
2 95 7 81 3 75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35 0
46 d2 a 81 2 46 18 6 9 31 81 2 c0 5 d 9 22 a1 2 9 42 15 0 25 1 75 1 95 1
81 2 95 7 81 3 75 8 9 51 95 1 81 2 5 1 26 ff 7f 75 10 55 e 65 11 9 30 35
0 46 d2 a 81 2 46 18 6 9 31 81 2 c0 5 d 9 54 25 a 95 1 75 8 81 2 15 0 27
ff ff 0 0 55 c 66 1 10 75 10 9 56 35 0 47 ff ff 0 0 81 2 85 8 9 55 25 a
b1 2 85 44 6 0 ff 9 c5 15 0 26 ff 0 75 8 96 0 1 b1 2 c0 5 d 9 e a1 1 85
7 9 22 a1 0 9 52 9 53 15 0 25 a 75 8 95 2 b1 2 c0 c0 5 1 9 2 a1 1 85 3 9
1 a1 0 5 9 19 1 29 2 15 0 25 1 75 1 95 2 81 2 95 6 81 3 5 1 9 30 9 31 75
10 95 2 15 0 26 ff 7f 35 0 46 ff 7f 81 2 c0 c0

Raw Name: Silicon Works Multi-touch Device
Raw Phys: usb-0000:00:1d.0-1.4/input0
Raw Info:
        bustype: 3 (USB)
        vendor: 0x29bd
        product: 0x4101
HIDIOCSFEATURE: Broken pipe
HIDIOCGFEATURE: Broken pipe
Error: 32
write: Broken pipe
read: Resource temporarily unavailable


Question: is there some similar HID driver I could use as a base to get
this thing working? I have some experience in kernel development (have
the w1_ds28e17 i2c host driver in review currently) but haven't done a
HID driver yet.

Where should I start?


Kind regards

	Jan
