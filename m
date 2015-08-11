From: Jamie Lentin <jm@lentin.co.uk>
Subject: [PATCH 2/3] HID: lenovo: Add missing return-value check
Date: Tue, 11 Aug 2015 22:40:51 +0100
Message-ID: <1439329252-16809-3-git-send-email-jm@lentin.co.uk>
References: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439329252-16809-1-git-send-email-jm@lentin.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jamie Lentin <jm@lentin.co.uk>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 drivers/hid/hid-lenovo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 65df414..265bfe2 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -178,9 +178,12 @@ static void lenovo_features_set_cptkbd(struct hid_device *hdev)
 	struct lenovo_drvdata_cptkbd *cptkbd_data = hid_get_drvdata(hdev);
 
 	ret = lenovo_send_cmd_cptkbd(hdev, 0x05, cptkbd_data->fn_lock);
-	ret = lenovo_send_cmd_cptkbd(hdev, 0x02, cptkbd_data->sensitivity);
 	if (ret)
 		hid_err(hdev, "Fn-lock setting failed: %d\n", ret);
+
+	ret = lenovo_send_cmd_cptkbd(hdev, 0x02, cptkbd_data->sensitivity);
+	if (ret)
+		hid_err(hdev, "Sensitivity setting failed: %d\n", ret);
 }
 
 static ssize_t attr_fn_lock_show_cptkbd(struct device *dev,
-- 
2.1.4
