From: akpm@linux-foundation.org
Subject: [patch 6/8] input: i8042: add Dritek quirk for Acer TravelMate 660
Date: Wed, 30 Jul 2008 12:31:41 -0700
Message-ID: <200807301931.m6UJVffQ012061@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34995 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753565AbYG3TcH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jul 2008 15:32:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, bonbons@linux-vserver.org

=46rom: Bruno Pr=E9mont <bonbons@linux-vserver.org>

The Acer TravelMate 660 series also requires the Dritek quirk to enable
the extra scancodes.

Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/i8042-x86ia64io.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN drivers/input/serio/i8042-x86ia64io.h~input-i8042-add-dritek-=
quirk-for-acer-travelmate-660 drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h~input-i8042-add-dritek-quir=
k-for-acer-travelmate-660
+++ a/drivers/input/serio/i8042-x86ia64io.h
@@ -388,6 +388,13 @@ static struct dmi_system_id __initdata i
 		},
 	},
 	{
+		.ident =3D "Acer TravelMate 660",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
+		},
+	},
+	{
 		.ident =3D "Acer TravelMate 2490",
 		.matches =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
_
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
