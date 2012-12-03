From: Diego Calleja <diegocg@gmail.com>
Subject: [PATCH] Fix touch support for wacom bamboo fun CTH-461
Date: Tue, 04 Dec 2012 00:56:50 +0100
Message-ID: <3305232.JQ4fXkYdWp@diego-arch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50585 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab2LCX7e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Dec 2012 18:59:34 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so1308609wey.19
        for <linux-input@vger.kernel.org>; Mon, 03 Dec 2012 15:59:33 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>

Commit f393ee2b814e3291c12565000210b3cf10aa5c1d forgot to add the
touch_max property for wacom bamboo fun CTH-461/S, id 056a:00d2.

This broke the touch functionality for that device. This patch,
(done with help of Ping Cheng), adds the correct value and makes
touch work again.

(Note: this problem exists since 3.5, so it may be a candidate for
-stable)


Signed-off-by: Diego Calleja <diegocg@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux/drivers/input/tablet/wacom_wac.c
===================================================================
--- linux.orig/drivers/input/tablet/wacom_wac.c
+++ linux/drivers/input/tablet/wacom_wac.c
@@ -2034,7 +2034,8 @@ static const struct wacom_features wacom
 	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD2 =
 	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
-	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 2 };
 static const struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,

