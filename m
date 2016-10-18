From: Aidan Hodge <aidanghodge@gmail.com>
Subject: Linux Kernel Issue: [Asus F556UA] Trackpad scrolling not working
Date: Tue, 18 Oct 2016 13:55:53 -0400
Message-ID: <CAHwVtBzy-dPN0SKvVavmAr72Qh36MSNRdO+QDT3XEO9CX_H=+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35401 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965233AbcJRRzy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Oct 2016 13:55:54 -0400
Received: by mail-yw0-f169.google.com with SMTP id t193so803443ywc.2
        for <linux-input@vger.kernel.org>; Tue, 18 Oct 2016 10:55:54 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

[1.] One line summary of the problem:
[Asus F556UA] Trackpad scrolling not working

[2.] Full description of the problem/report:
The trackpad works for basic functions (move the mouse cursor, right
click, and left click). It doesn't scroll or do anything involving
more than one finger, and it appears as if the kernel doesn't
recognize it correctly. Here is the output of "cat
/proc/bus/input/devices" that pertains to the trackpad. It's the only
entry on the list without the correct name:

I: Bus=0018 Vendor=0b05 Product=0101 Version=0100
N: Name="FTE1001:00 0B05:0101"
P: Phys=i2c-FTE1001:00
S: Sysfs=/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-FTE1001:00/0018:0B05:0101.0001/input/input11
U: Uniq=
H: Handlers=mouse0 event11
B: PROP=0
B: EV=17
B: KEY=30000 0 0 0 0
B: REL=103
B: MSC=10

You may or may not find this helpful.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 4.9.0-040900rc1-generic (kernel@tangerine) (gcc version
6.2.0 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #201610151630 SMP Sat Oct 15
20:33:39 UTC 2016

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt):
n/a

[6.] A small shell script or example program which triggers the
problem (if possible):
n/a
