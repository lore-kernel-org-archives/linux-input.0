From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: sony: remove redundant check for -ve err
Date: Mon, 27 Mar 2017 18:51:18 +0100
Message-ID: <20170327175118.28322-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:53064 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdC0Rv2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 13:51:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

err is being checked for failure each time it is being updated
so this err check is totally redundant and can be removed

Detected with CoverityScan, CID#1420665 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-sony.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index bb124e339d26..e3c6fe554056 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2614,9 +2614,6 @@ static int sony_input_configured(struct hid_device *hdev,
 		ret = 0;
 	}
 
-	if (ret < 0)
-		goto err_stop;
-
 	if (sc->quirks & SONY_LED_SUPPORT) {
 		ret = sony_leds_init(sc);
 		if (ret < 0)
-- 
2.11.0

