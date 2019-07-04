From: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH] Documentation: input: Add HID gadget driver's docs to Input subsystem
Date: Fri,  5 Jul 2019 00:00:48 +0530
Message-ID: <20190704183048.32360-1-shreeya.patel23498@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, dmitry.torokhov@gmail.com, corbet@lwn.net, gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Convert gadget_hid file to ReST format, in order to allow it to
be parsed by Sphinx.
Also move the file in the Input subsystem documentation so as to
put it in the right place.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 .../devices/gadget_hid.rst}                        | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
 rename Documentation/{usb/gadget_hid.txt => input/devices/gadget_hid.rst} (96%)

diff --git a/Documentation/usb/gadget_hid.txt b/Documentation/input/devices/gadget_hid.rst
similarity index 96%
rename from Documentation/usb/gadget_hid.txt
rename to Documentation/input/devices/gadget_hid.rst
index 098d563040cc..132a8d6719f0 100644
--- a/Documentation/usb/gadget_hid.txt
+++ b/Documentation/input/devices/gadget_hid.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
 ===========================
 Linux USB HID gadget driver
 ===========================
@@ -8,15 +10,15 @@ Introduction
 The HID Gadget driver provides emulation of USB Human Interface
 Devices (HID). The basic HID handling is done in the kernel,
 and HID reports can be sent/received through I/O on the
-/dev/hidgX character devices.
+:file:`/dev/hidgX` character devices.
 
 For more details about HID, see the developer page on
-http://www.usb.org/developers/hidpage/
+`<http://www.usb.org/developers/hidpage/>`_
 
 Configuration
 =============
 
-g_hid is a platform driver, so to use it you need to add
+*g_hid* is a platform driver, so to use it you need to add
 struct platform_device(s) to your platform code defining the
 HID function descriptors you want to use - E.G. something
 like::
@@ -89,16 +91,16 @@ Send and receive HID reports
 ============================
 
 HID reports can be sent/received using read/write on the
-/dev/hidgX character devices. See below for an example program
+:file:`/dev/hidgX` character devices. See below for an example program
 to do this.
 
-hid_gadget_test is a small interactive program to test the HID
+*hid_gadget_test* is a small interactive program to test the HID
 gadget driver. To use, point it at a hidg device and set the
 device type (keyboard / mouse / joystick) - E.G.::
 
 	# hid_gadget_test /dev/hidg0 keyboard
 
-You are now in the prompt of hid_gadget_test. You can type any
+You are now in the prompt of *hid_gadget_test*. You can type any
 combination of options and values. Available options and
 values are listed at program start. In keyboard mode you can
 send up to six values.
-- 
2.17.1
