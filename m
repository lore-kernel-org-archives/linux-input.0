From: Samuel Ortiz <sameo@openedhand.com>
Subject: [PATCH] Fix pxa27x keypad KPC macros
Date: Tue, 19 Feb 2008 11:25:12 +0100
Message-ID: <20080219102511.GA6396@caravaggio>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp20.orange.fr ([193.252.22.29]:23361 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbYBSKZS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Feb 2008 05:25:18 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2013.orange.fr (SMTP Server) with ESMTP id 94C041C000B0
	for <linux-input@vger.kernel.org>; Tue, 19 Feb 2008 11:25:14 +0100 (CET)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eric Miao <eric.miao@marvell.com>

Hi Dmitry,

On the pxa27x keypad driver, we want to mask (key_number - 1), not
key_number.
The current implementation works fine for all values but the maximum
one, i.e. 8.

This patch is against your input git tree.

Signed-off-by: Samuel Ortiz <sameo@openedhand.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6-input/drivers/input/keyboard/pxa27x_keypad.c
===================================================================
--- linux-2.6-input.orig/drivers/input/keyboard/pxa27x_keypad.c	2008-02-19 11:10:04.000000000 +0100
+++ linux-2.6-input/drivers/input/keyboard/pxa27x_keypad.c	2008-02-19 11:11:00.000000000 +0100
@@ -50,9 +50,9 @@
 #define KPKDI           0x0048
 
 /* bit definitions */
-#define KPC_MKRN(n)	((((n) & 0x7) - 1) << 26) /* matrix key row number */
-#define KPC_MKCN(n)	((((n) & 0x7) - 1) << 23) /* matrix key column number */
-#define KPC_DKN(n)	((((n) & 0x7) - 1) << 6)  /* direct key number */
+#define KPC_MKRN(n)	((((n) - 1) & 0x7) << 26) /* matrix key row number */
+#define KPC_MKCN(n)	((((n) - 1) & 0x7) << 23) /* matrix key column number */
+#define KPC_DKN(n)	((((n) - 1) & 0x7) << 6)  /* direct key number */
 
 #define KPC_AS          (0x1 << 30)  /* Automatic Scan bit */
 #define KPC_ASACT       (0x1 << 29)  /* Automatic Scan on Activity */

