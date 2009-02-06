From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH 1/5] input: New MATRIX_KEY macro
Date: Fri, 6 Feb 2009 17:48:28 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090120BD37@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og115.obsmtp.com ([64.18.1.35]:57404 "HELO
	exprod6og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752327AbZBFWtX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2009 17:49:23 -0500
Content-class: urn:content-classes:message
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>

Introduce new macro to input.h for packing matrix keypad keycodes.

As suggested by David Brownell, add two driver-internal defines:
     * MATRIX_ROWCOL_MASK to strip R/C from MATRIX_KEY()
     * MATRIX_KEYCODE_MASK to stip the keycode from a MATRIX_KEY()

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Brownell <david-b@pacbell.net>

---

diff --git a/include/linux/input.h b/include/linux/input.h
index 1249a0c..6d88780 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -598,6 +598,17 @@ struct input_absinfo {
 #define KEY_CNT			(KEY_MAX+1)
 
 /*
+ * Macro to pack the row/col of a key on a matrix keypad and it's
associated
+ * KEY_* code into into an array.  4 bits are used for both the row and
column
+ * allowing for up to a 16x16 keypad.  The row (_r) and column (_c) are
+ * interchangable depending on a keypad drivers usage.
+ */
+#define MATRIX_KEY(_r, _c, _v)	(((_r) << 28) | ((_c) << 24) | (_v))
+
+#define MATRIX_ROWCOL_MASK	0xff000000
+#define MATRIX_KEYCODE_MASK	0x00ffffff
+
+/*
  * Relative axes
  */
  
