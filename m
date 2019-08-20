From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely() call around IS_ERR()
Date: Tue, 20 Aug 2019 12:56:12 +0200
Message-ID: <1566298572-12409-2-git-send-email-info@metux.net>
References: <1566298572-12409-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566298572-12409-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: pali.rohar@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

IS_ERR() already calls unlikely(), so this extra unlikely() call
around IS_ERR() is not needed.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 34700ed..ed16614 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1476,7 +1476,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
 		dev2 = psmouse->dev;
-	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+	} else if (IS_ERR_OR_NULL(priv->dev3)) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
 			psmouse_queue_work(psmouse, &priv->dev3_register_work,
-- 
1.9.1
