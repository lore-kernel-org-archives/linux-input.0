From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] input: sirfsoc-onkey - set the capability of reporting KEY_POWER
Date: Tue, 25 Feb 2014 21:36:14 +0800
Message-ID: <1393335375-1870-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:43926 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbaBYNgn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Feb 2014 08:36:43 -0500
Received: by mail-pd0-f178.google.com with SMTP id fp1so7801822pdb.37
        for <linux-input@vger.kernel.org>; Tue, 25 Feb 2014 05:36:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Xianglong Du <Xianglong.Du@csr.com>

commit a1a7521064428fc1cf8 moved to report EV_KEY event(KEY_POWER) instead of
reporting EV_PWR event(KEY_SUSPEND), but it didn't enable the capability, so
the KEY_POWER will not be reported to userspace by input core. this patch fixes
the issue.

Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/input/misc/sirfsoc-onkey.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 4d66c72..e4104f9 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -136,6 +136,7 @@ static int sirfsoc_pwrc_probe(struct platform_device *pdev)
 	pwrcdrv->input->name = "sirfsoc pwrckey";
 	pwrcdrv->input->phys = "pwrc/input0";
 	pwrcdrv->input->evbit[0] = BIT_MASK(EV_KEY);
+	input_set_capability(pwrcdrv->input, EV_KEY, KEY_POWER);
 
 	INIT_DELAYED_WORK(&pwrcdrv->work, sirfsoc_pwrc_report_event);
 
-- 
1.7.9.5

