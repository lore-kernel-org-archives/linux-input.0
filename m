From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] [media] Input: fix missing unlock on error in rmi_f54_request_report()
Date: Tue, 13 Sep 2016 14:24:50 +0000
Message-ID: <1473776690-3748-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33784 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbcIMOY5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 10:24:57 -0400
Received: by mail-pa0-f67.google.com with SMTP id h5so9291850pao.0
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2016 07:24:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Nick Dyer <nick@shmanahar.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Add the missing unlock before return from function
rmi_f54_request_report() in the error handling case.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/input/rmi4/rmi_f54.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index bd86d3d..99a8836 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -198,8 +198,10 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
 	mutex_lock(&f54->data_mutex);
 
 	error = rmi_write(rmi_dev, fn->fd.command_base_addr, F54_GET_REPORT);
-	if (error < 0)
+	if (error < 0) {
+		mutex_unlock(&f54->data_mutex);
 		return error;
+	}
 
 	init_completion(&f54->cmd_done);

