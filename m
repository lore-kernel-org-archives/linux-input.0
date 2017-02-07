From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 05/18] HID: Improve two size determinations in
 hid_open_report()
Date: Tue, 7 Feb 2017 20:46:47 +0100
Message-ID: <08ff35e1-d9f4-2296-c641-d6a28e951594@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Feb 2017 22:00:07 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 404eccd0d670..16c73bf49d55 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -975,7 +975,7 @@ int hid_open_report(struct hid_device *device)
 	device->rdesc = start;
 	device->rsize = size;
 
-	parser = vzalloc(sizeof(struct hid_parser));
+	parser = vzalloc(sizeof(*parser));
 	if (!parser) {
 		ret = -ENOMEM;
 		goto err;
@@ -986,7 +986,7 @@ int hid_open_report(struct hid_device *device)
 	end = start + size;
 
 	device->collection = kcalloc(HID_DEFAULT_NUM_COLLECTIONS,
-				     sizeof(struct hid_collection), GFP_KERNEL);
+				     sizeof(*device->collection), GFP_KERNEL);
 	if (!device->collection) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.11.1

