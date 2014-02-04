From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH 4/5] Add support for ramp effect in hid-lg4ff
Date: Tue, 04 Feb 2014 23:13:45 +0100
Message-ID: <1602355.m08XyDkxUs@geidi-prime>
References: <1602354.DiHhm9tiaI@geidi-prime> <3580124.nFkHgCoyEf@geidi-prime> <2603901.tycGoWUc45@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:39350 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934008AbaBDWNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 17:13:48 -0500
In-Reply-To: <2603901.tycGoWUc45@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, simon@mungewell.org, linux-input@vger.kernel.org

Add support for ramp effect in hid-lg4ff

Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
 drivers/hid/hid-lg4ff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index c82b02c..75245cc 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -71,6 +71,7 @@ struct lg4ff_device_entry {
=20
 static const signed short lg4ff_wheel_effects[] =3D {
 	FF_CONSTANT,
+	FF_RAMP,
 	FF_PERIODIC,
 	FF_SQUARE,
 	FF_TRIANGLE,
--=20
1.8.5.3


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
