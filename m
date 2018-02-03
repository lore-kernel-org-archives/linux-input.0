From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] HID: picoLCD: Improve a size determination in
 picolcd_probe()
Date: Sat, 3 Feb 2018 21:20:27 +0100
Message-ID: <2dd7d4d6-b4d4-b1fe-5ce2-974eb64d8c40@users.sourceforge.net>
References: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1ef884c9-9fbe-b95f-d318-b806639e6065@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?UTF-8?Q?Bruno_Pr=c3=a9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 21:05:55 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-picolcd_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd_core.c
index 5dc48ecc1b98..ff38016be6fb 100644
--- a/drivers/hid/hid-picolcd_core.c
+++ b/drivers/hid/hid-picolcd_core.c
@@ -547,7 +547,7 @@ static int picolcd_probe(struct hid_device *hdev,
 	 * Let's allocate the picolcd data structure, set some reasonable
 	 * defaults, and associate it with the device
 	 */
-	data = kzalloc(sizeof(struct picolcd_data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (data == NULL) {
 		error = -ENOMEM;
 		goto err_no_cleanup;
-- 
2.16.1

