From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 03/18] HID: Use kmalloc_array() in open_collection()
Date: Tue, 7 Feb 2017 20:42:04 +0100
Message-ID: <2db59cee-8bb5-9b53-993b-c03fe5c58225@users.sourceforge.net>
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
Date: Mon, 6 Feb 2017 19:09:42 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ffb7e5d4ee19..51f3547ca44f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -131,8 +131,9 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 	}
 
 	if (parser->device->maxcollection == parser->device->collection_size) {
-		collection = kmalloc(sizeof(struct hid_collection) *
-				parser->device->collection_size * 2, GFP_KERNEL);
+		collection = kmalloc_array(parser->device->collection_size * 2,
+					   sizeof(*collection),
+					   GFP_KERNEL);
 		if (!collection)
 			return -ENOMEM;
 
-- 
2.11.1
