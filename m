From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH 2/4] Input: ads7846 - add a include header to prevent building fails
Date: Thu, 16 Sep 2010 18:51:24 +0800
Message-ID: <1284634286-8871-3-git-send-email-jason77.wang@gmail.com>
References: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
 <1284634286-8871-2-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38243 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab0IPKr5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 06:47:57 -0400
In-Reply-To: <1284634286-8871-2-git-send-email-jason77.wang@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, notasas@gmail.com, vapier@gentoo.org
Cc: linux-input@vger.kernel.org

After we switch this driver to use thread IRQ, we introduce some
kthread macros, when we build this driver, we will get errors like
that:
ds7846.c: In function 'ads7846_stop':
ads7846.c:205: error: 'TASK_NORMAL' undeclared (first use in ...)
ads7846.c:205: error: (Each undeclared identifier is ...)
ads7846.c:205: error: for each function it appears in.)

Here add a header file to fix this error.

Signed-off-by: Jason Wang <jason77.wang@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index d1fc8ef..5ddaeea 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -21,6 +21,7 @@
 #include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-- 
1.5.6.5

