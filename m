From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] MAINTAINERS: Add an entry for the input MT protocol
Date: Thu, 24 Jun 2010 12:12:01 +0200
Message-ID: <1277374321-19358-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:47839 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754628Ab0FXKMX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jun 2010 06:12:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>

This patch adds a maintainer for the input multitouch (MT) protocol,
such that get_maintainer.pl selects it whenever an MT event is present
in the patch.

Cc: Joe Perches <joe@perches.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d119c9..603413b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2887,6 +2887,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained
 F:	drivers/input/
 
+INPUT MULTITOUCH (MT) PROTOCOL
+M:	Henrik Rydberg <rydberg@euromail.se>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/input/multi-touch-protocol.txt
+K:	\b(ABS|SYN)_MT_
+
 INTEL IDLE DRIVER
 M:	Len Brown <lenb@kernel.org>
 L:	linux-pm@lists.linux-foundation.org
-- 
1.6.3.3

