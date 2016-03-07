From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH] MAINTAINERS: Add devicetree bindings to Input Drivers section
Date: Mon,  7 Mar 2016 19:18:13 +0100
Message-ID: <1457374694-4764-1-git-send-email-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42235 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146AbcCGSST (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 7 Mar 2016 13:18:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, open list <linux-kernel@vger.kernel.org>

To avoid changes to input bindings not reaching linux-input reviewers
add an appropriate file pattern to the MAINTAINERS entry.

Reported-by: Heiko St=C3=BCbner <heiko@sntech.de>
Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e9d47e10f59..b01a56dd7fb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5633,6 +5633,7 @@ F:	drivers/input/
 F:	include/linux/input.h
 F:	include/uapi/linux/input.h
 F:	include/linux/input/
+F:	Documentation/devicetree/bindings/input/
=20
 INPUT MULTITOUCH (MT) PROTOCOL
 M:	Henrik Rydberg <rydberg@bitmath.org>
--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
