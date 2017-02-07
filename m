From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 04/18] HID: Improve another size determination in
 open_collection()
Date: Tue, 7 Feb 2017 20:43:30 +0100
Message-ID: <19c977dd-521b-c284-adc5-ee4050f3297b@users.sourceforge.net>
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
Date: Mon, 6 Feb 2017 19:19:22 +0100

Replace the specification of a data structure by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 51f3547ca44f..404eccd0d670 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -138,11 +138,9 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 			return -ENOMEM;
 
 		memcpy(collection, parser->device->collection,
-			sizeof(struct hid_collection) *
-			parser->device->collection_size);
+		       sizeof(*collection) * parser->device->collection_size);
 		memset(collection + parser->device->collection_size, 0,
-			sizeof(struct hid_collection) *
-			parser->device->collection_size);
+		       sizeof(*collection) * parser->device->collection_size);
 		kfree(parser->device->collection);
 		parser->device->collection = collection;
 		parser->device->collection_size *= 2;
-- 
2.11.1
