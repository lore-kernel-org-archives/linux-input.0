From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Sun, 17 Nov 2013 19:08:25 +0100
Message-ID: <2014555.nmU692BQMt@sven-desktop>
References: <1384021557-24106-1-git-send-email-sven@narfation.org> <1567991.TNa7UhjX8Q@sven-desktop> <CANq1E4RN2vpFvLcT6jdPw59wyJN-cBfFRQhMFzak7kJpPL86Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10038956.552frb96Sx"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42089 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab3KQSI2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 13:08:28 -0500
In-Reply-To: <CANq1E4RN2vpFvLcT6jdPw59wyJN-cBfFRQhMFzak7kJpPL86Nw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


--nextPart10038956.552frb96Sx
Content-Type: multipart/mixed; boundary="nextPart5191000.979WfPsHWx"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart5191000.979WfPsHWx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 17 November 2013 17:30:51 David Herrmann wrote:
> Yeah, the input-ff callbacks cannot be handled inline. You also get
> deadlocks with the input-spinlock. In the wiimote driver I simply
> dispatch the ff-events to a workqueue. You can have a look at
> drivers/hid/hid-wiimote-modules.c. You can get some ordering-problems
> then, but these can usually be ignored as they just collapse events.
> 
> The related commit was:
> 
> commit f50f9aabf32db7414551ffdfdccc71be5f3d6e7d
> Author: David Herrmann <dh.herrmann@gmail.com>
> Date:   Wed Oct 2 13:47:28 2013 +0200
> 
>     HID: wiimote: fix FF deadlock

Yes, I've played around with the linux kernel usb message api and came to the 
same conclusion (for now). I've only tested it with a small proof of concept 
patch and it didn't hang anymore with testhaptic.

Maybe Simon Wood can test his devices because I am unsure whether PS3 
dualshock clones will work with the interrupt or control urbs. For example the 
script from Simon didn't work at all for me.

Kind regards,
	Sven
--nextPart5191000.979WfPsHWx
Content-Disposition: attachment; filename="proof_of_concept_wq_rumble.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="proof_of_concept_wq_rumble.patch"

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index da551d1..d509447 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -224,6 +224,10 @@ static const unsigned int buzz_keymap[] = {
 
 struct sony_sc {
 	unsigned long quirks;
+	struct work_struct rumble_worker;
+	struct hid_device *hdev;
+	__u8 left;
+	__u8 right;
 
 	void *extra;
 };
@@ -614,35 +618,53 @@ static void buzz_remove(struct hid_device *hdev)
 	drv_data->extra = NULL;
 }
 
-#ifdef CONFIG_SONY_FF
-static int sony_play_effect(struct input_dev *dev, void *data,
-			    struct ff_effect *effect)
+static void sony_rumble_worker(struct work_struct *work)
 {
+	struct sony_sc *sc = container_of(work, struct sony_sc, rumble_worker);
 	unsigned char buf[] = {
 		0x01,
 		0x00, 0xff, 0x00, 0xff, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x03,
+		0x00, 0x00, 0x00, 0x00, 0x02,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
-		0x00, 0x00, 0x00, 0x00, 0x00
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00
 	};
-	__u8 left;
-	__u8 right;
+	struct usb_interface *intf = to_usb_interface(sc->hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(intf);
+
+	buf[3] = sc->right;
+	buf[5] = sc->left;
+
+	if (sc->right || sc->left)
+		usb_interrupt_msg(usbdev, usb_sndctrlpipe(usbdev, 2), buf,
+				  sizeof(buf), NULL, USB_CTRL_SET_TIMEOUT);
+
+	buf[10] = 0x1e;
+	usb_interrupt_msg(usbdev, usb_sndctrlpipe(usbdev, 2), buf, sizeof(buf),
+			  NULL, USB_CTRL_SET_TIMEOUT);
+}
+
+#ifdef CONFIG_SONY_FF
+static int sony_play_effect(struct input_dev *dev, void *data,
+			    struct ff_effect *effect)
+{
 	struct hid_device *hid = input_get_drvdata(dev);
+	struct sony_sc *sc = hid_get_drvdata(hid);
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
 
-	left = effect->u.rumble.strong_magnitude / 256;
-	right = effect->u.rumble.weak_magnitude ? 1 : 0;
+	sc->left = effect->u.rumble.strong_magnitude / 256;
+	sc->right = effect->u.rumble.weak_magnitude ? 1 : 0;
 
-	buf[3] = right;
-	buf[5] = left;
 
-	return hid->hid_output_raw_report(hid, buf, sizeof(buf),
-					  HID_OUTPUT_REPORT);
+	schedule_work(&sc->rumble_worker);
+	return 0;
 }
 
 static int sony_init_ff(struct hid_device *hdev)
@@ -650,6 +672,9 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct hid_input *hidinput = list_entry(hdev->inputs.next,
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+
+	INIT_WORK(&sc->rumble_worker, sony_rumble_worker);
 
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
@@ -711,6 +736,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (ret < 0)
 		goto err_stop;
 
+	sc->hdev = hdev;
 	ret = sony_init_ff(hdev);
 	if (ret < 0)
 		goto err_stop;
@@ -728,6 +754,8 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->quirks & BUZZ_CONTROLLER)
 		buzz_remove(hdev);
 
+	cancel_work_sync(&sc->rumble_worker);
+
 	hid_hw_stop(hdev);
 }
 

--nextPart5191000.979WfPsHWx--

--nextPart10038956.552frb96Sx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSiQYZAAoJEF2HCgfBJntGkiwP/AxOdo82aBANAJig2Roybioo
g8HgGYhdJXQytBwqMEoBH6O7BV9cSKy1EZdTOSUeQpPWXlVs81czx7H/fFboU5tZ
fF6A7bUtELwoWD+lQHzjyV8Bb/EVk24dtRnlRJ6R9BDPNPGopTt/yJXt6Opm/AQ/
allWTdZyfy9s8qa6MgZ9+JtHTBCgqqqakMgsxAbj2GTy1cx1GScfHO56hw0R1C7a
N4DCrcMtuV8hb/pXO7KBShM9JuGKaXkFhnm5uo+DUbUicV1kOCnz37ovLW5y3d+3
hsICgaBkEH7gXP6iaf+7zS2zeJZek46JOmo83YyyDE8t+eMIDWgaq/LRJ3RlvL4L
ZOcDdY5K/5w0DEzFiO3Gf+UjeH1/476Z6y7/nC9nPhq2bcLlKiesHbFjPFHaWOCc
EKn+QDuhD//QVKtGGxmHLFR6zSoai7zBHR1Ntk8HzXDNKhbuXMy/FDi+g3P3/pZG
tK9K+fS5KeZQSlHKEMfrioZHEWHEnss8iE57XC347USWyW50BeL4cdnr2TwYG8da
/c55uxO77IxaCYMSglEitL0Z//pkBDlc9/UgZYBUH4L48W9r3umyKH6XB3UP+B7Q
Iq7rXkiBd0aeTIXLDKVJ4sMmHxZXZ+43HZ6/zPPDFxNyRtLx7oO42AOVYWCVV//A
g3royPyq+LqHb7TEKkBX
=Ag2q
-----END PGP SIGNATURE-----

--nextPart10038956.552frb96Sx--

