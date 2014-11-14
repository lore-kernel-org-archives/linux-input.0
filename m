From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 1/7] input: alps: Set correct name of psmouse device in alps_init()
Date: Fri, 14 Nov 2014 20:38:20 +0100
Message-ID: <1415993906-13307-2-git-send-email-pali.rohar@gmail.com>
References: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:62303 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161540AbaKNTiy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Nov 2014 14:38:54 -0500
In-Reply-To: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Vadim Klishko <vadim@cirque.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

On some laptops after starting them from off state (not after reboot), =
function
alps_probe_trackstick_v3() (called from function alps_identify()) does =
not
detect trackstick. To fix this problem we need to reset device. But fun=
ction
alps_identify() is called also from alps_detect() and we do not want to=
 reset
device in detect function because it will slow down initialization of a=
ll other
non alps devices.

This patch moves code for setting correct device name & protocol from f=
unction
alps_detect() to alps_init() which already doing full device reset.

So this patch removes need to do trackstick detection in alps_detect() =
function.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 8d85c79..9ffa98d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2392,6 +2392,10 @@ int alps_init(struct psmouse *psmouse)
 	if (input_register_device(priv->dev2))
 		goto init_fail;
=20
+	if (!(priv->flags & ALPS_DUALPOINT))
+		psmouse->name =3D "GlidePoint TouchPad";
+	psmouse->model =3D priv->proto_version;
+
 	psmouse->protocol_handler =3D alps_process_byte;
 	psmouse->poll =3D alps_poll;
 	psmouse->disconnect =3D alps_disconnect;
@@ -2422,11 +2426,18 @@ int alps_detect(struct psmouse *psmouse, bool s=
et_properties)
 		return -1;
=20
 	if (set_properties) {
+		/*
+		 * NOTE: To detect model and trackstick presence we need to do
+		 *       full device reset. To speed up detection and prevent
+		 *       calling duplicate initialization sequence (both in
+		 *       alps_detect() and alps_init()) we set model/protocol
+		 *       version and correct name in alps_init() (which will
+		 *       do full device reset). For now set name to DualPoint.
+		 */
 		psmouse->vendor =3D "ALPS";
-		psmouse->name =3D dummy.flags & ALPS_DUALPOINT ?
-				"DualPoint TouchPad" : "GlidePoint";
-		psmouse->model =3D dummy.proto_version << 8;
+		psmouse->name =3D "DualPoint TouchPad";
 	}
+
 	return 0;
 }
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
