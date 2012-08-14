From: James <linux-input@madingley.org>
Subject: Re: New Alps protocol in the wild?
Date: Tue, 14 Aug 2012 11:35:53 +0100
Message-ID: <20120814103553.GF23370@arianrhod.panaceas.james.local>
References: <87obmwld7n.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bAmEntskrkuBymla"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 78-105-106-38.zone3.bethere.co.uk ([78.105.106.38]:42702 "EHLO
	new-global.panaceas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755958Ab2HNL3W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 07:29:22 -0400
Content-Disposition: inline
In-Reply-To: <87obmwld7n.fsf@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just got a Dell E6230 with the same E7 report: 73 03 0a
As noted above using the qemu serio logging doesn't work.
The driver only enables multitouch if it sees the right
name for the device in the DSDT.

The following patch (against the seabios in qemu-0.14.1)
enables the windows 7 driver (7.1211.101.114 from
http://www.dell.com/support/drivers/us/en/04/DriverDetails/DriverFileFormats/Product/latitude-e6230?DriverId=CKNFN&FileId=2988050063&urlProductCode=False 
) to bind successfully and alows one to get data from the serio
logging patch

Are there any standard tools for reverse engineering the
protocol - I saw mention of an alps-reg-dump but was
unable to find it?

thanks,

James.

--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="make-6230-touchpad-bind-in-win7.patch"

--- ./qemu-0.14.1/roms/seabios/src/acpi-dsdt.dsl	2011-05-06 20:02:01.000000000 +0100
+++ ./qemu-0.14.1.jmm/roms/seabios/src/acpi-dsdt.dsl	2012-08-14 11:09:22.000000000 +0100
@@ -253,7 +253,7 @@
             }
 
             /* Keyboard seems to be important for WinXP install */
-            Device (KBD)
+            Device (PS2K)
             {
                 Name (_HID, EisaId ("PNP0303"))
                 Method (_STA, 0, NotSerialized)
@@ -261,10 +261,8 @@
                     Return (0x0f)
                 }
 
-                Method (_CRS, 0, NotSerialized)
+		Name (_CRS, ResourceTemplate ()
                 {
-                     Name (TMP, ResourceTemplate ()
-                     {
                     IO (Decode16,
                         0x0060,             // Address Range Minimum
                         0x0060,             // Address Range Maximum
@@ -277,30 +275,52 @@
                         0x01,               // Address Alignment
                         0x01,               // Address Length
                         )
+                IRQ (Edge, ActiveHigh, Exclusive, )
+                    {1}
+
+                })
+
+
+
+
+            Name (_PRS, ResourceTemplate ()
+            {
+                StartDependentFn (0x00, 0x00)
+                {
+                    FixedIO (
+                        0x0060,             // Address
+                        0x01,               // Length
+                        )
+                    FixedIO (
+                        0x0064,             // Address
+                        0x01,               // Length
+                        )
                     IRQNoFlags ()
                         {1}
-                    })
-                    Return (TMP)
                 }
-            }
+                EndDependentFn ()
+            })
+		}
 
 	    /* PS/2 mouse */
-            Device (MOU)
+            Device (PS2M)
             {
-                Name (_HID, EisaId ("PNP0F13"))
-                Method (_STA, 0, NotSerialized)
-                {
-                    Return (0x0f)
-                }
-
-                Method (_CRS, 0, NotSerialized)
+                Name (_CID, EisaId ("PNP0F13"))
+		Name (_HID, EisaId ("DLL0532"))
+            Name (_CRS, ResourceTemplate ()
+            {
+                IRQ (Edge, ActiveHigh, Exclusive, )
+                    {12}
+            })
+            Name (_PRS, ResourceTemplate ()
+            {
+                StartDependentFn (0x00, 0x00)
                 {
-                    Name (TMP, ResourceTemplate ()
-                    {
-                         IRQNoFlags () {12}
-                    })
-                    Return (TMP)
+                    IRQNoFlags ()
+                        {12}
                 }
+                EndDependentFn ()
+            })
             }
 
 	    /* PS/2 floppy controller */

--bAmEntskrkuBymla--
