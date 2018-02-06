From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] HID: core: Delete an error message for a failed memory
 allocation in open_collection()
Date: Tue, 6 Feb 2018 17:47:12 +0100
Message-ID: <92b58eb4-e68b-f7eb-d99e-5d0993ad18b6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:40:51 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c2560aae5542..5ad5f52f6f9b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -133,10 +133,9 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 	if (parser->device->maxcollection == parser->device->collection_size) {
 		collection = kmalloc(sizeof(struct hid_collection) *
 				parser->device->collection_size * 2, GFP_KERNEL);
-		if (collection == NULL) {
-			hid_err(parser->device, "failed to reallocate collection array\n");
+		if (!collection)
 			return -ENOMEM;
-		}
+
 		memcpy(collection, parser->device->collection,
 			sizeof(struct hid_collection) *
 			parser->device->collection_size);
-- 
2.16.1

