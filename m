From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 02/18] HID: Delete an error message for a failed memory
 allocation in open_collection()
Date: Tue, 7 Feb 2017 20:40:48 +0100
Message-ID: <d119e689-ee52-d492-ac83-108876015646@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Feb 2017 18:42:26 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: Possible unnecessary 'out of memory' message

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9b0a97bbde96..ffb7e5d4ee19 100644
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
2.11.1
