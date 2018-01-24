From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] Input: apbps2: Improve a size determination in
 apbps2_of_probe()
Date: Wed, 24 Jan 2018 17:35:47 +0100
Message-ID: <affc3d44-3fdc-ce54-322a-c0beec3e92c6@users.sourceforge.net>
References: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 17:15:39 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/serio/apbps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 9b75c4e1bc13..a1c64df3b6cb 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -170,7 +170,7 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 	/* Set reload register to core freq in kHz/10 */
 	iowrite32be(freq_hz / 10000, &priv->regs->reload);
 
-	priv->io = kzalloc(sizeof(struct serio), GFP_KERNEL);
+	priv->io = kzalloc(sizeof(*priv->io), GFP_KERNEL);
 	if (!priv->io)
 		return -ENOMEM;
 
-- 
2.16.1

