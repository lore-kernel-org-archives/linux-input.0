From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH 5/5] Remove the note that no driver currently uses ff-memless-next
Date: Tue, 04 Feb 2014 23:14:53 +0100
Message-ID: <2010881.Fh1vPVWlHG@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <2603901.tycGoWUc45@geidi-prime> <1602355.m08XyDkxUs@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.spider.cz ([31.31.77.241]:39355 "EHLO prifuk.cz"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S933998AbaBDWOz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 17:14:55 -0500
In-Reply-To: <1602355.m08XyDkxUs@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, simon@mungewell.org, linux-input@vger.kernel.org

Remove the note that no driver currently uses ff-memless-next

Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
 drivers/input/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 4371a12..ba05100 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -81,8 +81,7 @@ config INPUT_FF_MEMLESS_NEXT
 	tristate "New version of support for memoryless force feedback device=
s"
 	help
 	  Say Y here if you want to enable support for various memoryless
-	  force feedback devices (as of now there is no hardware-specific
-	  driver that supports this).
+	  force feedback devices.
=20
 	  If unsure, say N.
=20
--=20
1.8.5.3


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
