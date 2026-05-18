Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C83E1CF6
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118556; cv=none; b=HjUcjkWVk3C+m+m0EJFSWFAKjWvn/NHR2spgFQ2niuf0oRCqnUzra23ZcPABQmNjblPWiflqcPOLEF77d0f+eCgDIfXAB6TwuKAwgWW0CNprlzxszm2nsr/r93fxovkGFenaxmbSh+pO09p86GYtFOyyy3RmUcdmD2Riwk1bTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118556; c=relaxed/simple;
	bh=NfwTbz5eKTKCh32K8bUV2znPNyWMbPjntjGfgLK9VUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4QqJoC5lIhgZOmW/JZ2F3QXYUM9iYM128djVp5zbX89FUuLXSKZxJQm4lEFqb+AvhyVwTAc49FLKjZ9TiD86dt7RAGs0cUiOYmq70ylPuGD3F4P7DuxEc3hlKjl3i7eUXDii9tmjUPlLWCpn9XwiCyIw4gcSqewwoRKq75Q/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bes.tel; spf=pass smtp.mailfrom=bes.tel; dkim=pass (2048-bit key) header.d=bes.tel header.i=@bes.tel header.b=oJpbJgb9; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=KU1aTaTy; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bes.tel
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bes.tel
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bes.tel header.i=@bes.tel header.b="oJpbJgb9";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="KU1aTaTy"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=oJpbJgb9OYPqSoz8HUIVS/+3aWEbuKroJX0AzuydU94amzTsDhGJ+b6ue8zECYGJEuqLacz4HN9wqswCoNyMF/bA9/ndH5XW9CMlqxagud+a+8UsG1TVGQFlLCdsddMlzx9iw3NVYyuic/tMeOF8/qCz1jyqFvhiApinMuEwxiUbBbKy/hkW6xc/qIlQFmSFLkMYZB5S7Q84l/JzLftOcFlfgbtgVSviWOgnbon3+ycZ51sDSDh5eFoc5YA026t5YeOhbgkJLS2QIDAEBmR4W/vetlTrYrU8SLX4mAUtoSnZrKa4TUggXPRCwH2ZqJNW1d5G7Y8GN4PkGz6yMRdJ2Q==; s=purelymail2; d=bes.tel; v=1; bh=NfwTbz5eKTKCh32K8bUV2znPNyWMbPjntjGfgLK9VUg=; h=Received:Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=KU1aTaTyGn3CXXlY1+J8QyWhU0SKSWSvHACGezK9+FJHHymjBv7zuCjANNTpodC0aVACHJAAWjnu4w6x42Y/LpI4FJEF5fM82HNAUgyvd9cuEQ5M0bXK8dP47D2Pjgz0Pe9dd6sQgILz8qgscwo3IB4SQx40chKwRnoryPXNe95XRduUM+KyVpBvJiBT+ObuPQPyo+mKUO1pdjPddu7m3n58arHrvRzRzhp5+rD59NjskcQPcJDMzyPjiAPBhMuNEPu6d0cgqhdWvdsCnOfh3Y6xdoi8c3OqLW0//yVT0LzQzHiQM0jmlWqDybSK3EIrLMR8vmtzfishjau78ZYH/Q==; s=purelymail2; d=purelymail.com; v=1; bh=NfwTbz5eKTKCh32K8bUV2znPNyWMbPjntjGfgLK9VUg=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 19882:3702:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1072404446;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 18 May 2026 15:35:38 +0000 (UTC)
Received: from xav13.bestouff.prv (unknown [10.2.161.35])
	by awak.mobi (Postfix) with ESMTPSA id 90D70362E2A;
	Mon, 18 May 2026 17:35:37 +0200 (CEST)
From: Xavier Bestel <xav@bes.tel>
To: Hans de Goede <hansg@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Xavier Bestel <xav@bes.tel>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+ gaming keyboards
Date: Mon, 18 May 2026 17:35:14 +0200
Message-ID: <20260518153519.605627-1-xav@bes.tel>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Add support for the Logitech G710 and G710+ (USB ID 046d:c24d) gaming
keyboards to the hid-lg-g15 driver.

These keyboards have 6 G-keys (G1-G6), M-keys (M1-M3, MR), a game mode
toggle, and two independent backlights: one for the main keyboard and one
for the WASD keys, each with a physical button to cycle brightness through
5 levels (0-4).

Key implementation details:

 - G-keys and M-keys are reported via HID input report 0x03 (4 bytes)
   using KEY_MACRO1-6, KEY_MACRO_PRESET1-3 and KEY_MACRO_RECORD_START.

 - The WASD backlight LED is registered as
   "g15::kbd_zoned_backlight-wasd" rather than with a
   "::kbd_backlight" suffix, because UPower currently only supports a
   single kbd_backlight LED per device. This follows the nomenclature
   from Documentation/leds/leds-class.rst

 - The G710+ firmware GET_REPORT for the backlight feature (0x08)
   always returns the power-on default values, ignoring any changes
   made via SET_REPORT. To work around this, the backlight brightness
   is tracked in the driver cache and brightness_get returns the
   cached value. M-key and game mode LEDs read back correctly.

 - The physical brightness cycle buttons are handled following the
   same pattern as the G15/G15v2: no key events are sent, instead the
   driver cycles the cached brightness and calls
   led_classdev_notify_brightness_hw_changed() from a work function,
   which allows GNOME to show the brightness OSD.

 - The game mode toggle is handled entirely by the firmware (it
   disables the Super key and lights an indicator LED). The driver
   exposes a read-only LED "g15::gamemode" with the
   LED_BRIGHT_HW_CHANGED flag, and notifies userspace of state
   changes via led_classdev_notify_brightness_hw_changed() by reading
   back the actual firmware state on each toggle.

 - Both brightness LEDs are registered with the LED_BRIGHT_HW_CHANGED
   flag to enable the brightness_hw_changed sysfs attribute.

 - HID_QUIRK_NOGET is set because the keyboard has buggy GET_REPORT
   handling that causes timeouts on some feature reports.

 - The G-keys feature report (0x09) uses 2 bytes per key rather than
   1 as on the G510, so the report size calculation is adjusted
   accordingly.

 - Also fix a pre-existing comment typo: "f000.0000" -> "ff00.0000"
   for the application report ID.

 - The loop bounds in lg_g15_led_set() and lg_g510_led_set() are
   tightened from "< LG_G15_LED_MAX" to "<=3D LG_G15_MACRO_RECORD" to
   avoid iterating over the new LG_G15_GAMEMODE enum value which does
   not apply to those keyboards.

Signed-off-by: Xavier Bestel <xav@bes.tel>
---
 drivers/hid/hid-ids.h    |   1 +
 drivers/hid/hid-lg-g15.c | 383 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 377 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index afcee13bad61..7c0f930bd014 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -904,6 +904,7 @@
 #define USB_DEVICE_ID_LOGITECH_G15_V2_LCD=090xc227
 #define USB_DEVICE_ID_LOGITECH_G510=09=090xc22d
 #define USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO=090xc22e
+#define USB_DEVICE_ID_LOGITECH_G710=09=090xc24d
 #define USB_DEVICE_ID_LOGITECH_G29_WHEEL=090xc24f
 #define USB_DEVICE_ID_LOGITECH_G920_WHEEL=090xc262
 #define USB_DEVICE_ID_LOGITECH_G923_XBOX_WHEEL=090xc26e
diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 1a88bc44ada4..95e89e9aeca6 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -29,6 +29,11 @@
 #define LG_G510_INPUT_MACRO_KEYS=090x03
 #define LG_G510_INPUT_KBD_BACKLIGHT=090x04
=20
+#define LG_G710_FEATURE_GAMEMODE        0x05
+#define LG_G710_FEATURE_M_KEYS_LEDS     0x06
+#define LG_G710_FEATURE_BACKLIGHT       0x08
+#define LG_G710_FEATURE_EXTRA_KEYS      0x09
+
 #define LG_G13_INPUT_REPORT=09=090x01
 #define LG_G13_FEATURE_M_KEYS_LEDS=090x05
 #define LG_G13_FEATURE_BACKLIGHT_RGB=090x07
@@ -48,6 +53,7 @@ enum lg_g15_model {
 =09LG_G15_V2,
 =09LG_G510,
 =09LG_G510_USB_AUDIO,
+=09LG_G710,
 =09LG_Z10,
 };
=20
@@ -59,6 +65,7 @@ enum lg_g15_led_type {
 =09LG_G15_MACRO_PRESET2,
 =09LG_G15_MACRO_PRESET3,
 =09LG_G15_MACRO_RECORD,
+=09LG_G15_GAMEMODE,
 =09LG_G15_LED_MAX
 };
=20
@@ -92,6 +99,7 @@ struct lg_g15_data {
 =09struct lg_g15_led leds[LG_G15_LED_MAX];
 =09bool game_mode_enabled;
 =09bool backlight_disabled;=09/* true =3D=3D HW backlight toggled *OFF* */
+=09unsigned long brightness_changed;=09/* bitmask of LEDs hw-cycled */
 };
=20
 /********* G13 LED functions ***********/
@@ -334,7 +342,7 @@ static int lg_g15_led_set(struct led_classdev *led_cdev=
,
 =09=09g15->transfer_buf[1] =3D g15_led->led + 1;
 =09=09g15->transfer_buf[2] =3D brightness << (g15_led->led * 4);
 =09} else {
-=09=09for (i =3D LG_G15_MACRO_PRESET1; i < LG_G15_LED_MAX; i++) {
+=09=09for (i =3D LG_G15_MACRO_PRESET1; i <=3D LG_G15_MACRO_RECORD; i++) {
 =09=09=09if (i =3D=3D g15_led->led)
 =09=09=09=09val =3D brightness;
 =09=09=09else
@@ -567,7 +575,7 @@ static int lg_g510_mkey_led_set(struct led_classdev *le=
d_cdev,
=20
 =09mutex_lock(&g15->mutex);
=20
-=09for (i =3D LG_G15_MACRO_PRESET1; i < LG_G15_LED_MAX; i++) {
+=09for (i =3D LG_G15_MACRO_PRESET1; i <=3D LG_G15_MACRO_RECORD; i++) {
 =09=09if (i =3D=3D g15_led->led)
 =09=09=09val =3D brightness;
 =09=09else
@@ -597,6 +605,234 @@ static int lg_g510_mkey_led_set(struct led_classdev *=
led_cdev,
 =09return ret;
 }
=20
+/******** G710 LED functions ********/
+
+static int lg_g710_update_game_led_brightness(struct lg_g15_data *g15)
+{
+=09int ret;
+
+=09ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_GAMEMODE,
+=09=09=09=09 g15->transfer_buf, 8,
+=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+=09if (ret !=3D 8) {
+=09=09hid_err(g15->hdev, "Error getting gamemode LED brightness: %d\n", re=
t);
+=09=09return (ret < 0) ? ret : -EIO;
+=09}
+
+=09g15->leds[LG_G15_GAMEMODE].brightness =3D
+=09=09!!g15->transfer_buf[1];
+
+=09return 0;
+}
+
+static int lg_g710_update_mkey_led_brightness(struct lg_g15_data *g15)
+{
+=09int ret;
+
+=09ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_M_KEYS_LEDS,
+=09=09=09=09 g15->transfer_buf, 2,
+=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+=09if (ret !=3D 2) {
+=09=09hid_err(g15->hdev, "Error getting macro LED brightness: %d\n", ret);
+=09=09return (ret < 0) ? ret : -EIO;
+=09}
+
+=09g15->leds[LG_G15_MACRO_PRESET1].brightness =3D
+=09=09!!(g15->transfer_buf[1] & 0x10);
+=09g15->leds[LG_G15_MACRO_PRESET2].brightness =3D
+=09=09!!(g15->transfer_buf[1] & 0x20);
+=09g15->leds[LG_G15_MACRO_PRESET3].brightness =3D
+=09=09!!(g15->transfer_buf[1] & 0x40);
+=09g15->leds[LG_G15_MACRO_RECORD].brightness =3D
+=09=09!!(g15->transfer_buf[1] & 0x80);
+
+=09return 0;
+}
+
+static int lg_g710_update_kbd_led_brightness(struct lg_g15_data *g15)
+{
+=09int ret;
+
+=09ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_BACKLIGHT,
+=09=09=09=09 g15->transfer_buf, 4,
+=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+=09if (ret !=3D 4) {
+=09=09hid_err(g15->hdev, "Error getting LED brightness: %d\n", ret);
+=09=09return (ret < 0) ? ret : -EIO;
+=09}
+
+=09g15->leds[LG_G15_KBD_BRIGHTNESS].brightness =3D 4 - min_t(u8, g15->tran=
sfer_buf[2], 4);
+=09g15->leds[LG_G15_LCD_BRIGHTNESS].brightness =3D 4 - min_t(u8, g15->tran=
sfer_buf[1], 4);
+
+=09return 0;
+}
+
+static enum led_brightness lg_g710_led_get(struct led_classdev *led_cdev)
+{
+=09struct lg_g15_led *g15_led =3D
+=09=09container_of(led_cdev, struct lg_g15_led, cdev);
+=09struct lg_g15_data *g15 =3D dev_get_drvdata(led_cdev->dev->parent);
+=09enum led_brightness brightness;
+
+=09mutex_lock(&g15->mutex);
+=09/*
+=09 * The G710+ firmware's GET_REPORT for the backlight always returns
+=09 * the power-on default values, ignoring any changes made via
+=09 * SET_REPORT. Use the cached brightness which is kept in sync by
+=09 * the _set callbacks. M-key and gamemode LEDs read back correctly.
+=09 */
+=09if (g15_led->led >=3D LG_G15_BRIGHTNESS_MAX && g15_led->led < LG_G15_GA=
MEMODE)
+=09=09lg_g710_update_mkey_led_brightness(g15);
+=09else if (g15_led->led >=3D LG_G15_GAMEMODE)
+=09=09lg_g710_update_game_led_brightness(g15);
+=09brightness =3D g15->leds[g15_led->led].brightness;
+=09mutex_unlock(&g15->mutex);
+
+=09return brightness;
+}
+
+static int lg_g710_mkey_led_set(struct led_classdev *led_cdev,
+=09=09=09  enum led_brightness brightness)
+{
+=09struct lg_g15_led *g15_led =3D
+=09=09container_of(led_cdev, struct lg_g15_led, cdev);
+=09struct lg_g15_data *g15 =3D dev_get_drvdata(led_cdev->dev->parent);
+=09u8 val, mask =3D 0;
+=09int i, ret;
+
+=09/* Ignore LED off on unregister / keyboard unplug */
+=09if (led_cdev->flags & LED_UNREGISTERING)
+=09=09return 0;
+
+=09mutex_lock(&g15->mutex);
+
+=09g15->transfer_buf[0] =3D LG_G710_FEATURE_M_KEYS_LEDS;
+
+=09for (i =3D LG_G15_MACRO_PRESET1; i <=3D LG_G15_MACRO_RECORD; i++) {
+=09=09if (i =3D=3D g15_led->led)
+=09=09=09val =3D brightness;
+=09=09else
+=09=09=09val =3D g15->leds[i].brightness;
+
+=09=09if (val)
+=09=09=09mask |=3D 1 << (i - LG_G15_MACRO_PRESET1 + 4);
+=09}
+
+=09g15->transfer_buf[1] =3D mask;
+
+=09ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_M_KEYS_LEDS,
+=09=09=09=09 g15->transfer_buf, 2,
+=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+=09if (ret =3D=3D 2) {
+=09=09/* Success */
+=09=09g15_led->brightness =3D brightness;
+=09=09ret =3D 0;
+=09} else {
+=09=09if (ret !=3D -EPIPE)
+=09=09=09hid_err(g15->hdev, "Error setting LED brightness: %d\n", ret);
+=09=09/* -EPIPE is transient (USB stall), cache is unchanged, retry next t=
ime */
+=09=09ret =3D 0;
+=09}
+
+=09mutex_unlock(&g15->mutex);
+
+=09return ret;
+}
+
+static int lg_g710_kbd_led_set(struct led_classdev *led_cdev,
+=09=09=09  enum led_brightness brightness)
+{
+=09struct lg_g15_led *g15_led =3D
+=09=09container_of(led_cdev, struct lg_g15_led, cdev);
+=09struct lg_g15_data *g15 =3D dev_get_drvdata(led_cdev->dev->parent);
+=09int ret;
+
+=09/* Ignore LED off on unregister / keyboard unplug */
+=09if (led_cdev->flags & LED_UNREGISTERING)
+=09=09return 0;
+
+=09mutex_lock(&g15->mutex);
+
+=09g15->transfer_buf[0] =3D LG_G710_FEATURE_BACKLIGHT;
+=09g15->transfer_buf[3] =3D 0;
+
+=09if (g15_led->led =3D=3D LG_G15_KBD_BRIGHTNESS) {
+=09=09g15->transfer_buf[1] =3D 4 - g15->leds[LG_G15_LCD_BRIGHTNESS].bright=
ness;
+=09=09g15->transfer_buf[2] =3D 4 - brightness;
+=09} else {
+=09=09g15->transfer_buf[1] =3D 4 - brightness;
+=09=09g15->transfer_buf[2] =3D 4 - g15->leds[LG_G15_KBD_BRIGHTNESS].bright=
ness;
+=09}
+
+=09ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_BACKLIGHT,
+=09=09=09=09 g15->transfer_buf, 4,
+=09=09=09=09 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+=09if (ret =3D=3D 4) {
+=09=09/* Success */
+=09=09g15_led->brightness =3D brightness;
+=09=09ret =3D 0;
+=09} else {
+=09=09if (ret !=3D -EPIPE)
+=09=09=09hid_err(g15->hdev, "Error setting LED brightness: %d\n", ret);
+=09=09/* -EPIPE is transient (USB stall), cache is unchanged, retry next t=
ime */
+=09=09ret =3D 0;
+=09}
+
+=09mutex_unlock(&g15->mutex);
+
+=09return ret;
+}
+
+/*
+ * The G710+ has separate physical keys for cycling the main keyboard back=
light
+ * and the WASD backlight. The firmware handles the actual brightness chan=
ge
+ * internally, but GET_REPORT always returns the power-on defaults regardl=
ess
+ * of any changes. So we must track the brightness in our cache and cycle =
it
+ * ourselves when a hardware brightness key press is detected.
+ *
+ * The firmware cycles brightness DOWN: 4 =E2=86=92 3 =E2=86=92 2 =E2=86=
=92 1 =E2=86=92 0 =E2=86=92 4 (in wire
+ * format where 0 =3D brightest, 4 =3D off). In user-facing terms (inverte=
d):
+ * 4 =E2=86=92 3 =E2=86=92 2 =E2=86=92 1 =E2=86=92 0 =E2=86=92 4.
+ *
+ * The game mode toggle is also handled here: the firmware toggles game mo=
de
+ * internally and updates the LED, so we read back the actual state via
+ * GET_REPORT and notify userspace of the change.
+ */
+static void lg_g710_leds_changed_work(struct work_struct *work)
+{
+=09struct lg_g15_data *g15 =3D container_of(work, struct lg_g15_data, work=
);
+=09bool changed[LG_G15_LED_MAX] =3D {};
+=09int i;
+
+=09mutex_lock(&g15->mutex);
+=09for (i =3D 0; i < LG_G15_BRIGHTNESS_MAX; i++) {
+=09=09if (!test_and_clear_bit(i, &g15->brightness_changed))
+=09=09=09continue;
+
+=09=09changed[i] =3D true;
+
+=09=09if (g15->leds[i].brightness > 0)
+=09=09=09g15->leds[i].brightness--;
+=09=09else
+=09=09=09g15->leds[i].brightness =3D
+=09=09=09=09g15->leds[i].cdev.max_brightness;
+=09}
+
+=09if (test_and_clear_bit(LG_G15_GAMEMODE, &g15->brightness_changed)) {
+=09=09changed[LG_G15_GAMEMODE] =3D true;
+=09=09lg_g710_update_game_led_brightness(g15);
+=09}
+
+=09for (i =3D 0; i < LG_G15_LED_MAX; i++) {
+=09=09if (!changed[i])
+=09=09=09continue;
+
+=09=09led_classdev_notify_brightness_hw_changed(&g15->leds[i].cdev,
+=09=09=09=09=09=09  g15->leds[i].brightness);
+=09}
+=09mutex_unlock(&g15->mutex);
+}
+
 /******** Generic LED functions ********/
 static int lg_g15_get_initial_led_brightness(struct lg_g15_data *g15)
 {
@@ -619,6 +855,16 @@ static int lg_g15_get_initial_led_brightness(struct lg=
_g15_data *g15)
 =09=09=09return ret;
=20
 =09=09return lg_g510_update_mkey_led_brightness(g15);
+=09case LG_G710:
+=09=09ret =3D lg_g710_update_game_led_brightness(g15);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D lg_g710_update_mkey_led_brightness(g15);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09return lg_g710_update_kbd_led_brightness(g15);
 =09case LG_Z10:
 =09=09/*
 =09=09 * Getting the LCD backlight brightness is not supported.
@@ -890,6 +1136,71 @@ static int lg_g510_leds_event(struct lg_g15_data *g15=
, u8 *data)
 =09return 0;
 }
=20
+static int lg_g710_event(struct lg_g15_data *g15, u8 *data, int size)
+{
+=09/*
+=09 * Bits 0-5:  G1-G6 keys
+=09 * Bits 6-8:  M1-M3 keys
+=09 * Bit 9:     MR key
+=09 * Bit 10:    WASD backlight cycle (handled as hw brightness change)
+=09 * Bit 11:    Kbd backlight cycle (handled as hw brightness change)
+=09 * Bit 12:    Game mode toggle (LED state change, handled by firmware)
+=09 */
+=09static const u16 keymap[] =3D {
+=09=09KEY_MACRO1,
+=09=09KEY_MACRO2,
+=09=09KEY_MACRO3,
+=09=09KEY_MACRO4,
+=09=09KEY_MACRO5,
+=09=09KEY_MACRO6,
+=09=09KEY_MACRO_PRESET1,
+=09=09KEY_MACRO_PRESET2,
+=09=09KEY_MACRO_PRESET3,
+=09=09KEY_MACRO_RECORD_START,
+=09=090,=09/* WASD illumination cycle - not a key event */
+=09=090,=09/* Kbd illumination cycle - not a key event */
+=09=090,=09/* Game mode toggle */
+=09};
+=09u16 pressed_keys;
+=09int i;
+
+=09if (size !=3D 4 || data[0] !=3D 3)
+=09=09return 1;
+
+=09pressed_keys =3D (data[1] & 0x3f) | ((data[2] & 0xf0) << 2) |
+=09=09       ((data[3] & 0x7) << 10);
+
+=09for (i =3D 0; i < ARRAY_SIZE(keymap); i++) {
+=09=09if (keymap[i])
+=09=09=09input_report_key(g15->input, keymap[i],
+=09=09=09=09=09pressed_keys & BIT(i));
+=09}
+=09input_sync(g15->input);
+
+=09/*
+=09 * Detect brightness key presses and schedule the work function
+=09 * to cycle cached brightness and notify userspace.
+=09 * Bit 10 =3D WASD backlight (maps to LG_G15_LCD_BRIGHTNESS slot).
+=09 * Bit 11 =3D Kbd backlight (maps to LG_G15_KBD_BRIGHTNESS slot).
+=09 */
+=09if (pressed_keys & BIT(10)) {
+=09=09set_bit(LG_G15_LCD_BRIGHTNESS, &g15->brightness_changed);
+=09=09schedule_work(&g15->work);
+=09}
+=09if (pressed_keys & BIT(11)) {
+=09=09set_bit(LG_G15_KBD_BRIGHTNESS, &g15->brightness_changed);
+=09=09schedule_work(&g15->work);
+=09}
+
+=09/* Game mode toggle =E2=80=94 bit 12 is a state bit, trigger on any cha=
nge */
+=09if (pressed_keys & BIT(12)) {
+=09=09set_bit(LG_G15_GAMEMODE, &g15->brightness_changed);
+=09=09schedule_work(&g15->work);
+=09}
+
+=09return 0;
+}
+
 static int lg_g15_raw_event(struct hid_device *hdev, struct hid_report *re=
port,
 =09=09=09    u8 *data, int size)
 {
@@ -924,6 +1235,10 @@ static int lg_g15_raw_event(struct hid_device *hdev, =
struct hid_report *report,
 =09=09if (data[0] =3D=3D LG_G510_INPUT_KBD_BACKLIGHT && size =3D=3D 2)
 =09=09=09return lg_g510_leds_event(g15, data);
 =09=09break;
+=09case LG_G710:
+=09=09if (data[0] =3D=3D 0x03 && size =3D=3D 4)
+=09=09=09return lg_g710_event(g15, data, size);
+=09=09break;
 =09}
=20
 =09return 0;
@@ -1055,6 +1370,37 @@ static int lg_g15_register_led(struct lg_g15_data *g=
15, int i, const char *name)
 =09=09=09ret =3D devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i]=
.cdev);
 =09=09}
 =09=09break;
+=09case LG_G710:
+=09=09switch (i) {
+=09=09case LG_G15_LCD_BRIGHTNESS:
+=09=09=09/*
+=09=09=09 * The G710+ does not have a separate LCD brightness,
+=09=09=09 * but it does have a separate brightness for WASD keys.
+=09=09=09 * Do not use the ::kbd_backlight suffix here, UPower
+=09=09=09 * only supports one kbd_backlight LED per device.
+=09=09=09 */
+=09=09=09g15->leds[i].cdev.name =3D "g15::kbd_zoned_backlight-wasd";
+=09=09=09fallthrough;
+=09=09case LG_G15_KBD_BRIGHTNESS:
+=09=09=09g15->leds[i].cdev.brightness_set_blocking =3D
+=09=09=09=09lg_g710_kbd_led_set;
+=09=09=09g15->leds[i].cdev.brightness_get =3D
+=09=09=09=09lg_g710_led_get;
+=09=09=09g15->leds[i].cdev.max_brightness =3D 4;
+=09=09=09g15->leds[i].cdev.flags =3D LED_BRIGHT_HW_CHANGED;
+=09=09=09break;
+=09=09default:
+=09=09=09if (i !=3D LG_G15_GAMEMODE)
+=09=09=09=09g15->leds[i].cdev.brightness_set_blocking =3D
+=09=09=09=09=09lg_g710_mkey_led_set;
+=09=09=09g15->leds[i].cdev.brightness_get =3D
+=09=09=09=09lg_g710_led_get;
+=09=09=09g15->leds[i].cdev.max_brightness =3D 1;
+=09=09=09if (i =3D=3D LG_G15_GAMEMODE)
+=09=09=09=09g15->leds[i].cdev.flags =3D LED_BRIGHT_HW_CHANGED;
+=09=09}
+=09=09ret =3D devm_led_classdev_register(&g15->hdev->dev, &g15->leds[i].cd=
ev);
+=09=09break;
 =09}
=20
 =09return ret;
@@ -1079,10 +1425,14 @@ static void lg_g15_init_input_dev_core(struct hid_d=
evice *hdev, struct input_dev
 static void lg_g15_init_input_dev(struct hid_device *hdev, struct input_de=
v *input,
 =09=09=09=09  const char *name)
 {
+=09struct lg_g15_data *g15 =3D hid_get_drvdata(hdev);
 =09int i;
=20
 =09lg_g15_init_input_dev_core(hdev, input, name);
=20
+=09if (g15->model =3D=3D LG_G710)
+=09=09return;
+
 =09/* Keys below the LCD, intended for controlling a menu on the LCD */
 =09for (i =3D 0; i < 5; i++)
 =09=09input_set_capability(input, EV_KEY, KEY_KBD_LCD_MENU1 + i);
@@ -1137,8 +1487,8 @@ static int lg_g15_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
 =09=09return ret;
=20
 =09/*
-=09 * Some models have multiple interfaces, we want the interface with
-=09 * the f000.0000 application input report.
+=09 * Some models have multiple interfaces, we want the interface
+=09 * with the ff00.0000 application input report.
 =09 */
 =09rep_enum =3D &hdev->report_enum[HID_INPUT_REPORT];
 =09list_for_each_entry(rep, &rep_enum->report_list, list) {
@@ -1212,6 +1562,13 @@ static int lg_g15_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
 =09case LG_Z10:
 =09=09connect_mask =3D HID_CONNECT_HIDRAW;
 =09=09break;
+=09case LG_G710:
+=09=09INIT_WORK(&g15->work, lg_g710_leds_changed_work);
+=09=09hdev->quirks |=3D HID_QUIRK_NOGET;
+=09=09connect_mask =3D HID_CONNECT_DEFAULT;
+=09=09gkeys_settings_feature_report =3D LG_G710_FEATURE_EXTRA_KEYS;
+=09=09gkeys =3D 6;
+=09=09break;
 =09}
=20
 =09ret =3D hid_hw_start(hdev, connect_mask);
@@ -1234,11 +1591,13 @@ static int lg_g15_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
 =09}
=20
 =09if (gkeys_settings_feature_report) {
+=09=09int report_size =3D (g15->model =3D=3D LG_G710) ? gkeys * 2 : gkeys;
+
 =09=09g15->transfer_buf[0] =3D gkeys_settings_feature_report;
-=09=09memset(g15->transfer_buf + 1, 0, gkeys);
+=09=09memset(g15->transfer_buf + 1, 0, report_size);
 =09=09ret =3D hid_hw_raw_request(g15->hdev,
 =09=09=09=09gkeys_settings_feature_report,
-=09=09=09=09g15->transfer_buf, gkeys + 1,
+=09=09=09=09g15->transfer_buf, report_size + 1,
 =09=09=09=09HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 =09}
=20
@@ -1327,12 +1686,18 @@ static int lg_g15_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
 =09=09goto error_hw_stop;
=20
 =09/* Register LED devices */
-=09for (i =3D 0; i < LG_G15_LED_MAX; i++) {
+=09for (i =3D 0; i <=3D LG_G15_MACRO_RECORD; i++) {
 =09=09ret =3D lg_g15_register_led(g15, i, led_names[i]);
 =09=09if (ret)
 =09=09=09goto error_hw_stop;
 =09}
=20
+=09if (g15->model =3D=3D LG_G710) {
+=09=09ret =3D lg_g15_register_led(g15, LG_G15_GAMEMODE, "g15::gamemode");
+=09=09if (ret)
+=09=09=09goto error_hw_stop;
+=09}
+
 =09return 0;
=20
 error_hw_stop:
@@ -1366,6 +1731,10 @@ static const struct hid_device_id lg_g15_devices[] =
=3D {
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 =09=09=09 USB_DEVICE_ID_LOGITECH_G510_USB_AUDIO),
 =09=09.driver_data =3D LG_G510_USB_AUDIO },
+=09/* G710 or G710+ */
+=09{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+=09=09=09 USB_DEVICE_ID_LOGITECH_G710),
+=09=09.driver_data =3D LG_G710 },
 =09/* Z-10 speakers */
 =09{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 =09=09=09 USB_DEVICE_ID_LOGITECH_Z_10_SPK),
--=20
2.53.0

