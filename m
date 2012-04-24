From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust input-related patterns
Date: Mon, 23 Apr 2012 23:33:49 -0700
Message-ID: <20120424063348.GA32713@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48925 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2DXGdy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 02:33:54 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org

Add pattens for input-related headers to MAINTAINERS file.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2f8f5..d7f7a96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3432,6 +3432,8 @@ Q:	http://patchwork.kernel.org/project/linux-input/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained
 F:	drivers/input/
+F:	include/linux/input.h
+F:	include/linux/input/
 
 INPUT MULTITOUCH (MT) PROTOCOL
 M:	Henrik Rydberg <rydberg@euromail.se>
-- 
1.7.7.6


-- 
Dmitry
