From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH 3/5] Add support for periodic effects in hid-lg4ff
Date: Tue, 04 Feb 2014 23:12:32 +0100
Message-ID: <2603901.tycGoWUc45@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <4656889.s9yIX65sPh@geidi-prime> <3580124.nFkHgCoyEf@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.spider.cz ([31.31.77.241]:39343 "EHLO prifuk.cz"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934041AbaBDWMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 17:12:35 -0500
In-Reply-To: <3580124.nFkHgCoyEf@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, simon@mungewell.org, linux-input@vger.kernel.org

Add support for periodic effects in hid-lg4ff

Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
 drivers/hid/hid-lg4ff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index f236b9f..c82b02c 100644
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
1.8.5.3


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
