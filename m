From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 19/20] HID: hid-debug: Show rdesc for unclaimed devices
Date: Sun, 26 Aug 2012 14:57:37 +0200
Message-ID: <1345985858-445-20-git-send-email-rydberg@euromail.se>
References: <1345985858-445-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345985858-445-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

Since commit a7197c2e, the raw report descriptor is available also for
unclaimed devices. This patch makes it show in the rdesc debugfs node.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-debug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 01dd9a7..933fff0 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -911,15 +911,21 @@ static void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 
 }
 
-
 static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 {
 	struct hid_device *hdev = f->private;
+	const __u8 *rdesc = hdev->rdesc;
+	unsigned rsize = hdev->rsize;
 	int i;
 
+	if (!rdesc) {
+		rdesc = hdev->dev_rdesc;
+		rsize = hdev->dev_rsize;
+	}
+
 	/* dump HID report descriptor */
-	for (i = 0; i < hdev->rsize; i++)
-		seq_printf(f, "%02x ", hdev->rdesc[i]);
+	for (i = 0; i < rsize; i++)
+		seq_printf(f, "%02x ", rdesc[i]);
 	seq_printf(f, "\n\n");
 
 	/* dump parsed data and input mappings */
-- 
1.7.12
