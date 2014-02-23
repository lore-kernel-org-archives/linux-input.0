From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH v2 3/4] hid-lg4ff: Add support for periodic effects
Date: Mon, 24 Feb 2014 00:34:34 +0100
Message-ID: <6737869.96ujbJ2eBZ@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.spider.cz ([31.31.77.241]:41503 "EHLO prifuk.cz"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbaBWXeh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 18:34:37 -0500
In-Reply-To: <1516865.M993BQAYe4@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, anssi.hannula@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

hid-lg4ff: Add support for periodic effects

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
 drivers/hid/hid-lg4ff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 95d2a9f..d7d8d83 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -71,6 +71,12 @@ struct lg4ff_device_entry {
=20
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
+	FF_PERIODIC,
+	FF_SQUARE,
+	FF_TRIANGLE,
+	FF_SINE,
+	FF_SAW_UP,
+	FF_SAW_DOWN,
 	FF_AUTOCENTER,
 	-1
 };
--=20
1.9.0


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
