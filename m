From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH] Update elantech documentation
Date: Tue, 27 Apr 2010 16:58:47 +0200
Message-ID: <1272380327-7921-2-git-send-email-rafl@debian.org>
References: <20100427073654.GC29797@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:52326 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756163Ab0D0PAP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 11:00:15 -0400
In-Reply-To: <20100427073654.GC29797@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 Documentation/input/elantech.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/elantech.txt
index a10c3b6..56941ae 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -333,14 +333,14 @@ byte 0:
 byte 1:
 
    bit   7   6   5   4   3   2   1   0
-        x15 x14 x13 x12 x11 x10 x9  x8
+         .   .   .   .   .  x10 x9  x8
 
 byte 2:
 
    bit   7   6   5   4   3   2   1   0
         x7  x6  x5  x4  x4  x2  x1  x0
 
-         x15..x0 = absolute x value (horizontal)
+         x10..x0 = absolute x value (horizontal)
 
 byte 3:
 
@@ -350,14 +350,14 @@ byte 3:
 byte 4:
 
    bit   7   6   5   4   3   2   1   0
-        y15 y14 y13 y12 y11 y10 y8  y8
+         .   .   .   .   .   .  y9  y8
 
 byte 5:
 
    bit   7   6   5   4   3   2   1   0
         y7  y6  y5  y4  y3  y2  y1  y0
 
-         y15..y0 = absolute y value (vertical)
+         y9..y0 = absolute y value (vertical)
 
 
 4.2.2 Two finger touch
-- 
1.7.1

