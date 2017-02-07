From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 01/18] HID: Use kmalloc_array() in hid_input_field()
Date: Tue, 7 Feb 2017 20:39:22 +0100
Message-ID: <540faed6-c664-def3-fbf9-767b40444165@users.sourceforge.net>
References: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edd25fcd-8625-2469-fa28-2315f81b6b8e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 6 Feb 2017 18:18:41 +0100

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus use the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 538ff697a4cf..9b0a97bbde96 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1272,7 +1272,7 @@ static void hid_input_field(struct hid_device *hid, struct hid_field *field,
 	__s32 max = field->logical_maximum;
 	__s32 *value;
 
-	value = kmalloc(sizeof(__s32) * count, GFP_ATOMIC);
+	value = kmalloc_array(count, sizeof(__s32), GFP_ATOMIC);
 	if (!value)
 		return;
 
-- 
2.11.1
