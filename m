From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 14/37] docs: input/gameport-programming: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:14 -0300
Message-ID: <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST.

Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/gameport-programming.txt | 83 ++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 24 deletions(-)

diff --git a/Documentation/input/gameport-programming.txt b/Documentation/input/gameport-programming.txt
index 03a74fc3b496..c96911df1c54 100644
--- a/Documentation/input/gameport-programming.txt
+++ b/Documentation/input/gameport-programming.txt
@@ -1,11 +1,12 @@
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Programming gameport drivers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-1. A basic classic gameport
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+A basic classic gameport
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the gameport doesn't provide more than the inb()/outb() functionality,
-the code needed to register it with the joystick drivers is simple:
+the code needed to register it with the joystick drivers is simple::
 
 	struct gameport gameport;
 
@@ -37,12 +38,12 @@ space only when something really is using it. Disable it again in the
 callback, so that it doesn't fail if some of the possible addresses are
 already occupied by other gameports.
 
-2. Memory mapped gameport
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Memory mapped gameport
+~~~~~~~~~~~~~~~~~~~~~~
 
 When a gameport can be accessed through MMIO, this way is preferred, because
 it is faster, allowing more reads per second. Registering such a gameport
-isn't as easy as a basic IO one, but not so much complex:
+isn't as easy as a basic IO one, but not so much complex::
 
 	struct gameport gameport;
 
@@ -53,19 +54,21 @@ isn't as easy as a basic IO one, but not so much complex:
 
 	unsigned char my_read(struct gameport *gameport)
 	{
-		return my_mmio;	
+		return my_mmio;
 	}
 
 	gameport.read = my_read;
 	gameport.trigger = my_trigger;
 	gameport_register_port(&gameport);
 
-3. Cooked mode gameport
-~~~~~~~~~~~~~~~~~~~~~~~
+.. _gameport_pgm_cooked_mode:
+
+Cooked mode gameport
+~~~~~~~~~~~~~~~~~~~~
 
 There are gameports that can report the axis values as numbers, that means
 the driver doesn't have to measure them the old way - an ADC is built into
-the gameport. To register a cooked gameport:
+the gameport. To register a cooked gameport::
 
 	struct gameport gameport;
 
@@ -95,8 +98,8 @@ See analog.c and input.c for handling of fuzz - the fuzz value determines
 the size of a gaussian filter window that is used to eliminate the noise
 in the data.
 
-4. More complex gameports
-~~~~~~~~~~~~~~~~~~~~~~~~~
+More complex gameports
+~~~~~~~~~~~~~~~~~~~~~~
 
 Gameports can support both raw and cooked modes. In that case combine either
 examples 1+2 or 1+3. Gameports can support internal calibration - see below,
@@ -104,65 +107,91 @@ and also lightning.c and analog.c on how that works. If your driver supports
 more than one gameport instance simultaneously, use the ->private member of
 the gameport struct to point to your data.
 
-5. Unregistering a gameport
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unregistering a gameport
+~~~~~~~~~~~~~~~~~~~~~~~~
 
-Simple:
+Simple::
 
-gameport_unregister_port(&gameport);
+    gameport_unregister_port(&gameport);
 
-6. The gameport structure
-~~~~~~~~~~~~~~~~~~~~~~~~~
+The gameport structure
+~~~~~~~~~~~~~~~~~~~~~~
 
-struct gameport {
+.. note::
+
+    This section is outdated. There are several fields here that don't
+    match what's there at include/linux/gameport.h.
+
+::
+
+    struct gameport {
 
 	void *private;
 
 A private pointer for free use in the gameport driver. (Not the joystick
 driver!)
 
+::
+
 	int number;
 
 Number assigned to the gameport when registered. Informational purpose only.
 
+::
+
 	int io;
 
 I/O address for use with raw mode. You have to either set this, or ->read()
 to some value if your gameport supports raw mode.
 
+::
+
 	int speed;
 
 Raw mode speed of the gameport reads in thousands of reads per second.
 
+::
+
 	int fuzz;
 
 If the gameport supports cooked mode, this should be set to a value that
-represents the amount of noise in the data. See section 3.
+represents the amount of noise in the data. See
+:ref:`gameport_pgm_cooked_mode`.
+
+::
 
 	void (*trigger)(struct gameport *);
 
 Trigger. This function should trigger the ns558 oneshots. If set to NULL,
 outb(0xff, io) will be used.
 
+::
+
 	unsigned char (*read)(struct gameport *);
 
 Read the buttons and ns558 oneshot bits. If set to NULL, inb(io) will be
 used instead.
 
-	int (*cooked_read)(struct gameport *, int *axes, int *buttons);	
+::
+
+	int (*cooked_read)(struct gameport *, int *axes, int *buttons);
 
 If the gameport supports cooked mode, it should point this to its cooked
 read function. It should fill axes[0..3] with four values of the joystick axes
 and buttons[0] with four bits representing the buttons.
 
-	int (*calibrate)(struct gameport *, int *axes, int *max); 
+::
+
+	int (*calibrate)(struct gameport *, int *axes, int *max);
 
 Function for calibrating the ADC hardware. When called, axes[0..3] should be
 pre-filled by cooked data by the caller, max[0..3] should be pre-filled with
 expected maximums for each axis. The calibrate() function should set the
 sensitivity of the ADC hardware so that the maximums fit in its range and
 recompute the axes[] values to match the new sensitivity or re-read them from
-the hardware so that they give valid values. 
+the hardware so that they give valid values.
+
+::
 
 	int (*open)(struct gameport *, int mode);
 
@@ -172,16 +201,22 @@ Second, resource allocation can happen here. The port can also be enabled
 here. Prior to this call, other fields of the gameport struct (namely the io
 member) need not to be valid.
 
+::
+
 	void (*close)(struct gameport *);
 
 Close() should free the resources allocated by open, possibly disabling the
 gameport.
 
+::
+
 	struct gameport_dev *dev;
 	struct gameport *next;
 
 For internal use by the gameport layer.
 
-};
+::
+
+    };
 
 Enjoy!
-- 
2.9.3

