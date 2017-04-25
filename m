From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] HID: Wacom: Improve size determinations in three
 functions
Date: Tue, 25 Apr 2017 17:14:54 +0200
Message-ID: <f6088931-7b68-ec9d-cc7f-5d48431cef56@users.sourceforge.net>
References: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:61618 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949065AbdDYPPa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 11:15:30 -0400
In-Reply-To: <d126aeeb-f7e0-e54b-b874-61d776fe45cb@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 25 Apr 2017 16:38:59 +0200

Replace the specification of three data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determinations a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/wacom_sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 550faf8819ea..7517da5300fd 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -726,7 +726,7 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 	data = wacom_get_hdev_data(hdev);
 	if (!data) {
-		data = kzalloc(sizeof(struct wacom_hdev_data), GFP_KERNEL);
+		data = kzalloc(sizeof(*data), GFP_KERNEL);
 		if (!data) {
 			retval = -ENOMEM;
 			goto out;
@@ -1088,7 +1088,7 @@ static int __wacom_devm_sysfs_create_group(struct wacom *wacom,
 	int error;
 
 	devres = devres_alloc(wacom_devm_sysfs_group_release,
-			      sizeof(struct wacom_sysfs_group_devres),
+			      sizeof(*devres),
 			      GFP_KERNEL);
 	if (!devres)
 		return -ENOMEM;
@@ -2556,7 +2556,7 @@ static int wacom_probe(struct hid_device *hdev,
 	/* hid-core sets this quirk for the boot interface */
 	hdev->quirks &= ~HID_QUIRK_NOGET;
 
-	wacom = devm_kzalloc(&hdev->dev, sizeof(struct wacom), GFP_KERNEL);
+	wacom = devm_kzalloc(&hdev->dev, sizeof(*wacom), GFP_KERNEL);
 	if (!wacom)
 		return -ENOMEM;
 
-- 
2.12.2

