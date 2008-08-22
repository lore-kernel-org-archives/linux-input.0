From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] Adding a maintainer for the BCM5974 multitouch driver
Date: Fri, 22 Aug 2008 19:01:32 +0200
Message-ID: <48AEF0EC.3080709@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:48626 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbYHVRBt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2008 13:01:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: torvalds@linux-foundation.org, linux-input@vger.kernel.org, trivial@kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28c69aa..74e3381 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -419,6 +419,12 @@ L:	linux-laptop@vger.kernel.org
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

