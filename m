From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 05/16 v2] Input: atmel_mxt_ts - verify object size in mxt_write_object
Date: Fri, 30 Mar 2012 00:49:15 +0800
Message-ID: <1333039766-8617-6-git-send-email-djkurtz@chromium.org>
References: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:43225 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759730Ab2C2Qta (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 12:49:30 -0400
Received: by vbnl22 with SMTP id l22so275643vbn.1
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 09:49:29 -0700 (PDT)
In-Reply-To: <1333039766-8617-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>
Cc: Daniel Kurtz <djkurtz@chromium.org>

Don't allow writing past the length of an object.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 920b35c..242976d 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -501,7 +501,7 @@ static int mxt_write_object(struct mxt_data *data,
 	u16 reg;
 
 	object = mxt_get_object(data, type);
-	if (!object)
+	if (!object || offset >= object->size)
 		return -EINVAL;
 
 	reg = object->start_address;
-- 
1.7.7.3

