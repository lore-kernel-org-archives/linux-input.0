From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 02/12] HID: multitouch: make sure the static list of class is not changed
Date: Thu, 21 Jun 2018 14:08:58 +0200
Message-ID: <20180621120908.16706-3-benjamin.tissoires@redhat.com>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

const is a magic keyword here :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
no changes in v3
---
 drivers/hid/hid-multitouch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 45968f7970f8..91624a2240ca 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -211,7 +211,7 @@ static int cypress_compute_slot(struct mt_device *td)
 		return -1;
 }
 
-static struct mt_class mt_classes[] = {
+static const struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_DEFAULT,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE },
@@ -1432,7 +1432,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, i;
 	struct mt_device *td;
-	struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
+	const struct mt_class *mtclass = mt_classes; /* MT_CLS_DEFAULT */
 
 	for (i = 0; mt_classes[i].name ; i++) {
 		if (id->driver_data == mt_classes[i].name) {
-- 
2.14.3
