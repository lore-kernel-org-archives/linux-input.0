From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] appletouch: give up maintainership
Date: Sun, 06 Dec 2009 19:46:10 +0100
Message-ID: <1260125170.3461.23.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:41020 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933833AbZLFSqE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 13:46:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

I no longer have a machine with this, and as
such am not really able to help out with this
driver any more. Remove the entire appletouch
section and let the driver fall under the
general input subsystem.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 MAINTAINERS |    7 -------
 1 file changed, 7 deletions(-)

--- wireless-testing.orig/MAINTAINERS	2009-12-06 19:43:45.000000000 +0100
+++ wireless-testing/MAINTAINERS	2009-12-06 19:43:55.000000000 +0100
@@ -486,13 +486,6 @@ S:	Maintained
 F:	drivers/net/appletalk/
 F:	net/appletalk/
 
-APPLETOUCH TOUCHPAD DRIVER
-M:	Johannes Berg <johannes@sipsolutions.net>
-L:	linux-input@vger.kernel.org
-S:	Maintained
-F:	Documentation/input/appletouch.txt
-F:	drivers/input/mouse/appletouch.c
-
 ARC FRAMEBUFFER DRIVER
 M:	Jaya Kumar <jayalk@intworks.biz>
 S:	Maintained


