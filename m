From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] gpio_keys: fix struct device declared inside parameter list
Date: Thu, 12 Jan 2012 10:11:31 +0100
Message-ID: <201201121011.31840.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:58047 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab2ALJLi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jan 2012 04:11:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

A struct device parameter is used in the enable and disable callbacks to
distinguish between different gpio_keys devices.

Platforms that don't use these callbacks may not include struct device
at all, as seen on arch/arm/mach-s3c2410/mach-n30.c

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/gpio_keys.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index b5ca4b2..004ff33 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -1,6 +1,8 @@
 #ifndef _GPIO_KEYS_H
 #define _GPIO_KEYS_H
 
+struct device;
+
 struct gpio_keys_button {
 	/* Configuration parameters */
 	unsigned int code;	/* input event code (KEY_*, SW_*) */
-- 
1.7.5.4

