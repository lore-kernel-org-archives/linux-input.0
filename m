From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] HID: Fix return value in hid-core.c
Date: Fri, 14 Sep 2012 17:16:17 +0530
Message-ID: <1347623177-14221-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46423 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2INLt1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 07:49:27 -0400
Received: by pbbrr13 with SMTP id rr13so5511808pbb.19
        for <linux-input@vger.kernel.org>; Fri, 14 Sep 2012 04:49:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, sachin.kamat@linaro.org, patches@linaro.org

Return -ENOMEM instead of -1 if memory allocation fails.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hid/hid-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 16d6454..1011a22 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -134,7 +134,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 				parser->device->collection_size * 2, GFP_KERNEL);
 		if (collection == NULL) {
 			hid_err(parser->device, "failed to reallocate collection array\n");
-			return -1;
+			return -ENOMEM;
 		}
 		memcpy(collection, parser->device->collection,
 			sizeof(struct hid_collection) *
-- 
1.7.4.1

