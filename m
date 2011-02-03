From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 5/5] Add chip I2C addresses to header file
Date: Thu, 03 Feb 2011 16:13:09 +0200
Message-ID: <4D4AB7F5.3070704@atmel.com>
References: <4D3DAE3C.6060806@atmel.com> <20110124170756.GB31066@core.coreip.homeip.net> <4D3EA7DD.6000601@atmel.com> <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com> <20110203074318.GA5814@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:57514 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246Ab1BCOMz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 09:12:55 -0500
In-Reply-To: <20110203074318.GA5814@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

Input: qt602240_ts - Add chip I2C addresses to header file

From: Iiro Valkonen <iiro.valkonen@atmel.com>

Add chip I2C addresses to header file.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 include/linux/i2c/qt602240_ts.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt602240_ts.h
index 130f8bc..ee4bccd 100644
--- a/include/linux/i2c/qt602240_ts.h
+++ b/include/linux/i2c/qt602240_ts.h
@@ -13,6 +13,14 @@
 #ifndef __LINUX_MAXTOUCH_TS_H
 #define __LINUX_MAXTOUCH_TS_H
 
+/* Chip I2C Addresses */
+#define MXT224_I2C_ADDR1	0x4A
+#define MXT224_I2C_ADDR2	0x4B
+#define MXT1386_I2C_ADDR1	0x4C
+#define MXT1386_I2C_ADDR2	0x4D
+#define MXT1386_I2C_ADDR3	0x5A
+#define MXT1386_I2C_ADDR4	0x5B
+
 /* Orient */
 #define MXT_NORMAL		0x0
 #define MXT_DIAGONAL		0x1
-- 
1.7.0.4

