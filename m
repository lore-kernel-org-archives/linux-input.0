From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [PATCH v2 4/4] hid-lg4ff: Add support for ramp effect
Date: Mon, 24 Feb 2014 00:36:15 +0100
Message-ID: <1470885.ADmv6FOjmm@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:41509 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762AbaBWXgR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 18:36:17 -0500
In-Reply-To: <1516865.M993BQAYe4@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, anssi.hannula@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

hid-lg4ff: Add support for ramp effect

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
 drivers/hid/hid-lg4ff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index d7d8d83..e5c90bb 100644
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
1.9.0


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
