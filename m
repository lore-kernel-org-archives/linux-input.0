From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/6] hid-prodikeys: Move an assignment in pk_probe()
Date: Sat, 3 Feb 2018 18:39:58 +0100
Message-ID: <44c2767f-c66c-3b36-4bd1-059d5d2f4461@users.sourceforge.net>
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 17:20:01 +0100

Move one assignment for a data structure member in one local variable
so that its setting will only be performed after a corresponding memory
allocation succeeded by this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 2e79dfc92162..7672f723b268 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -804,8 +804,6 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (!pk)
 		return -ENOMEM;
 
-	pk->hdev = hdev;
-
 	pm = kzalloc(sizeof(*pm), GFP_KERNEL);
 	if (pm == NULL) {
 		ret = -ENOMEM;
@@ -814,6 +812,7 @@ static int pk_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	pm->pk = pk;
 	pk->pm = pm;
+	pk->hdev = hdev;
 	pm->ifnum = ifnum;
 
 	hid_set_drvdata(hdev, pk);
-- 
2.16.1

