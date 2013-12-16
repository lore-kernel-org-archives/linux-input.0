From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 1/2] Input: joystick - refer to /dev/input/js0 in documentation
Date: Mon, 16 Dec 2013 09:57:14 +0100
Message-ID: <1387184235-20169-2-git-send-email-ospite@studenti.unina.it>
References: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:3692 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab3LPI53 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 03:57:29 -0500
In-Reply-To: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Nowadays the joystick device nodes are created under /dev/input, reflect
this in the documentation in order to make copy and paste easier for
users.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 Documentation/input/joystick-api.txt | 2 +-
 Documentation/input/joystick.txt     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/input/joystick-api.txt b/Documentation/input/joystick-api.txt
index c507330..f95f648 100644
--- a/Documentation/input/joystick-api.txt
+++ b/Documentation/input/joystick-api.txt
@@ -16,7 +16,7 @@ joystick.
 
 By default, the device is opened in blocking mode.
 
-	int fd = open ("/dev/js0", O_RDONLY);
+	int fd = open ("/dev/input/js0", O_RDONLY);
 
 
 2. Event Reading
diff --git a/Documentation/input/joystick.txt b/Documentation/input/joystick.txt
index 304262b..8d027dc 100644
--- a/Documentation/input/joystick.txt
+++ b/Documentation/input/joystick.txt
@@ -116,7 +116,7 @@ your needs:
   For testing the joystick driver functionality, there is the jstest
 program in the utilities package. You run it by typing:
 
-	jstest /dev/js0
+	jstest /dev/input/js0
 
   And it should show a line with the joystick values, which update as you
 move the stick, and press its buttons. The axes should all be zero when the
@@ -136,7 +136,7 @@ joystick should be autocalibrated by the driver automagically. However, with
 some analog joysticks, that either do not use linear resistors, or if you
 want better precision, you can use the jscal program
 
-	jscal -c /dev/js0
+	jscal -c /dev/input/js0
 
  included in the joystick package to set better correction coefficients than
 what the driver would choose itself.
@@ -145,7 +145,7 @@ what the driver would choose itself.
 calibration using the jstest command, and if you do, you then can save the
 correction coefficients into a file
 
-	jscal -p /dev/js0 > /etc/joystick.cal
+	jscal -p /dev/input/js0 > /etc/joystick.cal
 
   And add a line to your rc script executing that file
 
@@ -556,7 +556,7 @@ interface, and "old" for the "0.x" interface. You run it by typing:
 
 5. FAQ
 ~~~~~~
-Q: Running 'jstest /dev/js0' results in "File not found" error. What's the
+Q: Running 'jstest /dev/input/js0' results in "File not found" error. What's the
    cause?
 A: The device files don't exist. Create them (see section 2.2).
 
-- 
1.8.5.1

