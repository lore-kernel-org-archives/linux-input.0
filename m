From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 16/24] input: Port hid-sony to ff-memless-next
Date: Tue, 22 Apr 2014 16:00:01 +0200
Message-ID: <1398175209-9565-17-git-send-email-madcatxster@devoid-pointer.net>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org
List-Id: linux-input@vger.kernel.org

Port hid-sony to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-sony.c | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index e76c36a..fc22f72 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -623,7 +623,7 @@ config HID_SONY
 config SONY_FF
 	bool "Sony PS2/3 accessories force feedback support"
 	depends on HID_SONY
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you have a Sony PS2/3 accessory and want to enable forc=
e
 	feedback support for it.
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2f19b15..70a9cc5 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/usb.h>
 #include <linux/leds.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
@@ -44,6 +45,7 @@
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | D=
UALSHOCK4_CONTROLLER_USB)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER_USB | DUALSHOCK4_CONTROLLE=
R_USB)
=20
+#define FF_UPDATE_RATE 50
 #define MAX_LEDS 4
=20
 static const u8 sixaxis_rdesc_fixup[] =3D {
@@ -970,16 +972,25 @@ static void dualshock4_state_worker(struct work_s=
truct *work)
=20
 #ifdef CONFIG_SONY_FF
 static int sony_play_effect(struct input_dev *dev, void *data,
-			    struct ff_effect *effect)
+			    const struct mlnx_effect_command *command)
 {
 	struct hid_device *hid =3D input_get_drvdata(dev);
 	struct sony_sc *sc =3D hid_get_drvdata(hid);
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
=20
-	if (effect->type !=3D FF_RUMBLE)
-		return 0;
=20
-	sc->left =3D effect->u.rumble.strong_magnitude / 256;
-	sc->right =3D effect->u.rumble.weak_magnitude / 256;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		sc->left =3D rumble_force->strong / 256;
+		sc->right =3D rumble_force->weak / 256;
+		break;
+	case MLNX_STOP_RUMBLE:
+		sc->left =3D 0;
+		sc->right =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
 	schedule_work(&sc->state_worker);
 	return 0;
@@ -992,7 +1003,7 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct input_dev *input_dev =3D hidinput->input;
=20
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
-	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
+	return input_ff_create_mlnx(input_dev, NULL, sony_play_effect, FF_UPD=
ATE_RATE);
 }
=20
 #else
@@ -1150,6 +1161,7 @@ static const struct hid_device_id sony_devices[] =
=3D {
 		.driver_data =3D DUALSHOCK4_CONTROLLER_USB },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CON=
TROLLER),
 		.driver_data =3D DUALSHOCK4_CONTROLLER_BT },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sony_devices);
--=20
1.9.2
