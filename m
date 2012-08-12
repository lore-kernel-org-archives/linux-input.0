From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 16/19] HID: hid-multitouch: Remove misleading null test
Date: Sun, 12 Aug 2012 23:42:34 +0200
Message-ID: <1344807757-2217-17-git-send-email-rydberg@euromail.se>
References: <1344807757-2217-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344807757-2217-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

A null test was left behind during the autoloading work;
the test was introduced by 8d179a9e, but was never completely
reverted.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-multitouch.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c400d90..b15133c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -691,12 +691,10 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct mt_device *td;
 	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
-	if (id) {
-		for (i = 0; mt_classes[i].name ; i++) {
-			if (id->driver_data == mt_classes[i].name) {
-				mtclass = &(mt_classes[i]);
-				break;
-			}
+	for (i = 0; mt_classes[i].name ; i++) {
+		if (id->driver_data == mt_classes[i].name) {
+			mtclass = &(mt_classes[i]);
+			break;
 		}
 	}
 
-- 
1.7.11.4
