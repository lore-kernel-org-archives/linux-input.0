From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: ams_delta_serio: fix spelling mistake: "paritiy" -> "parity"
Date: Thu, 23 Jun 2016 10:12:25 +0100
Message-ID: <1466673145-2220-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51177 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbcFWJMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 05:12:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_warn message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/serio/ams_delta_serio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 45887e3..3df501c 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -56,7 +56,7 @@ static int check_data(int data)
 	/* it should be odd */
 	if (!(parity & 0x01)) {
 		dev_warn(&ams_delta_serio->dev,
-				"paritiy check failed, data=0x%X parity=0x%X\n",
+				"parity check failed, data=0x%X parity=0x%X\n",
 				data, parity);
 		return SERIO_PARITY;
 	}
-- 
2.8.1

