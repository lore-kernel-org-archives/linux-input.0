From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] MAINTAINERS: input: mt: remove non existent git tree
Date: Sun,  7 Jun 2015 10:27:40 +0300
Message-ID: <cd677bec4cbe521fbdb7688cdfe44e1daa49212b.1433662060.git.baruch@tkos.co.il>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:57685 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbbFGH2D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Jun 2015 03:28:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Henrik Rydberg <rydberg@bitmath.org>

The "INPUT MULTITOUCH (MT) PROTOCOL" entry git tree is not there on
git.kernel.org.

Cc: Henrik Rydberg <rydberg@bitmath.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8afd2953678..eff2100dbf15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5094,7 +5094,6 @@ F:	include/linux/input/
 INPUT MULTITOUCH (MT) PROTOCOL
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-input@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git
 S:	Odd fixes
 F:	Documentation/input/multi-touch-protocol.txt
 F:	drivers/input/input-mt.c
-- 
2.1.4

