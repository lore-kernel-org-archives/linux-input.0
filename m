From: Sam hung <sam.hung@emc.com.tw>
Subject: [PATCH] booboo[ADD] 1.support new ic type for version 4.
Date: Thu,  8 Jan 2015 17:13:43 +0800
Message-ID: <1420708423-19272-1-git-send-email-sam.hung@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:7983 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbbAHJOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 04:14:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: dusonlin@emc.com.tw, Sam hung <sam.hung@emc.com.tw>

Signed-off-by: Yi ju Hong <sam.hung@emc.com.tw>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index f2b9780..77ecf6d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1520,6 +1520,8 @@ static int elantech_set_properties(struct elantech_data *etd)
 		case 7:
 		case 8:
 		case 9:
+		case 10:
+		case 13:
 			etd->hw_version = 4;
 			break;
 		default:
-- 
1.8.3.2

