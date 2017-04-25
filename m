From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] HID: Wacom: Delete two unnecessary return statements
Date: Tue, 25 Apr 2017 17:15:55 +0200
Message-ID: <40f97a94-1df2-c50a-803d-7b66b641eaf3@users.sourceforge.net>
References: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 25 Apr 2017 16:50:02 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/wacom_sys.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 7517da5300fd..f70e7d7351c7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2329,7 +2329,6 @@ static void wacom_wireless_work(struct work_struct *work)
 fail:
 	wacom_release_resources(wacom1);
 	wacom_release_resources(wacom2);
-	return;
 }
 
 static void wacom_remote_destroy_one(struct wacom *wacom, unsigned int index)
@@ -2534,8 +2533,6 @@ static void wacom_mode_change_work(struct work_struct *work)
 		if (error)
 			return;
 	}
-
-	return;
 }
 
 static int wacom_probe(struct hid_device *hdev,
-- 
2.12.2
