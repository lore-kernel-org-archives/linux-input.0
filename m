From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input: omap4-keypad: Improve a size determination in
 omap4_keypad_probe()
Date: Fri, 26 Jan 2018 14:50:05 +0100
Message-ID: <e12b1b34-fb31-4c47-5fd8-6c93a44854cc@users.sourceforge.net>
References: <3df8e062-2a39-05c9-bf49-c85fd636abff@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3df8e062-2a39-05c9-bf49-c85fd636abff@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Christophe Jaillet <christophe.jaillet@wanadoo.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 26 Jan 2018 14:28:07 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/keyboard/omap4-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 6fe554e4026e..4b5bd0c611d6 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -256,7 +256,7 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
+	keypad_data = kzalloc(sizeof(*keypad_data), GFP_KERNEL);
 	if (!keypad_data)
 		return -ENOMEM;
 
-- 
2.16.1
