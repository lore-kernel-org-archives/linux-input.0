From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH] Input: elantech - add new icbody type 15
Date: Sun, 19 Nov 2017 22:56:47 +0800
Message-ID: <20171119145647.4327-1-aaron.ma@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51719 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbdKSO5Z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 19 Nov 2017 09:57:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com

The touchpad of Lenovo Thinkpad L480 reports it's version as 15.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index b84cd978fce2..a4aaa748e987 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1613,7 +1613,7 @@ static int elantech_set_properties(struct elantech_data *etd)
 		case 5:
 			etd->hw_version = 3;
 			break;
-		case 6 ... 14:
+		case 6 ... 15:
 			etd->hw_version = 4;
 			break;
 		default:
-- 
2.13.6

