From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: pxa27x_keypad: fix typo "debpunce" -> "debounce"
Date: Tue, 25 Oct 2016 12:03:12 +0100
Message-ID: <20161025110312.7505-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38391 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965640AbcJYLDO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Oct 2016 07:03:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to typo in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/keyboard/pxa27x_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index fcef5d1..e244433 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -316,7 +316,7 @@ static int pxa27x_keypad_build_keycode_from_dt(struct pxa27x_keypad *keypad)
 	error = of_property_read_u32(np, "marvell,debounce-interval",
 				     &pdata->debounce_interval);
 	if (error) {
-		dev_err(dev, "failed to parse debpunce-interval\n");
+		dev_err(dev, "failed to parse debounce-interval\n");
 		return error;
 	}
 
-- 
2.9.3

