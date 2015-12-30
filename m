From: =?iso-8859-1?Q?Aur=E9lien?= Francillon <aurelien@francillon.net>
Subject: [PATCH] Input: i8042 add Fujitsu Lifebook U745 to the nomux list
Date: Wed, 30 Dec 2015 01:14:23 +0100
Message-ID: <20151230001423.GW8549@crashmenot.s3.eurecom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.eurecom.fr ([193.55.113.213]:58792 "EHLO smtp2.eurecom.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753613AbbL3AY6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Dec 2015 19:24:58 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

Without i8042.nomux=3D1 the Elantech touch pad is not working at all on
a Fujitsu Lifebook U745. This patch does not seem necessary for all
U745 (maybe because of different BIOS versions?). However, it was
verified that the patch does not break those (see opensuse bug 883192:
https://bugzilla.opensuse.org/show_bug.cgi?id=3D883192).

Signed-off-by: Aur=E9lien Francillon <aurelien@francillon.net>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/seri=
o/i8042-x86ia64io.h
index c115565..68f5f4a 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -258,6 +258,13 @@ static const struct dmi_system_id __initconst i804=
2_dmi_nomux_table[] =3D {
 		},
 	},
 	{
+		/* Fujitsu Lifebook U745 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
+		},
+	},
+	{
 		/* Fujitsu T70H */
 		.matches =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
--=20
2.6.4


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
