From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] HID: sony: Fix memory corruption issue on cleanup.
Date: Wed,  4 Sep 2019 14:22:11 -0700
Message-ID: <20190904212211.29832-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, andreyknvl@google.com
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The sony driver is not properly cleaning up from potential failures in
sony_input_configured. Currently it calls hid_hw_stop, while hid_connect
is still running. This is not a good idea, instead hid_hw_stop should
be moved to sony_probe. Similar changes were recently made to Logitech
drivers, which were also doing improper cleanup.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
CC: stable@vger.kernel.org
---
 drivers/hid/hid-sony.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31f1023214d3..09f2c617b09f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2806,7 +2806,6 @@ static int sony_input_configured(struct hid_device *hdev,
 	sony_cancel_work_sync(sc);
 	sony_remove_dev_list(sc);
 	sony_release_device_id(sc);
-	hid_hw_stop(hdev);
 	return ret;
 }
 
@@ -2868,6 +2867,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	if (!(hdev->claimed & HID_CLAIMED_INPUT)) {
 		hid_err(hdev, "failed to claim input\n");
+		hid_hw_stop(hdev);
 		return -ENODEV;
 	}
 
-- 
2.21.0
