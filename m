From: weiyj_lk@163.com
Subject: [PATCH -next] Input: soc_button_array - remove duplicated include from soc_button_array.c
Date: Thu, 16 Apr 2015 21:12:00 +0800
Message-ID: <1429189920-24334-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:42951 "EHLO m12-18.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757494AbbDPNNl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2015 09:13:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>, Jin Yao <yao.jin@linux.intel.com>, Lejun Zhu <lejun.zhu@linux.intel.com>, Pramod Gurav <pramod.gurav@smartplayin.com>, Alexandre Courbot <acourbot@nvidia.com>, Bastien Nocera <hadess@hadess.net>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-input@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/input/misc/soc_button_array.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index e8e010a..c14b827 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -18,7 +18,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/platform_device.h>
-#include <linux/acpi.h>
 
 /*
  * Definition of buttons on the tablet. The ACPI index of each button

