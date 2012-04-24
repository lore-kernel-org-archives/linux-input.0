From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] MAINTAINERS - remove Alessandro Rubini from mice maintainers
Date: Mon, 23 Apr 2012 23:32:47 -0700
Message-ID: <20120424063246.GA32680@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48707 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2DXGcx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 02:32:53 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Alessandro Rubini <rubini@gnudd.com>, linux-input@vger.kernel.org

I do not recall Alessandro replying to mice-related question or patches
for ages so let's stop people using get-maintainer.pl from CCing him
with patches.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 MAINTAINERS |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7f7a96..114ffd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4465,12 +4465,6 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/mmc/host/imxmmc.*
 
-MOUSE AND MISC DEVICES [GENERAL]
-M:	Alessandro Rubini <rubini@ipvvis.unipv.it>
-S:	Maintained
-F:	drivers/input/mouse/
-F:	include/linux/gpio_mouse.h
-
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@gmail.com>
 S:	Maintained
-- 
1.7.7.6


-- 
Dmitry
