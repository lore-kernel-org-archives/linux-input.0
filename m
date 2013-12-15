From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: [RFC] Add ff-memless-next driver
Date: Sun, 15 Dec 2013 01:19:52 +0100
Message-ID: <20107437.IkYg87uJMY@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:40257 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329Ab3LOA3x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Dec 2013 19:29:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, elias.vds@gmail.com, anssi.hannula@iki.fi

Hi,

"ff-memless-next" driver is an extended modification of the original ff=
-memless driver. Unlike ff-memless, ff-memless-next targets only "serio=
us" FFB devices such as racing wheels and hi(ish)-end joysticks with FF=
B actuators instead of simple rumble motors. Modifications in ff-memles=
s-next include:
- Support of periodic and ramp effects
  These are treated as "combinable" effects and forces created by each =
of these effects is superposed into one total force
- Support for conditional effects
  As these effects cannot be effectively combined together, they are ha=
ndled separately depending on the capabilities of the underlying HW-spe=
cific driver
- Removed emulation of rumble effect
- Adjustable update rate
- Differentiation between "set effect's force to zero" and "stop effect=
"
- Checks whether the effect's parameters are valid upon upload - this s=
hould better be handled by ff-core though IMHO.

At the moment there is no HW-specific backend that would make use of ff=
-memless-next, the plan is to update hid-lg4ff once ff-memless-next get=
s accepted by upstream. ff-memless-next can be tested with dummy FFB de=
vice module which is available here (git://prifuk.cz/ff-dummy-device).

My primary motivation to write ff-memless-next were limitations of the =
current ff-memless driver I came across during work on the driver for L=
ogitech gaming wheels. However, ff-memless-next contains no code that w=
ould specifically target Logitech devices.

I must give a huge thanks to Elias Vanderstuyft (CC'd) for his extensiv=
e testing of the driver and numerous helpful suggestions.

Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
---
=46rom 12c7feb547ff16d91f6d04986862eaf5f266ddeb Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?Michal=3D20Mal=3DC3=3DBD?=3D <madcatxster@prifuk.cz=
>
Date: Sat, 14 Dec 2013 21:53:26 +0100
Subject: [PATCH 1/1] Add ff-memless-next driver

---
 drivers/input/Kconfig                 |  12 +
 drivers/input/Makefile                |   1 +
 drivers/input/ff-memless-next.c       | 675 ++++++++++++++++++++++++++=
++++++++
 include/linux/input/ff-memless-next.h |  29 ++
 4 files changed, 717 insertions(+)
 create mode 100644 drivers/input/ff-memless-next.c
 create mode 100644 include/linux/input/ff-memless-next.h

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index a11ff74..893ab00 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -77,6 +77,18 @@ config INPUT_MATRIXKMAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called matrix-keymap.
=20
+config INPUT_FF_MEMLESS_NEXT
+	tristate "New version of support for memoryless force feedback device=
s"
+	help
+	  Say Y here if you want to enable support for various memoryless
+	  force feedback devices (as of now there is no hardware-specific
+	  driver that supports this)
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ff-memless-next.
+
 comment "Userland interfaces"
=20
 config INPUT_MOUSEDEV
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 5ca3f63..169e99c 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_INPUT_FF_MEMLESS)	+=3D ff-memless.o
 obj-$(CONFIG_INPUT_POLLDEV)	+=3D input-polldev.o
 obj-$(CONFIG_INPUT_SPARSEKMAP)	+=3D sparse-keymap.o
 obj-$(CONFIG_INPUT_MATRIXKMAP)	+=3D matrix-keymap.o
+obj-$(CONFIG_INPUT_FF_MEMLESS_NEXT)	+=3D ff-memless-next.o
=20
 obj-$(CONFIG_INPUT_MOUSEDEV)	+=3D mousedev.o
 obj-$(CONFIG_INPUT_JOYDEV)	+=3D joydev.o
diff --git a/drivers/input/ff-memless-next.c b/drivers/input/ff-memless=
-next.c
new file mode 100644
index 0000000..23727b2
--- /dev/null
+++ b/drivers/input/ff-memless-next.c
@@ -0,0 +1,675 @@
+/*
+ *
+ * Force feedback support for memory-less devices
+ *
+ * This module is based on "ff-memless" orignally written by Anssi Han=
nula.
+ * It is extented to support all force feedback effects currently supp=
orted
+ * by the Linux input stack. All effects except FF_RAMP are handled in=
 accordance with
+ * Microsoft DirectInput specification valid at the time the module wa=
s written.
+ *
+ * Copyright(c) 2013 Michal Maly <madcatxster@prifuk.cz>
+ *
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
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
+#define FF_MIN_UPDATE_RATE_MSECS 5
+
+#define FF_EFFECT_STARTED 0x0
+#define FF_EFFECT_PLAYING 0x1
+
+
+struct mlnx_effect {
+	struct ff_effect *effect;
+	unsigned long flags;
+	unsigned long begin_at;
+	unsigned long stop_at;
+	unsigned long updated_at;
+	unsigned long attack_stop;
+	unsigned long fade_begin;
+	int repeat;
+	u16 playback_time;
+};
+
+struct mlnx_device {
+	u8 combinable_playing;
+	unsigned long update_rate_jiffies;
+	void *private;
+	struct mlnx_effect effects[FF_MAX_EFFECTS];
+	int gain;
+	struct timer_list timer;
+	struct input_dev *dev;
+
+	int (*control_effect)(struct input_dev *, void *, const struct mlnx_e=
ffect_command *);
+};
+
+static inline s32 mlnx_calculate_x_force(const s32 level, const u16 di=
rection)
+{
+	s32 new =3D (level * -fixp_sin(direction)) >> FRAC_N;
+	pr_debug("x force: %d\n", new);
+	return new;
+}
+
+static inline s32 mlnx_calculate_y_force(const s32 level, const u16 di=
rection)
+{
+	s32 new =3D (level * -fixp_cos(direction)) >> FRAC_N;
+	pr_debug("y force: %d\n", new);
+	return new;
+}
+
+static inline s32 mlnx_clamp_level(const s32 level)
+{
+	return (level > 0x7fff) ? 0x7fff : ((level < -0x7fff) ? -0x7fff : lev=
el);
+}
+
+static inline int mlnx_is_conditional(const struct ff_effect *effect)
+{
+	return (effect->type =3D=3D FF_DAMPER) || (effect->type =3D=3D FF_FRI=
CTION) || (effect->type =3D=3D FF_INERTIA) || (effect->type =3D=3D FF_S=
PRING);
+}
+
+static void mlnx_set_envelope_times(struct mlnx_effect *mlnxeff)
+{
+	struct ff_effect *effect =3D mlnxeff->effect;
+	switch (effect->type) {
+	case FF_CONSTANT:
+		if (effect->u.constant.envelope.attack_length)
+			mlnxeff->attack_stop =3D mlnxeff->begin_at + msecs_to_jiffies(effec=
t->u.constant.envelope.attack_length);
+		if (effect->replay.length && effect->u.constant.envelope.fade_length=
)
+			mlnxeff->fade_begin =3D mlnxeff->stop_at - msecs_to_jiffies(effect-=
>u.constant.envelope.fade_length);
+		break;
+	case FF_PERIODIC:
+		pr_debug("Phase: %u, Offset: %d\n", effect->u.periodic.phase, effect=
->u.periodic.offset);
+		if (effect->u.periodic.envelope.attack_length)
+			mlnxeff->attack_stop =3D mlnxeff->begin_at + msecs_to_jiffies(effec=
t->u.periodic.envelope.attack_length);
+		if (effect->replay.length && effect->u.periodic.envelope.fade_length=
)
+			mlnxeff->fade_begin =3D mlnxeff->stop_at - msecs_to_jiffies(effect-=
>u.periodic.envelope.fade_length);
+		break;
+	case FF_RAMP:
+		if (effect->u.ramp.envelope.attack_length)
+			mlnxeff->attack_stop =3D mlnxeff->begin_at + msecs_to_jiffies(effec=
t->u.ramp.envelope.attack_length);
+		if (effect->replay.length && effect->u.ramp.envelope.fade_length)
+			mlnxeff->fade_begin =3D mlnxeff->stop_at - msecs_to_jiffies(effect-=
>u.ramp.envelope.fade_length);
+		break;
+	default:
+		break;
+	}
+}
+
+static void mlnx_set_trip_times(struct mlnx_effect *mlnxeff, const uns=
igned long now)
+{
+	mlnxeff->begin_at =3D now + msecs_to_jiffies(mlnxeff->effect->replay.=
delay);
+	mlnxeff->stop_at =3D mlnxeff->begin_at + msecs_to_jiffies(mlnxeff->ef=
fect->replay.length);
+	mlnxeff->updated_at =3D mlnxeff->begin_at;
+	if (mlnxeff->effect->type =3D=3D FF_PERIODIC) {
+		mlnxeff->playback_time =3D mlnxeff->effect->u.periodic.phase;
+		/* Adjust periodic effects phase accordingly to Microsoft DirectInpu=
t specification */
+		switch (mlnxeff->effect->u.periodic.waveform) {
+		case FF_TRIANGLE:
+			mlnxeff->playback_time +=3D mlnxeff->effect->u.periodic.period / 4;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void mlnx_start_effect(struct mlnx_device *mlnxdev, struct mlnx=
_effect *mlnxeff)
+{
+	const unsigned long now =3D jiffies;
+
+	mlnx_set_trip_times(mlnxeff, now);
+	mlnx_set_envelope_times(mlnxeff);
+	__set_bit(FF_EFFECT_STARTED, &mlnxeff->flags);
+}
+
+static void mlnx_stop_effect(struct mlnx_device *mlnxdev, struct mlnx_=
effect *mlnxeff, const int idx)
+{
+	switch (mlnxeff->effect->type) {
+	case FF_CONSTANT:
+	case FF_PERIODIC:
+		if (--mlnxdev->combinable_playing =3D=3D 0) {
+			const struct mlnx_effect_command c =3D { .cmd =3D MLNX_STOP_COMBINE=
D };
+			mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &c);
+		}
+		return;
+	case FF_DAMPER:
+	case FF_FRICTION:
+	case FF_INERTIA:
+	case FF_SPRING:
+	{
+		const struct mlnx_effect_command c =3D { .cmd =3D MLNX_STOP_UNCOMB,
+							 .u.uncomb.id =3D idx,
+							 .u.uncomb.effect =3D mlnxeff->effect };
+		mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &c);
+		return;
+	}
+	default:
+		return;
+	}
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
+static s32 mlnx_apply_envelope(const struct mlnx_effect *mlnxeff, cons=
t s32 level)
+{
+	const struct ff_effect *effect =3D mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+	const unsigned long now =3D jiffies;
+	const s32 alevel =3D abs(level);
+
+	/* Effect has an envelope with nonzero attack time */
+	if (envelope->attack_length && time_before(now, mlnxeff->attack_stop)=
) {
+		const s32 into_trans_msecs =3D jiffies_to_msecs(now - mlnxeff->begin=
_at);
+		const s32 trans_length =3D envelope->attack_length;
+		const s32 dlevel =3D (alevel - envelope->attack_level) * into_trans_=
msecs / trans_length;
+		pr_debug("Effect is attacking\n");
+		pr_debug("Envelope orig: %d, dlevel: %d, into: %d, length: %d\n", le=
vel, dlevel, into_trans_msecs, trans_length);
+		return level < 0 ? -(dlevel + envelope->attack_level) : (dlevel + en=
velope->attack_level);
+	} else if (envelope->fade_length && time_before_eq(mlnxeff->fade_begi=
n, now)) {
+		const s32 into_trans_msecs =3D jiffies_to_msecs(now - mlnxeff->fade_=
begin);
+		const s32 trans_length =3D envelope->fade_length;
+		const s32 dlevel =3D (envelope->fade_level - alevel) * into_trans_ms=
ecs / trans_length;
+		pr_debug("Effect is fading\n");
+		pr_debug("Envelope orig: %d, dlevel: %d, into: %d, length: %d\n", le=
vel, dlevel, into_trans_msecs, trans_length);
+		return level < 0 ? -(dlevel + alevel) : (dlevel + alevel);
+	}
+
+	return level;
+}
+
+static s32 mlnx_calculate_periodic(struct mlnx_effect *mlnxeff, const =
s32 level)
+{
+	const struct ff_effect *effect =3D mlnxeff->effect;
+	const unsigned long now =3D jiffies;
+	const u16 period =3D effect->u.periodic.period;
+	const unsigned long dt =3D jiffies_to_msecs(now - mlnxeff->updated_at=
);
+	s32 new =3D level;
+	unsigned long n_periods;
+	u16 t;
+
+	mlnxeff->playback_time +=3D dt;
+	mlnxeff->playback_time &=3D 0x7fff; /* Make sure we don't exceed the =
max allowed period */
+	n_periods =3D mlnxeff->playback_time / period;
+	t =3D mlnxeff->playback_time - (n_periods * period);
+
+	switch (effect->u.periodic.waveform) {
+	case FF_SINE:
+	{
+		u16 degrees =3D (360 * t) / period;
+		new =3D ((level * fixp_sin(degrees)) >> FRAC_N) + effect->u.periodic=
=2Eoffset;
+		break;
+	}
+	case FF_SQUARE:
+	{
+		u16 degrees =3D (360 * t) / period;
+		new =3D level * (degrees < 180 ? 1 : -1);
+		break;
+	}
+	case FF_SAW_UP:
+		new =3D 2 * level * t / period - level + effect->u.periodic.offset;
+		break;
+	case FF_SAW_DOWN:
+		new =3D level - 2 * level * t / period + effect->u.periodic.offset;
+		break;
+	case FF_TRIANGLE:
+	{
+		/* Fixed-point implementation of A =3D 1 - 4 * ABS(0.5 - FRAC(0.5x +=
 0.25)) */
+		s32 a =3D abs(0x4000 - (((0x8000 * t / period) + 0x2000) & 0x7fff));
+		new =3D ((level * (0x8000 - 4 * a)) >> 15) + effect->u.periodic.offs=
et;
+		break;
+	}
+	case FF_CUSTOM:
+		pr_debug("Custom waveform is not handled by this driver.\n");
+		return level;
+	default:
+		pr_debug("Invalid waveform.\n");
+		return level;
+	}
+
+	new =3D mlnx_clamp_level(new); /* Make sure that the offset did not m=
ake the value exceed the s16 range */
+	pr_debug("level: %d, playback: %u, t: %u, dt: %lu\n", new, mlnxeff->p=
layback_time, t, dt);
+	return new;
+}
+
+static s32 mlnx_calculate_ramp(const struct mlnx_effect *mlnxeff)
+{
+	const struct ff_effect *effect =3D mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+	const unsigned long now =3D jiffies;
+	const u16 length =3D effect->replay.length;
+	s16 start =3D effect->u.ramp.start_level;
+	s16 end =3D effect->u.ramp.end_level;
+	u16 t =3D jiffies_to_msecs(now - mlnxeff->begin_at);
+	s32 new;
+
+	/* Effect has an envelope with nonzero attack time
+	 * If the envelope is attacking, adjust "start", if the
+	 * effect is fading, adjust "end". */
+	if (envelope->attack_length && time_before(now, mlnxeff->attack_stop)=
) {
+		const s32 into_trans_msecs =3D jiffies_to_msecs(now - mlnxeff->begin=
_at);
+		const s32 trans_length =3D envelope->attack_length;
+		const s32 dlevel =3D (abs(start) - envelope->attack_level) * into_tr=
ans_msecs / trans_length;
+		start =3D start < 0 ? -(dlevel + envelope->attack_level) : (dlevel +=
 envelope->attack_level);
+		pr_debug("RA Envelope orig: %d, dlevel: %d, into: %d, length: %d\n",=
 start, dlevel, into_trans_msecs, trans_length);
+	} else if (envelope->fade_length && time_before_eq(mlnxeff->fade_begi=
n, now)) {
+		const s32 into_trans_msecs =3D jiffies_to_msecs(now - mlnxeff->fade_=
begin);
+		const s32 trans_length =3D envelope->fade_length;
+		const s32 dlevel =3D (envelope->fade_level - abs(end)) * into_trans_=
msecs / trans_length;
+		end =3D end < 0 ? -(dlevel + abs(end)) : (dlevel + abs(end));
+		pr_debug("RA Envelope orig: %d, dlevel: %d, into: %d, length: %d\n",=
 end, dlevel, into_trans_msecs, trans_length);
+	}
+
+	new =3D ((end - start) * t) / (length) + start;
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
ffect *mlnxeff, const unsigned long update_rate_jiffies)
+{
+	const struct ff_effect *effect =3D mlnxeff->effect;
+	const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+	const unsigned long now =3D jiffies;
+	unsigned long fade_next;
+
+	/* Effect has an envelope with nonzero attack time */
+	if (envelope->attack_length && time_before(now, mlnxeff->attack_stop)=
) {
+		pr_debug("Attack stop: %lu\n", mlnxeff->attack_stop);
+		if (time_before(mlnxeff->updated_at + update_rate_jiffies, mlnxeff->=
attack_stop))
+			return mlnxeff->updated_at + update_rate_jiffies;
+		else
+			return mlnxeff->attack_stop;
+	}
+
+	/* Effect has an envelope with nonzero fade time */
+	if (mlnxeff->effect->replay.length) {
+		if (envelope->fade_length) {
+
+			/* Schedule the next update when the fade begins */
+			if (time_before(mlnxeff->updated_at, mlnxeff->fade_begin))
+				return mlnxeff->fade_begin;
+
+			/* Already fading */
+			else if (time_before(mlnxeff->fade_begin, now)) {
+				fade_next =3D mlnxeff->updated_at + update_rate_jiffies;
+				if (time_after(fade_next, mlnxeff->stop_at))
+					return mlnxeff->stop_at; /* Schedule update when the effect stops=
 */
+				else
+					return fade_next;      /* Schedule update at the next checkpoint =
*/
+			}
+		} else
+			return mlnxeff->stop_at;
+	}
+
+	/* There is no envelope */
+	if (mlnxeff->begin_at =3D=3D now && test_bit(FF_EFFECT_PLAYING, &mlnx=
eff->flags))
+		return now - 1; /* Prevent the effect from being started twice */
+	else
+		return mlnxeff->begin_at;
+}
+
+static unsigned long mlnx_get_update_time(const struct mlnx_effect *ml=
nxeff, const unsigned long update_rate_jiffies)
+{
+	const unsigned long now =3D jiffies;
+	unsigned long time, update_periodic;
+
+	switch (mlnxeff->effect->type) {
+	/* Constant effect does not change with time, but it can have an enve=
lope and a duration */
+	case FF_CONSTANT:
+		return mlnx_get_envelope_update_time(mlnxeff, update_rate_jiffies);
+	/* Periodic and ramp effects have to be periodically updated */
+	case FF_PERIODIC:
+	case FF_RAMP:
+		time =3D mlnx_get_envelope_update_time(mlnxeff, update_rate_jiffies)=
;
+
+		if (mlnxeff->effect->type =3D=3D FF_PERIODIC && mlnxeff->effect->u.p=
eriodic.waveform =3D=3D FF_SQUARE)
+			update_periodic =3D msecs_to_jiffies(mlnxeff->effect->u.periodic.pe=
riod / 2) + mlnxeff->updated_at;
+		else
+			update_periodic =3D mlnxeff->updated_at + update_rate_jiffies;
+
+		/* Periodic effect has to be updated earlier than envelope or envelo=
pe update time is in the past */
+		if (time_before(update_periodic, time) || time_before(time, now))
+			return update_periodic;
+		else /* Envelope needs to be updated */
+			return time;
+	case FF_DAMPER:
+	case FF_FRICTION:
+	case FF_INERTIA:
+	case FF_SPRING:
+	default:
+		if (time_after_eq(mlnxeff->begin_at, now))
+			return mlnxeff->begin_at;
+		else
+			return mlnxeff->stop_at;
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
+	/* Iterate over all effects and determine the earliest time when we h=
ave to attend to any */
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++) {
+		mlnxeff =3D &mlnxdev->effects[i];
+
+		if (!test_bit(FF_EFFECT_STARTED, &mlnxeff->flags))
+			continue; /* Effect is not started, skip it */
+
+		if (test_bit(FF_EFFECT_PLAYING, &mlnxeff->flags))
+			time =3D mlnx_get_update_time(mlnxeff, mlnxdev->update_rate_jiffies=
);
+		else
+			time =3D mlnxeff->begin_at;
+
+		pr_debug("Update time for effect %d: %lu\n", i, time);
+
+		/* Scheduled time is in the future and is either before the current =
earliest time
+		 * or it is the first valid time value in this pass */
+		if (time_before_eq(now, time) && (++events =3D=3D 1 || time_before(t=
ime, earliest)))
+			earliest =3D time;
+	}
+
+	if (events) {
+		pr_debug("Events: %d, earliest: %lu\n", events, earliest);
+		mod_timer(&mlnxdev->timer, earliest);
+	}
+}
+
+static void mlnx_add_force(struct mlnx_effect *mlnxeff, s32 *cfx, s32 =
*cfy, const u16 gain)
+{
+	u16 direction;
+	s32 level;
+
+	pr_debug("Processing effect type %d, ID %d\n", mlnxeff->effect->type,=
 mlnxeff->effect->id);
+
+	direction =3D mlnxeff->effect->direction * 360 / 0xffff;
+	pr_debug("Direction deg: %u\n", direction);
+
+	switch (mlnxeff->effect->type) {
+	case FF_CONSTANT:
+		level =3D mlnx_apply_envelope(mlnxeff, mlnxeff->effect->u.constant.l=
evel);
+		break;
+	case FF_PERIODIC:
+		level =3D mlnx_apply_envelope(mlnxeff, mlnxeff->effect->u.periodic.m=
agnitude);
+		level =3D mlnx_calculate_periodic(mlnxeff, level);
+		break;
+	case FF_RAMP:
+		level =3D mlnx_calculate_ramp(mlnxeff);
+		break;
+	default:
+		pr_debug("Effect %d is not handled by mlnx_add_force, this is probab=
ly a bug!\n", mlnxeff->effect->type);
+		return;
+	}
+
+	*cfx +=3D mlnx_calculate_x_force(level, direction) * gain / 0xffff;
+	*cfy +=3D mlnx_calculate_y_force(level, direction) * gain / 0xffff;
+}
+
+static void mlnx_play_effects(struct mlnx_device *mlnxdev)
+{
+	const u16 gain =3D mlnxdev->gain;
+	const unsigned long now =3D jiffies;
+	int i;
+	int cfx =3D 0;
+	int cfy =3D 0;
+
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++) {
+		struct mlnx_effect *mlnxeff =3D &mlnxdev->effects[i];
+
+		if (!test_bit(FF_EFFECT_STARTED, &mlnxeff->flags)) {
+			pr_debug("Effect %hd/%d not started\n", mlnxeff->effect->id, i);
+			continue;
+		}
+
+		if (time_before(now, mlnxeff->begin_at)) {
+			pr_debug("Effect %hd/%d begins at a later time\n", mlnxeff->effect-=
>id, i);
+			continue;
+		}
+
+		if (time_before_eq(mlnxeff->stop_at, now) && mlnxeff->effect->replay=
=2Elength) {
+			pr_debug("Effect %hd/%d has to be stopped\n", mlnxeff->effect->id, =
i);
+
+			/* If the effect should be repeated, reset it */
+			if (--mlnxeff->repeat > 0) {
+				__clear_bit(FF_EFFECT_PLAYING, &mlnxeff->flags);
+				mlnxeff->begin_at =3D mlnxeff->stop_at + msecs_to_jiffies(mlnxeff-=
>effect->replay.delay);
+				mlnxeff->stop_at =3D mlnxeff->begin_at + msecs_to_jiffies(mlnxeff-=
>effect->replay.length);
+			} else /* The effect has to be stopped */
+				mlnx_stop_effect(mlnxdev, mlnxeff, i);
+
+			continue;
+		}
+
+		switch (mlnxeff->effect->type) {
+		case FF_CONSTANT:
+		case FF_PERIODIC:
+		case FF_RAMP:
+			if (!test_and_set_bit(FF_EFFECT_PLAYING, &mlnxeff->flags)) {
+				mlnxdev->combinable_playing++;
+				pr_debug("Starting combinable effect, total %u\n", mlnxdev->combin=
able_playing);
+			}
+			mlnx_add_force(mlnxeff, &cfx, &cfy, gain);
+			break;
+		case FF_DAMPER:
+		case FF_FRICTION:
+		case FF_INERTIA:
+		case FF_SPRING:
+			if (!test_and_set_bit(FF_EFFECT_PLAYING, &mlnxeff->flags)) {
+				const struct mlnx_effect_command ecmd =3D { .cmd =3D MLNX_START_UN=
COMB,
+									  .u.uncomb.id =3D i,
+									  .u.uncomb.effect =3D mlnxeff->effect };
+				mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &ecmd);
+			}
+			break;
+		default:
+			pr_debug("Unhandled type of effect.\n");
+		}
+		mlnxeff->updated_at =3D now;
+	}
+
+	if (mlnxdev->combinable_playing) {
+		const struct mlnx_effect_command ecmd =3D { .cmd =3D MLNX_START_COMB=
INED,
+							  .u.simple_force =3D { .x =3D mlnx_clamp_level(cfx), .y =3D ml=
nx_clamp_level(cfy) } };
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
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++)
+		__clear_bit(FF_EFFECT_PLAYING, &mlnxdev->effects[i].flags);
+
+	mlnx_play_effects(mlnxdev);
+}
+
+static int mlnx_startstop(struct input_dev *dev, int effect_id, int re=
peat)
+{
+	struct mlnx_device *mlnxdev =3D dev->ff->private;
+	struct mlnx_effect *mlnxeff =3D &mlnxdev->effects[effect_id];
+
+	if (repeat > 0) {
+		pr_debug("Starting effect ID %d\n", effect_id);
+		mlnxeff->repeat =3D repeat;
+		mlnx_start_effect(mlnxdev, mlnxeff);
+	} else {
+		pr_debug("Stopping effect ID %d\n", effect_id);
+		if (test_bit(FF_EFFECT_STARTED, &mlnxdev->effects[effect_id].flags))=
 {
+			if (test_bit(FF_EFFECT_PLAYING, &mlnxdev->effects[effect_id].flags)=
) {
+				mlnx_stop_effect(mlnxdev, mlnxeff, effect_id);
+				__clear_bit(FF_EFFECT_PLAYING, &mlnxdev->effects[effect_id].flags)=
;
+			}
+			__clear_bit(FF_EFFECT_STARTED, &mlnxdev->effects[effect_id].flags);
+		} else
+			pr_debug("Effect ID %d already stopped.\n", effect_id);
+	}
+
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
, struct ff_effect *old)
+{
+	struct mlnx_device *mlnxdev =3D dev->ff->private;
+	struct mlnx_effect *mlnxeff =3D &mlnxdev->effects[effect->id];
+	const unsigned long now =3D jiffies;
+	int ret, fade_from;
+
+	pr_debug("Uploading effect type %d, ID %d\n", effect->type, effect->i=
d);
+
+	if (effect->type =3D=3D FF_PERIODIC) {
+		if (!effect->u.periodic.period)
+			return -EINVAL;
+	}
+
+	if (effect->type =3D=3D FF_CONSTANT || effect->type =3D=3D FF_PERIODI=
C || effect->type =3D=3D FF_RAMP) {
+		const struct ff_envelope *envelope =3D mlnx_get_envelope(effect);
+
+		/* Infinite effects cannot fade */
+		if (effect->replay.length =3D=3D 0 && envelope->fade_length > 0)
+			return -EINVAL;
+		/* Fade length cannot be greater than effect duration */
+		fade_from =3D (int)effect->replay.length - (int)envelope->fade_lengt=
h;
+		if (fade_from < 0)
+			return -EINVAL;
+		/* Envelope cannot start fading before it finishes attacking */
+		if (fade_from < envelope->attack_length)
+			return -EINVAL;
+	}
+
+	spin_lock_irq(&dev->event_lock);
+	/* Check if the effect being modified is playing */
+	if (test_bit(FF_EFFECT_STARTED, &mlnxeff->flags)) {
+		/* Set the effect to stopped state */
+		__clear_bit(FF_EFFECT_STARTED, &mlnxeff->flags);
+		mlnx_set_trip_times(mlnxeff, now);
+		mlnx_set_envelope_times(mlnxeff);
+		mlnx_schedule_playback(mlnxdev);
+	}
+
+	/* Some devices might have a limit on how many uncombinable effect ca=
n be played at once */
+	if (mlnx_is_conditional(effect)) {
+		struct mlnx_effect_command ecmd =3D { .cmd =3D MLNX_CAN_PLAY,
+						    .u.uncomb.id =3D effect->id,
+						    .u.uncomb.effect =3D effect };
+		ret =3D mlnxdev->control_effect(dev, mlnxdev->private, &ecmd);
+		if (ret) {
+			pr_debug("Device rejected effect\n");
+			spin_unlock_irq(&dev->event_lock);
+			return ret;
+		}
+	}
+
+	spin_unlock_irq(&dev->event_lock);
+
+	return 0;
+}
+
+int input_ff_create_mlnx(struct input_dev *dev, void *data, int(*contr=
ol_effect)(struct input_dev *, void *, const struct mlnx_effect_command=
 *),
+			 const u16 update_rate)
+{
+	struct mlnx_device *mlnxdev;
+	int ret;
+	int i;
+
+	if (update_rate < FF_MIN_UPDATE_RATE_MSECS)
+		return -EINVAL;
+
+	mlnxdev =3D kzalloc(sizeof(struct mlnx_device), GFP_KERNEL);
+	if (!mlnxdev)
+		return -ENOMEM;
+
+	mlnxdev->dev =3D dev;
+	mlnxdev->private =3D data;
+	mlnxdev->control_effect =3D control_effect;
+	mlnxdev->gain =3D 0xffff;
+	mlnxdev->update_rate_jiffies =3D msecs_to_jiffies(update_rate);
+	setup_timer(&mlnxdev->timer, mlnx_timer_fired, (unsigned long)dev);
+
+	ret =3D input_ff_create(dev, FF_MAX_EFFECTS);
+	if (ret) {
+		kfree(mlnxdev);
+		return ret;
+	}
+
+	dev->ff->private =3D mlnxdev;
+	dev->ff->upload =3D mlnx_upload;
+	dev->ff->set_gain =3D mlnx_set_gain;
+	dev->ff->destroy =3D mlnx_destroy;
+	dev->ff->playback =3D mlnx_startstop;
+
+	/* Link mlnxdev->effects to dev->ff->effects */
+	for (i =3D 0; i < FF_MAX_EFFECTS; i++)
+		mlnxdev->effects[i].effect =3D &dev->ff->effects[i];
+
+	pr_debug("MLNX: Device successfully registered.\n");
+	return 0;
+}
+EXPORT_SYMBOL_GPL(input_ff_create_mlnx);
diff --git a/include/linux/input/ff-memless-next.h b/include/linux/inpu=
t/ff-memless-next.h
new file mode 100644
index 0000000..0711c1c
--- /dev/null
+++ b/include/linux/input/ff-memless-next.h
@@ -0,0 +1,29 @@
+#include <linux/input.h>
+
+enum mlnx_commands {
+	MLNX_START_COMBINED,
+	MLNX_STOP_COMBINED,
+	MLNX_START_UNCOMB,
+	MLNX_STOP_UNCOMB,
+	MLNX_CAN_PLAY
+};
+
+struct mlnx_simple_force {
+	const s32 x;
+	const s32 y;
+};
+
+struct mlnx_uncomb_effect {
+	const int id;
+	const struct ff_effect *effect;
+};
+
+struct mlnx_effect_command {
+	const enum mlnx_commands cmd;
+	union {
+		const struct mlnx_simple_force simple_force;
+		const struct mlnx_uncomb_effect uncomb;
+	} u;
+};
+
+int input_ff_create_mlnx(struct input_dev *dev, void *data, int(*contr=
ol_effect)(struct input_dev *, void *, const struct mlnx_effect_command=
 *), const u16 update_rate);
--=20
1.8.5.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
