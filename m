From: dave turvene <dturvene@dahetral.com>
Subject: [PATCH] Input: ALPS - Update documentation for recent touchpad driver mods
Date: Fri, 22 Feb 2013 17:37:11 -0500
Message-ID: <87hal4vuug.fsf@dahetral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dahetral.com ([128.177.27.153]:52420 "EHLO dahetral.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757642Ab3BVWhg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Feb 2013 17:37:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, vincent.vanackere@gmail.com, bgamari@gmail.com, jacmet@sunsite.dk, cernekee@gmail.com, jwboyer@redhat.com, linux-input@vger.kernel.org

Updated documentation for the new ALPS touchpad support submitted in two
patchsets by Kevin Cernekee.  My understanding is the most recent
patchset '"Dolphin V2" touchpad support' may still need some work but 
Future work on the ALPS driver should not impact these documentation changes.

See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/606238

Signed-off-by: David Turvene <dturvene@dahetral.com>

---
 Documentation/input/alps.txt |   68 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
index f274c28..24592bd 100644
--- a/Documentation/input/alps.txt
+++ b/Documentation/input/alps.txt
@@ -3,10 +3,26 @@ ALPS Touchpad Protocol
 
 Introduction
 ------------
-
-Currently the ALPS touchpad driver supports four protocol versions in use by
-ALPS touchpads, called versions 1, 2, 3, and 4. Information about the various
-protocol versions is contained in the following sections.
+Currently the ALPS touchpad driver supports five protocol versions in use by
+ALPS touchpads, called versions 1, 2, 3, 4 and 5.  
+
+Since roughly mid-2010 several new ALPS touchpads have been released and
+integrated into a variety of laptops and netbooks.  These new touchpads
+have enough behavior differences that the alps_model_data definition
+table, describing the properties of the different versions, is no longer
+adequate.  The design choices were to re-define the alps_model_data
+table, with the risk of regression testing existing devices, or isolate
+the new devices outside of the alps_model_data table.  The latter design
+choice was made.  The new touchpad signatures are named: "Rushmore",
+"Pinnacle", and "Dolphin", which you will see in the alps.c code.  
+For the purposes of this document, this group of ALPS touchpads will
+generically be called "new ALPS touchpads".
+
+We experimented with probing the ACPI interface _HID (Hardware ID)/_CID
+(Compatibility ID) definition as a way to uniquely identify the
+different ALPS variants but there did not appear to be a 1:1 mapping.
+In fact, it appeared to be an m:n mapping between the _HID and actual
+hardware type.
 
 Detection
 ---------
@@ -19,9 +35,13 @@ If the E6 report is successful, the touchpad model is identified using the "E7
 report" sequence: E8-E7-E7-E7-E9. The response is the model signature and is
 matched against known models in the alps_model_data_array.
 
-With protocol versions 3 and 4, the E7 report model signature is always
-73-02-64. To differentiate between these versions, the response from the
-"Enter Command Mode" sequence must be inspected as described below.
+For older touchpads supporting protocol versions 3 and 4, the E7 report
+model signature is always 73-02-64. To differentiate between these
+versions, the response from the "Enter Command Mode" sequence must be
+inspected as described below.
+
+The new ALPS touchpads have an E7 signature of 73-03-50 or 73-03-0A but
+seem to be better differentiated by the EC Command Mode response.
 
 Command Mode
 ------------
@@ -46,6 +66,14 @@ address of the register being read, and the third contains the value of the
 register. Registers are written by writing the value one nibble at a time
 using the same encoding used for addresses.
 
+For the new ALPS touchpads, the EC command is used to enter command
+mode. The response in the new ALPS touchpads is significantly different,
+and more important in determining the behavior.  This code has been
+separated from the original alps_model_data table and put in the
+alps_identify function.  For example, there seem to be two hardware init
+sequences for the "Dolphin" touchpads as determined by the second byte
+of the EC response.
+
 Packet Format
 -------------
 
@@ -186,3 +214,29 @@ There are several things worth noting here.
     well.
 
 So far no v4 devices with tracksticks have been encountered.
+
+ALPS Absolute Mode - Protocol Version 5
+---------------------------------------
+This is basically Protocol Version 3 but with different logic for packet
+decode.  It uses the same alps_process_touchpad_packet_v3 call with a
+specialized decode_fields function pointer to correctly interpret the
+packets.  This appears to only be used by the Dolphin devices.
+
+For single-touch, the 6-byte packet format is:
+
+ byte 0:    1    1    0    0    1    0    0    0
+ byte 1:    0   x6   x5   x4   x3   x2   x1   x0
+ byte 2:    0   y6   y5   y4   y3   y2   y1   y0
+ byte 3:    0    M    R    L    1    m    r    l
+ byte 4:   y10  y9   y8   y7  x10   x9   x8   x7
+ byte 5:    0   z6   z5   z4   z3   z2   z1   z0
+
+For mt, the format is:
+
+ byte 0:    1    1    1    n3   1   n2   n1   x24
+ byte 1:    1   y7   y6    y5  y4   y3   y2    y1
+ byte 2:    ?   x2   x1   y12 y11  y10   y9    y8
+ byte 3:    0  x23  x22   x21 x20  x19  x18   x17
+ byte 4:    0   x9   x8    x7  x6   x5   x4    x3
+ byte 5:    0  x16  x15   x14 x13  x12  x11   x10
+
-- 
1.7.9.5




