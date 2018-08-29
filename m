From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] HID: core: fix NULL pointer dereference
Date: Wed, 29 Aug 2018 10:22:09 -0500
Message-ID: <20180829152209.GA29831@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

There is a NULL pointer dereference in case memory resources
for *parse* are not successfully allocated.

Fix this by adding a new goto label and make the execution
path jump to it in case vzalloc() fails.

Addresses-Coverity-ID: 1473081 ("Dereference after null check")
Fixes: b2dd9f2e5a8a ("HID: core: fix memory leak on probe")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4548dae..5bec924 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1000,7 +1000,7 @@ int hid_open_report(struct hid_device *device)
 	parser = vzalloc(sizeof(struct hid_parser));
 	if (!parser) {
 		ret = -ENOMEM;
-		goto err;
+		goto alloc_err;
 	}
 
 	parser->device = device;
@@ -1049,6 +1049,7 @@ int hid_open_report(struct hid_device *device)
 	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
 err:
 	kfree(parser->collection_stack);
+alloc_err:
 	vfree(parser);
 	hid_close_report(device);
 	return ret;
-- 
2.7.4
