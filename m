From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2] HID: fix error message in hid_open_report()
Date: Fri, 23 Aug 2019 21:15:27 +0200
Message-ID: <5866b49b330a750b44003ebd9f532541dcb13f18.1566587656.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On HID report descriptor parsing error the code displays bogus
pointer instead of error offset (subtracts start=NULL from end).
Make the message more useful by displaying correct error offset
and include total buffer size for reference.

This was carried over from ancient times - "Fixed" commit just
promoted the message from DEBUG to ERROR.

Cc: stable@vger.kernel.org
Fixes: 8c3d52fc393b ("HID: make parser more verbose about parsing errors by default")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
v2: fixed printf() warning spotted by Jiri Kosina <jikos@kernel.org>

 * against v5.2.9

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/hid/hid-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 210b81a56e1a..3af76624e4aa 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1139,6 +1139,7 @@ int hid_open_report(struct hid_device *device)
 	__u8 *start;
 	__u8 *buf;
 	__u8 *end;
+	__u8 *next;
 	int ret;
 	static int (*dispatch_type[])(struct hid_parser *parser,
 				      struct hid_item *item) = {
@@ -1192,7 +1193,8 @@ int hid_open_report(struct hid_device *device)
 	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
 
 	ret = -EINVAL;
-	while ((start = fetch_item(start, end, &item)) != NULL) {
+	while ((next = fetch_item(start, end, &item)) != NULL) {
+		start = next;
 
 		if (item.format != HID_ITEM_FORMAT_SHORT) {
 			hid_err(device, "unexpected long global item\n");
@@ -1230,7 +1232,8 @@ int hid_open_report(struct hid_device *device)
 		}
 	}
 
-	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
+	hid_err(device, "item fetching failed at offset %u/%u\n",
+		size - (unsigned int)(end - start), size);
 err:
 	kfree(parser->collection_stack);
 alloc_err:
-- 
2.20.1
