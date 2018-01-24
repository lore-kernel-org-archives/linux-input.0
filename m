From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] Input: apbps2: Fix typos in a comment
Date: Wed, 24 Jan 2018 17:36:53 +0100
Message-ID: <ba412c8a-e125-2289-ffdf-da3d68533c55@users.sourceforge.net>
References: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50013a33-b7ca-fce1-9769-bfe3db850a8a@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, trivial@kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Jan 2018 17:21:18 +0100

Adjust two words in this description.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/serio/apbps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index a1c64df3b6cb..baa93bad993c 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -117,7 +117,7 @@ static int apbps2_open(struct serio *io)
 	while ((ioread32be(&priv->regs->status) & APBPS2_STATUS_DR) && --limit)
 		tmp = ioread32be(&priv->regs->data);
 
-	/* Enable reciever and it's interrupt */
+	/* Enable receiver and its interrupt */
 	iowrite32be(APBPS2_CTRL_RE | APBPS2_CTRL_RI, &priv->regs->ctrl);
 
 	return 0;
-- 
2.16.1
