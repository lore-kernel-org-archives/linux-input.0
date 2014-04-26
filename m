From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 20/24] input: Port gamecon to ff-memless-next
Date: Sat, 26 Apr 2014 13:57:57 +0200
Message-ID: <1398513696-12626-21-git-send-email-madcatxster@devoid-pointer.net>
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

Port gamecon to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/input/joystick/Kconfig   |  2 +-
 drivers/input/joystick/gamecon.c | 57 ++++++++++++++++++++++----------=
--------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kc=
onfig
index 56eb471..2dd3ba1 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -221,7 +221,7 @@ config JOYSTICK_DB9
 config JOYSTICK_GAMECON
 	tristate "Multisystem, NES, SNES, N64, PSX joysticks and gamepads"
 	depends on PARPORT
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	  Say Y here if you have a Nintendo Entertainment System gamepad,
 	  Super Nintendo Entertainment System gamepad, Nintendo 64 gamepad,
diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/=
gamecon.c
index e68e497..209d0fb 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -40,6 +40,7 @@
 #include <linux/input.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/input/ff-memless-next.h>
=20
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("NES, SNES, N64, MultiSystem, PSX gamepad driver");
@@ -47,6 +48,7 @@ MODULE_LICENSE("GPL");
=20
 #define GC_MAX_PORTS		3
 #define GC_MAX_DEVICES		5
+#define FF_UPDATE_RATE 50
=20
 struct gc_config {
 	int args[GC_MAX_DEVICES + 1];
@@ -263,43 +265,48 @@ static void gc_n64_process_packet(struct gc *gc)
 }
=20
 static int gc_n64_play_effect(struct input_dev *dev, void *data,
-			      struct ff_effect *effect)
+			      const struct mlnx_effect_command *command)
 {
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
 	int i;
 	unsigned long flags;
 	struct gc *gc =3D input_get_drvdata(dev);
 	struct gc_subdev *sdev =3D data;
 	unsigned char target =3D 1 << sdev->idx; /* select desired pin */
+	unsigned int cmd;
=20
-	if (effect->type =3D=3D FF_RUMBLE) {
-		struct ff_rumble_effect *rumble =3D &effect->u.rumble;
-		unsigned int cmd =3D
-			rumble->strong_magnitude || rumble->weak_magnitude ?
-			GC_N64_CMD_01 : GC_N64_CMD_00;
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		cmd =3D (rumble_force->strong || rumble_force->weak) ? GC_N64_CMD_01=
 : GC_N64_CMD_00;
+		break;
+	case MLNX_STOP_RUMBLE:
+		cmd =3D GC_N64_CMD_00;
+		break;
+	default:
+		return -EINVAL;
+	}
=20
-		local_irq_save(flags);
+	local_irq_save(flags);
=20
-		/* Init Rumble - 0x03, 0x80, 0x01, (34)0x80 */
-		gc_n64_send_command(gc, GC_N64_CMD_03, target);
+	/* Init Rumble - 0x03, 0x80, 0x01, (34)0x80 */
+	gc_n64_send_command(gc, GC_N64_CMD_03, target);
+	gc_n64_send_command(gc, GC_N64_CMD_80, target);
+	gc_n64_send_command(gc, GC_N64_CMD_01, target);
+	for (i =3D 0; i < 32; i++)
 		gc_n64_send_command(gc, GC_N64_CMD_80, target);
-		gc_n64_send_command(gc, GC_N64_CMD_01, target);
-		for (i =3D 0; i < 32; i++)
-			gc_n64_send_command(gc, GC_N64_CMD_80, target);
-		gc_n64_send_stop_bit(gc, target);
+	gc_n64_send_stop_bit(gc, target);
=20
-		udelay(GC_N64_DELAY);
-
-		/* Now start or stop it - 0x03, 0xc0, 0zx1b, (32)0x01/0x00 */
-		gc_n64_send_command(gc, GC_N64_CMD_03, target);
-		gc_n64_send_command(gc, GC_N64_CMD_c0, target);
-		gc_n64_send_command(gc, GC_N64_CMD_1b, target);
-		for (i =3D 0; i < 32; i++)
-			gc_n64_send_command(gc, cmd, target);
-		gc_n64_send_stop_bit(gc, target);
+	udelay(GC_N64_DELAY);
=20
-		local_irq_restore(flags);
+	/* Now start or stop it - 0x03, 0xc0, 0zx1b, (32)0x01/0x00 */
+	gc_n64_send_command(gc, GC_N64_CMD_03, target);
+	gc_n64_send_command(gc, GC_N64_CMD_c0, target);
+	gc_n64_send_command(gc, GC_N64_CMD_1b, target);
+	for (i =3D 0; i < 32; i++)
+		gc_n64_send_command(gc, cmd, target);
+	gc_n64_send_stop_bit(gc, target);
=20
-	}
+	local_irq_restore(flags);
=20
 	return 0;
 }
@@ -317,7 +324,7 @@ static int __init gc_n64_init_ff(struct input_dev *=
dev, int i)
=20
 	input_set_capability(dev, EV_FF, FF_RUMBLE);
=20
-	err =3D input_ff_create_memless(dev, sdev, gc_n64_play_effect);
+	err =3D input_ff_create_mlnx(dev, sdev, gc_n64_play_effect, FF_UPDATE=
_RATE);
 	if (err) {
 		kfree(sdev);
 		return err;
--=20
1.9.2
