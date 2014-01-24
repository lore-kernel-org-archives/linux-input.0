From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 13/15] Input: synaptics-rmi4 - properly set F01 container on PDT scan
Date: Thu, 23 Jan 2014 16:00:21 -0800
Message-ID: <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-11-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-12-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19858 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753624AbaAXAAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 19:00:04 -0500
In-Reply-To: <1390521623-6491-13-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 52345ae..9d8d6ec 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -488,6 +488,8 @@ static int create_function(struct rmi_device *rmi_dev,
 		return error;
 
 	list_add_tail(&fn->node, &data->function_list);
+	if (pdt->function_number == 0x01)
+		data->f01_container = fn;
 
 	return 0;
 }
-- 
1.8.1.5

