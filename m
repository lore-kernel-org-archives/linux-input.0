From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH trivial] input: apanel: remove a redundant MODULE_ALIAS
Date: Mon, 29 Aug 2011 23:26:29 +0200
Message-ID: <1314653189-31020-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:49145 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754317Ab1H2V1c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Aug 2011 17:27:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Hemminger <shemminger@linux-foundation.org>, linux-kernel@vger.kernel.org, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 drivers/input/misc/apanel.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index a8d2b8d..1dd1bd3 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -346,5 +346,4 @@ MODULE_DESCRIPTION(APANEL_NAME " driver");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(APANEL_VERSION);
=20
-MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifeBook*:pvr*:rvnFUJITSU:*");
 MODULE_ALIAS("dmi:*:svnFUJITSU:pnLifebook*:pvr*:rvnFUJITSU:*");
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
