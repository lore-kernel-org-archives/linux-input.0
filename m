From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] Input: max7359_keypad: Delete an error message for a
 failed memory allocation in max7359_probe()
Date: Sat, 27 Jan 2018 13:14:16 +0100
Message-ID: <7ba43976-2b29-abc7-6d08-e8c49b4564a6@users.sourceforge.net>
References: <95f7f53b-fa1e-8270-ae4c-5b3d721a4831@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95f7f53b-fa1e-8270-ae4c-5b3d721a4831@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 12:56:25 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/max7359_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/max7359_keypad.c b/drivers/input/keyboard/max7359_keypad.c
index cd44d22d8770..ba6a670a769e 100644
--- a/drivers/input/keyboard/max7359_keypad.c
+++ b/drivers/input/keyboard/max7359_keypad.c
@@ -184,10 +184,8 @@ static int max7359_probe(struct i2c_client *client,
 
 	keypad = devm_kzalloc(&client->dev, sizeof(struct max7359_keypad),
 			      GFP_KERNEL);
-	if (!keypad) {
-		dev_err(&client->dev, "failed to allocate memory\n");
+	if (!keypad)
 		return -ENOMEM;
-	}
 
 	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev) {
-- 
2.16.1
