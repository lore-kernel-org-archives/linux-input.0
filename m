From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 01/24] input: Add ff-memless-next module
Date: Sat, 26 Apr 2014 13:57:38 +0200
Message-ID: <1398513696-12626-2-git-send-email-madcatxster@devoid-pointer.net>
References: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from prifuk.cz ([31.31.77.140]:49812 "EHLO smtp.devoid-pointer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbaDZMC5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Apr 2014 08:02:57 -0400
In-Reply-To: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

Add ff-memless-next module

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
---
 drivers/input/Kconfig                 |   11 +
 drivers/input/Makefile                |    1 +
 drivers/input/ff-memless-next.c       | 1037 +++++++++++++++++++++++++=
++++++++
 include/linux/input/ff-memless-next.h |  162 +++++
 4 files changed, 1211 insertions(+)
 create mode 100644 drivers/input/ff-memless-next.c
 create mode 100644 include/linux/input/ff-memless-next.h

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index a11ff74..3780962 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -38,6 +38,17 @@ config INPUT_FF_MEMLESS
 	  To compile this driver as a module, choose M here: the
 	  module will be called ff-memless.
=20
+config INPUT_FF_MEMLESS_NEXT
+	tristate "New version of support for memoryless force-feedback device=
s"
+	help
+	  Say Y here to enable a new version of support for memoryless force
+	  feedback devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ff-memless-next.
+
 config INPUT_POLLDEV
 	tristate "Polled input device skeleton"
 	help
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 5ca3f63..b4f11f5 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_INPUT)		+=3D input-core.o
 input-core-y :=3D input.o input-compat.o input-mt.o ff-core.o
=20
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+=3D ff-memless.o
+obj-$(CONFIG_INPUT_FF_MEMLESS_NEXT)	+=3D ff-memless-next.o
 obj-$(CONFIG_INPUT_POLLDEV)	+=3D input-polldev.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+=3D sparse-keymap.o
 obj-$(CONFIG_INPUT_MATRIXKMAP)	+=3D matrix-keymap.o
diff --git a/drivers/input/ff-memless-next.c b/drivers/input/ff-memless=
-next.c
new file mode 100644
index 0000000..24619e9
--- /dev/null
+++ b/drivers/input/ff-memless-next.c
@@ -0,0 +1,1037 @@
+/*
+ * Force feedback support for memoryless devices
+ *
+ * This module is based on "ff-memless" orignally written by Anssi Han=
nula.
+ * It is extended to support all force feedback effects currently supp=
orted
+ * by the Linux input stack.
+ * Logic of emulation of FF_RUMBLE through FF_PERIODIC provided by
+ * Elias Vanderstuyft <elias.vds@gmail.com>
+ *
+ * Copyright(c) 2014 Michal "MadCatX" Maly <madcatxster@devoid-pointer=
=2Enet>
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/jiffies.h>
+#include <linux/fixp-arith.h>
+#include <linux/input/ff-memless-next.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michal \"MadCatX\" Maly");
+MODULE_DESCRIPTION("Force feedback support for memoryless force feedba=
ck devices");
+
+#define FF_MAX_EFFECTS 16
+#define FF_MIN_EFFECT_LENGTH ((MSEC_PER_SEC / CONFIG_HZ) + 1)
+#define FF_EFFECT_STARTED 1
+#define FF_EFFECT_PLAYING 2
+#define FF_EFFECT_EMULATED 3
+
+enum mlnx_emulate {
+	EMUL_NOTHING,	/* Do not emulate anything */
+	EMUL_RUMBLE,	/* Emulate FF_RUMBLE with FF_PERIODIC */
+	EMUL_PERIODIC	/* Emulate FF_PERIODIC with FF_RUMBLE */
+};
+
+struct mlnx_effect {
+	struct ff_effect effect;
+	unsigned long flags;
+	unsigned long begin_at;
+	unsigned long stop_at;
+	unsigned long updated_at;
+	unsigned long attack_stop;
+	unsigned long fade_begin;
+	int repeat;
+};
+
+struct mlnx_device {
+	u8 combinable_playing;
+	u8 rumble_playing;
+	unsigned long update_rate_jiffies;
+	void *private;
+	struct mlnx_effect effects[FF_MAX_EFFECTS];
+	u16 gain;
+	struct timer_list timer;
+	struct input_dev *dev;
+	enum mlnx_emulate emul;
+
+	int (*control_effect)(struct input_dev *, void *,
+			      const struct mlnx_effect_command *);
+};
+
+static s32 mlnx_calculate_x_force(const s32 level,
+						  const u16 direction)
+{
+	s32 new =3D (level * -fixp_sin(direction)) >> FRAC_N;
+	pr_debug("x force: %d\n", new);
+	return new;
+}
+
+static s32 mlnx_calculate_y_force(const s32 level,
+						  const u16 direction)
+{
+	s32 new =3D (level * fixp_cos(direction)) >> FRAC_N;
+	pr_debug("y force: %d\n", new);
+	return new;
+}
+
+static bool mlnx_is_combinable(const struct ff_effect *effect)
+{
+	switch (effect->type) {
+	case FF_CONSTANT:
+	case FF_PERIODIC:
+	case FF_RAMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mlnx_is_conditional(const struct ff_effect *effect)
+{
+	switch (effect->type) {
+	case FF_DAMPER:
+	case FF_FRICTION:
+	case FF_INERTIA:
+	case FF_SPRING:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void mlnx_clr_emulated(struct mlnx_effect *mlnxeff)
+{
+	__clear_bit(FF_EFFECT_EMULATED, &mlnxeff->flags);
+}
+
+static void mlnx_clr_playing(struct mlnx_effect *mlnxeff)
+{
+	__clear_bit(FF_EFFECT_PLAYING, &mlnxeff->flags);
+}
+
+static void mlnx_clr_started(struct mlnx_effect *mlnxeff)
+{
+	__clear_bit(FF_EFFECT_STARTED, &mlnxeff->flags);
+}
+
+static bool mlnx_is_emulated(const struct mlnx_effect *mlnxeff)
+{
+	return test_bit(FF_EFFECT_EMULATED, &mlnxeff->flags);
+}
+
+static bool mlnx_is_rumble(const struct ff_effect *effect)
+{
+	return effect->type =3D=3D FF_RUMBLE;
+}
+
+static bool mlnx_is_playing(const struct mlnx_effect *mlnxeff)
+{
+	return test_bit(FF_EFFECT_PLAYING, &mlnxeff->flags);
+}
+
+static bool mlnx_is_started(const struct mlnx_effect *mlnxeff)
+{
+	return test_bit(FF_EFFECT_STARTED, &mlnxeff->flags);
+}
+
+static bool mlnx_test_set_playing(struct mlnx_effect *mlnxeff)
+{
+	return test_and_set_bit(FF_EFFECT_PLAYING, &mlnxeff->flags);
+}
+
+static const struct ff_envelope *mlnx_get_envelope(const struct ff_eff=
ect *effect)
+{
+	static const struct ff_envelope empty;
+
+	switch (effect->type) {
+	case FF_CONSTANT:
+		return &effect->u.constant.envelope;
+	case FF_PERIODIC:
+		return &effect->u.periodic.envelope;
+	case FF_RAMP:
+		return &effect->u.ramp.envelope;
+	default:
+		return &empty;
+	}
+}
+
+/* Some devices might have a limit on how many uncombinable effects
+ * can be played at once */
+static int mlnx_upload_conditional(struct mlnx_device *mlnxdev,
+				   const struct ff_effect *effect)
+{
+	struct mlnx_effect_command ecmd =3D {
+		.cmd =3D MLNX_UPLOAD_UNCOMB,
+		.u.uncomb.id =3D effect->id,
+		.u.uncomb.effect =3D effect
+	};
+	return mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &ecmd)=
;
+}
+
+static int mlnx_erase_conditional(struct mlnx_device *mlnxdev,
+				  const struct ff_effect *effect)
+{
+	struct mlnx_effect_command ecmd =3D {
+		.cmd =3D MLNX_ERASE_UNCOMB,
+		.u.uncomb.id =3D effect->id,
+		.u.uncomb.effect =3D effect
+	};
+	return mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &ecmd)=
;
+}
+
+static void mlnx_set_envelope_times(struct mlnx_effect *mlnxeff)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+
+	if (envelope->attack_length) {
+		unsigned long j =3D msecs_to_jiffies(envelope->attack_length);
+		mlnxeff->attack_stop =3D mlnxeff->begin_at + j;
+	}
+	if (effect->replay.length && envelope->fade_length) {
+		unsigned long j =3D msecs_to_jiffies(envelope->fade_length);
+		mlnxeff->fade_begin =3D mlnxeff->stop_at - j;
+	}
+}
+
+static void mlnx_set_trip_times(struct mlnx_effect *mlnxeff,
+				const unsigned long now)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const u16 replay_delay =3D effect->replay.delay;
+	const u16 replay_length =3D effect->replay.length;
+
+	mlnxeff->begin_at =3D now + msecs_to_jiffies(replay_delay);
+	mlnxeff->stop_at =3D mlnxeff->begin_at + msecs_to_jiffies(replay_leng=
th);
+	mlnxeff->updated_at =3D mlnxeff->begin_at;
+}
+
+static void mlnx_start_effect(struct mlnx_effect *mlnxeff)
+{
+	const unsigned long now =3D jiffies;
+
+	mlnx_set_trip_times(mlnxeff, now);
+	mlnx_set_envelope_times(mlnxeff);
+	__set_bit(FF_EFFECT_STARTED, &mlnxeff->flags);
+}
+
+static void mlnx_stop_effect(struct mlnx_device *mlnxdev,
+			     const struct mlnx_effect *mlnxeff)
+{
+	switch (mlnxeff->effect.type) {
+	case FF_PERIODIC:
+		if (mlnx_is_emulated(mlnxeff)) {
+			if (--mlnxdev->rumble_playing =3D=3D 0) {
+				const struct mlnx_effect_command c =3D {
+					.cmd =3D MLNX_STOP_RUMBLE
+				};
+				mlnxdev->control_effect(mlnxdev->dev,
+							mlnxdev->private, &c);
+			}
+			return;
+		}
+	case FF_CONSTANT:
+	case FF_RAMP:
+		if (--mlnxdev->combinable_playing =3D=3D 0) {
+			const struct mlnx_effect_command c =3D {
+				.cmd =3D MLNX_STOP_COMBINED
+			};
+			mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private,
+						&c);
+		}
+		return;
+	case FF_RUMBLE:
+		if (mlnx_is_emulated(mlnxeff)) {
+			if (--mlnxdev->combinable_playing =3D=3D 0) {
+				const struct mlnx_effect_command c =3D {
+					.cmd =3D MLNX_STOP_COMBINED
+				};
+				mlnxdev->control_effect(mlnxdev->dev,
+							mlnxdev->private, &c);
+			}
+		} else {
+			if (--mlnxdev->rumble_playing =3D=3D 0) {
+				const struct mlnx_effect_command c =3D {
+					.cmd =3D MLNX_STOP_RUMBLE
+				};
+				mlnxdev->control_effect(mlnxdev->dev,
+							mlnxdev->private, &c);
+			}
+		}
+		return;
+	case FF_DAMPER:
+	case FF_FRICTION:
+	case FF_INERTIA:
+	case FF_SPRING:
+	{
+		const struct mlnx_effect_command c =3D {
+			.cmd =3D MLNX_STOP_UNCOMB,
+			.u.uncomb.id =3D mlnxeff->effect.id,
+			.u.uncomb.effect =3D &mlnxeff->effect
+		};
+		mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &c);
+		return;
+	}
+	default:
+		return;
+	}
+}
+
+static int mlnx_restart_effect(struct mlnx_device *mlnxdev,
+			       struct mlnx_effect *mlnxeff)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const unsigned long now =3D jiffies;
+
+	if (mlnx_is_combinable(effect)) {
+		if (effect->replay.delay)
+			mlnx_stop_effect(mlnxdev, mlnxeff);
+		else {
+			if (mlnx_is_emulated(mlnxeff))
+				mlnxdev->rumble_playing--;
+			else
+				mlnxdev->combinable_playing--;
+		}
+	} else if (mlnx_is_rumble(effect)) {
+		if (effect->replay.delay)
+			mlnx_stop_effect(mlnxdev, mlnxeff);
+		else {
+			if (mlnx_is_emulated(mlnxeff))
+				mlnxdev->combinable_playing--;
+			else
+				mlnxdev->rumble_playing--;
+		}
+	} else if (mlnx_is_conditional(effect)) {
+		int ret;
+		if (effect->replay.delay)
+			mlnx_stop_effect(mlnxdev, mlnxeff);
+
+		ret =3D mlnx_upload_conditional(mlnxdev, &mlnxeff->effect);
+		if (ret)
+			return ret;
+	}
+
+	mlnx_set_trip_times(mlnxeff, now);
+	mlnx_set_envelope_times(mlnxeff);
+
+	return 0;
+}
+
+static s32 mlnx_apply_envelope(const struct mlnx_effect *mlnxeff,
+			       const s32 level)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+	const unsigned long now =3D jiffies;
+	const s32 alevel =3D abs(level);
+
+	/* Effect has an envelope with nonzero attack time */
+	if (envelope->attack_length && time_before(now, mlnxeff->attack_stop)=
) {
+		const s32 clength =3D jiffies_to_msecs(now - mlnxeff->begin_at);
+		const s32 alength =3D envelope->attack_length;
+		const s32 dlevel =3D (alevel - envelope->attack_level)
+				 * clength / alength;
+		return level < 0 ? -(dlevel + envelope->attack_level) :
+				    (dlevel + envelope->attack_level);
+	} else if (envelope->fade_length && time_before_eq(mlnxeff->fade_begi=
n, now)) {
+		const s32 clength =3D jiffies_to_msecs(now - mlnxeff->fade_begin);
+		const s32 flength =3D envelope->fade_length;
+		const s32 dlevel =3D (envelope->fade_level - alevel)
+				 * clength / flength;
+		return level < 0 ? -(dlevel + alevel) : (dlevel + alevel);
+	}
+
+	return level;
+}
+
+static s32 mlnx_calculate_periodic(struct mlnx_effect *mlnxeff, const =
s32 level)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const unsigned long now =3D jiffies;
+	const u16 period =3D effect->u.periodic.period;
+	const u16 phase =3D effect->u.periodic.phase;
+	const s16 offset =3D effect->u.periodic.offset;
+	s32 new =3D level;
+	u16 t =3D (jiffies_to_msecs(now - mlnxeff->begin_at) + phase) % perio=
d;
+
+	switch (effect->u.periodic.waveform) {
+	case FF_SINE:
+	{
+		u16 degrees =3D (360 * t) / period;
+		new =3D ((level * fixp_sin(degrees)) >> FRAC_N) + offset;
+		break;
+	}
+	case FF_SQUARE:
+	{
+		u16 degrees =3D (360 * t) / period;
+		new =3D level * (degrees < 180 ? 1 : -1) + offset;
+		break;
+	}
+	case FF_SAW_UP:
+		new =3D 2 * level * t / period - level + offset;
+		break;
+	case FF_SAW_DOWN:
+		new =3D level - 2 * level * t / period + offset;
+		break;
+	case FF_TRIANGLE:
+	{
+		new =3D (2 * abs(level - (2 * level * t) / period));
+		new =3D new - abs(level) + offset;
+		break;
+	}
+	case FF_CUSTOM:
+		pr_debug("Custom waveform is not handled by this driver\n");
+		return level;
+	default:
+		pr_err("Invalid waveform\n");
+		return level;
+	}
+
+	/* Ensure that the offset did not make the value exceed s16 range */
+	new =3D clamp(new, -0x7fff, 0x7fff);
+	pr_debug("level: %d, t: %u\n", new, t);
+	return new;
+}
+
+static s32 mlnx_calculate_ramp(const struct mlnx_effect *mlnxeff)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+	const unsigned long now =3D jiffies;
+	const u16 length =3D effect->replay.length;
+	const s16 mean =3D (effect->u.ramp.start_level + effect->u.ramp.end_l=
evel) / 2;
+	const u16 t =3D jiffies_to_msecs(now - mlnxeff->begin_at);
+	s32 start =3D effect->u.ramp.start_level;
+	s32 end =3D effect->u.ramp.end_level;
+	s32 new;
+
+	if (envelope->attack_length && time_before(now, mlnxeff->attack_stop)=
) {
+		const s32 clength =3D jiffies_to_msecs(now - mlnxeff->begin_at);
+		const s32 alength =3D envelope->attack_length;
+		s32 attack_level;
+		if (end > start)
+			attack_level =3D mean - envelope->attack_level;
+		else
+			attack_level =3D mean + envelope->attack_level;
+		start =3D (start - attack_level) * clength / alength
+		      + attack_level;
+	} else if (envelope->fade_length && time_before_eq(mlnxeff->fade_begi=
n, now)) {
+		const s32 clength =3D jiffies_to_msecs(now - mlnxeff->fade_begin);
+		const s32 flength =3D envelope->fade_length;
+		s32 fade_level;
+		if (end > start)
+			fade_level =3D mean + envelope->fade_level;
+		else
+			fade_level =3D mean - envelope->fade_level;
+		end =3D (fade_level - end) * clength / flength + end;
+	}
+
+	new =3D ((end - start) * t) / length + start;
+	new =3D clamp(new, -0x7fff, 0x7fff);
+	pr_debug("RAMP level: %d, t: %u\n", new, t);
+	return new;
+}
+
+static void mlnx_destroy(struct ff_device *dev)
+{
+	struct mlnx_device *mlnxdev =3D dev->private;
+	del_timer_sync(&mlnxdev->timer);
+
+	kfree(mlnxdev->private);
+}
+
+static unsigned long mlnx_get_envelope_update_time(const struct mlnx_e=
ffect *mlnxeff,
+						   const unsigned long update_rate_jiffies)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+	const unsigned long now =3D jiffies;
+	unsigned long fade_next;
+
+	/* Effect has an envelope with nonzero attack time */
+	if (envelope->attack_length && time_before(now, mlnxeff->attack_stop)=
) {
+		if (time_before(mlnxeff->updated_at + update_rate_jiffies, mlnxeff->=
attack_stop))
+			return mlnxeff->updated_at + update_rate_jiffies;
+
+		return mlnxeff->attack_stop;
+	}
+
+	/* Effect has an envelope with nonzero fade time */
+	if (mlnxeff->effect.replay.length) {
+		if (!envelope->fade_length)
+			return mlnxeff->stop_at;
+
+		/* Schedule the next update when the fade begins */
+		if (time_before(mlnxeff->updated_at, mlnxeff->fade_begin))
+			return mlnxeff->fade_begin;
+
+		/* Already fading */
+		fade_next =3D mlnxeff->updated_at + update_rate_jiffies;
+
+		/* Schedule update when the effect stops */
+		if (time_after(fade_next, mlnxeff->stop_at))
+			return mlnxeff->stop_at;
+		/* Schedule update at the next checkpoint */
+			return fade_next;
+	}
+
+	/* There is no envelope */
+
+	/* Prevent the effect from being started twice */
+	if (mlnxeff->begin_at =3D=3D now && mlnx_is_playing(mlnxeff))
+		return now - 1;
+
+	return mlnxeff->begin_at;
+}
+
+static unsigned long mlnx_get_update_time(struct mlnx_effect *mlnxeff,
+				const unsigned long update_rate_jiffies)
+{
+	const unsigned long now =3D jiffies;
+	unsigned long time, update_periodic;
+
+	switch (mlnxeff->effect.type) {
+	/* Constant effect does not change with time, but it can have
+	 * an envelope and a duration */
+	case FF_CONSTANT:
+		return mlnx_get_envelope_update_time(mlnxeff,
+						     update_rate_jiffies);
+	/* Periodic and ramp effects have to be periodically updated */
+	case FF_PERIODIC:
+	case FF_RAMP:
+		time =3D mlnx_get_envelope_update_time(mlnxeff,
+						     update_rate_jiffies);
+		if (mlnx_is_emulated(mlnxeff))
+			update_periodic =3D mlnxeff->stop_at;
+		else
+			update_periodic =3D mlnxeff->updated_at +
+					  update_rate_jiffies;
+
+		/* Periodic effect has to be updated earlier than envelope
+		 * or envelope update time is in the past */
+		if (time_before(update_periodic, time) || time_before(time, now))
+			return update_periodic;
+		/* Envelope needs to be updated */
+		return time;
+	case FF_RUMBLE:
+		if (mlnx_is_emulated(mlnxeff))
+			return mlnxeff->updated_at + update_rate_jiffies;
+	case FF_DAMPER:
+	case FF_FRICTION:
+	case FF_INERTIA:
+	case FF_SPRING:
+	default:
+		if (time_after_eq(mlnxeff->begin_at, now))
+			return mlnxeff->begin_at;
+
+		return mlnxeff->stop_at;
+	}
+}
+
+static void mlnx_schedule_playback(struct mlnx_device *mlnxdev)
+{
+	struct mlnx_effect *mlnxeff;
+	const unsigned long now =3D jiffies;
+	int events =3D 0;
+	int i;
+	unsigned long earliest =3D 0;
+	unsigned long time;
+
+	/* Iterate over all effects and determine the earliest
+	 * time when we have to attend to any */
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++) {
+		mlnxeff =3D &mlnxdev->effects[i];
+
+		if (!mlnx_is_started(mlnxeff))
+			continue; /* Effect is not started, skip it */
+
+		if (mlnx_is_playing(mlnxeff))
+			time =3D mlnx_get_update_time(mlnxeff,
+						mlnxdev->update_rate_jiffies);
+		else
+			time =3D mlnxeff->begin_at;
+
+		pr_debug("Update time for effect %d: %lu\n", i, time);
+
+		/* Scheduled time is in the future and is either
+		 * before the current earliest time or it is
+		 * the first valid time value in this pass */
+		if (time_before_eq(now, time) &&
+		    (++events =3D=3D 1 || time_before(time, earliest)))
+			earliest =3D time;
+	}
+
+	if (events) {
+		pr_debug("Events: %d, earliest: %lu\n", events, earliest);
+		mod_timer(&mlnxdev->timer, earliest);
+	} else {
+		pr_debug("No events, deactivating timer\n");
+		del_timer(&mlnxdev->timer);
+	}
+}
+
+static u16 mlnx_calculate_rumble_direction(const u32 total_mag, const =
u16 total_dir,
+					   const u32 new_mag, const u16 new_dir)
+{
+	if (!new_mag)
+		return total_dir;
+	if (!total_mag)
+		return new_dir;
+	return (((total_dir >> 1) * total_mag +
+		(new_dir >> 1) * new_mag) /
+		(total_mag + new_mag)) << 1;
+}
+
+static void mlnx_add_force(struct mlnx_effect *mlnxeff, s32 *cfx, s32 =
*cfy,
+			   const u16 gain)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	u16 direction;
+	s32 level;
+
+	pr_debug("Processing effect type %d, ID %d\n",
+		 mlnxeff->effect.type, mlnxeff->effect.id);
+
+	direction =3D mlnxeff->effect.direction * 360 / 0xffff;
+	pr_debug("Direction deg: %u\n", direction);
+
+	switch (mlnxeff->effect.type) {
+	case FF_CONSTANT:
+		level =3D mlnx_apply_envelope(mlnxeff, effect->u.constant.level);
+		break;
+	case FF_PERIODIC:
+		level =3D mlnx_apply_envelope(mlnxeff,
+					    effect->u.periodic.magnitude);
+		level =3D mlnx_calculate_periodic(mlnxeff, level);
+		break;
+	case FF_RAMP:
+		level =3D mlnx_calculate_ramp(mlnxeff);
+		break;
+	default:
+		pr_err("Effect %d not handled by mlnx_add_force\n",
+		       mlnxeff->effect.type);
+		return;
+	}
+
+	*cfx +=3D mlnx_calculate_x_force(level, direction) * gain / 0xffff;
+	*cfy +=3D mlnx_calculate_y_force(level, direction) * gain / 0xffff;
+}
+
+static void mlnx_add_rumble(const struct mlnx_effect *mlnxeff, u32 *st=
rong_mag,
+			    u32 *weak_mag, u16 *strong_dir,
+			    u16 *weak_dir, const u16 gain)
+{
+	const struct ff_effect *eff =3D &mlnxeff->effect;
+	const struct ff_rumble_effect *reff =3D &mlnxeff->effect.u.rumble;
+	const u32 new_strong_mag =3D (u32)reff->strong_magnitude * gain / 0xf=
fffU;
+	const u32 new_weak_mag =3D (u32)reff->weak_magnitude * gain / 0xffffU=
;
+
+	*strong_dir =3D mlnx_calculate_rumble_direction(*strong_mag, *strong_=
dir,
+						      new_strong_mag,
+						      eff->direction);
+	*weak_dir =3D mlnx_calculate_rumble_direction(*weak_mag, *weak_dir,
+						    new_weak_mag,
+						    eff->direction);
+	*strong_mag +=3D new_strong_mag;
+	*weak_mag +=3D new_weak_mag;
+}
+
+static void mlnx_add_emul_periodic(const struct mlnx_effect *mlnxeff,
+				   u32 *strong_mag, u32 *weak_mag,
+				   u16 *strong_dir, u16 *weak_dir,
+				   const u16 gain)
+{
+	const struct ff_effect *eff =3D &mlnxeff->effect;
+	const u32 level =3D (u32)abs(mlnx_apply_envelope(mlnxeff,
+						  eff->u.periodic.magnitude)) * gain / 0x7fffU;
+
+	*strong_dir =3D mlnx_calculate_rumble_direction(*strong_mag, *strong_=
dir,
+						      level, eff->direction);
+	*weak_dir =3D mlnx_calculate_rumble_direction(*weak_mag, *weak_dir,
+						    level, eff->direction);
+
+	*strong_mag +=3D level;
+	*weak_mag +=3D level;
+}
+
+static void mlnx_add_emul_rumble(const struct mlnx_effect *mlnxeff, s3=
2 *cfx,
+				 s32 *cfy, const u16 gain,
+				 const unsigned long now,
+				 const unsigned long update_rate_jiffies)
+{
+	const struct ff_effect *effect =3D &mlnxeff->effect;
+	const u16 strong =3D effect->u.rumble.strong_magnitude;
+	const u16 weak =3D effect->u.rumble.weak_magnitude;
+	/* To calculate 't', we pretend that mlnxeff->begin_at =3D=3D 0, thus=
 t =3D=3D now.  */
+	/* This will synchronise all simultaneously playing emul rumble effec=
ts,     */
+	/* otherwise non-deterministic phase-inversions could occur depending=
 on     */
+	/* upload time, which could lead to undesired cancellation of these e=
ffects. */
+	const unsigned long t =3D now % (4UL * update_rate_jiffies);
+	s32 level =3D 0;
+	bool direction_up;
+	bool direction_left;
+
+	if (strong)
+		level +=3D (strong / 4) * (t < 2UL * update_rate_jiffies ? 1 : -1);
+	if (weak)
+		level +=3D (weak / 4) * (t < 2UL * update_rate_jiffies ?
+					(t < 1UL * update_rate_jiffies ? 1 : -1) :
+					(t < 3UL * update_rate_jiffies ? 1 : -1));
+	direction_up =3D (effect->direction > 0x3fffU && effect->direction <=3D=
 0xbfffU);
+	direction_left =3D (effect->direction <=3D 0x7fffU);
+
+	pr_debug("Emulated cf: %d, t: %lu, n: %lu, begin: %lu, diff: %lu j: %=
lu\n",
+		 level, t, now, mlnxeff->begin_at, now - mlnxeff->begin_at,
+		 update_rate_jiffies);
+	level =3D (level * gain) / 0xffff;
+	*cfx +=3D direction_left ? -level : level;
+	*cfy +=3D direction_up ? -level : level;
+}
+
+static void mlnx_play_effects(struct mlnx_device *mlnxdev)
+{
+	const u16 gain =3D mlnxdev->gain;
+	const unsigned long now =3D jiffies;
+	int i;
+	s32 cfx =3D 0;
+	s32 cfy =3D 0;
+	u32 strong_mag =3D 0;
+	u32 weak_mag =3D 0;
+	u16 strong_dir =3D 0;
+	u16 weak_dir =3D 0;
+
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++) {
+		struct mlnx_effect *mlnxeff =3D &mlnxdev->effects[i];
+
+		if (!mlnx_is_started(mlnxeff)) {
+			pr_debug("Effect %hd/%d not started\n",
+				 mlnxeff->effect.id, i);
+			continue;
+		}
+
+		if (time_before(now, mlnxeff->begin_at)) {
+			pr_debug("Effect %hd/%d begins at a later time\n",
+				 mlnxeff->effect.id, i);
+			continue;
+		}
+
+		if (time_before_eq(mlnxeff->stop_at, now) && mlnxeff->effect.replay.=
length) {
+			pr_debug("Effect %hd/%d has to be stopped\n",
+				 mlnxeff->effect.id, i);
+
+			mlnx_clr_playing(mlnxeff);
+			if (--mlnxeff->repeat > 0)
+				mlnx_restart_effect(mlnxdev, mlnxeff);
+			else {
+				mlnx_stop_effect(mlnxdev, mlnxeff);
+				mlnx_clr_started(mlnxeff);
+				mlnx_clr_emulated(mlnxeff);
+				if (mlnx_is_conditional(&mlnxeff->effect))
+					mlnx_erase_conditional(mlnxdev, &mlnxeff->effect);
+			}
+
+			continue;
+		}
+
+		switch (mlnxeff->effect.type) {
+		case FF_PERIODIC:
+			if (mlnxdev->emul =3D=3D EMUL_PERIODIC) {
+				if (!mlnx_test_set_playing(mlnxeff)) {
+					mlnxdev->rumble_playing++;
+					pr_debug("Starting emul periodic, total rumble %u\n",
+						 mlnxdev->rumble_playing);
+				}
+				__set_bit(FF_EFFECT_EMULATED, &mlnxeff->flags);
+				mlnx_add_emul_periodic(mlnxeff, &strong_mag, &weak_mag,
+						       &strong_dir, &weak_dir, gain);
+				break;
+			}
+		case FF_CONSTANT:
+		case FF_RAMP:
+			if (!mlnx_test_set_playing(mlnxeff)) {
+				mlnxdev->combinable_playing++;
+				pr_debug("Starting combinable effect, total %u\n",
+					 mlnxdev->combinable_playing);
+			}
+			mlnx_add_force(mlnxeff, &cfx, &cfy, gain);
+			break;
+		case FF_RUMBLE:
+			if (mlnxdev->emul =3D=3D EMUL_RUMBLE) {
+				if (!mlnx_test_set_playing(mlnxeff)) {
+					mlnxdev->combinable_playing++;
+					pr_debug("Starting emul rumble, total comb %u\n",
+						 mlnxdev->combinable_playing);
+				}
+				__set_bit(FF_EFFECT_EMULATED, &mlnxeff->flags);
+				mlnx_add_emul_rumble(mlnxeff, &cfx, &cfy, gain, now,
+						     mlnxdev->update_rate_jiffies);
+			} else {
+				if (!mlnx_test_set_playing(mlnxeff)) {
+					mlnxdev->rumble_playing++;
+					pr_debug("Starting rumble effect, total %u\n",
+						 mlnxdev->rumble_playing);
+				}
+				mlnx_add_rumble(mlnxeff, &strong_mag, &weak_mag,
+						&strong_dir, &weak_dir, gain);
+			}
+			break;
+		case FF_DAMPER:
+		case FF_FRICTION:
+		case FF_INERTIA:
+		case FF_SPRING:
+			if (!mlnx_test_set_playing(mlnxeff)) {
+				const struct mlnx_effect_command ecmd =3D {
+					.cmd =3D MLNX_START_UNCOMB,
+					.u.uncomb.id =3D i,
+					.u.uncomb.effect =3D &mlnxeff->effect
+				};
+				mlnxdev->control_effect(mlnxdev->dev,
+						      mlnxdev->private, &ecmd);
+			}
+			break;
+		default:
+			pr_debug("Unhandled type of effect\n");
+		}
+		mlnxeff->updated_at =3D now;
+	}
+
+	if (mlnxdev->combinable_playing) {
+		const struct mlnx_effect_command ecmd =3D {
+			.cmd =3D MLNX_START_COMBINED,
+			.u.simple_force =3D {
+				.x =3D clamp(cfx, -0x7fff, 0x7fff),
+				.y =3D clamp(cfy, -0x7fff, 0x7fff)
+			}
+		};
+		mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &ecmd);
+	}
+	if (mlnxdev->rumble_playing) {
+		const struct mlnx_effect_command ecmd =3D {
+			.cmd =3D MLNX_START_RUMBLE,
+			.u.rumble_force =3D {
+				.strong =3D clamp(strong_mag, (u32)0, (u32)0xffffU),
+				.weak =3D clamp(weak_mag, (u32)0, (u32)0xffffU),
+				.strong_dir =3D clamp(strong_dir, (u16)0, (u16)0xffffU),
+				.weak_dir =3D clamp(weak_dir, (u16)0, (u16)0xffffU)
+			}
+		};
+		mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &ecmd);
+	}
+
+	mlnx_schedule_playback(mlnxdev);
+}
+
+static void mlnx_set_gain(struct input_dev *dev, u16 gain)
+{
+	struct mlnx_device *mlnxdev =3D dev->ff->private;
+	int i;
+
+	mlnxdev->gain =3D gain;
+
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++) {
+		struct mlnx_effect *eff =3D &mlnxdev->effects[i];
+		if (eff =3D=3D NULL)
+			continue;
+		if (mlnx_is_playing(eff)) {
+			if (mlnx_is_combinable(&eff->effect)) {
+				mlnx_clr_playing(eff);
+				if (mlnx_is_emulated(eff))
+					--mlnxdev->rumble_playing;
+				else
+					--mlnxdev->combinable_playing;
+			} else if (mlnx_is_rumble(&eff->effect)) {
+				mlnx_clr_playing(eff);
+				if (mlnx_is_emulated(eff))
+					--mlnxdev->combinable_playing;
+				else
+					--mlnxdev->rumble_playing;
+			}
+		}
+	}
+
+	mlnx_play_effects(mlnxdev);
+}
+
+static int mlnx_startstop(struct input_dev *dev, int effect_id, int re=
peat)
+{
+	struct mlnx_device *mlnxdev =3D dev->ff->private;
+	struct mlnx_effect *mlnxeff =3D &mlnxdev->effects[effect_id];
+	int ret;
+
+	if (repeat > 0) {
+		pr_debug("Starting effect ID %d\n", effect_id);
+		mlnxeff->repeat =3D repeat;
+
+		if (!mlnx_is_started(mlnxeff)) {
+			/* Check that device has a free effect slot */
+			if (mlnx_is_conditional(&mlnxeff->effect)) {
+				ret =3D mlnx_upload_conditional(mlnxdev, &mlnxeff->effect);
+				if (ret) {
+					/* Device effect slots are all occupied */
+					pr_debug("No free effect slot for EID %d\n", effect_id);
+					return ret;
+				}
+			}
+			mlnx_start_effect(mlnxeff);
+		}
+	} else {
+		pr_debug("Stopping effect ID %d\n", effect_id);
+		if (mlnx_is_started(mlnxeff)) {
+			if (mlnx_is_playing(mlnxeff)) {
+				mlnx_clr_playing(mlnxeff);
+				mlnx_stop_effect(mlnxdev, mlnxeff);
+			}
+			mlnx_clr_started(mlnxeff);
+			mlnx_clr_emulated(mlnxeff);
+
+			if (mlnx_is_conditional(&mlnxeff->effect))
+				return mlnx_erase_conditional(mlnxdev, &mlnxeff->effect);
+		} else {
+			pr_debug("Effect ID %d already stopped\n", effect_id);
+			return 0;
+		}
+	}
+	mlnx_play_effects(mlnxdev);
+
+	return 0;
+}
+
+static void mlnx_timer_fired(unsigned long data)
+{
+	struct input_dev *dev =3D (struct input_dev *)data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->event_lock, flags);
+	mlnx_play_effects(dev->ff->private);
+	spin_unlock_irqrestore(&dev->event_lock, flags);
+}
+
+static int mlnx_upload(struct input_dev *dev, struct ff_effect *effect=
,
+		       struct ff_effect *old)
+{
+	struct mlnx_device *mlnxdev =3D dev->ff->private;
+	struct mlnx_effect *mlnxeff =3D &mlnxdev->effects[effect->id];
+	const u16 length =3D effect->replay.length;
+	const u16 delay =3D effect->replay.delay;
+	int ret, fade_from;
+
+	/* Effect's timing is below kernel timer resolution */
+	if (length && length < FF_MIN_EFFECT_LENGTH)
+		effect->replay.length =3D FF_MIN_EFFECT_LENGTH;
+	if (delay && delay < FF_MIN_EFFECT_LENGTH)
+		effect->replay.delay =3D FF_MIN_EFFECT_LENGTH;
+
+	/* Periodic effects must have a non-zero period */
+	if (effect->type =3D=3D FF_PERIODIC) {
+		if (!effect->u.periodic.period)
+			return -EINVAL;
+	}
+	/* Ramp effects cannot be infinite */
+	if (effect->type =3D=3D FF_RAMP && !length)
+		return -EINVAL;
+
+	if (mlnx_is_combinable(effect)) {
+		const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+
+		/* Infinite effects cannot fade */
+		if (!length && envelope->fade_length > 0)
+			return -EINVAL;
+		/* Fade length cannot be greater than effect duration */
+		fade_from =3D (int)length - (int)envelope->fade_length;
+		if (fade_from < 0)
+			return -EINVAL;
+		/* Envelope cannot start fading before it finishes attacking */
+		if (fade_from < envelope->attack_length && fade_from > 0)
+			return -EINVAL;
+	}
+
+
+	spin_lock_irq(&dev->event_lock);
+	mlnxeff->effect =3D *effect; /* Keep internal copy of the effect */
+	/* Check if the effect being modified is playing */
+	if (mlnx_is_started(mlnxeff)) {
+		if (mlnx_is_playing(mlnxeff)) {
+			mlnx_clr_playing(mlnxeff);
+			ret =3D mlnx_restart_effect(mlnxdev, mlnxeff);
+
+			if (ret) {
+				/* Restore the original effect */
+				if (old)
+					mlnxeff->effect =3D *old;
+				spin_unlock_irq(&dev->event_lock);
+				return ret;
+			}
+		}
+
+		mlnx_schedule_playback(mlnxdev);
+	}
+
+	spin_unlock_irq(&dev->event_lock);
+
+	return 0;
+}
+
+int input_ff_create_mlnx(struct input_dev *dev, void *data,
+			 int (*control_effect)(struct input_dev *, void *, const struct mln=
x_effect_command *),
+			 const u16 update_rate)
+{
+	struct mlnx_device *mlnxdev;
+	int ret;
+	const u16 min_update_rate =3D update_rate < FF_MIN_EFFECT_LENGTH ?
+				    FF_MIN_EFFECT_LENGTH : update_rate;
+
+	mlnxdev =3D kzalloc(sizeof(*mlnxdev), GFP_KERNEL);
+	if (!mlnxdev)
+		return -ENOMEM;
+
+	mlnxdev->dev =3D dev;
+	mlnxdev->private =3D data;
+	mlnxdev->control_effect =3D control_effect;
+	mlnxdev->gain =3D 0xffff;
+	mlnxdev->update_rate_jiffies =3D msecs_to_jiffies(min_update_rate);
+	input_set_capability(dev, EV_FF, FF_GAIN);
+	setup_timer(&mlnxdev->timer, mlnx_timer_fired, (unsigned long)dev);
+
+	/* Set up effect emulation if needed */
+	if (test_bit(FF_PERIODIC, dev->ffbit) &&
+	    !test_bit(FF_RUMBLE, dev->ffbit)) {
+		set_bit(FF_RUMBLE, dev->ffbit);
+		mlnxdev->emul =3D EMUL_RUMBLE;
+		pr_debug("Emulating RUMBLE with PERIODIC\n");
+	} else if (test_bit(FF_RUMBLE, dev->ffbit) &&
+		   !test_bit(FF_PERIODIC, dev->ffbit)) {
+		set_bit(FF_PERIODIC, dev->ffbit);
+		set_bit(FF_SINE, dev->ffbit);
+		set_bit(FF_SQUARE, dev->ffbit);
+		set_bit(FF_TRIANGLE, dev->ffbit);
+		set_bit(FF_SAW_DOWN, dev->ffbit);
+		set_bit(FF_SAW_UP, dev->ffbit);
+		mlnxdev->emul =3D EMUL_PERIODIC;
+		pr_debug("Emulating PERIODIC with RUMBLE\n");
+	} else {
+		mlnxdev->emul =3D EMUL_NOTHING;
+		pr_debug("No effect emulation is necessary\n");
+	}
+
+	ret =3D input_ff_create(dev, FF_MAX_EFFECTS);
+	if (ret) {
+		kfree(mlnxdev);
+		return ret;
+	}
+
+
+	dev->ff->private =3D mlnxdev;
+	dev->ff->upload =3D mlnx_upload;
+	dev->ff->set_gain =3D mlnx_set_gain;
+	dev->ff->destroy =3D mlnx_destroy;
+	dev->ff->playback =3D mlnx_startstop;
+
+	pr_debug("Device successfully registered.\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(input_ff_create_mlnx);
diff --git a/include/linux/input/ff-memless-next.h b/include/linux/inpu=
t/ff-memless-next.h
new file mode 100644
index 0000000..7522451
--- /dev/null
+++ b/include/linux/input/ff-memless-next.h
@@ -0,0 +1,162 @@
+#include <linux/input.h>
+
+/** DEFINITION OF TERMS
+ *
+ * Combined effect - An effect whose force is a superposition of force=
s
+ *                   generated by all effects that can be added togeth=
er.
+ *                   Only one combined effect can be playing at a time=
=2E
+ *                   Effects that can be added together to create a co=
mbined
+ *                   effect are FF_CONSTANT, FF_PERIODIC and FF_RAMP.
+ * Uncombinable effect - An effect that cannot be combined with anothe=
r effect.
+ *                       All conditional effects - FF_DAMPER, FF_FRICT=
ION,
+ *                       FF_INERTIA and FF_SPRING are uncombinable.
+ *                       Number of uncombinable effects playing simult=
aneously
+ *                       depends on the capabilities of the hardware.
+ * Rumble effect - An effect generated by device's rumble motors inste=
ad of
+ *                 force feedback actuators.
+ *
+ *
+ * HANDLING OF UNCOMBINABLE EFFECTS
+ *
+ * Uncombinable effects cannot be combined together into just one effe=
ct, at
+ * least not in a clear and obvious manner. Therefore these effects ha=
ve to
+ * be handled individually by ff-memless-next. Handling of these effec=
ts is
+ * left entirely to the hardware-specific driver, ff-memless-next mere=
ly
+ * passes these effects to the hardware-specific driver at appropriate=
 time.
+ * ff-memless-next provides the UPLOAD command to notify the hardware-=
specific
+ * driver that the userspace is about to request playback of an uncomb=
inable
+ * effect. The hardware-specific driver shall take all steps needed to=
 make
+ * the device ready to play the effect when it receives the UPLOAD com=
mand.
+ * The actual playback shall commence when START_UNCOMB command is rec=
eived.
+ * Opposite to the UPLOAD command is the ERASE command which tells
+ * the hardware-specific driver that the playback has finished and tha=
t
+ * the effect will not be restarted. STOP_UNCOMB command tells
+ * the hardware-specific driver that the playback shall stop but the d=
evice
+ * shall still be ready to resume the playback immediately.
+ *
+ * In case it is not possible to make the device ready to play an unco=
mbinable
+ * effect (all hardware effect slots are occupied), the hardware-speci=
fic
+ * driver may return an error when it receives an UPLOAD command. If t=
he
+ * hardware-specific driver returns 0, the upload is considered succes=
sful.
+ * START_UNCOMB and STOP_UNCOMB commands cannot fail and the device mu=
st always
+ * start the playback of the requested effect if the UPLOAD command of=
 the
+ * respective effect has been successful. ff-memless-next will never s=
end
+ * a START/STOP_UNCOMB command for an effect that has not been uploade=
d
+ * successfully, nor will it send an ERASE command for an effect that =
is
+ * playing (=3D has been started with START_UNCOMB command).
+ */
+
+enum mlnx_commands {
+	/* Start or update a combined effect. This command is sent whenever
+	 * a FF_CONSTANT, FF_PERIODIC or FF_RAMP is started, stopped or
+	 * updated by userspace, when the applied envelopes are recalculated
+	 * or when periodic effects are recalculated. */
+	MLNX_START_COMBINED,
+	/* Stop combined effect. This command is sent when all combinable
+	 * effects are stopped. */
+	MLNX_STOP_COMBINED,
+	/* Start or update a rumble effect. This command is sent whenever
+	 * a FF_RUMBLE effect is started or when its magnitudes or directions
+	 * change. */
+	MLNX_START_RUMBLE,
+	/* Stop a rumble effect. This command is sent when all FF_RUMBLE
+	 * effects are stopped. */
+	MLNX_STOP_RUMBLE,
+	/* Start or update an uncombinable effect. This command is sent
+	 * whenever an uncombinable effect is started or updated. */
+	MLNX_START_UNCOMB,
+	/* Stop uncombinable effect. This command is sent when an uncombinabl=
e
+	 * effect is stopped. */
+	MLNX_STOP_UNCOMB,
+	/* Upload uncombinable effect to device. This command is sent when th=
e
+	 * effect is started from userspace. It is up to the hardware-specifi=
c
+	 * driver to handle this situation.
+	 */
+	MLNX_UPLOAD_UNCOMB,
+	/* Remove uncombinable effect from device, This command is sent when
+	 * and uncombinable effect has finished playing and will not be
+	 * restarted.
+	 */
+	MLNX_ERASE_UNCOMB
+};
+
+/** struct mlnx_simple_force - holds constant forces along X and Y axi=
s
+ * @x: Force along X axis. Negative value denotes force pulling to the=
 left,
+ *     positive value denotes force pulling to the right.
+ * @y: Force along Y axis. Negative value denotes force denotes force =
pulling
+ *     away from the user, positive value denotes force pulling toward=
s
+ *     the user.
+ */
+struct mlnx_simple_force {
+	const s32 x;
+	const s32 y;
+};
+
+/** struct mlnx_rumble_force - holds information about rumble effect
+ * @strong: Magnitude of the strong vibration.
+ * @weak: Magnitude of the weak vibration.
+ * @strong_dir: Direction of the strong vibration expressed in the sam=
e way
+ *              as the direction of force feedback effect in struct ff=
_effect.
+ * @weak_dir: Direction of the weak vibration, same as above applies.
+ */
+struct mlnx_rumble_force {
+	const u32 strong;
+	const u32 weak;
+	const u16 strong_dir;
+	const u16 weak_dir;
+};
+
+/** struct mlnx_uncomb_effect - holds information about uncombinable e=
ffect
+ * @id: Id of the effect assigned by ff-core.
+ * @effect: Pointer to the uncombinable effect stored in ff-memless-ne=
xt module
+ *          Hardware-specific driver must not alter this.
+ */
+struct mlnx_uncomb_effect {
+	const int id;
+	const struct ff_effect *effect;
+};
+
+/** struct mlnx_commands - describes what action shall the force feedb=
ack
+ *                         device perform
+ * @cmd: Type of the action.
+ * @u: Data associated with the action.
+ */
+struct mlnx_effect_command {
+	const enum mlnx_commands cmd;
+	union {
+		const struct mlnx_simple_force simple_force;
+		const struct mlnx_rumble_force rumble_force;
+		const struct mlnx_uncomb_effect uncomb;
+	} u;
+};
+
+/** input_ff_create_mlnx() - Register a device within ff-memless-next =
and
+ *                           the kernel force feedback system
+ * @dev: Pointer to the struct input_dev associated with the device.
+ * @data: Any device-specific data that shall be passed to the callbac=
k.
+ *        function called by ff-memless-next when a force feedback act=
ion
+ *        shall be performed.
+ * @control_effect: Pointer to the callback function.
+ * @update_date: Delay in milliseconds between two recalculations of p=
eriodic
+ *               effects, ramp effects and envelopes. Note that this v=
alue will
+ *               never be lower than (CONFIG_HZ / 1000) + 1 regardless=
 of the
+ *               value specified here. This is not a "hard" rate limit=
er.
+ *               Userspace still can submit effects at a rate faster t=
han
+ *               this value.
+ */
+int input_ff_create_mlnx(struct input_dev *dev, void *data,
+			 int (*control_effect)(struct input_dev *, void *, const struct mln=
x_effect_command *),
+			 const u16 update_rate);
+
+/** int control_effect() - Callback to the HW-specific driver.
+ * @struct input_dev *: Pointer to the struct input_dev of the device =
that is
+ *                     is being controlled.
+ * @void *: Pointer to any device-specific data set by the HW-specific=
 driver.
+ *         This data will be free'd automatically by ff-memless-next w=
hen the
+ *         device is destroyed.
+ * @const struct mlnx_effect_command *:
+ *         Action the device shall perform. Note that this pointer is =
valid
+ *         only within the context of the callback function. If the HW=
-specific
+ *         driver needs any data from this structure after the callbac=
k
+ *         function returns, it must copy it.
+ */
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
