From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] MAINTAINERS: Add me as reviewer of ALPS PS/2 touchpad driver
Date: Mon,  6 Jun 2016 14:03:01 +0200
Message-ID: <1465214581-22327-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33353 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcFFMEB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2016 08:04:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 MAINTAINERS |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed1229e..057c626 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -595,6 +595,10 @@ S:	Odd Fixes
 L:	linux-alpha@vger.kernel.org
 F:	arch/alpha/
=20
+ALPS PS/2 TOUCHPAD DRIVER
+R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
+F:	drivers/input/mouse/alps.*
+
 ALTERA MAILBOX DRIVER
 M:	Ley Foon Tan <lftan@altera.com>
 L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
