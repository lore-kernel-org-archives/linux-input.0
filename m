From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 11/27] HID: wacom: use devres to allocate driver data
Date: Tue,  5 Jul 2016 16:39:07 +0200
Message-ID: <1467729563-23318-12-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We started switching the driver to devres, so we should use it as much
as possible.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index ec088c1..56d62e8 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1844,7 +1844,7 @@ static int wacom_probe(struct hid_device *hdev,
 	/* hid-core sets this quirk for the boot interface */
 	hdev->quirks &= ~HID_QUIRK_NOGET;
 
-	wacom = kzalloc(sizeof(struct wacom), GFP_KERNEL);
+	wacom = devm_kzalloc(&hdev->dev, sizeof(struct wacom), GFP_KERNEL);
 	if (!wacom)
 		return -ENOMEM;
 
@@ -1892,7 +1892,6 @@ static int wacom_probe(struct hid_device *hdev,
 
 fail_type:
 fail_parse:
-	kfree(wacom);
 	hid_set_drvdata(hdev, NULL);
 	return error;
 }
@@ -1916,7 +1915,6 @@ static void wacom_remove(struct hid_device *hdev)
 	wacom_remove_shared_data(wacom);
 
 	hid_set_drvdata(hdev, NULL);
-	kfree(wacom);
 }
 
 #ifdef CONFIG_PM
-- 
2.5.5
