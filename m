From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 02/15] Input: synaptics-rmi4 - don't kfree devm_ alloced memory
Date: Thu, 23 Jan 2014 16:00:10 -0800
Message-ID: <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19723 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751957AbaAWX7S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 18:59:18 -0500
In-Reply-To: <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_f01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index cf1081f..98bc65a9 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -390,7 +390,7 @@ static int rmi_f01_initialize(struct rmi_function *fn)
 	return 0;
 
  error_exit:
-	kfree(data);
+	devm_kfree(&fn->dev, data);
 	return error;
 }
 
-- 
1.8.1.5

