From: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Subject: [PATCH] Allow kxtj9 accelerometer driver to work on kxtf9
Date: Sat, 14 Jan 2012 04:56:57 +0400
Message-ID: <1326502617-26879-1-git-send-email-alexander.tarasikov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53383 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab2ANA5U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Jan 2012 19:57:20 -0500
Received: by bkuw12 with SMTP id w12so375845bku.19
        for <linux-input@vger.kernel.org>; Fri, 13 Jan 2012 16:57:19 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Alexander Tarasikov <alexander.tarasikov@gmail.com>

	Kionix kxtj9 is a pin- and register-compatible replacement
	for the kxtf9 accelerometer. This patch makes the kxtj9 driver
	probe routine accept kxtf9. This has been tested briefly on
	a kxtf9 accelerometer and seems to report correct results.

Signed-off-by: Alexander Tarasikov <alexander.tarasikov@gmail.com>
---
 drivers/input/misc/kxtj9.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 783597a..c54fe18 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -487,7 +487,10 @@ static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
 		goto out;
 	}
 
-	retval = retval != 0x06 ? -EIO : 0;
+	if (retval == 0x6 || retval == 0x1)
+		retval = 0;
+	else
+		retval = -EIO;
 
 out:
 	kxtj9_device_power_off(tj9);
-- 
1.7.7.3

