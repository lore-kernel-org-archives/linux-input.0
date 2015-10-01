From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 2/3] Input: alps: drop unlikely before IS_ERR_OR_NULL
Date: Thu,  1 Oct 2015 10:55:30 +0800
Message-ID: <081982d1188978b6020952afb4c2dcf3bc42fa1f.1443667610.git.geliangtang@163.com>
References: <03d18502ed7ed417f136c091f417d2d88c147ec6.1443667610.git.geliangtang@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-135.163.com ([123.125.50.135]:43618 "EHLO m50-135.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755094AbbJAC4N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 22:56:13 -0400
In-Reply-To: <03d18502ed7ed417f136c091f417d2d88c147ec6.1443667610.git.geliangtang@163.com>
In-Reply-To: <03d18502ed7ed417f136c091f417d2d88c147ec6.1443667610.git.geliangtang@163.com>
References: <03d18502ed7ed417f136c091f417d2d88c147ec6.1443667610.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

IS_ERR_OR_NULL already contain an unlikely compiler flag. Drop it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4d24686..b4f146a 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1367,7 +1367,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
 		dev2 = psmouse->dev;
-	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+	} else if (IS_ERR_OR_NULL(priv->dev3)) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
 			psmouse_queue_work(psmouse, &priv->dev3_register_work,
-- 
2.5.0


