From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Mon, 18 Nov 2013 01:26:41 +0100
Message-ID: <2105006.tGLFZqe9L3@sven-desktop>
References: <1384021557-24106-1-git-send-email-sven@narfation.org> <5434362.OvDlhOjSJd@sven-edge> <8249378.0C4gn7PafG@sven-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1401419.GtDRF6rULV"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42118 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab3KRA0p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 19:26:45 -0500
In-Reply-To: <8249378.0C4gn7PafG@sven-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


--nextPart1401419.GtDRF6rULV
Content-Type: multipart/mixed; boundary="nextPart4685080.Pr9MiVPmFx"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart4685080.Pr9MiVPmFx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 18 November 2013 00:53:25 Sven Eckelmann wrote:
[..]
> Ok, just tried it and it seems this byte is really for the LEDs. But
> unfortunately, it is enabling/disabling the LEDs completely and not the
> configuration.
> 
> And sending less bytes just lets everything fail.

Forgot to add my proof of concept patch for the LED control. I've attached it 
so you can also try it out.

@Simon: This may also be interesting for you because you've asked for it in 
8c40cb08b7c44f373c2c533614d70b6a.squirrel@mungewell.org

Kind regards,
	Sven

--nextPart4685080.Pr9MiVPmFx
Content-Disposition: attachment; filename="0001-HID-sony-Make-sixaxis-usb-LEDs-configurable.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-HID-sony-Make-sixaxis-usb-LEDs-configurable.patch"

>From 94d33d53718268d3f41f9ec38105e221e0ba3585 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Nov 2013 01:22:39 +0100
Subject: [RFC] HID: sony: Make sixaxis usb LEDs configurable

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 144 +++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 70 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 098af2f8..d1d99bb 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -224,18 +224,13 @@ static const unsigned int buzz_keymap[] = {
 
 struct sony_sc {
 	unsigned long quirks;
+	struct work_struct state_worker;
+	struct hid_device *hdev;
 
 #ifdef CONFIG_SONY_FF
-	struct work_struct rumble_worker;
-	struct hid_device *hdev;
 	__u8 left;
 	__u8 right;
 #endif
-
-	void *extra;
-};
-
-struct buzz_extra {
 	int led_state;
 	struct led_classdev *leds[4];
 };
@@ -466,58 +461,66 @@ static void buzz_set_leds(struct hid_device *hdev, int leds)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
-static void buzz_led_set_brightness(struct led_classdev *led,
+static void sony_set_leds(struct hid_device *hdev, int leds)
+{
+	struct sony_sc *drv_data = hid_get_drvdata(hdev);
+
+	if (drv_data->quirks & BUZZ_CONTROLLER) {
+		buzz_set_leds(hdev, leds);
+	} else if (drv_data->quirks & SIXAXIS_CONTROLLER_USB) {
+		drv_data->led_state = leds;
+		schedule_work(&drv_data->state_worker);
+	}
+}
+
+static void sony_led_set_brightness(struct led_classdev *led,
 				    enum led_brightness value)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 
 	int n;
 
 	drv_data = hid_get_drvdata(hdev);
-	if (!drv_data || !drv_data->extra) {
+	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
 		return;
 	}
-	buzz = drv_data->extra;
 
 	for (n = 0; n < 4; n++) {
-		if (led == buzz->leds[n]) {
-			int on = !! (buzz->led_state & (1 << n));
+		if (led == drv_data->leds[n]) {
+			int on = !! (drv_data->led_state & (1 << n));
 			if (value == LED_OFF && on) {
-				buzz->led_state &= ~(1 << n);
-				buzz_set_leds(hdev, buzz->led_state);
+				drv_data->led_state &= ~(1 << n);
+				sony_set_leds(hdev, drv_data->led_state);
 			} else if (value != LED_OFF && !on) {
-				buzz->led_state |= (1 << n);
-				buzz_set_leds(hdev, buzz->led_state);
+				drv_data->led_state |= (1 << n);
+				sony_set_leds(hdev, drv_data->led_state);
 			}
 			break;
 		}
 	}
 }
 
-static enum led_brightness buzz_led_get_brightness(struct led_classdev *led)
+static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 
 	int n;
 	int on = 0;
 
 	drv_data = hid_get_drvdata(hdev);
-	if (!drv_data || !drv_data->extra) {
+	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
 		return LED_OFF;
 	}
-	buzz = drv_data->extra;
 
 	for (n = 0; n < 4; n++) {
-		if (led == buzz->leds[n]) {
-			on = !! (buzz->led_state & (1 << n));
+		if (led == drv_data->leds[n]) {
+			on = !! (drv_data->led_state & (1 << n));
 			break;
 		}
 	}
@@ -525,35 +528,36 @@ static enum led_brightness buzz_led_get_brightness(struct led_classdev *led)
 	return on ? LED_FULL : LED_OFF;
 }
 
-static int buzz_init(struct hid_device *hdev)
+static int sony_leds_init(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 	int n, ret = 0;
 	struct led_classdev *led;
 	size_t name_sz;
 	char *name;
+	size_t name_len;
+	const char *name_format;
 
 	drv_data = hid_get_drvdata(hdev);
-	BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
+	BUG_ON(!(drv_data->quirks & (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER)));
 
-	/* Validate expected report characteristics. */
-	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
-		return -ENODEV;
-
-	buzz = kzalloc(sizeof(*buzz), GFP_KERNEL);
-	if (!buzz) {
-		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
-		return -ENOMEM;
+	if (drv_data->quirks & BUZZ_CONTROLLER) {
+		name_len = strlen("::buzz#");
+		name_format = "%s::buzz%d";
+		/* Validate expected report characteristics. */
+		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
+			return -ENODEV;
+	} else {
+		name_len = strlen("::sony#");
+		name_format = "%s::sony%d";
 	}
-	drv_data->extra = buzz;
 
 	/* Clear LEDs as we have no way of reading their initial state. This is
 	 * only relevant if the driver is loaded after somebody actively set the
 	 * LEDs to on */
-	buzz_set_leds(hdev, 0x00);
+	sony_set_leds(hdev, 0x00);
 
-	name_sz = strlen(dev_name(&hdev->dev)) + strlen("::buzz#") + 1;
+	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
 
 	for (n = 0; n < 4; n++) {
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
@@ -563,12 +567,12 @@ static int buzz_init(struct hid_device *hdev)
 		}
 
 		name = (void *)(&led[1]);
-		snprintf(name, name_sz, "%s::buzz%d", dev_name(&hdev->dev), n + 1);
+		snprintf(name, name_sz, name_format, dev_name(&hdev->dev), n + 1);
 		led->name = name;
 		led->brightness = 0;
 		led->max_brightness = 1;
-		led->brightness_get = buzz_led_get_brightness;
-		led->brightness_set = buzz_led_set_brightness;
+		led->brightness_get = sony_led_get_brightness;
+		led->brightness_set = sony_led_set_brightness;
 
 		if (led_classdev_register(&hdev->dev, led)) {
 			hid_err(hdev, "Failed to register LED %d\n", n);
@@ -576,73 +580,71 @@ static int buzz_init(struct hid_device *hdev)
 			goto error_leds;
 		}
 
-		buzz->leds[n] = led;
+		drv_data->leds[n] = led;
 	}
 
 	return ret;
 
 error_leds:
 	for (n = 0; n < 4; n++) {
-		led = buzz->leds[n];
-		buzz->leds[n] = NULL;
+		led = drv_data->leds[n];
+		drv_data->leds[n] = NULL;
 		if (!led)
 			continue;
 		led_classdev_unregister(led);
 		kfree(led);
 	}
 
-	kfree(drv_data->extra);
-	drv_data->extra = NULL;
 	return ret;
 }
 
-static void buzz_remove(struct hid_device *hdev)
+static void sony_leds_remove(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 	struct led_classdev *led;
 	int n;
 
 	drv_data = hid_get_drvdata(hdev);
-	BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
+	BUG_ON(!(drv_data->quirks & (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER)));
 
-	buzz = drv_data->extra;
 
 	for (n = 0; n < 4; n++) {
-		led = buzz->leds[n];
-		buzz->leds[n] = NULL;
+		led = drv_data->leds[n];
+		drv_data->leds[n] = NULL;
 		if (!led)
 			continue;
 		led_classdev_unregister(led);
 		kfree(led);
 	}
-
-	kfree(drv_data->extra);
-	drv_data->extra = NULL;
 }
 
-#ifdef CONFIG_SONY_FF
-static void sony_rumble_worker(struct work_struct *work)
+static void sony_state_worker(struct work_struct *work)
 {
-	struct sony_sc *sc = container_of(work, struct sony_sc, rumble_worker);
+	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	unsigned char buf[] = {
 		0x01,
-		0x00, 0xff, 0x00, 0xff, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x03,
+		0x00, 0xff, 0x00, 0xf0, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0x00, 0x00, 0x00, 0x00, 0x00
 	};
+	size_t len = sizeof(buf);
 
+#ifdef CONFIG_SONY_FF
 	buf[3] = sc->right;
 	buf[5] = sc->left;
+#endif
 
-	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
+	buf[10] |= (sc->led_state & 0xf) << 1;
+
+	sc->hdev->hid_output_raw_report(sc->hdev, buf, len,
 					HID_OUTPUT_REPORT);
 }
 
+#ifdef CONFIG_SONY_FF
 static int sony_play_effect(struct input_dev *dev, void *data,
 			    struct ff_effect *effect)
 {
@@ -655,7 +657,7 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 	sc->left = effect->u.rumble.strong_magnitude / 256;
 	sc->right = effect->u.rumble.weak_magnitude ? 1 : 0;
 
-	schedule_work(&sc->rumble_worker);
+	schedule_work(&sc->state_worker);
 	return 0;
 }
 
@@ -664,10 +666,6 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct hid_input *hidinput = list_entry(hdev->inputs.next,
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
-	struct sony_sc *sc = hid_get_drvdata(hdev);
-
-	sc->hdev = hdev;
-	INIT_WORK(&sc->rumble_worker, sony_rumble_worker);
 
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
@@ -677,7 +675,7 @@ static void sony_destroy_ff(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	cancel_work_sync(&sc->rumble_worker);
+	cancel_work_sync(&sc->state_worker);
 }
 
 #else
@@ -706,6 +704,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
+	sc->hdev = hdev;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -729,17 +728,22 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
+		INIT_WORK(&sc->state_worker, sony_state_worker);
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-	else if (sc->quirks & BUZZ_CONTROLLER)
-		ret = buzz_init(hdev);
 	else
 		ret = 0;
 
 	if (ret < 0)
 		goto err_stop;
 
+	if (sc->quirks & (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_USB)) {
+		ret = sony_leds_init(hdev);
+		if (ret < 0)
+			goto err_stop;
+	}
+
 	ret = sony_init_ff(hdev);
 	if (ret < 0)
 		goto err_stop;
@@ -754,8 +758,8 @@ static void sony_remove(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	if (sc->quirks & BUZZ_CONTROLLER)
-		buzz_remove(hdev);
+	if (sc->quirks & (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER))
+		sony_leds_remove(hdev);
 
 	sony_destroy_ff(hdev);
 
-- 
1.8.4.3


--nextPart4685080.Pr9MiVPmFx--

--nextPart1401419.GtDRF6rULV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSiV7CAAoJEF2HCgfBJntGCFYP/3LigRAH67WDSDtHNEEU/TVP
cOPa2Z2pcW4BDYvbZ6uEtKqHwOGjmVi4iuxvLabffF7KJiHctiGDz1SSIELPMvpq
ya5yJP0Op7N+SkBN+3/KaDHZJ3W3OVYjT8QnacW+DGLSsM4kTMGhccIo1cXTjasL
Ij6DY5uxHB+Kht3O9FV0aQ1fU/vmCbrvYaJLhRNDexwOdzFvb9BJR56r8q9X3fqK
H/QdGIj+FjZkBDQ+24He/4K/zLvoHD6JWnIOWucR5CmqvVyXCjbF0oDyNycrpohv
j/XYGk4MDm3FnXlcLcaF/j4QwkS2tHXUMMwGrNxz4X2jROaw5qV5oJWSPK09ELm5
oJppBNtZv8Qx+yxMJrtFWB61FczUpbHh/oMwH1RB+UUOeV0uxPXnRIjEkMTqr9te
rGLGdRAeS/Y5xAL0VU7djYmxdSIY1E79X/SqneP9yDccYejHGVlgHsoNVe+yVR9Z
crL1BPLy5F3hPtfJFF3D+2bpus3zjXhIdqOjPyaKren9Y+SGz1wW8tGjxUjqq/U8
p5Jk3XSwhw269NSOoUlBL1i6THeyQoxk7JNyXT7RTQgM/DUahznK9Ps68qR04FYE
8pQphwi9T3HyzDO8nSnuL+j67tc7jne6Dy/soSuUUaYSaLZtdzLHP2NzqPt/v/xN
7gigoNspf0n0+S2cdO+f
=Qi4O
-----END PGP SIGNATURE-----

--nextPart1401419.GtDRF6rULV--

