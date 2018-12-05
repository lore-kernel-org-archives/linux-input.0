From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH v3 2/8] HID: core: store the collections as a basic tree
Date: Wed,  5 Dec 2018 10:42:22 +1000
Message-ID: <20181205004228.10714-3-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

For each collection parsed, store a pointer to the parent collection
(if any). This makes it a lot easier to look up which collection(s)
any given item is part of

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
No changes since v1

 drivers/hid/hid-core.c | 4 ++++
 include/linux/hid.h    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 5bec9244c45b..43d488a45120 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -172,6 +172,8 @@ static int open_collection(struct hid_parser *parser, unsigned type)
 	collection->type = type;
 	collection->usage = usage;
 	collection->level = parser->collection_stack_ptr - 1;
+	collection->parent = parser->active_collection;
+	parser->active_collection = collection;
 
 	if (type == HID_COLLECTION_APPLICATION)
 		parser->device->maxapplication++;
@@ -190,6 +192,8 @@ static int close_collection(struct hid_parser *parser)
 		return -EINVAL;
 	}
 	parser->collection_stack_ptr--;
+	if (parser->active_collection)
+		parser->active_collection = parser->active_collection->parent;
 	return 0;
 }
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a355d61940f2..fdfda898656c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -427,6 +427,7 @@ struct hid_local {
  */
 
 struct hid_collection {
+	struct hid_collection *parent;
 	unsigned type;
 	unsigned usage;
 	unsigned level;
@@ -650,6 +651,7 @@ struct hid_parser {
 	unsigned int         *collection_stack;
 	unsigned int          collection_stack_ptr;
 	unsigned int          collection_stack_size;
+	struct hid_collection *active_collection;
 	struct hid_device    *device;
 	unsigned int          scan_flags;
 };
-- 
2.19.2
