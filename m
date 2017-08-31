From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: bits shifted too much for 9th and 10th buttons
Date: Thu, 31 Aug 2017 15:50:03 -0700
Message-ID: <20170831225003.5247-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37838 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdHaWuM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 31 Aug 2017 18:50:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id a2so571826pfj.4
        for <linux-input@vger.kernel.org>; Thu, 31 Aug 2017 15:50:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>

Cintiq 12 has 10 expresskey buttons. The bit shift for the last
two buttons were off by 5.

Fixes: c7f0522 ("HID: wacom: Slim down wacom_intuos_pad processing")

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Matthieu Robin <matthieu@macolu.org>
---
 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9f94029..801889c 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -567,8 +567,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
 				keys = data[9] & 0x07;
 			}
 		} else {
-			buttons = ((data[6] & 0x10) << 10) |
-			          ((data[5] & 0x10) << 9)  |
+			buttons = ((data[6] & 0x10) << 5)  |
+			          ((data[5] & 0x10) << 4)  |
 			          ((data[6] & 0x0F) << 4)  |
 			          (data[5] & 0x0F);
 		}
-- 
2.7.4

