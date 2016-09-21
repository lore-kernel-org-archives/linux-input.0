From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] Input: rmi_f54 - fix non static symbol warning
Date: Wed, 21 Sep 2016 15:14:58 +0000
Message-ID: <1474470898-8747-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36087 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933395AbcIUPPH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Sep 2016 11:15:07 -0400
Received: by mail-pf0-f193.google.com with SMTP id n24so2509224pfb.3
        for <linux-input@vger.kernel.org>; Wed, 21 Sep 2016 08:15:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Nick Dyer <nick@shmanahar.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-input@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/input/rmi4/rmi_f54.c:79:12: warning:
 symbol 'rmi_f54_report_type_names' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/input/rmi4/rmi_f54.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index cf805b9..65ac9d9 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -76,7 +76,7 @@ enum rmi_f54_report_type {
 	F54_MAX_REPORT_TYPE,
 };
 
-const char *rmi_f54_report_type_names[] = {
+static const char * const rmi_f54_report_type_names[] = {
 	[F54_REPORT_NONE]		= "Unknown",
 	[F54_8BIT_IMAGE]		= "Normalized 8-Bit Image",
 	[F54_16BIT_IMAGE]		= "Normalized 16-Bit Image",



