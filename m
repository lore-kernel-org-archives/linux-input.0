From: Bruno =?iso-8859-1?q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH] Input: i8042 - add Dritek quirk for Acer TravelMate 660
Date: Fri, 16 May 2008 22:08:32 +0200
Message-ID: <200805162208.33370.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [158.64.110.160] ([158.64.110.160]:46767 "EHLO
	bonbons.gotdns.org" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754305AbYEPUSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2008 16:18:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

The Acer TravelMate 660 series also requires the Dritek quirk to enable=
 the
extra scancodes.

Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
CC: Dmitry Torokhov <dtor@mail.ru>

diff -NurpP linux-2.6.25.4-orig/drivers/input/serio/i8042-x86ia64io.h l=
inux-2.6.25.4/drivers/input/serio/i8042-x86ia64io.h
--- linux-2.6.25.4-orig/drivers/input/serio/i8042-x86ia64io.h	2008-04-1=
7 04:49:44.000000000 +0200
+++ linux-2.6.25.4/drivers/input/serio/i8042-x86ia64io.h	2008-05-16 19:=
20:30.000000000 +0200
@@ -331,6 +331,13 @@ static struct dmi_system_id __initdata i
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

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
