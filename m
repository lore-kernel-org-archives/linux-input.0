From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] MAINTAINERS: Add cyttsp touchscreen maintainer entry
Date: Wed, 15 Feb 2012 11:44:07 +0100
Message-ID: <1329302647-1839-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43860 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab2BOKoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Feb 2012 05:44:21 -0500
Received: by wgbdt10 with SMTP id dt10so798459wgb.1
        for <linux-input@vger.kernel.org>; Wed, 15 Feb 2012 02:44:20 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

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

