From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: matrix_keypad: Improve a size determination in
 matrix_keypad_probe()
Date: Sat, 27 Jan 2018 13:54:23 +0100
Message-ID: <8098317f-46bb-fefb-936c-eb82605c565c@users.sourceforge.net>
References: <106bffd0-28ed-7c33-1f32-ae84b40f52c7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:57282 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752523AbeA0Myc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 27 Jan 2018 07:54:32 -0500
In-Reply-To: <106bffd0-28ed-7c33-1f32-ae84b40f52c7@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, David Rivshin <DRivshin@allworx.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 27 Jan 2018 13:43:16 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/matrix_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 90238201a9cc..16206a8a5f07 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -487,7 +487,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
+	keypad = kzalloc(sizeof(*keypad), GFP_KERNEL);
 	input_dev = input_allocate_device();
 	if (!keypad || !input_dev) {
 		err = -ENOMEM;
-- 
2.16.1

