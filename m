From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] input: touchscreen: mxs-lradc: Make symbol mxs_lradc_ts_irq_names static
Date: Tue, 25 Apr 2017 06:27:04 +0000
Message-ID: <20170425062704.26222-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35957 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S980608AbdDYG1K (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 02:27:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so6917320pfd.3
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 23:27:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/input/touchscreen/mxs-lradc-ts.c:33:12: warning:
 symbol 'mxs_lradc_ts_irq_names' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/input/touchscreen/mxs-lradc-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index 4b4aebf..603ac5a 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -30,7 +30,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
-const char *mxs_lradc_ts_irq_names[] = {
+static const char *mxs_lradc_ts_irq_names[] = {
 	"mxs-lradc-touchscreen",
 	"mxs-lradc-channel6",
 	"mxs-lradc-channel7",

