From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] HID: lenovo: Adjust four checks for null pointers
Date: Tue, 6 Feb 2018 17:19:01 +0100
Message-ID: <1dc4fe03-be3b-7175-05aa-2f5397f57cb5@users.sourceforge.net>
References: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <06e2d590-f980-0022-c476-6b999239ff9f@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 17:02:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lenovo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index f863b94f3476..ba128123466b 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -687,7 +687,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer = devm_kzalloc(&hdev->dev,
 				    sizeof(*data_pointer),
 				    GFP_KERNEL);
-	if (data_pointer == NULL) {
+	if (!data_pointer) {
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -698,7 +698,7 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 
 	name_mute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
 	name_micmute = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
-	if (name_mute == NULL || name_micmute == NULL) {
+	if (!name_mute || !name_micmute) {
 		hid_err(hdev, "Could not allocate memory for led data\n");
 		ret = -ENOMEM;
 		goto err;
@@ -823,7 +823,7 @@ static void lenovo_remove_tpkbd(struct hid_device *hdev)
 	 * Only the trackpoint half of the keyboard has drvdata and stuff that
 	 * needs unregistering.
 	 */
-	if (data_pointer == NULL)
+	if (!data_pointer)
 		return;
 
 	sysfs_remove_group(&hdev->dev.kobj,
-- 
2.16.1

