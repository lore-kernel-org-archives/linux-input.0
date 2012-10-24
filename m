From: Matthias Brugger <matthias.bgg@googlemail.com>
Subject: [PATCH 2/2] touchscreen/ads7846.c: move filter variables to global include
Date: Wed, 24 Oct 2012 13:38:56 +0200
Message-ID: <1351078736-16785-2-git-send-email-matthias.bgg@gmail.com>
References: <1351078736-16785-1-git-send-email-matthias.bgg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45723 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758498Ab2JXLjP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Oct 2012 07:39:15 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so200281wey.19
        for <linux-input@vger.kernel.org>; Wed, 24 Oct 2012 04:39:14 -0700 (PDT)
In-Reply-To: <1351078736-16785-1-git-send-email-matthias.bgg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, grinberg@compulab.co.il
Cc: Matthias Brugger <matthias.bgg@gmail.com>

To implement a custom filter in the board platform code,
the struct ads7846_filterd might be needed. This patch moves the struct
to the global include file of the driver.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |    9 ---------
 include/linux/spi/ads7846.h         |    9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 9e61a4b..cc3b048 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -90,15 +90,6 @@ struct ads7846_packet {
 	u8			read_x_cmd[3], read_y_cmd[3], pwrdown_cmd[3];
 };
 
-struct ads7846_filterd {
-	int			read_cnt;
-	int			read_rep;
-	int			last_read;
-	u16			debounce_max;
-	u16			debounce_tol;
-	u16			debounce_rep;
-};
-
 struct ads7846 {
 	struct input_dev	*input;
 	char			phys[32];
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index c64de9d..cc7b34d 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -58,3 +58,12 @@ struct ads7846_platform_data {
 	unsigned long irq_flags;
 };
 
+struct ads7846_filterd {
+	int			read_cnt;
+	int			read_rep;
+	int			last_read;
+	u16			debounce_max;
+	u16			debounce_tol;
+	u16			debounce_rep;
+};
+
-- 
1.7.9.5

