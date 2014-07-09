From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 11/14] alps: Report 2 touches when we've > 2 fingers
Date: Wed,  9 Jul 2014 17:24:16 +0200
Message-ID: <1404919459-23561-12-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558AbaGIPYm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:42 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

If we detect more then 2 fingers report 2 touches, rather then only
reporting the upper left corner of the bounding box.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index adc90ab..93c6087 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -454,7 +454,7 @@ static void alps_report_semi_mt_data(struct psmouse *psmouse, int fingers)
 		fingers = f->pressure > 0 ? 1 : 0;
 	}
 
-	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 1);
+	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 2);
 
 	input_mt_report_finger_count(dev, fingers);
 
-- 
2.0.0

