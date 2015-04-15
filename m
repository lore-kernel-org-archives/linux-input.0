From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/4] HID: wacom: remove unused packet lengths
Date: Wed, 15 Apr 2015 16:54:58 -0700
Message-ID: <1429142098-16912-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33161 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbbDOXzE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 19:55:04 -0400
Received: by pdbnk13 with SMTP id nk13so70045511pdb.0
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2015 16:55:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

We use generic hid_report_len() to get individual packet length now.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 4700ac9..f5a5f68 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -18,10 +18,7 @@
 #define WACOM_NAME_MAX		64
 
 /* packet length for individual models */
-#define WACOM_PKGLEN_PENPRTN	 7
-#define WACOM_PKGLEN_GRAPHIRE	 8
 #define WACOM_PKGLEN_BBFUN	 9
-#define WACOM_PKGLEN_INTUOS	10
 #define WACOM_PKGLEN_TPC1FG	 5
 #define WACOM_PKGLEN_TPC1FG_B	10
 #define WACOM_PKGLEN_TPC2FG	14
@@ -29,9 +26,6 @@
 #define WACOM_PKGLEN_BBTOUCH3	64
 #define WACOM_PKGLEN_BBPEN	10
 #define WACOM_PKGLEN_WIRELESS	32
-#define WACOM_PKGLEN_MTOUCH	62
-#define WACOM_PKGLEN_MTTPC	40
-#define WACOM_PKGLEN_DTUS	68
 #define WACOM_PKGLEN_PENABLED	 8
 #define WACOM_PKGLEN_BPAD_TOUCH	32
 #define WACOM_PKGLEN_BPAD_TOUCH_USB	64
-- 
1.9.1

