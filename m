From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH v3 1/5] hid-multitouch: Auto detection of maxcontacts
Date: Fri, 18 Mar 2011 14:27:52 +0100
Message-ID: <1300454876-5017-2-git-send-email-benjamin.tissoires__33793.0970280015$1300454942$gmane$org@enac.fr>
References: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39045 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539Ab1CRN1m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2011 09:27:42 -0400
In-Reply-To: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <ch>

This patch enables support of autodetection of maxcontacts.
When adding support for a new device, one is now able to let
the device tell how many contacts it supports, or to manually
set the value if the device happens to provide wrong information.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Reviewed-by: St=C3=A9phane Chatty <chatty@enac.fr>
---

changes since v2:
* reverted "if (td->mtclass->maxcontacts)" test
* reverted MT_DEFAULT_MAXCONTACT
* add a test on td->slots before kzalloc
* remove device in case td->slots was not allocated

 drivers/hid/hid-multitouch.c |   52 +++++++++++++++++++++++++++++-----=
-------
 1 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index ee01e65..b9f9eec 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -60,8 +60,9 @@ struct mt_device {
 	__s8 inputmode;		/* InputMode HID feature, -1 if non-existent */
 	__u8 num_received;	/* how many contacts we received */
 	__u8 num_expected;	/* expected last contact index */
+	__u8 maxcontacts;
 	bool curvalid;		/* is the current contact valid? */
-	struct mt_slot slots[0];	/* first slot */
+	struct mt_slot *slots;
 };
=20
 struct mt_class {
@@ -79,6 +80,8 @@ struct mt_class {
 #define MT_CLS_CYPRESS				4
 #define MT_CLS_EGALAX				5
=20
+#define MT_DEFAULT_MAXCONTACT	10
+
 /*
  * these device-dependent functions determine what slot corresponds
  * to a valid contact that was just read.
@@ -95,12 +98,12 @@ static int cypress_compute_slot(struct mt_device *t=
d)
 static int find_slot_from_contactid(struct mt_device *td)
 {
 	int i;
-	for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
+	for (i =3D 0; i < td->maxcontacts; ++i) {
 		if (td->slots[i].contactid =3D=3D td->curdata.contactid &&
 			td->slots[i].touch_state)
 			return i;
 	}
-	for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
+	for (i =3D 0; i < td->maxcontacts; ++i) {
 		if (!td->slots[i].seen_in_this_frame &&
 			!td->slots[i].touch_state)
 			return i;
@@ -113,8 +116,7 @@ static int find_slot_from_contactid(struct mt_devic=
e *td)
=20
 struct mt_class mt_classes[] =3D {
 	{ .name =3D MT_CLS_DEFAULT,
-		.quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP,
-		.maxcontacts =3D 10 },
+		.quirks =3D MT_QUIRK_NOT_SEEN_MEANS_UP },
 	{ .name =3D MT_CLS_DUAL_INRANGE_CONTACTID,
 		.quirks =3D MT_QUIRK_VALID_IS_INRANGE |
 			MT_QUIRK_SLOT_IS_CONTACTID,
@@ -142,9 +144,19 @@ struct mt_class mt_classes[] =3D {
 static void mt_feature_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
 {
-	if (usage->hid =3D=3D HID_DG_INPUTMODE) {
-		struct mt_device *td =3D hid_get_drvdata(hdev);
+	struct mt_device *td =3D hid_get_drvdata(hdev);
+
+	switch (usage->hid) {
+	case HID_DG_INPUTMODE:
 		td->inputmode =3D field->report->id;
+		break;
+	case HID_DG_CONTACTMAX:
+		td->maxcontacts =3D field->value[0];
+		if (td->mtclass->maxcontacts)
+			/* check if the maxcontacts is given by the class */
+			td->maxcontacts =3D td->mtclass->maxcontacts;
+
+		break;
 	}
 }
=20
@@ -208,8 +220,7 @@ static int mt_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 			td->last_slot_field =3D usage->hid;
 			return 1;
 		case HID_DG_CONTACTID:
-			input_mt_init_slots(hi->input,
-					td->mtclass->maxcontacts);
+			input_mt_init_slots(hi->input, td->maxcontacts);
 			td->last_slot_field =3D usage->hid;
 			return 1;
 		case HID_DG_WIDTH:
@@ -292,7 +303,7 @@ static void mt_complete_slot(struct mt_device *td)
 	if (td->curvalid) {
 		int slotnum =3D mt_compute_slot(td);
=20
-		if (slotnum >=3D 0 && slotnum < td->mtclass->maxcontacts)
+		if (slotnum >=3D 0 && slotnum < td->maxcontacts)
 			td->slots[slotnum] =3D td->curdata;
 	}
 	td->num_received++;
@@ -307,7 +318,7 @@ static void mt_emit_event(struct mt_device *td, str=
uct input_dev *input)
 {
 	int i;
=20
-	for (i =3D 0; i < td->mtclass->maxcontacts; ++i) {
+	for (i =3D 0; i < td->maxcontacts; ++i) {
 		struct mt_slot *s =3D &(td->slots[i]);
 		if ((td->mtclass->quirks & MT_QUIRK_NOT_SEEN_MEANS_UP) &&
 			!s->seen_in_this_frame) {
@@ -341,7 +352,7 @@ static int mt_event(struct hid_device *hid, struct =
hid_field *field,
 	struct mt_device *td =3D hid_get_drvdata(hid);
 	__s32 quirks =3D td->mtclass->quirks;
=20
-	if (hid->claimed & HID_CLAIMED_INPUT) {
+	if (hid->claimed & HID_CLAIMED_INPUT && td->slots) {
 		switch (usage->hid) {
 		case HID_DG_INRANGE:
 			if (quirks & MT_QUIRK_VALID_IS_INRANGE)
@@ -442,9 +453,7 @@ static int mt_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
 	 */
 	hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
=20
-	td =3D kzalloc(sizeof(struct mt_device) +
-				mtclass->maxcontacts * sizeof(struct mt_slot),
-				GFP_KERNEL);
+	td =3D kzalloc(sizeof(struct mt_device), GFP_KERNEL);
 	if (!td) {
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
@@ -461,6 +470,18 @@ static int mt_probe(struct hid_device *hdev, const=
 struct hid_device_id *id)
 	if (ret)
 		goto fail;
=20
+	if (!td->maxcontacts)
+		td->maxcontacts =3D MT_DEFAULT_MAXCONTACT;
+
+	td->slots =3D kzalloc(td->maxcontacts * sizeof(struct mt_slot),
+				GFP_KERNEL);
+	if (!td->slots) {
+		dev_err(&hdev->dev, "cannot allocate multitouch slots\n");
+		hid_hw_stop(hdev);
+		ret =3D -ENOMEM;
+		goto fail;
+	}
+
 	mt_set_input_mode(hdev);
=20
 	return 0;
@@ -482,6 +503,7 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td =3D hid_get_drvdata(hdev);
 	hid_hw_stop(hdev);
+	kfree(td->slots);
 	kfree(td);
 	hid_set_drvdata(hdev, NULL);
 }
--=20
1.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
