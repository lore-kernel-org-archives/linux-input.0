From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 26/37] docs: input/userio: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:26 -0300
Message-ID: <679c283194489e852074900b0133b5b6acd9395f.1491308444.git.mchehab@s-opensource.com>
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
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/userio.txt | 79 +++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/Documentation/input/userio.txt b/Documentation/input/userio.txt
index 0880c0f447a6..f780c77931fe 100644
--- a/Documentation/input/userio.txt
+++ b/Documentation/input/userio.txt
@@ -1,37 +1,47 @@
-			      The userio Protocol
-	     (c) 2015 Stephen Chandler Paul <thatslyude@gmail.com>
-			      Sponsored by Red Hat
---------------------------------------------------------------------------------
-
-1. Introduction
-~~~~~~~~~~~~~~~
-  This module is intended to try to make the lives of input driver developers
+.. include:: <isonum.txt>
+
+===================
+The userio Protocol
+===================
+
+
+:Copyright: |copy| 2015 Stephen Chandler Paul <thatslyude@gmail.com>
+
+Sponsored by Red Hat
+
+
+Introduction
+=============
+
+This module is intended to try to make the lives of input driver developers
 easier by allowing them to test various serio devices (mainly the various
 touchpads found on laptops) without having to have the physical device in front
 of them. userio accomplishes this by allowing any privileged userspace program
 to directly interact with the kernel's serio driver and control a virtual serio
 port from there.
 
-2. Usage overview
-~~~~~~~~~~~~~~~~~
-  In order to interact with the userio kernel module, one simply opens the
+Usage overview
+==============
+
+In order to interact with the userio kernel module, one simply opens the
 /dev/userio character device in their applications. Commands are sent to the
 kernel module by writing to the device, and any data received from the serio
 driver is read as-is from the /dev/userio device. All of the structures and
 macros you need to interact with the device are defined in <linux/userio.h> and
 <linux/serio.h>.
 
-3. Command Structure
-~~~~~~~~~~~~~~~~~~~~
-  The struct used for sending commands to /dev/userio is as follows:
+Command Structure
+=================
+
+The struct used for sending commands to /dev/userio is as follows::
 
 	struct userio_cmd {
 		__u8 type;
 		__u8 data;
 	};
 
-  "type" describes the type of command that is being sent. This can be any one
-of the USERIO_CMD macros defined in <linux/userio.h>. "data" is the argument
+``type`` describes the type of command that is being sent. This can be any one
+of the USERIO_CMD macros defined in <linux/userio.h>. ``data`` is the argument
 that goes along with the command. In the event that the command doesn't have an
 argument, this field can be left untouched and will be ignored by the kernel.
 Each command should be sent by writing the struct directly to the character
@@ -39,31 +49,36 @@ device. In the event that the command you send is invalid, an error will be
 returned by the character device and a more descriptive error will be printed
 to the kernel log. Only one command can be sent at a time, any additional data
 written to the character device after the initial command will be ignored.
-  To close the virtual serio port, just close /dev/userio.
 
-4. Commands
-~~~~~~~~~~~
+To close the virtual serio port, just close /dev/userio.
 
-4.1 USERIO_CMD_REGISTER
-~~~~~~~~~~~~~~~~~~~~~~~
-  Registers the port with the serio driver and begins transmitting data back and
+Commands
+========
+
+USERIO_CMD_REGISTER
+~~~~~~~~~~~~~~~~~~~
+
+Registers the port with the serio driver and begins transmitting data back and
 forth. Registration can only be performed once a port type is set with
 USERIO_CMD_SET_PORT_TYPE. Has no argument.
 
-4.2 USERIO_CMD_SET_PORT_TYPE
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-  Sets the type of port we're emulating, where "data" is the port type being
+USERIO_CMD_SET_PORT_TYPE
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Sets the type of port we're emulating, where ``data`` is the port type being
 set. Can be any of the macros from <linux/serio.h>. For example: SERIO_8042
 would set the port type to be a normal PS/2 port.
 
-4.3 USERIO_CMD_SEND_INTERRUPT
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-  Sends an interrupt through the virtual serio port to the serio driver, where
-"data" is the interrupt data being sent.
+USERIO_CMD_SEND_INTERRUPT
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
-5. Userspace tools
-~~~~~~~~~~~~~~~~~~
-  The userio userspace tools are able to record PS/2 devices using some of the
+Sends an interrupt through the virtual serio port to the serio driver, where
+``data`` is the interrupt data being sent.
+
+Userspace tools
+===============
+
+The userio userspace tools are able to record PS/2 devices using some of the
 debugging information from i8042, and play back the devices on /dev/userio. The
 latest version of these tools can be found at:
 
-- 
2.9.3

