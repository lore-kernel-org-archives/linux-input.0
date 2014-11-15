From: Ben Sagal <bensagal@gmail.com>
Subject: LEN2006 Synaptics touchpad min max fix
Date: Sat, 15 Nov 2014 23:09:22 +0200
Message-ID: <CAK4AR+_pycN0MCqcjM_svpd5UjMWacXVr5QTWJeU-Ean4sD-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:58955 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbaKOVJo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Nov 2014 16:09:44 -0500
Received: by mail-wg0-f48.google.com with SMTP id a1so3807554wgh.7
        for <linux-input@vger.kernel.org>; Sat, 15 Nov 2014 13:09:43 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

RE bug: https://bugzilla.kernel.org/show_bug.cgi?id=88211

The LEN2006 Synaptics touchpad (as found in my thinkpad E540) returns
wrong min max values.

touchpad-edge-detector output:
>  Touchpad SynPS/2 Synaptics TouchPad on /dev/input/event6
>  Move one finger around the touchpad to detect the actual edges
>  Kernel says:    x [1472..5674], y [1408..4684]
>  Touchpad sends: x [1264..5675], y [1171..4688]

the patch is against 3.17.2

Signed-off-by: Binyamin Sagal <bensagal@gmail.com>
---

diff -uNr linux.org/drivers/input/mouse/synaptics.c
linux/drivers/input/mouse/synaptics.c
--- linux.org/drivers/input/mouse/synaptics.c 2014-11-14
12:18:39.000000000 +0200
+++ linux/drivers/input/mouse/synaptics.c 2014-11-14 08:25:05.963395004 +0200
@@ -143,6 +143,10 @@
  (const char * const []){"LEN2001", NULL},
  1024, 5022, 2508, 4832
  },
+ {
+ (const char * const []){"LEN2006", NULL},
+ 1264, 5675, 1171, 4688
+ },
  { }
 };
