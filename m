From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH] Input: atkbd - correct MSC_SCAN events for force_release keys
Date: Sun, 28 Sep 2014 23:13:24 +0200
Message-ID: <2075303.cGkXBhvpNe@pebbles.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:51635 "EHLO
	mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbaI1VXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Sep 2014 17:23:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Without the change either no scancode would be reported on release
of force_release keys, or - if the key is marked as force_release
erroneously - the release event and the scancode would be reported
in separate reports to the input layer.

Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
---
 drivers/input/keyboard/atkbd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/at=
kbd.c
index 2dd1d0d..6375ae6 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -456,8 +456,9 @@ static irqreturn_t atkbd_interrupt(struct serio *se=
rio, unsigned char data,
=20
 	keycode =3D atkbd->keycode[code];
=20
-	if (keycode !=3D ATKBD_KEY_NULL)
-		input_event(dev, EV_MSC, MSC_SCAN, code);
+	if (!(atkbd->release && test_bit(code, atkbd->force_release_mask)))
+		if (keycode !=3D ATKBD_KEY_NULL)
+			input_event(dev, EV_MSC, MSC_SCAN, code);
=20
 	switch (keycode) {
 	case ATKBD_KEY_NULL:
@@ -511,6 +512,7 @@ static irqreturn_t atkbd_interrupt(struct serio *se=
rio, unsigned char data,
 		input_sync(dev);
=20
 		if (value && test_bit(code, atkbd->force_release_mask)) {
+			input_event(dev, EV_MSC, MSC_SCAN, code);
 			input_report_key(dev, keycode, 0);
 			input_sync(dev);
 		}
--=20
1.8.4.5


--=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
work: +49 2405 49936-424
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
