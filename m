From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/14] alps: Fix rushmore packet decoding
Date: Wed,  9 Jul 2014 17:24:06 +0200
Message-ID: <1404919459-23561-2-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15182 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932397AbaGIPYa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:30 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

From: Yunkang Tang <yunkang.tang@cn.alps.com>

Signed-off-by: Yunkang Tang <yunkang.tang@cn.alps.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index fb15c64..0448331 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -559,6 +559,9 @@ static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 {
 	alps_decode_pinnacle(f, p, psmouse);
 
+	/* rushmore's packet decode has a bit difference with pinnacle's */
+	f->is_mp = !!(p[5] & 0x40);
+	f->fingers = max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
 	f->x_map |= (p[5] & 0x10) << 11;
 	f->y_map |= (p[5] & 0x20) << 6;
 }
-- 
2.0.0

