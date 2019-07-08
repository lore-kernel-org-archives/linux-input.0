From: Tim Schumacher <timschumi@gmx.de>
Subject: [PATCH] Input: iforce - Remove empty multiline comments
Date: Mon,  8 Jul 2019 04:50:10 +0200
Message-ID: <20190708025010.9318-1-timschumi@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, timschumi@gmx.de
List-Id: linux-input@vger.kernel.org

Those are remnants of the SPDX identifier migration, which haven't been
removed properly.

Signed-off-by: Tim Schumacher <timschumi@gmx.de>
=2D--
This is probably the highest level of cosmetic-only that a patch
can achieve, sorry for the noise.

CCing Thomas Gleixner, since the tool (is it a tool?) that makes
those SPDX changes would have room for improvement in that regard.
It seems to expect that all of the license information is contained
within the same comment block, which wasn't the case for the iforce
driver.
=2D--
 drivers/input/joystick/iforce/iforce-ff.c      | 3 ---
 drivers/input/joystick/iforce/iforce-main.c    | 3 ---
 drivers/input/joystick/iforce/iforce-packets.c | 3 ---
 drivers/input/joystick/iforce/iforce-serio.c   | 3 ---
 drivers/input/joystick/iforce/iforce-usb.c     | 3 ---
 drivers/input/joystick/iforce/iforce.h         | 3 ---
 6 files changed, 18 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-ff.c b/drivers/input/joy=
stick/iforce/iforce-ff.c
index 2ed7da7d1f3e..4350927f7781 100644
=2D-- a/drivers/input/joystick/iforce/iforce-ff.c
+++ b/drivers/input/joystick/iforce/iforce-ff.c
@@ -6,9 +6,6 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */

-/*
- */
-
 #include "iforce.h"

 /*
diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/j=
oystick/iforce/iforce-main.c
index 55f5b7bb4cac..8c2ffa43ce89 100644
=2D-- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -6,9 +6,6 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */

-/*
- */
-
 #include "iforce.h"

 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.den=
eux@gmail.com>");
diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/inpu=
t/joystick/iforce/iforce-packets.c
index 42cd9730e4cc..677a7773059d 100644
=2D-- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -6,9 +6,6 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */

-/*
- */
-
 #include "iforce.h"

 static struct {
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/=
joystick/iforce/iforce-serio.c
index 65a4fe26324f..b3fff64d92dd 100644
=2D-- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -6,9 +6,6 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */

-/*
- */
-
 #include "iforce.h"

 void iforce_serial_xmit(struct iforce *iforce)
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/jo=
ystick/iforce/iforce-usb.c
index f1569ae8381b..ec5058e05317 100644
=2D-- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -6,9 +6,6 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */

-/*
- */
-
 #include "iforce.h"

 void iforce_usb_xmit(struct iforce *iforce)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joysti=
ck/iforce/iforce.h
index f1681706f526..32e91baf63f5 100644
=2D-- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -6,9 +6,6 @@
  *  USB/RS232 I-Force joysticks and wheels.
  */

-/*
- */
-
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/input.h>
=2D-
2.22.0
