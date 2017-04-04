From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 18/37] docs: input/joystick-api: convert it to ReST format
Date: Tue,  4 Apr 2017 09:22:18 -0300
Message-ID: <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
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
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34565
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752803AbdDDMXD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:03 -0400
In-Reply-To: <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

This file require some adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/joystick-api.txt | 138 +++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 63 deletions(-)

diff --git a/Documentation/input/joystick-api.txt b/Documentation/input/joystick-api.txt
index 943b18eac918..9b9d26833086 100644
--- a/Documentation/input/joystick-api.txt
+++ b/Documentation/input/joystick-api.txt
@@ -1,12 +1,11 @@
-		      Joystick API Documentation                -*-Text-*-
+==========================
+Joystick API Documentation
+==========================
 
-		        Ragnar Hojland Espinosa
-			  <ragnar@macula.net>
+:Author: Ragnar Hojland Espinosa <ragnar@macula.net> - 7 Aug 1998
 
-			      7 Aug 1998
-
-1. Initialization
-~~~~~~~~~~~~~~~~~
+Initialization
+==============
 
 Open the joystick device following the usual semantics (that is, with open).
 Since the driver now reports events instead of polling for changes,
@@ -14,18 +13,20 @@ immediately after the open it will issue a series of synthetic events
 (JS_EVENT_INIT) that you can read to check the initial state of the
 joystick.
 
-By default, the device is opened in blocking mode.
+By default, the device is opened in blocking mode::
 
 	int fd = open ("/dev/input/js0", O_RDONLY);
 
 
-2. Event Reading
-~~~~~~~~~~~~~~~~
+Event Reading
+=============
+
+::
 
 	struct js_event e;
 	read (fd, &e, sizeof(e));
 
-where js_event is defined as
+where js_event is defined as::
 
 	struct js_event {
 		__u32 time;     /* event timestamp in milliseconds */
@@ -38,10 +39,10 @@ If the read is successful, it will return sizeof(e), unless you wanted to read
 more than one event per read as described in section 3.1.
 
 
-2.1 js_event.type
-~~~~~~~~~~~~~~~~~
+js_event.type
+-------------
 
-The possible values of ``type'' are
+The possible values of ``type`` are::
 
 	#define JS_EVENT_BUTTON         0x01    /* button pressed/released */
 	#define JS_EVENT_AXIS           0x02    /* joystick moved */
@@ -49,47 +50,50 @@ The possible values of ``type'' are
 
 As mentioned above, the driver will issue synthetic JS_EVENT_INIT ORed
 events on open. That is, if it's issuing a INIT BUTTON event, the
-current type value will be
+current type value will be::
 
 	int type = JS_EVENT_BUTTON | JS_EVENT_INIT;	/* 0x81 */
 
 If you choose not to differentiate between synthetic or real events
-you can turn off the JS_EVENT_INIT bits
+you can turn off the JS_EVENT_INIT bits::
 
 	type &= ~JS_EVENT_INIT;				/* 0x01 */
 
 
-2.2 js_event.number
-~~~~~~~~~~~~~~~~~~~
+js_event.number
+---------------
 
-The values of ``number'' correspond to the axis or button that
+The values of ``number`` correspond to the axis or button that
 generated the event. Note that they carry separate numeration (that
 is, you have both an axis 0 and a button 0). Generally,
 
-			number
+        =============== =======
+	Axis		number
+        =============== =======
 	1st Axis X	0
 	1st Axis Y	1
 	2nd Axis X	2
 	2nd Axis Y	3
 	...and so on
+        =============== =======
 
 Hats vary from one joystick type to another. Some can be moved in 8
 directions, some only in 4, The driver, however, always reports a hat as two
 independent axis, even if the hardware doesn't allow independent movement.
 
 
-2.3 js_event.value
-~~~~~~~~~~~~~~~~~~
+js_event.value
+--------------
 
-For an axis, ``value'' is a signed integer between -32767 and +32767
+For an axis, ``value`` is a signed integer between -32767 and +32767
 representing the position of the joystick along that axis. If you
-don't read a 0 when the joystick is `dead', or if it doesn't span the
+don't read a 0 when the joystick is ``dead``, or if it doesn't span the
 full range, you should recalibrate it (with, for example, jscal).
 
-For a button, ``value'' for a press button event is 1 and for a release
+For a button, ``value`` for a press button event is 1 and for a release
 button event is 0.
 
-Though this
+Though this::
 
 	if (js_event.type == JS_EVENT_BUTTON) {
 		buttons_state ^= (1 << js_event.number);
@@ -97,6 +101,8 @@ Though this
 
 may work well if you handle JS_EVENT_INIT events separately,
 
+::
+
 	if ((js_event.type & ~JS_EVENT_INIT) == JS_EVENT_BUTTON) {
 		if (js_event.value)
 			buttons_state |= (1 << js_event.number);
@@ -109,17 +115,17 @@ have to write a separate handler for JS_EVENT_INIT events in the first
 snippet, this ends up being shorter.
 
 
-2.4 js_event.time
-~~~~~~~~~~~~~~~~~
+js_event.time
+-------------
 
-The time an event was generated is stored in ``js_event.time''. It's a time
+The time an event was generated is stored in ``js_event.time``. It's a time
 in milliseconds since ... well, since sometime in the past.  This eases the
 task of detecting double clicks, figuring out if movement of axis and button
 presses happened at the same time, and similar.
 
 
-3. Reading
-~~~~~~~~~~
+Reading
+=======
 
 If you open the device in blocking mode, a read will block (that is,
 wait) forever until an event is generated and effectively read. There
@@ -133,8 +139,8 @@ admittedly, a long time;)
 	b) open the device in non-blocking mode (O_NONBLOCK)
 
 
-3.1 O_NONBLOCK
-~~~~~~~~~~~~~~
+O_NONBLOCK
+----------
 
 If read returns -1 when reading in O_NONBLOCK mode, this isn't
 necessarily a "real" error (check errno(3)); it can just mean there
@@ -143,6 +149,8 @@ all events on the queue (that is, until you get a -1).
 
 For example,
 
+::
+
 	while (1) {
 		while (read (fd, &e, sizeof(e)) > 0) {
 			process_event (e);
@@ -171,14 +179,17 @@ the driver will switch to startup mode and next time you read it,
 synthetic events (JS_EVENT_INIT) will be generated to inform you of
 the actual state of the joystick.
 
-[As for version 1.2.8, the queue is circular and able to hold 64
+
+.. note::
+
+ As for version 1.2.8, the queue is circular and able to hold 64
  events. You can increment this size bumping up JS_BUFF_SIZE in
- joystick.h and recompiling the driver.]
+ joystick.h and recompiling the driver.
 
 
 In the above code, you might as well want to read more than one event
 at a time using the typical read(2) functionality. For that, you would
-replace the read above with something like
+replace the read above with something like::
 
 	struct js_event mybuffer[0xff];
 	int i = read (fd, mybuffer, sizeof(mybuffer));
@@ -189,10 +200,10 @@ sizeof(js_event)  Again, if the buffer was full, it's a good idea to
 process the events and keep reading it until you empty the driver queue.
 
 
-4. IOCTLs
-~~~~~~~~~
+IOCTLs
+======
 
-The joystick driver defines the following ioctl(2) operations.
+The joystick driver defines the following ioctl(2) operations::
 
 				/* function			3rd arg  */
 	#define JSIOCGAXES	/* get number of axes		char	 */
@@ -202,31 +213,31 @@ The joystick driver defines the following ioctl(2) operations.
 	#define JSIOCSCORR	/* set correction values	&js_corr */
 	#define JSIOCGCORR	/* get correction values	&js_corr */
 
-For example, to read the number of axes
+For example, to read the number of axes::
 
 	char number_of_axes;
 	ioctl (fd, JSIOCGAXES, &number_of_axes);
 
 
-4.1 JSIOGCVERSION
-~~~~~~~~~~~~~~~~~
+JSIOGCVERSION
+-------------
 
 JSIOGCVERSION is a good way to check in run-time whether the running
 driver is 1.0+ and supports the event interface. If it is not, the
 IOCTL will fail. For a compile-time decision, you can test the
-JS_VERSION symbol
+JS_VERSION symbol::
 
 	#ifdef JS_VERSION
 	#if JS_VERSION > 0xsomething
 
 
-4.2 JSIOCGNAME
-~~~~~~~~~~~~~~
+JSIOCGNAME
+----------
 
 JSIOCGNAME(len) allows you to get the name string of the joystick - the same
 as is being printed at boot time. The 'len' argument is the length of the
 buffer provided by the application asking for the name. It is used to avoid
-possible overrun should the name be too long.
+possible overrun should the name be too long::
 
 	char name[128];
 	if (ioctl(fd, JSIOCGNAME(sizeof(name)), name) < 0)
@@ -234,8 +245,8 @@ possible overrun should the name be too long.
 	printf("Name: %s\n", name);
 
 
-4.3 JSIOC[SG]CORR
-~~~~~~~~~~~~~~~~~
+JSIOC[SG]CORR
+-------------
 
 For usage on JSIOC[SG]CORR I suggest you to look into jscal.c  They are
 not needed in a normal program, only in joystick calibration software
@@ -246,7 +257,7 @@ warning in following releases of the driver.
 Both JSIOCSCORR and JSIOCGCORR expect &js_corr to be able to hold
 information for all axis. That is, struct js_corr corr[MAX_AXIS];
 
-struct js_corr is defined as
+struct js_corr is defined as::
 
 	struct js_corr {
 		__s32 coef[8];
@@ -254,17 +265,17 @@ struct js_corr is defined as
 		__u16 type;
 	};
 
-and ``type''
+and ``type``::
 
 	#define JS_CORR_NONE            0x00    /* returns raw values */
 	#define JS_CORR_BROKEN          0x01    /* broken line */
 
 
-5. Backward compatibility
-~~~~~~~~~~~~~~~~~~~~~~~~~
+Backward compatibility
+======================
 
 The 0.x joystick driver API is quite limited and its usage is deprecated.
-The driver offers backward compatibility, though. Here's a quick summary:
+The driver offers backward compatibility, though. Here's a quick summary::
 
 	struct JS_DATA_TYPE js;
 	while (1) {
@@ -275,7 +286,7 @@ The driver offers backward compatibility, though. Here's a quick summary:
 	}
 
 As you can figure out from the example, the read returns immediately,
-with the actual state of the joystick.
+with the actual state of the joystick::
 
 	struct JS_DATA_TYPE {
 		int buttons;    /* immediate button state */
@@ -283,12 +294,14 @@ with the actual state of the joystick.
 		int y;          /* immediate y axis value */
 	};
 
-and JS_RETURN is defined as
+and JS_RETURN is defined as::
 
 	#define JS_RETURN       sizeof(struct JS_DATA_TYPE)
 
 To test the state of the buttons,
 
+::
+
 	first_button_state  = js.buttons & 1;
 	second_button_state = js.buttons & 2;
 
@@ -302,13 +315,12 @@ called Multisystem joysticks in this driver), under /dev/djsX. This driver
 doesn't try to be compatible with that interface.
 
 
-6. Final Notes
-~~~~~~~~~~~~~~
+Final Notes
+===========
 
-____/|	Comments, additions, and specially corrections are welcome.
-\ o.O|	Documentation valid for at least version 1.2.8 of the joystick
- =(_)=	driver and as usual, the ultimate source for documentation is
-   U	to "Use The Source Luke" or, at your convenience, Vojtech ;)
+::
 
-					- Ragnar
-EOF
+  ____/|	Comments, additions, and specially corrections are welcome.
+  \ o.O|	Documentation valid for at least version 1.2.8 of the joystick
+   =(_)=	driver and as usual, the ultimate source for documentation is
+     U		to "Use The Source Luke" or, at your convenience, Vojtech ;)
-- 
2.9.3

