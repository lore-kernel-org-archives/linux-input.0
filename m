From: "hartleys" <hartleys@visionengravers.com>
Subject: [PATCH 1/5] input: New MATRIX_KEY macro
Date: Fri, 30 Jan 2009 13:45:43 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909011A5466@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob109.obsmtp.com ([64.18.1.22]:47944 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751601AbZA3SqQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2009 13:46:16 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Introduce new macro to input.h for packing matrix keypad keycodes.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/include/linux/input.h b/include/linux/input.h
index 1249a0c..0879493 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -598,6 +598,14 @@ struct input_absinfo {
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
+/*
  * Relative axes
  */
 
