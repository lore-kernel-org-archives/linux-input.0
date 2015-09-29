From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2] HID: hid-input: allow input_configured callback return
 errors
Date: Tue, 29 Sep 2015 15:52:59 -0700
Message-ID: <20150929225259.GA33426@dtor-ws>
References: <20150925231451.GA40951@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34261 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbbI2WxE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 18:53:04 -0400
Content-Disposition: inline
In-Reply-To: <20150925231451.GA40951@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Jaikumar Ganesh <jaikumarg@android.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, James C Boyd <jcboyd.dev@gmail.com>, Karl Relton <karllinuxtest.relton@ntlworld.com>, David Herrmann <dh.herrmann@gmail.com>, Olivier Gay <ogay@logitech.com>, Ross Skaliotis <rskaliotis@gmail.com>, Jamie Lentin <jm@lentin.co.uk>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andreas Fleig <andreasfleig@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Peter Wu <peter@lekensteyn.nl>, Goffredo Baroncelli <kreijack@inwind.it>, Mathieu Magnaudet <mathieu.magnaudet@gmail.com>, Brent Adam <brentadamdev@gmail.com>, Yang Bo <linuxsea@163.com>, Seth Forshee <seth.forshee@canonical.com>, Andrew Duggan <aduggan@synaptics.com>, Dan Carpenter <dan.carpenter@oracle.com>, Frank Praznik <fran>

When configuring input device via input_configured callback we may
encounter errors (for example input_mt_init_slots() may fail). Instead
of continuing with half-initialized input device let's allow driver
indicate failures.

Signed-off-by: Jaikumar Ganesh <jaikumarg@android.com>
Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Acked-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v1->v2:
- addressed David's comments re: hid-multitouch.c
- changed hid-rmi.c to not return error if device is not RMI one as
  mentioned by Andrew Duggan.

 drivers/hid/hid-appleir.c        |  4 +++-
 drivers/hid/hid-elo.c            |  4 +++-
 drivers/hid/hid-input.c          | 10 ++++++----
 drivers/hid/hid-lenovo.c         |  4 +++-
 drivers/hid/hid-logitech-hidpp.c |  4 +++-
 drivers/hid/hid-magicmouse.c     |  8 ++++++--
 drivers/hid/hid-multitouch.c     | 20 +++++++++++++++-----
 drivers/hid/hid-ntrig.c          |  6 ++++--
 drivers/hid/hid-rmi.c            | 11 +++++++----
 drivers/hid/hid-sony.c           | 13 ++++++++++---
 drivers/hid/hid-uclogic.c        |  6 ++++--
 include/linux/hid.h              |  4 ++--
 12 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 0e6a42d..07cbc70 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -256,7 +256,7 @@ out:
 	return 0;
 }
=20
-static void appleir_input_configured(struct hid_device *hid,
+static int appleir_input_configured(struct hid_device *hid,
 		struct hid_input *hidinput)
 {
 	struct input_dev *input_dev =3D hidinput->input;
@@ -275,6 +275,8 @@ static void appleir_input_configured(struct hid_dev=
ice *hid,
 	for (i =3D 0; i < ARRAY_SIZE(appleir_key_table); i++)
 		set_bit(appleir->keymap[i], input_dev->keybit);
 	clear_bit(KEY_RESERVED, input_dev->keybit);
+
+	return 0;
 }
=20
 static int appleir_input_mapping(struct hid_device *hid,
diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 4e49462..aad8c16 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -37,7 +37,7 @@ static bool use_fw_quirk =3D true;
 module_param(use_fw_quirk, bool, S_IRUGO);
 MODULE_PARM_DESC(use_fw_quirk, "Do periodic pokes for broken M firmwar=
es (default =3D true)");
=20
-static void elo_input_configured(struct hid_device *hdev,
+static int elo_input_configured(struct hid_device *hdev,
 		struct hid_input *hidinput)
 {
 	struct input_dev *input =3D hidinput->input;
@@ -45,6 +45,8 @@ static void elo_input_configured(struct hid_device *h=
dev,
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
+
+	return 0;
 }
=20
 static void elo_process_data(struct input_dev *input, const u8 *data, =
int size)
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 53aeaf6..2ba6bf6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1510,8 +1510,9 @@ int hidinput_connect(struct hid_device *hid, unsi=
gned int force)
 				 * UGCI) cram a lot of unrelated inputs into the
 				 * same interface. */
 				hidinput->report =3D report;
-				if (drv->input_configured)
-					drv->input_configured(hid, hidinput);
+				if (drv->input_configured &&
+				    drv->input_configured(hid, hidinput))
+					goto out_cleanup;
 				if (input_register_device(hidinput->input))
 					goto out_cleanup;
 				hidinput =3D NULL;
@@ -1532,8 +1533,9 @@ int hidinput_connect(struct hid_device *hid, unsi=
gned int force)
 	}
=20
 	if (hidinput) {
-		if (drv->input_configured)
-			drv->input_configured(hid, hidinput);
+		if (drv->input_configured &&
+		    drv->input_configured(hid, hidinput))
+			goto out_cleanup;
 		if (input_register_device(hidinput->input))
 			goto out_cleanup;
 	}
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index e4bc6cb..8979f1f 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -848,7 +848,7 @@ static void lenovo_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
=20
-static void lenovo_input_configured(struct hid_device *hdev,
+static int lenovo_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
 {
 	switch (hdev->product) {
@@ -863,6 +863,8 @@ static void lenovo_input_configured(struct hid_devi=
ce *hdev,
 			}
 			break;
 	}
+
+	return 0;
 }
=20
=20
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
index 452e5d5..5fd9786 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1285,13 +1285,15 @@ static void hidpp_populate_input(struct hidpp_d=
evice *hidpp,
 		m560_populate_input(hidpp, input, origin_is_hid_core);
 }
=20
-static void hidpp_input_configured(struct hid_device *hdev,
+static int hidpp_input_configured(struct hid_device *hdev,
 				struct hid_input *hidinput)
 {
 	struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
 	struct input_dev *input =3D hidinput->input;
=20
 	hidpp_populate_input(hidpp, input, true);
+
+	return 0;
 }
=20
 static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.=
c
index 29a74c1..d6fa496 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -471,18 +471,22 @@ static int magicmouse_input_mapping(struct hid_de=
vice *hdev,
 	return 0;
 }
=20
-static void magicmouse_input_configured(struct hid_device *hdev,
+static int magicmouse_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
=20
 {
 	struct magicmouse_sc *msc =3D hid_get_drvdata(hdev);
+	int ret;
=20
-	int ret =3D magicmouse_setup_input(msc->input, hdev);
+	ret =3D magicmouse_setup_input(msc->input, hdev);
 	if (ret) {
 		hid_err(hdev, "magicmouse setup input failed (%d)\n", ret);
 		/* clean msc->input to notify probe() of the failure */
 		msc->input =3D NULL;
+		return ret;
 	}
+
+	return 0;
 }
=20
=20
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index 426b2f1..2ed42d8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -725,12 +725,13 @@ static void mt_touch_report(struct hid_device *hi=
d, struct hid_report *report)
 		mt_sync_frame(td, report->field[0]->hidinput->input);
 }
=20
-static void mt_touch_input_configured(struct hid_device *hdev,
+static int mt_touch_input_configured(struct hid_device *hdev,
 					struct hid_input *hi)
 {
 	struct mt_device *td =3D hid_get_drvdata(hdev);
 	struct mt_class *cls =3D &td->mtclass;
 	struct input_dev *input =3D hi->input;
+	int ret;
=20
 	if (!td->maxcontacts)
 		td->maxcontacts =3D MT_DEFAULT_MAXCONTACT;
@@ -752,9 +753,12 @@ static void mt_touch_input_configured(struct hid_d=
evice *hdev,
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
=20
-	input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
+	ret =3D input_mt_init_slots(input, td->maxcontacts, td->mt_flags);
+	if (ret)
+		return ret;
=20
 	td->mt_flags =3D 0;
+	return 0;
 }
=20
 static int mt_input_mapping(struct hid_device *hdev, struct hid_input =
*hi,
@@ -930,15 +934,19 @@ static void mt_post_parse(struct mt_device *td)
 		cls->quirks &=3D ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 }
=20
-static void mt_input_configured(struct hid_device *hdev, struct hid_in=
put *hi)
+static int mt_input_configured(struct hid_device *hdev, struct hid_inp=
ut *hi)
 {
 	struct mt_device *td =3D hid_get_drvdata(hdev);
 	char *name;
 	const char *suffix =3D NULL;
 	struct hid_field *field =3D hi->report->field[0];
+	int ret;
=20
-	if (hi->report->id =3D=3D td->mt_report_id)
-		mt_touch_input_configured(hdev, hi);
+	if (hi->report->id =3D=3D td->mt_report_id) {
+		ret =3D mt_touch_input_configured(hdev, hi);
+		if (ret)
+			return ret;
+	}
=20
 	/*
 	 * some egalax touchscreens have "application =3D=3D HID_DG_TOUCHSCRE=
EN"
@@ -989,6 +997,8 @@ static void mt_input_configured(struct hid_device *=
hdev, struct hid_input *hi)
 			hi->input->name =3D name;
 		}
 	}
+
+	return 0;
 }
=20
 static int mt_probe(struct hid_device *hdev, const struct hid_device_i=
d *id)
diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 600f207..756d1ef 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -859,14 +859,14 @@ not_claimed_input:
 	return 1;
 }
=20
-static void ntrig_input_configured(struct hid_device *hid,
+static int ntrig_input_configured(struct hid_device *hid,
 		struct hid_input *hidinput)
=20
 {
 	struct input_dev *input =3D hidinput->input;
=20
 	if (hidinput->report->maxfield < 1)
-		return;
+		return 0;
=20
 	switch (hidinput->report->field[0]->application) {
 	case HID_DG_PEN:
@@ -890,6 +890,8 @@ static void ntrig_input_configured(struct hid_devic=
e *hid,
 							"N-Trig MultiTouch";
 		break;
 	}
+
+	return 0;
 }
=20
 static int ntrig_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 2c14812..67cd059 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -1173,7 +1173,7 @@ static int rmi_populate(struct hid_device *hdev)
 	return 0;
 }
=20
-static void rmi_input_configured(struct hid_device *hdev, struct hid_i=
nput *hi)
+static int rmi_input_configured(struct hid_device *hdev, struct hid_in=
put *hi)
 {
 	struct rmi_data *data =3D hid_get_drvdata(hdev);
 	struct input_dev *input =3D hi->input;
@@ -1185,10 +1185,10 @@ static void rmi_input_configured(struct hid_dev=
ice *hdev, struct hid_input *hi)
 	hid_dbg(hdev, "Opening low level driver\n");
 	ret =3D hid_hw_open(hdev);
 	if (ret)
-		return;
+		return ret;
=20
 	if (!(data->device_flags & RMI_DEVICE))
-		return;
+		return 0;
=20
 	/* Allow incoming hid reports */
 	hid_device_io_start(hdev);
@@ -1228,7 +1228,9 @@ static void rmi_input_configured(struct hid_devic=
e *hdev, struct hid_input *hi)
 	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 0x0f, 0, 0);
 	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 0x0f, 0, 0);
=20
-	input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
+	ret =3D input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTE=
R);
+	if (ret < 0)
+		goto exit;
=20
 	if (data->button_count) {
 		__set_bit(EV_KEY, input->evbit);
@@ -1244,6 +1246,7 @@ static void rmi_input_configured(struct hid_devic=
e *hdev, struct hid_input *hi)
 exit:
 	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
+	return ret;
 }
=20
 static int rmi_input_mapping(struct hid_device *hdev,
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 661f94f..774cd22 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1360,20 +1360,27 @@ static int sony_register_touchpad(struct hid_in=
put *hi, int touch_count,
 	return 0;
 }
=20
-static void sony_input_configured(struct hid_device *hdev,
+static int sony_input_configured(struct hid_device *hdev,
 					struct hid_input *hidinput)
 {
 	struct sony_sc *sc =3D hid_get_drvdata(hdev);
+	int ret;
=20
 	/*
 	 * The Dualshock 4 touchpad supports 2 touches and has a
 	 * resolution of 1920x942 (44.86 dots/mm).
 	 */
 	if (sc->quirks & DUALSHOCK4_CONTROLLER) {
-		if (sony_register_touchpad(hidinput, 2, 1920, 942) !=3D 0)
+		ret =3D sony_register_touchpad(hidinput, 2, 1920, 942);
+		if (ret) {
 			hid_err(sc->hdev,
-				"Unable to initialize multi-touch slots\n");
+				"Unable to initialize multi-touch slots: %d\n",
+				ret);
+			return ret;
+		}
 	}
+
+	return 0;
 }
=20
 /*
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index b905d50..85ac435 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -731,7 +731,7 @@ static int uclogic_input_mapping(struct hid_device =
*hdev, struct hid_input *hi,
 	return 0;
 }
=20
-static void uclogic_input_configured(struct hid_device *hdev,
+static int uclogic_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
 {
 	char *name;
@@ -741,7 +741,7 @@ static void uclogic_input_configured(struct hid_dev=
ice *hdev,
=20
 	/* no report associated (HID_QUIRK_MULTI_INPUT not set) */
 	if (!hi->report)
-		return;
+		return 0;
=20
 	field =3D hi->report->field[0];
=20
@@ -774,6 +774,8 @@ static void uclogic_input_configured(struct hid_dev=
ice *hdev,
 			hi->input->name =3D name;
 		}
 	}
+
+	return 0;
 }
=20
 /**
diff --git a/include/linux/hid.h b/include/linux/hid.h
index f17980d..251a1d3 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -698,8 +698,8 @@ struct hid_driver {
 	int (*input_mapped)(struct hid_device *hdev,
 			struct hid_input *hidinput, struct hid_field *field,
 			struct hid_usage *usage, unsigned long **bit, int *max);
-	void (*input_configured)(struct hid_device *hdev,
-				 struct hid_input *hidinput);
+	int (*input_configured)(struct hid_device *hdev,
+				struct hid_input *hidinput);
 	void (*feature_mapping)(struct hid_device *hdev,
 			struct hid_field *field,
 			struct hid_usage *usage);
--=20
2.6.0.rc2.230.g3dd15c0

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
