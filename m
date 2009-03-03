From: Richard Hughes <hughsient@gmail.com>
Subject: [patch] add KEY_HIBERNATE and clarify the uses of KEY_SUSPEND and
 KEY_SLEEP
Date: Tue, 03 Mar 2009 17:20:18 +0000
Message-ID: <1236100818.3900.36.camel@hughsie-work.lan>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090302112400.GA2356@khazad-dum.debian.net>
	 <1235995903.3858.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qXNgvHX/aF4F/8ss5Hcn"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f177.google.com ([209.85.219.177]:59243 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZCCRVM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 12:21:12 -0500
In-Reply-To: <1235995903.3858.83.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, mjg <mjg@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>


--=-qXNgvHX/aF4F/8ss5Hcn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've attached a patch that adds KEY_HIBERNATE and clarifies the uses of
KEY_SUSPEND and KEY_SLEEP.

Please consider. Thanks.

Richard Hughes


--=-qXNgvHX/aF4F/8ss5Hcn
Content-Disposition: attachment; filename*0=0001-INPUT-add-KEY_HIBERNATE-and-clarify-the-uses-of-KEY.patc; filename*1=h
Content-Type: text/x-patch; name="0001-INPUT-add-KEY_HIBERNATE-and-clarify-the-uses-of-KEY.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From bc161c6e4253d94dee3b1c42dfcf32a0120921a1 Mon Sep 17 00:00:00 2001
From: Richard Hughes <richard@hughsie.com>
Date: Tue, 3 Mar 2009 17:16:49 +0000
Subject: [PATCH] INPUT: add KEY_HIBERNATE and clarify the uses of KEY_SUSPEND and KEY_SLEEP

Add a new key define that is used for sleeping to disk.

In userspace we've agreed with the following nomenclature:
 - standby = sleep CPU and devices (not really used any more)
 - suspend = sleep to memory (quite fast)
 - hibernate = sleep to disk (slow)

We've already converted Xorg, HAL, and most of userspace to use the same names.
Adding a new key should reduce the confusion where:

KEY_SUSPEND was mapped to XF86Standby, XF86Hibernate or XF86Sleep
KEY_SLEEP was mapped to XF86Hibernate or XF86Standby

With this patch, the sleep keys can be labeled consistently all the way
through the stack. Other patches to device drivers are to follow.

Signed-off-by: Richard Hughes <hughsient@gmail.com>
---
 include/linux/input.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 1249a0c..f5dee33 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -263,7 +263,7 @@ struct input_absinfo {
 #define KEY_MENU		139	/* Menu (show menu) */
 #define KEY_CALC		140	/* AL Calculator */
 #define KEY_SETUP		141
-#define KEY_SLEEP		142	/* SC System Sleep */
+#define KEY_SLEEP		142	/* SC System Sleep (either RAM or disk) */
 #define KEY_WAKEUP		143	/* System Wake Up */
 #define KEY_FILE		144	/* AL Local Machine Browser */
 #define KEY_SENDFILE		145
@@ -324,7 +324,7 @@ struct input_absinfo {
 #define KEY_PROG3		202
 #define KEY_PROG4		203
 #define KEY_DASHBOARD		204	/* AL Dashboard */
-#define KEY_SUSPEND		205
+#define KEY_SUSPEND		205	/* Sleep state, typically to RAM */
 #define KEY_CLOSE		206	/* AC Close */
 #define KEY_PLAY		207
 #define KEY_FASTFORWARD		208
@@ -375,6 +375,8 @@ struct input_absinfo {
 
 #define KEY_WIMAX		246
 
+#define KEY_HIBERNATE		247	/* Sleep state, typically to disk */
+
 /* Range 248 - 255 is reserved for special needs of AT keyboard driver */
 
 #define BTN_MISC		0x100
-- 
1.6.1.3


--=-qXNgvHX/aF4F/8ss5Hcn--

