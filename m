From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3] HID: core: move Usage Page concatenation to Main item
Date: Tue, 26 Mar 2019 21:03:30 +0100
Message-ID: <20190326200331.25934-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: oneukum@suse.de, Terry.Junge@plantronics.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

As seen on some USB wireless keyboards manufactured by Primax, the HID
parser was using some assumptions that are not always true. In this case
it's s the fact that, inside the scope of a main item, an Usage Page
will always precede an Usage.

The spec is not pretty clear as 6.2.2.7 states "Any usage that follows
is interpreted as a Usage ID and concatenated with the Usage Page".
While 6.2.2.8 states "When the parser encounters a main item it
concatenates the last declared Usage Page with a Usage to form a
complete usage value." Being somewhat contradictory it was decided to
match Window's implementation, which follows 6.2.2.8.

In summary, the patch moves the Usage Page concatenation from the local
item parsing function to the main item parsing function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

v2->v3: - Update patch title

v1->v2: - Add usage concatenation to hid_scan_main()
	- Rework tests in hid-tools, making sure no-one is failing

 drivers/hid/hid-core.c | 40 ++++++++++++++++++++++++++++------------
 include/linux/hid.h    |  1 +
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9993b692598f..40c836ce3248 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
  * Add a usage to the temporary parser table.
  */
 
-static int hid_add_usage(struct hid_parser *parser, unsigned usage)
+static int hid_add_usage(struct hid_parser *parser, unsigned usage, __u8 size)
 {
 	if (parser->local.usage_index >= HID_MAX_USAGES) {
 		hid_err(parser->device, "usage index exceeded\n");
 		return -1;
 	}
 	parser->local.usage[parser->local.usage_index] = usage;
+	parser->local.usage_size[parser->local.usage_index] = size;
 	parser->local.collection_index[parser->local.usage_index] =
 		parser->collection_stack_ptr ?
 		parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
@@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 			return 0;
 		}
 
-		if (item->size <= 2)
-			data = (parser->global.usage_page << 16) + data;
-
-		return hid_add_usage(parser, data);
+		return hid_add_usage(parser, data, item->size);
 
 	case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
 
@@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 			return 0;
 		}
 
-		if (item->size <= 2)
-			data = (parser->global.usage_page << 16) + data;
-
 		parser->local.usage_minimum = data;
 		return 0;
 
@@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 			return 0;
 		}
 
-		if (item->size <= 2)
-			data = (parser->global.usage_page << 16) + data;
-
 		count = data - parser->local.usage_minimum;
 		if (count + parser->local.usage_index >= HID_MAX_USAGES) {
 			/*
@@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 		}
 
 		for (n = parser->local.usage_minimum; n <= data; n++)
-			if (hid_add_usage(parser, n)) {
+			if (hid_add_usage(parser, n, item->size)) {
 				dbg_hid("hid_add_usage failed\n");
 				return -1;
 			}
@@ -547,6 +539,26 @@ static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
 	return 0;
 }
 
+/*
+ * Concatenate Usage Pages into Usages where relevant:
+ * As per specification, 6.2.2.8: "When the parser encounters a main item it
+ * concatenates the last declared Usage Page with a Usage to form a complete
+ * usage value."
+ */
+
+static void hid_concatenate_usage_page(struct hid_parser *parser)
+{
+	unsigned usages;
+	int i;
+
+	usages = max_t(unsigned, parser->local.usage_index,
+				 parser->global.report_count);
+
+	for (i = 0; i < usages; i++)
+		if (parser->local.usage_size[i] <= 2)
+			parser->local.usage[i] += parser->global.usage_page << 16;
+}
+
 /*
  * Process a main item.
  */
@@ -556,6 +568,8 @@ static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
 	__u32 data;
 	int ret;
 
+	hid_concatenate_usage_page(parser);
+
 	data = item_udata(item);
 
 	switch (item->tag) {
@@ -765,6 +779,8 @@ static int hid_scan_main(struct hid_parser *parser, struct hid_item *item)
 	__u32 data;
 	int i;
 
+	hid_concatenate_usage_page(parser);
+
 	data = item_udata(item);
 
 	switch (item->tag) {
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f9707d1dcb58..d1fb4b678873 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -417,6 +417,7 @@ struct hid_global {
 
 struct hid_local {
 	unsigned usage[HID_MAX_USAGES]; /* usage array */
+	__u8 usage_size[HID_MAX_USAGES]; /* usage size array */
 	unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
 	unsigned usage_index;
 	unsigned usage_minimum;
-- 
2.21.0
