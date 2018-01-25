From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input: kxtj9: Delete an error message for a failed memory
 allocation in kxtj9_probe()
Date: Thu, 25 Jan 2018 18:18:54 +0100
Message-ID: <0d5cb90a-28e7-544b-3b77-3e50f11edb15@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 25 Jan 2018 18:13:57 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/misc/kxtj9.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index efaffcc57e36..ddd5ca6812cb 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -526,11 +526,8 @@ static int kxtj9_probe(struct i2c_client *client,
 	}
 
 	tj9 = kzalloc(sizeof(*tj9), GFP_KERNEL);
-	if (!tj9) {
-		dev_err(&client->dev,
-			"failed to allocate memory for module data\n");
+	if (!tj9)
 		return -ENOMEM;
-	}
 
 	tj9->client = client;
 	tj9->pdata = *pdata;
-- 
2.16.1

