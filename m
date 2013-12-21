From: Joe Perches <joe@perches.com>
Subject: Re: [RFC v2] ff-memless-next driver
Date: Sat, 21 Dec 2013 15:05:01 -0800
Message-ID: <1387667101.22671.6.camel@joe-AO722>
References: <2287724.uNI0tVeDgp@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0239.hostedemail.com ([216.40.44.239]:42833 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754054Ab3LUXFG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 21 Dec 2013 18:05:06 -0500
In-Reply-To: <2287724.uNI0tVeDgp@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, anssi.hannula@iki.fi, elias.vds@gmail.com

Refactoring can help reduce the line lengths.

For example:

Move the get_envelope function.
Use get_envelope in set_envelope_times.
---
 drivers/input/ff-memless-next.c | 58 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/input/ff-memless-next.c b/drivers/input/ff-memless-next.c
index 722601a..73e1127 100644
--- a/drivers/input/ff-memless-next.c
+++ b/drivers/input/ff-memless-next.c
@@ -104,34 +104,46 @@ static int mlnx_upload_conditional(struct mlnx_device *mlnxdev,
 	return mlnxdev->control_effect(mlnxdev->dev, mlnxdev->private, &ecmd);
 }
 
+static const struct ff_envelope *mlnx_get_envelope(const struct ff_effect *effect)
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
 static void mlnx_set_envelope_times(struct mlnx_effect *mlnxeff)
 {
 	const struct ff_effect *effect = &mlnxeff->effect;
+	const struct ff_envelope *env;
 
 	switch (effect->type) {
-	case FF_CONSTANT:
-		if (effect->u.constant.envelope.attack_length)
-			mlnxeff->attack_stop = mlnxeff->begin_at + msecs_to_jiffies(effect->u.constant.envelope.attack_length);
-		if (effect->replay.length && effect->u.constant.envelope.fade_length)
-			mlnxeff->fade_begin = mlnxeff->stop_at - msecs_to_jiffies(effect->u.constant.envelope.fade_length);
-		break;
 	case FF_PERIODIC:
 		pr_debug("Phase: %u, Offset: %d\n",
 			 effect->u.periodic.phase, effect->u.periodic.offset);
-		if (effect->u.periodic.envelope.attack_length)
-			mlnxeff->attack_stop = mlnxeff->begin_at + msecs_to_jiffies(effect->u.periodic.envelope.attack_length);
-		if (effect->replay.length && effect->u.periodic.envelope.fade_length)
-			mlnxeff->fade_begin = mlnxeff->stop_at - msecs_to_jiffies(effect->u.periodic.envelope.fade_length);
 		break;
+	case FF_CONSTANT:
 	case FF_RAMP:
-		if (effect->u.ramp.envelope.attack_length)
-			mlnxeff->attack_stop = mlnxeff->begin_at + msecs_to_jiffies(effect->u.ramp.envelope.attack_length);
-		if (effect->replay.length && effect->u.ramp.envelope.fade_length)
-			mlnxeff->fade_begin = mlnxeff->stop_at - msecs_to_jiffies(effect->u.ramp.envelope.fade_length);
 		break;
 	default:
-		break;
+		return;
 	}
+
+	env = mlnx_get_envelope(effect);
+	if (env->attack_length)
+		mlnxeff->attack_stop = mlnxeff->begin_at +
+				       msecs_to_jiffies(env->attack_length);
+	if (effect->replay.length && env->fade_length)
+		mlnxeff->fade_begin = mlnxeff->stop_at -
+				      msecs_to_jiffies(env->fade_length);
 }
 
 static void mlnx_set_trip_times(struct mlnx_effect *mlnxeff,
@@ -185,22 +197,6 @@ static void mlnx_stop_effect(struct mlnx_device *mlnxdev,
 	}
 }
 
-static const struct ff_envelope *mlnx_get_envelope(const struct ff_effect *effect)
-{
-	static const struct ff_envelope empty;
-
-	switch (effect->type) {
-	case FF_CONSTANT:
-		return &effect->u.constant.envelope;
-	case FF_PERIODIC:
-		return &effect->u.periodic.envelope;
-	case FF_RAMP:
-		return &effect->u.ramp.envelope;
-	default:
-		return &empty;
-	}
-}
-
 static s32 mlnx_apply_envelope(const struct mlnx_effect *mlnxeff,
 			       const s32 level)
 {


