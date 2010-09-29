From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH] Input: i8042 - use unsigned char for 0x90
Date: Wed, 29 Sep 2010 10:34:06 +0200
Message-ID: <1285749246.7370.5.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37264 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab0I2I1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 04:27:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kernel-janitors <kernel-janitors@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Keep the file consistent and make clear that we mean 144 instead of -112.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/input/serio/i8042.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index f585131..18db5a8 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1063,7 +1063,7 @@ static long i8042_panic_blink(int state)
 #ifdef CONFIG_X86
 static void i8042_dritek_enable(void)
 {
-	char param = 0x90;
+	unsigned char param = 0x90;
 	int error;
 
 	error = i8042_command(&param, 0x1059);
-- 
1.7.1

