From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: [RFC] ForceFeedback sequences
Date: Wed, 10 Feb 2010 11:03:54 +0200
Message-ID: <1265792634.4787.1591.camel@tema>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-b2Ip77nffU3LqYp7jwnB"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60933 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab0BJJEJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2010 04:04:09 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1A93kXT014553
	for <linux-input@vger.kernel.org>; Wed, 10 Feb 2010 11:04:06 +0200
Received: from [172.22.214.74] (trdhcp21474.nmp.nokia.com [172.22.214.74])
	by mgw-sa01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o1A93uYY018853
	for <linux-input@vger.kernel.org>; Wed, 10 Feb 2010 11:03:56 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>


--=-b2Ip77nffU3LqYp7jwnB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Linux FF-interface hasn't developed much. How about adding sequences to
that interface.

Here is small test-patch which I made to look what kind of problems
there might be. This is ff-memless only because I wanted to reuse it's
timer system. Also, it's not optimized (kind of ugly hack :). Anyway, it
shows some problematic things, like custom_data pointer state, ownership
of effect and is effect still enabled. Moving to ff-core solves most of
these.

More generic way to do this would be at ff-core, so all ff-devices could
use it, but thats not a simple task (timers..). Also kind of misusing
custom-field is probably not so good thing :). Maybe adding new type or
something.

So, what you think? Does this make any sense?

	++Jam


--=-b2Ip77nffU3LqYp7jwnB
Content-Disposition: attachment; filename="0001-Input-FF-memless-custom-sequence-hack.patch"
Content-Type: text/x-patch; name="0001-Input-FF-memless-custom-sequence-hack.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From dec8a86ff4b287019b4ce6989a738934c9eb95a1 Mon Sep 17 00:00:00 2001
From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Date: Tue, 9 Feb 2010 11:03:54 +0200
Subject: [PATCH] Input: FF-memless custom sequence hack

This takes unused custom functionality and use it for
making sequences in ff-memless. This can be only counted
as a hack for testing purposes.

Signed-off-by: Jari Vanhala <ext-jari.vanhala@nokia.com>
---
 drivers/input/ff-core.c      |    9 +++
 drivers/input/ff-memless.c   |  115 ++++++++++++++++++++++++++++++++++++++++-
 drivers/input/input-compat.c |    1 +
 3 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 59797a3..6396328 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -193,6 +193,9 @@ static int erase_effect(struct input_dev *dev, int effect_id,
 		return error;
 
 	spin_lock_irq(&dev->event_lock);
+	if (ff->effects[effect_id].type == FF_PERIODIC &&
+	    ff->effects[effect_id].u.periodic.waveform == FF_CUSTOM)
+		ff->effects[effect_id].u.periodic.custom_data = NULL;
 	ff->playback(dev, effect_id, 0);
 	ff->effect_owners[effect_id] = NULL;
 	spin_unlock_irq(&dev->event_lock);
@@ -250,6 +253,12 @@ static int flush_effects(struct input_dev *dev, struct file *file)
 	mutex_lock(&ff->mutex);
 
 	for (i = 0; i < ff->max_effects; i++)
+		if (!check_effect_access(ff, i, file) &&
+		    ff->effects[i].type == FF_PERIODIC &&
+		    ff->effects[i].u.periodic.waveform == FF_CUSTOM)
+			ff->effects[i].u.periodic.custom_data = NULL;
+
+	for (i = 0; i < ff->max_effects; i++)
 		erase_effect(dev, i, file);
 
 	mutex_unlock(&ff->mutex);
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index f967008..b14510b 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -54,6 +54,7 @@ struct ml_effect_state {
 	unsigned long play_at;	/* start time */
 	unsigned long stop_at;	/* stop time */
 	unsigned long adj_at;	/* last time the effect was sent */
+	int custom_index;	/* current custom index */
 };
 
 struct ml_device {
@@ -317,6 +318,29 @@ static void ml_combine_effects(struct ff_effect *effect,
 
 }
 
+#define IS_CUSTOM(effect)	(effect->type == FF_PERIODIC && \
+				 effect->u.periodic.waveform == FF_CUSTOM)
+static struct ff_effect *find_custom_effect(struct ml_effect_state *states,
+					    struct ff_effect *effect,
+					    int index)
+{
+	s16 id;
+	struct ff_effect *ret;
+
+	if (!effect || !effect->u.periodic.custom_data ||
+	    effect->u.periodic.custom_len / sizeof(__s16) <= index)
+		return NULL;
+	/* XXX: check if effect->u.periodic.custom_data still points
+	 * to valid memory */
+	id = effect->u.periodic.custom_data[index];
+	if (id < 0 || id == effect->id || id >= FF_MEMLESS_EFFECTS)
+		return NULL;
+	ret = states[id].effect;
+	if (IS_CUSTOM(ret))
+		return NULL;
+
+	return ret;
+}
 
 /*
  * Because memoryless devices have only one effect per effect type active
@@ -326,7 +350,7 @@ static int ml_get_combo_effect(struct ml_device *ml,
 			       unsigned long *effect_handled,
 			       struct ff_effect *combo_effect)
 {
-	struct ff_effect *effect;
+	struct ff_effect *effect, *effect2;
 	struct ml_effect_state *state;
 	int effect_type;
 	int i;
@@ -368,9 +392,56 @@ static int ml_get_combo_effect(struct ml_device *ml,
 
 			__clear_bit(FF_EFFECT_PLAYING, &state->flags);
 
+			if (IS_CUSTOM(effect)) {
+				state->custom_index++;
+				effect2 = find_custom_effect(ml->states,
+					effect, state->custom_index);
+				if (effect2) {
+					struct ff_envelope *envelope;
+					state->play_at = jiffies +
+						msecs_to_jiffies(effect2->
+								 replay.delay);
+					state->stop_at = state->play_at +
+						msecs_to_jiffies(effect2->
+								 replay.length);
+					state->adj_at = state->play_at;
+					effect->replay.length =
+						effect2->replay.length;
+					envelope = (struct ff_envelope *)
+						get_envelope(effect2);
+					effect->u.periodic.envelope =
+						*envelope;
+					__clear_bit(i, effect_handled);
+					i--;
+					continue;
+				}
+			}
+
 			if (--state->count <= 0) {
 				__clear_bit(FF_EFFECT_STARTED, &state->flags);
 			} else {
+				if (IS_CUSTOM(effect)) {
+					struct ff_envelope *envelope;
+					state->custom_index = 0;
+					effect2 =
+						find_custom_effect(ml->states,
+						effect, state->custom_index);
+					if (!effect2) {
+						__clear_bit(FF_EFFECT_PLAYING,
+							    &state->flags);
+						__clear_bit(FF_EFFECT_STARTED,
+							    &state->flags);
+						continue;
+					}
+					effect->replay.length =
+						effect2->replay.length;
+					envelope = (struct ff_envelope *)
+						get_envelope(effect2);
+					effect->u.periodic.envelope =
+						*envelope;
+					__clear_bit(i, effect_handled);
+					i--;
+				}
 				state->play_at = jiffies +
 					msecs_to_jiffies(effect->replay.delay);
 				state->stop_at = state->play_at +
@@ -378,8 +449,27 @@ static int ml_get_combo_effect(struct ml_device *ml,
 			}
 		} else {
 			__set_bit(FF_EFFECT_PLAYING, &state->flags);
-			state->adj_at = jiffies;
-			ml_combine_effects(combo_effect, state, ml->gain);
+			if (IS_CUSTOM(effect)) {
+				struct ml_effect_state state2;
+				effect2 = find_custom_effect(ml->states,
+					effect, state->custom_index);
+				if (!effect2) {
+					__clear_bit(FF_EFFECT_PLAYING,
+						    &state->flags);
+					__clear_bit(FF_EFFECT_STARTED,
+						    &state->flags);
+					continue;
+				}
+				state->adj_at = jiffies;
+				memcpy(&state2, state, sizeof(state2));
+				state2.effect = effect2;
+				ml_combine_effects(combo_effect,
+						   &state2, ml->gain);
+			} else {
+				state->adj_at = jiffies;
+				ml_combine_effects(combo_effect, state,
+						   ml->gain);
+			}
 		}
 	}
 
@@ -446,6 +536,24 @@ static int ml_ff_playback(struct input_dev *dev, int effect_id, int value)
 		state->stop_at = state->play_at +
 				 msecs_to_jiffies(state->effect->replay.length);
 		state->adj_at = state->play_at;
+		if (IS_CUSTOM(state->effect)) {
+			struct ff_effect *effect;
+			struct ff_envelope *envelope;
+			state->custom_index = 0;
+			effect = find_custom_effect(ml->states, state->effect,
+						    state->custom_index);
+			if (!effect) {
+				__clear_bit(FF_EFFECT_STARTED, &state->flags);
+				return -EINVAL;
+			}
+			state->play_at = jiffies +
+				msecs_to_jiffies(effect->replay.delay);
+			state->stop_at = state->play_at +
+				msecs_to_jiffies(effect->replay.length);
+			state->effect->replay.length = effect->replay.length;
+			envelope = (struct ff_envelope *)get_envelope(effect);
+			state->effect->u.periodic.envelope = *envelope;
+		}
 
 	} else {
 		debug("initiated stop");
@@ -536,6 +644,7 @@ int input_ff_create_memless(struct input_dev *dev, void *data,
 		set_bit(FF_SINE, dev->ffbit);
 		set_bit(FF_TRIANGLE, dev->ffbit);
 		set_bit(FF_SQUARE, dev->ffbit);
+		set_bit(FF_CUSTOM, dev->ffbit);
 	}
 
 	for (i = 0; i < FF_MEMLESS_EFFECTS; i++)
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index 1accb89..2df00b6 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -83,6 +83,7 @@ int input_ff_effect_from_user(const char __user *buffer, size_t size,
 
 		if (compat_effect->type == FF_PERIODIC &&
 		    compat_effect->u.periodic.waveform == FF_CUSTOM)
+			/* This propably should make a real copy ++Jam */
 			effect->u.periodic.custom_data =
 				compat_ptr(compat_effect->u.periodic.custom_data);
 	} else {
-- 
1.6.3.3


--=-b2Ip77nffU3LqYp7jwnB--

