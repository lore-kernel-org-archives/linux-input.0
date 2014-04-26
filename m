From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 16/24] hid: Port hid-sony to ff-memless-next
Date: Sat, 26 Apr 2014 13:57:53 +0200
Message-ID: <1398513696-12626-17-git-send-email-madcatxster@devoid-pointer.net>
References: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

Port hid-sony to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/hid/Kconfig    |  2 +-
 drivers/hid/hid-sony.c | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 9260d14..e97c382 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -634,7 +634,7 @@ config HID_SONY
 config SONY_FF
 	bool "Sony PS2/3/4 accessories force feedback support"=20
 	depends on HID_SONY
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	Say Y here if you have a Sony PS2/3/4 accessory and want to enable
 	force feedback support for it.
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 908de27..95bb2e1 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -34,6 +34,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/input/mt.h>
+#include <linux/input/ff-memless-next.h>
=20
 #include "hid-ids.h"
=20
@@ -53,6 +54,7 @@
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLL=
ER)
 #define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
=20
+#define FF_UPDATE_RATE 50
 #define MAX_LEDS 4
=20
 static const u8 sixaxis_rdesc_fixup[] =3D {
@@ -1308,16 +1310,25 @@ static void dualshock4_state_worker(struct work=
_struct *work)
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
@@ -1330,7 +1341,7 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct input_dev *input_dev =3D hidinput->input;
=20
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
-	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
+	return input_ff_create_mlnx(input_dev, NULL, sony_play_effect, FF_UPD=
ATE_RATE);
 }
=20
 #else
@@ -1762,6 +1773,7 @@ static const struct hid_device_id sony_devices[] =
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
