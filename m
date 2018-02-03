From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] HID: ntrig: Delete an error message for a failed memory
 allocation in ntrig_probe()
Date: Sat, 3 Feb 2018 21:58:04 +0100
Message-ID: <a89d945d-6bfa-ed1a-3bf5-cd9efddba6c9@users.sourceforge.net>
References: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <86d02ef2-0ac2-5462-0ff0-a0cd87c3d1f7@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:46:20 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-ntrig.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 3d121d8ee980..2a8dafaea2f0 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -905,10 +905,8 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				| HID_QUIRK_NO_INIT_REPORTS;
 
 	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
-	if (!nd) {
-		hid_err(hdev, "cannot allocate N-Trig data\n");
+	if (!nd)
 		return -ENOMEM;
-	}
 
 	nd->reading_mt = 0;
 	nd->min_width = 0;
-- 
2.16.1

