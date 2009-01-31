From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] input: i reaches -1
Date: Sat, 31 Jan 2009 11:25:32 +0100
Message-ID: <4984271C.1080908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:55406 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbZAaKZe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2009 05:25:34 -0500
Received: by ewy14 with SMTP id 14so1138724ewy.13
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2009 02:25:33 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru
Cc: linux-input@vger.kernel.org

With a postfix decrement i reaches -1 rather than 0,
but after the loop it is tested whether it has become 0.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index d297acc..1e827ad 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -83,7 +83,7 @@ static int write_tbcr(struct pxa930_trkball *trkball, int v)
 
 	__raw_writel(v, trkball->mmio_base + TBCR);
 
-	while (i--) {
+	while (--i) {
 		if (__raw_readl(trkball->mmio_base + TBCR) == v)
 			break;
 		msleep(1);
