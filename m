From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] MAINTAINERS: Change maintainer for cyttsp driver
Date: Sun, 14 Jul 2013 23:41:21 +0200
Message-ID: <1373838082-12372-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:51166 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab3GNVlm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Jul 2013 17:41:42 -0400
Received: by mail-we0-f181.google.com with SMTP id p58so9394371wes.40
        for <linux-input@vger.kernel.org>; Sun, 14 Jul 2013 14:41:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Ferruh Yigit <fery@cypress.com>, ttdrivers@cypress.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

I haven't had time to work on this driver for a long time and
Ferruh has been doing a great job making it more generic,
adding support for new hardware and providing bug fixes.

So, let's make MAINTAINERS reflect reality and add him as the
cyttsp maintainer instead of me.

Also, since Ferruh works for Cypress, we may change the driver
status from Maintained to Supported.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---

Ferruh, please send your ack if you are willing to take over
maintainance of this driver.

Also, please confirm that you have been working on behalf of
Cypress instead of doing it on your free time. Otherwise we
should keep the driver status to maintained instead supported.

Thanks a lot and best regards,
Javier

 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d771d9..4ba996c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2458,9 +2458,9 @@ S:	Maintained
 F:	drivers/media/common/cypress_firmware*
 
 CYTTSP TOUCHSCREEN DRIVER
-M:	Javier Martinez Canillas <javier@dowhile0.org>
+M:	Ferruh Yigit <fery@cypress.com>
 L:	linux-input@vger.kernel.org
-S:	Maintained
+S:	Supported
 F:	drivers/input/touchscreen/cyttsp*
 F:	include/linux/input/cyttsp.h
 
-- 
1.7.7.6

