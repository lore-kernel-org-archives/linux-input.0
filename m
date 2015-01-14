From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/6] Input: ALPS - fix trackstick detection on some Dell Latitudes
Date: Wed, 14 Jan 2015 14:55:53 -0800
Message-ID: <1421276154-8689-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:52334 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbANW4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 17:56:17 -0500
Received: by mail-ig0-f178.google.com with SMTP id b16so11608337igk.5
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 14:56:17 -0800 (PST)
In-Reply-To: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

On some Dell Latitudes we fail to identify presence of trackstick unles=
s we
reset the device. The issue is quite benign as we do perform reset in
alps_init(), so the trackstick ends up working, but mouse name reported=
 to
userspace is not accurate.

In order to fix the issue while avoiding the additional lengthy reset w=
e
move the resrt to alps_detect() and keep the discovered state to be use=
d
later in alps_init().

Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c | 74 ++++++++++++++++++++++++++++++++++----=
--------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index cabb267..fd3303d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2304,6 +2304,7 @@ static int alps_identify(struct psmouse *psmouse,=
 struct alps_data *priv)
 {
 	const struct alps_protocol_info *protocol;
 	unsigned char e6[4], e7[4], ec[4];
+	int error;
=20
 	/*
 	 * First try "E6 report".
@@ -2349,10 +2350,15 @@ static int alps_identify(struct psmouse *psmous=
e, struct alps_data *priv)
 		}
 	}
=20
-	/* Save the Firmware version */
-	memcpy(priv->fw_ver, ec, 3);
+	if (priv) {
+		/* Save the Firmware version */
+		memcpy(priv->fw_ver, ec, 3);
+		error =3D alps_set_protocol(psmouse, priv, protocol);
+		if (error)
+			return error;
+	}
=20
-	return alps_set_protocol(psmouse, priv, protocol);
+	return 0;
 }
=20
 static int alps_reconnect(struct psmouse *psmouse)
@@ -2406,22 +2412,20 @@ static void alps_set_abs_params_mt(struct alps_=
data *priv,
=20
 int alps_init(struct psmouse *psmouse)
 {
-	struct alps_data *priv;
+	struct alps_data *priv =3D psmouse->private;
 	struct input_dev *dev1 =3D psmouse->dev, *dev2;
+	int error;
=20
-	priv =3D kzalloc(sizeof(struct alps_data), GFP_KERNEL);
 	dev2 =3D input_allocate_device();
-	if (!priv || !dev2)
+	if (!dev2) {
+		error =3D -ENOMEM;
 		goto init_fail;
+	}
=20
 	priv->dev2 =3D dev2;
=20
-	psmouse_reset(psmouse);
-
-	if (alps_identify(psmouse, priv) < 0)
-		goto init_fail;
-
-	if (priv->hw_init(psmouse))
+	error =3D priv->hw_init(psmouse);
+	if (error)
 		goto init_fail;
=20
 	/*
@@ -2519,24 +2523,56 @@ int alps_init(struct psmouse *psmouse)
 init_fail:
 	psmouse_reset(psmouse);
 	input_free_device(dev2);
-	kfree(priv);
+	/*
+	 * Even though we did not allocate psmouse->private we do free
+	 * it here.
+	 */
+	kfree(psmouse->private);
 	psmouse->private =3D NULL;
-	return -1;
+	return error;
 }
=20
 int alps_detect(struct psmouse *psmouse, bool set_properties)
 {
-	struct alps_data dummy;
+	struct alps_data *priv;
+	int error;
=20
-	if (alps_identify(psmouse, &dummy) < 0)
-		return -1;
+	error =3D alps_identify(psmouse, NULL);
+	if (error)
+		return error;
+
+	/*
+	 * Reset the device to make sure it is fully operational:
+	 * on some laptops, like certain Dell Latitudes, we may
+	 * fail to properly detect presence of trackstick if device
+	 * has not been reset.
+	 */
+	psmouse_reset(psmouse);
+
+	priv =3D kzalloc(sizeof(struct alps_data), GFP_KERNEL);
+	if (priv)
+		return -ENOMEM;
+
+	error =3D alps_identify(psmouse, priv);
+	if (error)
+		return error;
=20
 	if (set_properties) {
 		psmouse->vendor =3D "ALPS";
-		psmouse->name =3D dummy.flags & ALPS_DUALPOINT ?
+		psmouse->name =3D priv->flags & ALPS_DUALPOINT ?
 				"DualPoint TouchPad" : "GlidePoint";
-		psmouse->model =3D dummy.proto_version;
+		psmouse->model =3D priv->proto_version;
+	} else {
+		/*
+		 * Destroy alps_data structure we allocated earlier since
+		 * this was just a "trial run". Otherwise we'll keep it
+		 * to be used by alps_init() which has to be called if
+		 * we succeed and set_properties is true.
+		 */
+		kfree(priv);
+		psmouse->private =3D NULL;
 	}
+
 	return 0;
 }
=20
--=20
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
