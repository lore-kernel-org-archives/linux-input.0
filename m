From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: tnetv107x-ts - add missing include of linux/module.h
Date: Sun, 21 Aug 2011 16:44:29 +0800
Message-ID: <1313916269.17491.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37993 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab1HUIoj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Aug 2011 04:44:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Cyril Chemparathy <cyril@ti.com>, linux-input@vger.kernel.org

tnetv107x-ts.c uses interfaces from linux/module.h,
so it should include that file.  This patch fixes build errors.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/tnetv107x-ts.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index 089b0a0..0e8f63e 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-- 
1.7.4.1



