From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] Input-at32psif: Remove OOM messages in psif_probe()
Date: Sat, 2 Jul 2016 21:07:25 +0200
Message-ID: <1c2a98cb-e853-7b4c-3c5b-1e3ee70c67fb@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <4471604f-f401-bed9-39be-1aff2a92edf6@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 2 Jul 2016 20:34:18 +0200

Delete two debug messages because Linux will usually provide
an appropriate information for a memory allocation failure.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/serio/at32psif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index fcb769a..b30503d 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -210,15 +210,13 @@ static int __init psif_probe(struct platform_device *pdev)
 	int ret;
 
 	psif = kzalloc(sizeof(struct psif), GFP_KERNEL);
-	if (!psif) {
-		dev_dbg(&pdev->dev, "out of memory\n");
+	if (!psif)
 		return -ENOMEM;
-	}
+
 	psif->pdev = pdev;
 
 	io = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!io) {
-		dev_dbg(&pdev->dev, "out of memory\n");
 		ret = -ENOMEM;
 		goto out_free_psif;
 	}
-- 
2.9.0

