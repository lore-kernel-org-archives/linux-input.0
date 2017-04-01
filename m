From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 26/33] docs: input/userio: convert it to ReST format
Date: Sat,  1 Apr 2017 15:16:09 -0300
Message-ID: <84c4c711e5b98aafca81460742d5c25fbb24474b.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
 <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
 <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
 <011680ea06ad0b73922b17a6c453d5891bfd5386.1491069870.git.mchehab@s-opensource.com>
 <87be2676f773a689c9b39c4f79cd843fb3678133.1491069870.git.mchehab@s-opensource.com>
 <6730cd298d203d22aec9a5a708cd1d15982e624b.1491069870.git.mchehab@s-opensource.com>
 <b9b1a9e27971fd899876825f2ccfd638c6c62668.1491069870.git.mchehab@s-opensource.com>
 <07a688fbc69c47362aca5882a3bcf72329d0fe1a.1491069870.git.mchehab@s-opensource.com>
 <13245dfb9e3a0f34547925ef3e6efc87b8165ae2.1491069870.git.mchehab@s-opensource.com>
 <355358d79dca250017195f1e0309d64edd432a07.1491069870.git.mchehab@s-opensource.com>
 <74a6c5b672275a8a40317a76c72845a939089c89.1491069870.git.mchehab@s-opensource.com>
 <d55bc5210e28c8c0bb4179e58359a8ff7b234f41.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <d55bc5210e28c8c0bb4179e58359a8ff7b234f41.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
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


