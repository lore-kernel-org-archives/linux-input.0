From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] Input: include MT library as source for kerneldoc
Date: Thu,  9 Dec 2010 22:32:13 +0100
Message-ID: <1291930333-10017-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:40684 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752098Ab0LIVcd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Dec 2010 16:32:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Henrik Rydberg <rydberg@euromail.se>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 Documentation/DocBook/device-drivers.tmpl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/DocBook/device-drivers.tmpl b/Documentation/DocBook/device-drivers.tmpl
index 22edcbb..35447e0 100644
--- a/Documentation/DocBook/device-drivers.tmpl
+++ b/Documentation/DocBook/device-drivers.tmpl
@@ -304,6 +304,10 @@ X!Idrivers/video/console/fonts.c
 !Edrivers/input/ff-core.c
 !Edrivers/input/ff-memless.c
      </sect1>
+     <sect1><title>Multitouch Library</title>
+!Iinclude/linux/input/mt.h
+!Edrivers/input/input-mt.c
+     </sect1>
      <sect1><title>Polled input devices</title>
 !Iinclude/linux/input-polldev.h
 !Edrivers/input/input-polldev.c
-- 
1.7.1

