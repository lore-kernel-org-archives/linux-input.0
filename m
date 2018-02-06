From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] hid-lg: Delete an error message for a failed memory
 allocation in lg_probe()
Date: Tue, 6 Feb 2018 15:45:13 +0100
Message-ID: <14c9b364-5a38-88f3-0cd4-913ca95dfc31@users.sourceforge.net>
References: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5c76a767-b1cb-2486-f24d-0d5a220b8985@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2018 14:25:32 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-lg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 596227ddb6e0..f4439dc64497 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -728,10 +728,9 @@ static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	drv_data = kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
-	if (!drv_data) {
-		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
+	if (!drv_data)
 		return -ENOMEM;
-	}
+
 	drv_data->quirks = id->driver_data;
 
 	hid_set_drvdata(hdev, (void *)drv_data);
-- 
2.16.1

