From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend] HID: Fix return values in hid-core.c
Date: Mon, 17 Sep 2012 16:41:56 +0530
Message-ID: <1347880316-24604-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41325 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749Ab2IQLPO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 07:15:14 -0400
Received: by dady13 with SMTP id y13so823904dad.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 04:15:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, sachin.kamat@linaro.org, patches@linaro.org

Return -ENOMEM instead of -1 if memory allocation fails.
Return -EINVAL instead of -1 for stack overflow and
underflow errors.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/hid/hid-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 16d6454..80b0218 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -126,7 +126,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 
 	if (parser->collection_stack_ptr == HID_COLLECTION_STACK_SIZE) {
 		hid_err(parser->device, "collection stack overflow\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	if (parser->device->maxcollection == parser->device->collection_size) {
@@ -134,7 +134,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 				parser->device->collection_size * 2, GFP_KERNEL);
 		if (collection == NULL) {
 			hid_err(parser->device, "failed to reallocate collection array\n");
-			return -1;
+			return -ENOMEM;
 		}
 		memcpy(collection, parser->device->collection,
 			sizeof(struct hid_collection) *
@@ -170,7 +170,7 @@ static int close_collection(struct hid_parser *parser)
 {
 	if (!parser->collection_stack_ptr) {
 		hid_err(parser->device, "collection stack underflow\n");
-		return -1;
+		return -EINVAL;
 	}
 	parser->collection_stack_ptr--;
 	return 0;
-- 
1.7.4.1

