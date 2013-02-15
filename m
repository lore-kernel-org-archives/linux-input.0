From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 1/2] Input: MT - do not apply filtering on emulated events
Date: Fri, 15 Feb 2013 20:36:20 +0100
Message-ID: <1360956981-1112-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:48558 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab3BOTfp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Feb 2013 14:35:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

The pointer emulation events are derived from contact values that
have already been filtered, so send the emulated events as is.

Reported-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/input-mt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 1abbc17..1b7f4d4 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -18,6 +18,7 @@ static void copy_abs(struct input_dev *dev, unsigned int dst, unsigned int src)
 {
 	if (dev->absinfo && test_bit(src, dev->absbit)) {
 		dev->absinfo[dst] = dev->absinfo[src];
+		dev->absinfo[dst].fuzz = 0;
 		dev->absbit[BIT_WORD(dst)] |= BIT_MASK(dst);
 	}
 }
-- 
1.8.1.2

