From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] Maintaining the new bcm5974 driver
Date: Sat, 19 Jul 2008 17:46:16 +0200
Message-ID: <1216482728.4528.0.camel@alnilam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:42750 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752376AbYGSPwR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jul 2008 11:52:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@osdl.org, torvalds@linux-foundation.org
Cc: vojtech@suse.cz, johannes@sipsolutions.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org

From: Henrik Rydberg <rydberg@euromail.se>

In case the bcm5974 multitouch driver would be picked up, I am of
course happy to maintain it.

This patch was applied to linux-next, version v2.6.26-8133-g151da15.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bc91036..8c99a32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -413,6 +413,12 @@ L:	linux-laptop@vger.kernel.org
 W:	http://www.canb.auug.org.au/~sfr/
 S:	Supported
 
+APPLE BCM5974 MULTITOUCH DRIVER
+P:	Henrik Rydberg
+M:	rydberg@euromail.se
+L:	linux-input@vger.kernel.org
+S:	Maintained
+
 APPLE SMC DRIVER
 P:	Nicolas Boichat
 M:	nicolas@boichat.ch
-- 
1.5.4.3

