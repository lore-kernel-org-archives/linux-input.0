From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 2/3] gpio_keys: use <linux/gpio.h> instead of <asm/gpio.h>
Date: Tue, 10 Nov 2009 22:59:39 +0000
Message-ID: <20091110230002.668609324@fluff.org.uk>
References: <20091110225937.922379610@fluff.org.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:42288 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758627AbZKJW75 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 17:59:57 -0500
Content-Disposition: inline; filename=simtec/ready/gpio-buttons-fix-include.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simtec Linux Team <linux@simtec.co.uk>

The gpio keys driver should be using <linux/gpio.h> instead of <asm/gpio.h>

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/input/keyboard/gpio_keys.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/input/keyboard/gpio_keys.c
===================================================================
--- a/drivers/input/keyboard/gpio_keys.c	2009-11-02 21:45:30.000000000 +0000
+++ b/drivers/input/keyboard/gpio_keys.c	2009-11-02 22:03:01.000000000 +0000
@@ -23,8 +23,7 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
-
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 
 struct gpio_button_data {
 	struct gpio_keys_button *button;

