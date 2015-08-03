From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH 1/9] MAINTAINERS: Add maintainer for atmel_mxt_ts
Date: Mon,  3 Aug 2015 16:23:09 +0100
Message-ID: <1438615397-17112-2-git-send-email-nick.dyer@itdev.co.uk>
References: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:11790 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754170AbbHCPcr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 11:32:47 -0400
In-Reply-To: <1438615397-17112-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a226416..d2409bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1915,6 +1915,12 @@ W:	http://atmelwlandriver.sourceforge.net/
 S:	Maintained
 F:	drivers/net/wireless/atmel*
 
+ATMEL MAXTOUCH DRIVER
+M:	Nick Dyer <nick.dyer@itdev.co.uk>
+T:	git git://github.com/atmel-maxtouch/linux.git
+S:	Supported
+F:	drivers/input/touchscreen/atmel_mxt_ts.c
+
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.4.6

