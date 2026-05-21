Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DEB22332E;
	Thu, 21 May 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369921; cv=none; b=ZNQHuj3t7MLIC5HQ1+GKhCXF1Y9zMBGU4/43tIKIL+th0lIIw91SdbB5lPOEPBtm4ZqGAY+GOFb4YGFqMjEKREuTSKm8OxBKOtlTRMwBDVP1aLLJ72T1BEdJj8z9ZmgT/Q6g3rf4kQEt5kXUZ4DRYbAucHRHmV2EStuWLaGQovM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369921; c=relaxed/simple;
	bh=VvFfi/Z0PlaRHDql+ODbPozEVEaliHCi2zVUOJmivUA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sw3BXNoFVmClxrYdHRkTFPWFC9edExNRQm/nbIaPyyrexrROl9RQNYZ+qjAoWvnJj83aA32JnC9ePPwvgxfWbI5lwtznzfYsTKxXn6XWfDWGzUFMt1Fb8RvvWgmbznmmm8MA+2C+q5VKyr0L0ffXg17l8KSGE++9+nHGJ1SXDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=KN59KIlS; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="KN59KIlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779369907; x=1779629107;
	bh=2T7bKXUtYhD1IVtchcvda75WFq36kL0orMmgBTH3gXI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KN59KIlSOs2mLWa27tA+2P5koMIOmzTe3tT1ep6CaSIwN6ngZdyz/deC0KRleS4ME
	 EcE/WEKMr1WYWcKF7m8r7T65NTh2fAVbhmwf/vzGC8ZaMy+LJr+ziDTFixqDhaJiOh
	 f1HmyutXvvtxcdu3nAejxbvVORBr3+0L5hXox23tp062NV+ZfbH+TKTes+7RoJlMbS
	 1O6JwnPkoyUFSQRToiXkv02N4LfS9LTD3BC0ZEorQ3eLbIMMuk12YfQJfbJ6I1sQBT
	 EGwXVMIsr3BUBxIGmK9eMiiOYkkMfdVgLYBdlPW3gD8YWwTJBdQE4S5hxi2a7ocI4e
	 ALvrrRziwiZHw==
Date: Thu, 21 May 2026 13:25:01 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aditya Garg <gargaditya08@proton.me>
Subject: [PATCH] HID: appletb-kbd: add option to switch default layer on double pressing fn key
Message-ID: <20260521132447.19241-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 1ad488701ad09236a6fe906fa6a724fd7d1ccbfa
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Aditya Garg <gargaditya08@proton.me>

This patch enables a user to switch the default layer from media to fn
keys and vice-versa upon double pressing the fn key. This behaviour can
be configured using the double_press_switch_time module parameter whose
value depicts the time in milliseconds within which the fn key must be
pressed again to switch the default layer. If set to 0, it simply
disables this behaviour.

Signed-off-by: Aditya Garg <gargaditya08@proton.me>
---
 drivers/hid/hid-appletb-kbd.c | 60 +++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 462010a75..4f900338b 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -56,6 +56,12 @@ static int appletb_tb_idle_timeout =3D 15;
 module_param_named(idle_timeout, appletb_tb_idle_timeout, int, 0644);
 MODULE_PARM_DESC(idle_timeout, "Idle timeout in sec");
=20
+static int appletb_tb_double_press_switch_layers;
+module_param_named(double_press_switch_time,
+=09=09   appletb_tb_double_press_switch_layers, int, 0644);
+MODULE_PARM_DESC(double_press_switch_time, "Time in ms within which if fn =
key is double "
+=09=09=09=09=09   "pressed will switch layers");
+
 struct appletb_kbd {
 =09struct hid_field *mode_field;
 =09struct input_handler inp_handler;
@@ -68,6 +74,7 @@ struct appletb_kbd {
 =09bool has_turned_off;
 =09u8 saved_mode;
 =09u8 current_mode;
+=09unsigned long last_fn_press;
 };
=20
 static const struct key_entry appletb_kbd_keymap[] =3D {
@@ -243,6 +250,18 @@ static int appletb_kbd_hid_event(struct hid_device *hd=
ev, struct hid_field *fiel
 =09return kbd->current_mode =3D=3D APPLETB_KBD_MODE_OFF;
 }
=20
+static u8 appletb_switch_mode(u8 mode)
+{
+=09switch (mode) {
+=09case APPLETB_KBD_MODE_SPCL:
+=09=09return APPLETB_KBD_MODE_FN;
+=09case APPLETB_KBD_MODE_FN:
+=09=09return APPLETB_KBD_MODE_SPCL;
+=09default:
+=09=09return mode;
+=09}
+}
+
 static void appletb_kbd_inp_event(struct input_handle *handle, unsigned in=
t type,
 =09=09=09      unsigned int code, int value)
 {
@@ -250,15 +269,42 @@ static void appletb_kbd_inp_event(struct input_handle=
 *handle, unsigned int type
=20
 =09reset_inactivity_timer(kbd);
=20
-=09if (type =3D=3D EV_KEY && code =3D=3D KEY_FN && appletb_tb_fn_toggle &&
-=09=09(kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
-=09=09 kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
+=09if (type =3D=3D EV_KEY && code =3D=3D KEY_FN &&
+=09    (kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
+=09     kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
+
 =09=09if (value =3D=3D 1) {
-=09=09=09kbd->saved_mode =3D kbd->current_mode;
-=09=09=09appletb_kbd_set_mode(kbd, kbd->current_mode =3D=3D APPLETB_KBD_MO=
DE_SPCL
-=09=09=09=09=09=09? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
+=09=09=09if (appletb_tb_double_press_switch_layers) {
+=09=09=09=09unsigned long now =3D jiffies;
+
+=09=09=09=09if (time_before(now, kbd->last_fn_press +
+=09=09=09=09=09msecs_to_jiffies(appletb_tb_double_press_switch_layers))) {
+
+=09=09=09=09=09appletb_tb_def_mode =3D
+=09=09=09=09=09=09appletb_switch_mode(
+=09=09=09=09=09=09=09appletb_tb_def_mode);
+
+=09=09=09=09=09appletb_kbd_set_mode(kbd,
+=09=09=09=09=09=09appletb_tb_def_mode);
+
+=09=09=09=09=09kbd->saved_mode =3D appletb_tb_def_mode;
+=09=09=09=09=09kbd->last_fn_press =3D 0;
+
+=09=09=09=09=09return;
+=09=09=09=09}
+
+=09=09=09=09kbd->last_fn_press =3D now;
+=09=09=09}
+=09=09=09if (appletb_tb_fn_toggle) {
+=09=09=09=09kbd->saved_mode =3D kbd->current_mode;
+
+=09=09=09=09appletb_kbd_set_mode(kbd,
+=09=09=09=09=09appletb_switch_mode(kbd->current_mode));
+=09=09=09}
+
 =09=09} else if (value =3D=3D 0) {
-=09=09=09if (kbd->saved_mode !=3D kbd->current_mode)
+=09=09=09if (appletb_tb_fn_toggle &&
+=09=09=09    kbd->saved_mode !=3D kbd->current_mode)
 =09=09=09=09appletb_kbd_set_mode(kbd, kbd->saved_mode);
 =09=09}
 =09}
--=20
2.53.0


