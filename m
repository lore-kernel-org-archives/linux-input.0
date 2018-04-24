From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] HID: wacom: Release device resource data obtained by devres_alloc()
Date: Tue, 24 Apr 2018 13:33:03 +0530
Message-ID: <9b8c9c6134cb27ee8ac37224098e382ab9189d62.1524556744.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Free device resource data, if __wacom_devm_sysfs_create_group
is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/hid/wacom_sys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index b54ef1f..ee7a37e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1213,8 +1213,10 @@ static int __wacom_devm_sysfs_create_group(struct wacom *wacom,
 	devres->root = root;
 
 	error = sysfs_create_group(devres->root, group);
-	if (error)
+	if (error) {
+		devres_free(devres);
 		return error;
+	}
 
 	devres_add(&wacom->hdev->dev, devres);
 
-- 
1.9.1
