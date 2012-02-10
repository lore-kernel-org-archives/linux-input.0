From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 2/2] MAINTAINERS: Add cyttsp touchscreen maintainer entry
Date: Fri, 10 Feb 2012 02:18:30 +0100
Message-ID: <1328836710-9897-2-git-send-email-javier@dowhile0.org>
References: <1328836710-9897-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:39817 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab2BJBUn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2012 20:20:43 -0500
Received: by werb13 with SMTP id b13so1671946wer.19
        for <linux-input@vger.kernel.org>; Thu, 09 Feb 2012 17:20:42 -0800 (PST)
In-Reply-To: <1328836710-9897-1-git-send-email-javier@dowhile0.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

Since Cypress TTSP driver was merged in mainline, add a maintainer entry for it.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3523ab0..5fa8732 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2110,6 +2110,13 @@ W:	http://www.cyclades.com/
 S:	Orphan
 F:	drivers/net/wan/pc300*
 
+CYTTSP TOUCHSCREEN DRIVER
+M:      Javier Martinez Canillas <javier@dowhile0.org>
+L:      linux-input@vger.kernel.org
+S:      Maintained
+F:      drivers/input/touchscreen/cyttsp*
+F:      include/linux/input/cyttsp.h
+
 DAMA SLAVE for AX.25
 M:	Joerg Reuter <jreuter@yaina.de>
 W:	http://yaina.de/jreuter/
-- 
1.7.7.6

