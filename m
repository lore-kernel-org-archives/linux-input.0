From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] MAINTAINERS: Remove wm97xx entry
Date: Fri,  2 Oct 2015 18:09:18 +0100
Message-ID: <1443805758-27153-1-git-send-email-broonie@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35887 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbbJBRJa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Oct 2015 13:09:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lgirdwood@mail.com>
Cc: patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Mark Brown <broonie@kernel.org>

Neither myself or Liam is especially interested in this driver any more
and the devices are already covered by the general ex-Wolfson entry so
just remove this.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---

This depends on an update to all the Wolfson entries in the ASoC tree so
I'll just apply it there.

 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 508f442..17f6cb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11393,15 +11393,6 @@ W:	http://oops.ghostprotocols.net:81/blog
 S:	Maintained
 F:	drivers/net/wireless/wl3501*
 
-WM97XX TOUCHSCREEN DRIVERS
-M:	Mark Brown <broonie@kernel.org>
-M:	Liam Girdwood <lrg@slimlogic.co.uk>
-L:	linux-input@vger.kernel.org
-W:	https://github.com/CirrusLogic/linux-drivers/wiki
-S:	Supported
-F:	drivers/input/touchscreen/*wm97*
-F:	include/linux/wm97xx.h
-
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.wolfsonmicro.com
 T:	git https://github.com/CirrusLogic/linux-drivers.git
-- 
2.5.0

