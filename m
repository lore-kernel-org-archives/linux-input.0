From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] HID: Use krealloc
Date: Wed,  1 Mar 2017 11:19:09 -0800
Message-ID: <4048f6d655d55b19fdaecab4e61f6883e12f72f0.1488395879.git.joe@perches.com>
References: <cover.1488395879.git.joe@perches.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:50372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752096AbdCATWH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 14:22:07 -0500
In-Reply-To: <cover.1488395879.git.joe@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This kmalloc/memcpy is equivalent to krealloc, so use krealloc
to avoid a possibly unnecessary memcpy.

Miscellanea:

o Add temporary variables osize and nsize to improve readability
o krealloc has a defect and does not support GFP_ZERO
  so the memset must be kept

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e9e87d337446..b1ebf53ca879 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -131,21 +131,19 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 	}
 
 	if (parser->device->maxcollection == parser->device->collection_size) {
-		collection = kmalloc(sizeof(struct hid_collection) *
-				parser->device->collection_size * 2, GFP_KERNEL);
-		if (collection == NULL) {
-			hid_err(parser->device, "failed to reallocate collection array\n");
+		unsigned int osize = parser->device->collection_size;
+		unsigned int nsize = osize * 2;
+
+		collection = krealloc(parser->device->collection,
+				      nsize * sizeof(struct hid_collection),
+				      GFP_KERNEL);
+		if (!collection)
 			return -ENOMEM;
-		}
-		memcpy(collection, parser->device->collection,
-			sizeof(struct hid_collection) *
-			parser->device->collection_size);
-		memset(collection + parser->device->collection_size, 0,
-			sizeof(struct hid_collection) *
-			parser->device->collection_size);
-		kfree(parser->device->collection);
+
+		memset(collection + osize, 0,
+		       sizeof(struct hid_collection) * osize);
 		parser->device->collection = collection;
-		parser->device->collection_size *= 2;
+		parser->device->collection_size = nsize;
 	}
 
 	parser->collection_stack[parser->collection_stack_ptr++] =
-- 
2.10.0.rc2.1.g053435c

