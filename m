From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: olpc_apsp: remove unused pointer 'np'
Date: Tue, 28 Aug 2018 15:56:48 +0100
Message-ID: <20180828145648.11619-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'nb' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'np' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/serio/olpc_apsp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
index 8e9a4209fcad..8bd8ed25946f 100644
--- a/drivers/input/serio/olpc_apsp.c
+++ b/drivers/input/serio/olpc_apsp.c
@@ -172,7 +172,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	struct serio *kb_serio, *pad_serio;
 	struct olpc_apsp *priv;
 	struct resource *res;
-	struct device_node *np;
 	unsigned long l;
 	int error;
 
@@ -180,7 +179,6 @@ static int olpc_apsp_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	np = pdev->dev.of_node;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->base)) {
-- 
2.17.1
