From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH] handle EV_PWR in input_set_capability
Date: Tue, 11 Dec 2007 18:18:59 +0300
Message-ID: <20071211151859.GA7965@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752561AbXLKPTV@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Handle EV_PWR type of input caps.

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>

Index: linux-test/drivers/input/input.c
===================================================================
--- linux-test.orig/drivers/input/input.c	2007-12-11 17:47:37.736228749 +0300
+++ linux-test/drivers/input/input.c	2007-12-11 17:47:52.620224309 +0300
@@ -1080,6 +1080,10 @@ void input_set_capability(struct input_d
 		__set_bit(code, dev->ffbit);
 		break;
 
+	case EV_PWR:
+		/* do nothing */
+		break;
+
 	default:
 		printk(KERN_ERR
 			"input_set_capability: unknown type %u (code %u)\n",
