From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 2/2] Input: joystick - use sizeof(VARIABLE) in documentation
Date: Mon, 16 Dec 2013 09:57:15 +0100
Message-ID: <1387184235-20169-3-git-send-email-ospite@studenti.unina.it>
References: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:3694 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751810Ab3LPI53 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Dec 2013 03:57:29 -0500
In-Reply-To: <1387184235-20169-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Use the preferred style sizeof(VARIABLE) instead of sizeof(TYPE) in the
joystick API documentation, Documentation/CodingStyle states that this
is the preferred style for allocations but using it elsewhere is good
too.

Also fix some errors like "sizeof(struct mybuffer)" which didn't mean
anything.

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 Documentation/input/joystick-api.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/input/joystick-api.txt b/Documentation/input/joystick-api.txt
index f95f648..47e60a5 100644
--- a/Documentation/input/joystick-api.txt
+++ b/Documentation/input/joystick-api.txt
@@ -23,7 +23,7 @@ By default, the device is opened in blocking mode.
 ~~~~~~~~~~~~~~~~
 
 	struct js_event e;
-	read (fd, &e, sizeof(struct js_event));
+	read (fd, &e, sizeof(e));
 
 where js_event is defined as
 
@@ -34,8 +34,8 @@ where js_event is defined as
 		__u8 number;    /* axis/button number */
 	};
 
-If the read is successful, it will return sizeof(struct js_event), unless
-you wanted to read more than one event per read as described in section 3.1.
+If the read is successful, it will return sizeof(e), unless you wanted to read
+more than one event per read as described in section 3.1.
 
 
 2.1 js_event.type
@@ -144,7 +144,7 @@ all events on the queue (that is, until you get a -1).
 For example,
 
 	while (1) {
-		while (read (fd, &e, sizeof(struct js_event)) > 0) {
+		while (read (fd, &e, sizeof(e)) > 0) {
 	        	process_event (e);
 	   	}
 	   	/* EAGAIN is returned when the queue is empty */
@@ -181,7 +181,7 @@ at a time using the typical read(2) functionality. For that, you would
 replace the read above with something like
 
 	struct js_event mybuffer[0xff];
-	int i = read (fd, mybuffer, sizeof(struct mybuffer));
+	int i = read (fd, mybuffer, ARRAY_SIZE(mybuffer));
 
 In this case, read would return -1 if the queue was empty, or some
 other value in which the number of events read would be i /
-- 
1.8.5.1

