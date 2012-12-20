From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/4] input: adxl34x: make platform_data include self contained
Date: Thu, 20 Dec 2012 14:51:10 +0100
Message-ID: <1356011471-18757-4-git-send-email-w.sang@pengutronix.de>
References: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50893 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab2LTNv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 08:51:29 -0500
In-Reply-To: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, Wolfram Sang <w.sang@pengutronix.de>

Since it suggests to use defines from input.h (ABS_X, ...), also include
the file to make them available.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 include/linux/input/adxl34x.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/input/adxl34x.h b/include/linux/input/adxl34x.h
index 57e01a7..010d981 100644
--- a/include/linux/input/adxl34x.h
+++ b/include/linux/input/adxl34x.h
@@ -13,6 +13,8 @@
 #ifndef __LINUX_INPUT_ADXL34X_H__
 #define __LINUX_INPUT_ADXL34X_H__
 
+#include <linux/input.h>
+
 struct adxl34x_platform_data {
 
 	/*
-- 
1.7.10.4

