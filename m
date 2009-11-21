From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: Re: [RFC, PATCH 2/2] gspca pac7302: add support for camera button
Date: Sat, 21 Nov 2009 12:16:59 +0100
Message-ID: <4B07CC2B.2020301@freemail.hu>
References: <4B04F7EA.4020804@freemail.hu> <4B0641CF.1000000@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01a.mail.t-online.hu ([84.2.40.6]:57547 "EHLO
	mail01a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbZKULQ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Nov 2009 06:16:56 -0500
In-Reply-To: <4B0641CF.1000000@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org
Cc: Jean-Francois Moine <moinejf@free.fr>, V4L Mailing List <linux-media@vger.kernel.org>

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

Add support for snapshot button found on Labtec Webcam 2200.

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
---
diff -r abfdd03b800d linux/drivers/media/video/gspca/pac7302.c
--- a/linux/drivers/media/video/gspca/pac7302.c	Thu Nov 19 10:34:21 200=
9 +0100
+++ b/linux/drivers/media/video/gspca/pac7302.c	Sat Nov 21 13:02:44 200=
9 +0100
@@ -68,8 +68,10 @@

 #define MODULE_NAME "pac7302"

+#include <linux/input.h>
 #include <media/v4l2-chip-ident.h>
 #include "gspca.h"
+#include "input.h"

 MODULE_AUTHOR("Thomas Kaiser thomas@kaiser-linux.li");
 MODULE_DESCRIPTION("Pixart PAC7302");
@@ -1220,6 +1222,37 @@
 }
 #endif

+#ifdef CONFIG_INPUT
+static int sd_int_pkt_scan(struct gspca_dev *gspca_dev,
+			u8 *data,		/* interrupt packet data */
+			int len)		/* interrput packet length */
+{
+	int ret =3D -EINVAL;
+	u8 data0, data1;
+
+	if (len =3D=3D 2) {
+		data0 =3D data[0];
+		data1 =3D data[1];
+		if ((data0 =3D=3D 0x00 && data1 =3D=3D 0x11) ||
+		    (data0 =3D=3D 0x22 && data1 =3D=3D 0x33) ||
+		    (data0 =3D=3D 0x44 && data1 =3D=3D 0x55) ||
+		    (data0 =3D=3D 0x66 && data1 =3D=3D 0x77) ||
+		    (data0 =3D=3D 0x88 && data1 =3D=3D 0x99) ||
+		    (data0 =3D=3D 0xaa && data1 =3D=3D 0xbb) ||
+		    (data0 =3D=3D 0xcc && data1 =3D=3D 0xdd) ||
+		    (data0 =3D=3D 0xee && data1 =3D=3D 0xff)) {
+			input_report_key(gspca_dev->input_dev, KEY_CAMERA, 1);
+			input_sync(gspca_dev->input_dev);
+			input_report_key(gspca_dev->input_dev, KEY_CAMERA, 0);
+			input_sync(gspca_dev->input_dev);
+			ret =3D 0;
+		}
+	}
+
+	return ret;
+}
+#endif
+
 /* sub-driver description for pac7302 */
 static struct sd_desc sd_desc =3D {
 	.name =3D MODULE_NAME,
@@ -1236,6 +1269,9 @@
 	.set_register =3D sd_dbg_s_register,
 	.get_chip_ident =3D sd_chip_ident,
 #endif
+#ifdef CONFIG_INPUT
+	.int_pkt_scan =3D sd_int_pkt_scan,
+#endif
 };

 /* -- module initialisation -- */

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
