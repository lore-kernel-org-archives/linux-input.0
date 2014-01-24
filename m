From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 15/15] Input: synaptics-rmi4 - correct RMI4 spec url
Date: Thu, 23 Jan 2014 16:00:23 -0800
Message-ID: <1390521623-6491-16-git-send-email-courtney.cavin@sonymobile.com>
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
 <1390521623-6491-14-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19880 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755582AbaAXAAK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 19:00:10 -0500
In-Reply-To: <1390521623-6491-15-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 9d8d6ec..9d845a4 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -7,7 +7,7 @@
  * The RMI4 specification can be found here (URL split for line length):
  *
  * http://www.synaptics.com/sites/default/files/
- *      511-000136-01-Rev-E-RMI4%20Intrfacing%20Guide.pdf
+ *      511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
-- 
1.8.1.5

