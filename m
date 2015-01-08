From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH 3/3] Update MAINTAINERS file with e3x0-button info.
Date: Thu,  8 Jan 2015 22:02:51 +0100
Message-ID: <1420750971-21812-4-git-send-email-moritz.fischer@ettus.com>
References: <1420750971-21812-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:40819 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbbAHVDc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 16:03:32 -0500
Received: by mail-we0-f177.google.com with SMTP id q59so4658012wes.8
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 13:03:31 -0800 (PST)
In-Reply-To: <1420750971-21812-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..65358d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3466,6 +3466,14 @@ M:	"Maciej W. Rozycki" <macro@linux-mips.org>
 S:	Maintained
 F:	drivers/tty/serial/dz.*
 
+E3X0 POWER BUTTON DRIVER
+M:	Moritz Fischer <moritz.fischer@ettus.com>
+L:	usrp-users@lists.ettus.com
+W:	http://www.ettus.com
+S:	Supported
+F:	drivers/input/misc/e3x0-button.c
+F:	Documentation/devicetree/bindings/input/e3x0-button.txt
+
 E4000 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
1.9.3

