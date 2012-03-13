From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 03/20] Input: atmel_mxt_ts - verify object size in mxt_write_object
Date: Tue, 13 Mar 2012 20:04:06 +0800
Message-ID: <1331640263-18935-4-git-send-email-djkurtz@chromium.org>
References: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:51938 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab2CMMEa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 08:04:30 -0400
Received: by ggnd2 with SMTP id d2so62545ggn.1
        for <linux-input@vger.kernel.org>; Tue, 13 Mar 2012 05:04:29 -0700 (PDT)
In-Reply-To: <1331640263-18935-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Iiro Valkonen <iiro.valkonen@atmel.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>

Don't allow writing past the length of an object.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0d4d492..e18c698 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -506,7 +506,7 @@ static int mxt_write_object(struct mxt_data *data,
 	u16 reg;
 
 	object = mxt_get_object(data, type);
-	if (!object)
+	if (!object || offset >= object->size)
 		return -EINVAL;
 
 	reg = object->start_address;
-- 
1.7.7.3

