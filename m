From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH] GPIO-KEY: Add flag to allow gpio key auto repeat.
Date: Mon, 20 Oct 2008 19:44:41 -0500
Message-ID: <200810201944.42118.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48868 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbYJUAos (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Oct 2008 20:44:48 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9L0ihAU016287
	for <linux-input@vger.kernel.org>; Mon, 20 Oct 2008 19:44:48 -0500
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m9L0igZq014718
	for <linux-input@vger.kernel.org>; Mon, 20 Oct 2008 19:44:42 -0500 (CDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This patch adds a flag to gpio-key driver to turn on the input subsystems 
auto repeat feature if needed.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 drivers/input/keyboard/gpio_keys.c |    4 ++++
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 drivers/input/keyboard/gpio_keys.c
 mode change 100644 => 100755 include/linux/gpio_keys.h

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
old mode 100644
new mode 100755
index 05f3f43..722529c
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -98,6 +98,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	/* Enable auto repeat feature of Linux input subsystem */
+	if (pdata->rep)
+		set_bit(EV_REP, input->evbit);
+
 	ddata->input = input;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
old mode 100644
new mode 100755
index ec6ecd7..1289fa7
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -15,6 +15,7 @@ struct gpio_keys_button {
 struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
+	unsigned int rep:1;		/* enable input subsystem auto repeat */
 };
 
 #endif
-- 
1.5.4.1

