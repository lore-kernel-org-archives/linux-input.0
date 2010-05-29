From: Christopher Heiny <cheiny@synaptics.com>
Subject: [RFC PATCH 0/1] input/touchscreen: Synaptics Touchscreen Driver
Date: Fri, 28 May 2010 17:29:39 -0700
Message-ID: <1275092980-29208-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from misc-148-66-126-238.pool.starband.net ([148.66.126.238]:60820
	"EHLO archaeopteryx.synaptics.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751195Ab0E2FKf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 01:10:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, William Manson <wmanson@synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>

This patch adds an initial driver supporting Synaptics ClearPad
touchscreens that use the RMI4 protocol, as defined here:

http://www.synaptics.com/sites/default/files/511-000136-01_revA.pdf


This patch addresses most of the feedback relating to our previous subm=
issions.
Of particular interest are I2C changes based on feedback from Jean Delv=
are.

Any feedback not acted on (such as creation of an 'rmi' bus on the kern=
el
bus architecture) are captured as TODOs in the code, and will be implem=
ented
in a future submission. Also, we've done a lot of reformatting in order
to make checkpatch happy (down to just a few line length warnings and a=
 couple
of macro formatting issues).

This patch builds for the Omap Zoom2 platform in our development enviro=
nment,
but I cannot guarantee that it will build for you.  We're working on ma=
king
sure it builds generically, and feedback relating to that will be great=
ly
appreciated (special thanks to Joerie de Gram for his previous feedback
on this).


This version of the driver does not support all features of the RMI4
protocol yet.  We felt it more important to start with a solid
implementation of the basic functionality, and then build on that base
to support additional features (such as gestures, proximity detection,
capacitive buttons, and so on).

Additionally, as this is our team's first venture into the wonderful
world of kernel submissions, we figured it was important to start out
initially with a fairly simple codebase, just in case we're doing
something horribly wrong.


The significant files in this version of the driver are:
    rmi_core.c
        Implements the basic core of the RMI4 protocol
        including self-discovery of RMI4 functions.  This
        also implements RMI4 function 0x01, which provides
        generic device control.
    rmi_function_11.c
        Implements basic RMI4 function 0x11 (2D sensor)
        features, including multitouch up to 10 fingers.
    rmi_app_touchpad.c
        The major driver functions (mod_init, mod_exit,
        and so on).
An additional file is included, but will eventually be changed/dropped
    rmi_i2c_gta01.c
        Provides platform setup for development.  This will
        be replaced in the future by a generic approach to
        specifying platform parameters.
More detailed descriptions can be found in each file's comments.

We chose to use multiple source files because it makes it easy to add
support for additional RMI4 functions with minimal impact to existing
functions.  Additionally, this supports future changes to the
configuration to allow you to compile in only those RMI4 functions that
you need for your particular device.


There are two existing drivers for similar Synaptics devices in the
current kernel tree (excluding the PS/2 touchpad driver).  These are:

=2E/linux-2.6/drivers/input/mouse/synaptics_i2c.c
      A driver for the Exeda 15mm touchpad, written by Mike Rapoport
      <mike@compulab.co.il> and Igor Grinberg <grinberg@compulab.co.il>

=2E/linux-2.6/drivers/staging/dream/synaptics_i2c_rmi.c
      A driver for the HTC Dream ClearPad, written by Arve Hj=C3=B8nnev=
=C3=A5g
      <arve@android.com>

We have not extended these drivers for a couple of reasons.  First, the
two drivers are specific to particular Synaptics products, and it is ou=
r
desire to produce a general solution that takes advantage of the 'self
describing' features of products that use the RMI protocol.

Second, and more importantly, is that the existing drivers are written
for an older version of the RMI protocol (aka RMI3) that is being
retired in favor of a more recent and substantially changed version (ak=
a
RMI4).  Most currently shipping Synaptics ClearPads speak the RMI4
protocol, and it will be Synaptics protocol of choice going forward.  I=
n
almost all respects, RMI4 is not backward compatible with RMI3, making
it impractical to support both versions in the same driver.


Comments and other feedback on this driver are welcomed.

Bill Manson
Allie Xiong
Christopher Heiny



---
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
