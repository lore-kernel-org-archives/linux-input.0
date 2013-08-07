From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: htcpen - Fix incorrect placement of __initdata
Date: Wed,  7 Aug 2013 15:09:06 +0530
Message-ID: <1375868346-28851-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33849 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab3HGJzw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Aug 2013 05:55:52 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so1700984pbc.29
        for <linux-input@vger.kernel.org>; Wed, 07 Aug 2013 02:55:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Pau Oliva Fora <pau@eslack.org>

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Pau Oliva Fora <pau@eslack.org>
---
 drivers/input/touchscreen/htcpen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/htcpen.c b/drivers/input/touchscreen/htcpen.c
index 6c4fb84..6650085 100644
--- a/drivers/input/touchscreen/htcpen.c
+++ b/drivers/input/touchscreen/htcpen.c
@@ -221,7 +221,7 @@ static struct isa_driver htcpen_isa_driver = {
 	}
 };
 
-static struct dmi_system_id __initdata htcshift_dmi_table[] = {
+static struct dmi_system_id htcshift_dmi_table[] __initdata = {
 	{
 		.ident = "Shift",
 		.matches = {
-- 
1.7.9.5

