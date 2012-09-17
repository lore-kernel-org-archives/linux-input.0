From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH] HID: wiimote: fix weight conversion error for values >
 17kg
Date: Mon, 17 Sep 2012 21:15:40 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1209172114000.3968@butterbrot>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:36246 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417Ab2IQTPq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 15:15:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@googlemail.com

Signed-Off-By: Florian Echtler <floe@butterbrot.org>
---
  drivers/hid/hid-wiimote-ext.c |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index fc98cc9..bc85bf2 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -585,7 +585,8 @@ static void handler_balance_board(struct wiimote_ext *ext, const __u8 *payload)
  		} else {
  			tmp = val[i] - ext->calib[i][1];
  			tmp *= 1700;
-			tmp /= ext->calib[i][2] - ext->calib[i][1] + 1700;
+			tmp /= ext->calib[i][2] - ext->calib[i][1];
+			tmp += 1700;
  		}
  		val[i] = tmp;
  	}
-- 
1.7.9.5

