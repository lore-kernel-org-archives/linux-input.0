From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/8] Input: move documentation for Amiga CD32
Date: Sat, 15 Apr 2017 22:11:38 -0700
Message-ID: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33797 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdDPFLs (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 16 Apr 2017 01:11:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

Move the documentation for Amiga CD32 together with other parallel port
joysticks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/cd32.rst             | 24 ---------------------
 Documentation/input/index.rst            |  1 -
 Documentation/input/joystick-parport.rst | 37 ++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/input/cd32.rst

diff --git a/Documentation/input/cd32.rst b/Documentation/input/cd32.rst
deleted file mode 100644
index 935028b957d9..000000000000
--- a/Documentation/input/cd32.rst
+++ /dev/null
@@ -1,24 +0,0 @@
-==========
-Amiga CD32
-==========
-
-I have written a small patch that let's me use my Amiga CD32
-joypad connected to the parallel port. Thought I'd share it with you so
-you can add it to the list of supported joysticks (hopefully someone will
-find it useful).
-
-It needs the following wiring:
-
-===========    =============
-CD32 pad       Parallel port
-===========    =============
-1 (Up)          2 (D0)
-2 (Down)        3 (D1)
-3 (Left)        4 (D2)
-4 (Right)       5 (D3)
-5 (Fire3)      14 (AUTOFD)
-6 (Fire1)      17 (SELIN)
-7 (+5V)         1 (STROBE)
-8 (Gnd)        18 (Gnd)
-9 (Fire2)       7 (D5)
-===========    =============
diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index 153f0d476c3e..32c0515fd24b 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -54,7 +54,6 @@ Input drivers
    appletouch
    atarikbd
    bcm5974
-   cd32
    cma3000_d0x
    cs461x
    edt-ft5x06
diff --git a/Documentation/input/joystick-parport.rst b/Documentation/input/joystick-parport.rst
index 0aa0fb17bf48..fa8cab584793 100644
--- a/Documentation/input/joystick-parport.rst
+++ b/Documentation/input/joystick-parport.rst
@@ -443,6 +443,43 @@ parallel port::
 The other pins (Up, Down, Right, Left, Power, Ground) are the same as for
 Multi joysticks using db9.c
 
+Amiga CD32
+----------
+
+Amiga CD32 joypad uses the following pinout::
+
+        +-----------> Button 3
+        | +---------> Right
+        | | +-------> Left
+        | | | +-----> Down
+        | | | | +---> Up
+        | | | | |
+      _____________
+    5 \ o o o o o / 1
+       \ o o o o /
+      9 `~~~~~~~' 6
+        | | | |
+        | | | +----> Button 1
+        | | +------> Power
+        | +--------> Ground
+        +----------> Button 2
+
+It can be connected to the parallel port and driven by db9.c driver. It needs the following wiring:
+
+	============    =============
+	CD32 pad        Parallel port
+	============    =============
+	1 (Up)           2 (D0)
+	2 (Down)         3 (D1)
+	3 (Left)         4 (D2)
+	4 (Right)        5 (D3)
+	5 (Button 3)    14 (AUTOFD)
+	6 (Button 1)    17 (SELIN)
+	7 (+5V)          1 (STROBE)
+	8 (Gnd)         18 (Gnd)
+	9 (Button 2)     7 (D5)
+	============    =============
+
 The drivers
 ===========
 
-- 
2.12.2.762.g0e3151a226-goog

