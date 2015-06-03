From: =?big5?B?rHikQKbLIA==?= <sam.hung@emc.com.tw>
Subject: [PATCH] Input: Elantech- add new icbody type
Date: Wed, 3 Jun 2015 16:26:33 +0800
Message-ID: <013b01d09dd7$03856e30$0a904a90$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:27385 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282AbbFCIge (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Jun 2015 04:36:34 -0400
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: 'duson' <dusonlin@emc.com.tw>


add new icbody type for the h/w connect with elantech driver.

Signed-off-by: Sam <sam.hung@emc.com.tw>
---
 drivers/input/mouse/elantech.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 79363b6..af40c59 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1555,6 +1555,7 @@ static int elantech_set_properties(struct
elantech_data *etd)
 		case 9:
 		case 10:
 		case 13:
+		case 14:
 			etd->hw_version = 4;
 			break;
 		default:

