Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467236682A
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189815; cv=none; b=GlqEuXvvGPQzzNp3jlY/EmM6hBTQrLc/82Y6Q+rdq9YbnapqEU3BA3ed5T7P3Zy5E7jnNSHicklJJwmFx/ZrotrUHEpIqJXsqiNutjVvl+gPKwxuCO/yIH+ydDwjEAGSmt38QJUmNGoZneoHoxmb+3Oa63AuHmRMHvn68weeK9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189815; c=relaxed/simple;
	bh=CruAw8S87iS2YJb+UI6qDMnrM0un++eewlRJ/CmACKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A7xDKYMPRcpwyvotEODcjBFP/NzVUWHA6URkjxpiFWjLDwyGDujx1WHjLq13WhWoFtPej6rwD+Z7YqJPl25fOqBOfTWEfJp/maNnlaSJjlX1T0vhkbnGoRxd0enBEBKO//wv817uNJmVdexK9gkERSi8v+whOckByGWm5wtAZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBr/8rrq; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBr/8rrq"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12732165d1eso15233700c88.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 17:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773189812; x=1773794612; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk0WREDtCVXykGdbaZiu6N2yvKmNjdEFOP6p+OWIlOY=;
        b=XBr/8rrqTFH58mwhXTsOgx9eAk2yNFszbM6gbJmJi7AwDrZA7idTJ/pF/gT0pyjTR4
         kY7R6+pcQjUEw68jaafXOPr/0Y0y4ya+dc/awRn9b5y6T669VFZ6oECKDAP4GBMTVAbA
         lkT6w9N8HIRNOV242a3LhznGf6MU1b1St+MhLxmP2SBDOzVD0XfEj6Jckm/4wC6I/laP
         JrTjaq82KVrI7q4MlMN4rrNLOlSFe9SuF5BZdTLqJzJXtvBJx5xaRSBMZyXCWQ5M9pXt
         nGiIbBS9KH87inmFunC4nXQDg+0+0OcsLwZpsTj5BdeqZvIhzwPHBrBGjPEKB4MDSMaa
         +w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189812; x=1773794612;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gk0WREDtCVXykGdbaZiu6N2yvKmNjdEFOP6p+OWIlOY=;
        b=jN6P2LLCupRE+GHD5KHgXFp5UYl5zj/jxQZexoIibFWWzIox/8vKBHACJoQWWOMe2W
         xj9dRGcqphnfqrcsY6OSe00L6UNycKYn7R9lRBc72hheTjuis3cYhJVUWposdFcQmI1F
         J1SntpLtaHm0P1pfMQeGbVjQkUORdoYJ8EpUPXwyftZE2JASAlxwzHNgeBrEsjbFB5JQ
         1d/O1e4faZ+fGYvDp9XzQu9dISpkglEO19Q7wO9HLiK/zrNlmGenit8oLoXTpNxMpisD
         WK9ipl369bgMO7pTTi/LD6Qmy7shdMzeNw5WLobdoJTJ8ESYNsOBlXJ11+RHWVtLi9K/
         4dEQ==
X-Gm-Message-State: AOJu0Yz+L5xqhkNnGzeC4q4q36SmzlAj+c34I8TQ8Auk962zY6aS0n68
	LF5DgNZG6nRL9IG1BHd0wRB+Sa1TOa5l7Zpw1xD8ViIwjgfUJicgD2eY
X-Gm-Gg: ATEYQzz1jQPCdxIimNUWaXeCuoBKGnTJ0f0Krh60UAUKG5j0gV/8evA8ZAAUBcBnp0B
	CFugr1EJiA1XO36zAFvsR/rYzu9YPeCgBWO/dNVW/x6bFjgrhKrzYPjd63+SDSrU1jBmYsoakTT
	A3bi63NW+CzHqpmbL9tz2hfQtC0QlnGCIlchz9MasuWWj5GzK5NUE+IoSdk5amTXEyYszfkRJZo
	SCv5Lwo1aoHhLITDLNQU2mKpO6nMJdDBV9bzHcvOkUrhbpuA/bBaYzn3PPYOQzkA7LDU/9tILle
	9qw+YRz8tla94gtyDpN+hqEpahkRTEYvY4Sqfi+oIIrFpoCQMXURyb41AMTQODNPUqsvSLScF4j
	y/6pHyilaisNCZ/ErMdL5OQnuN0t7AyGbWrp0uHJz7gQXne4WXVqSLqww+LH1SX0wR+9cM8RyQX
	lNk4PVe8JUSEczt7eIVz1387gBzYZclm046K03RNiOf71e5auK4O2x/54nuvq2F09s
X-Received: by 2002:a05:7301:608a:b0:2be:83d0:d229 with SMTP id 5a478bee46e88-2be8a5a77e8mr232377eec.27.1773189812200;
        Tue, 10 Mar 2026 17:43:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a834fb3sm587084eec.2.2026.03.10.17.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:43:31 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:43:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, Andres Salomon <dilinger@queued.net>, 
	Daniel Drake <drake@endlessm.com>
Subject: [PATCH] Input: hgpk - remove protocol support
Message-ID: <abC5U_JigA9TrGYu@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The protocol flavor for ALPS touchpads found in OLPC laptops has been
broken since 2015 commit c378b5119eb0 ("Input: psmouse - factor out
common protocol probing code") that forgot to add hgpk_init() to HGPK
entry in psmouse_protocols array.

Since nobody complained for 10 years let's remove it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/Kconfig        |   10 -
 drivers/input/mouse/Makefile       |    1 -
 drivers/input/mouse/hgpk.c         | 1063 ----------------------------
 drivers/input/mouse/hgpk.h         |   61 --
 drivers/input/mouse/psmouse-base.c |   21 +-
 drivers/input/mouse/psmouse.h      |    2 +-
 6 files changed, 2 insertions(+), 1156 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 833b643f0616..30d119d4634b 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -164,16 +164,6 @@ config MOUSE_PS2_TOUCHKIT
 
 	  If unsure, say N.
 
-config MOUSE_PS2_OLPC
-	bool "OLPC PS/2 mouse protocol extension"
-	depends on MOUSE_PS2 && OLPC
-	help
-	  Say Y here if you have an OLPC XO-1 laptop (with built-in
-	  PS/2 touchpad/tablet device).  The manufacturer calls the
-	  touchpad an HGPK.
-
-	  If unsure, say N.
-
 config MOUSE_PS2_FOCALTECH
 	bool "FocalTech PS/2 mouse protocol extension" if EXPERT
 	default y
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index a1336d5bee6f..137ed0c32d90 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -29,7 +29,6 @@ psmouse-objs := psmouse-base.o synaptics.o focaltech.o
 psmouse-$(CONFIG_MOUSE_PS2_ALPS)	+= alps.o
 psmouse-$(CONFIG_MOUSE_PS2_BYD)		+= byd.o
 psmouse-$(CONFIG_MOUSE_PS2_ELANTECH)	+= elantech.o
-psmouse-$(CONFIG_MOUSE_PS2_OLPC)	+= hgpk.o
 psmouse-$(CONFIG_MOUSE_PS2_LOGIPS2PP)	+= logips2pp.o
 psmouse-$(CONFIG_MOUSE_PS2_LIFEBOOK)	+= lifebook.o
 psmouse-$(CONFIG_MOUSE_PS2_SENTELIC)	+= sentelic.o
diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
deleted file mode 100644
index 6125652e5ad8..000000000000
--- a/drivers/input/mouse/hgpk.c
+++ /dev/null
@@ -1,1063 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * OLPC HGPK (XO-1) touchpad PS/2 mouse driver
- *
- * Copyright (c) 2006-2008 One Laptop Per Child
- * Authors:
- *   Zephaniah E. Hull
- *   Andres Salomon <dilinger@debian.org>
- *
- * This driver is partly based on the ALPS driver, which is:
- *
- * Copyright (c) 2003 Neil Brown <neilb@cse.unsw.edu.au>
- * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
- * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
- * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
- */
-
-/*
- * The spec from ALPS is available from
- * <http://wiki.laptop.org/go/Touch_Pad/Tablet>.  It refers to this
- * device as HGPK (Hybrid GS, PT, and Keymatrix).
- *
- * The earliest versions of the device had simultaneous reporting; that
- * was removed.  After that, the device used the Advanced Mode GS/PT streaming
- * stuff.  That turned out to be too buggy to support, so we've finally
- * switched to Mouse Mode (which utilizes only the center 1/3 of the touchpad).
- */
-
-#define DEBUG
-#include <linux/slab.h>
-#include <linux/input.h>
-#include <linux/module.h>
-#include <linux/serio.h>
-#include <linux/libps2.h>
-#include <linux/delay.h>
-#include <asm/olpc.h>
-
-#include "psmouse.h"
-#include "hgpk.h"
-
-#define ILLEGAL_XY 999999
-
-static bool tpdebug;
-module_param(tpdebug, bool, 0644);
-MODULE_PARM_DESC(tpdebug, "enable debugging, dumping packets to KERN_DEBUG.");
-
-static int recalib_delta = 100;
-module_param(recalib_delta, int, 0644);
-MODULE_PARM_DESC(recalib_delta,
-	"packets containing a delta this large will be discarded, and a "
-	"recalibration may be scheduled.");
-
-static int jumpy_delay = 20;
-module_param(jumpy_delay, int, 0644);
-MODULE_PARM_DESC(jumpy_delay,
-	"delay (ms) before recal after jumpiness detected");
-
-static int spew_delay = 1;
-module_param(spew_delay, int, 0644);
-MODULE_PARM_DESC(spew_delay,
-	"delay (ms) before recal after packet spew detected");
-
-static int recal_guard_time;
-module_param(recal_guard_time, int, 0644);
-MODULE_PARM_DESC(recal_guard_time,
-	"interval (ms) during which recal will be restarted if packet received");
-
-static int post_interrupt_delay = 40;
-module_param(post_interrupt_delay, int, 0644);
-MODULE_PARM_DESC(post_interrupt_delay,
-	"delay (ms) before recal after recal interrupt detected");
-
-static bool autorecal = true;
-module_param(autorecal, bool, 0644);
-MODULE_PARM_DESC(autorecal, "enable recalibration in the driver");
-
-static char hgpk_mode_name[16];
-module_param_string(hgpk_mode, hgpk_mode_name, sizeof(hgpk_mode_name), 0644);
-MODULE_PARM_DESC(hgpk_mode,
-	"default hgpk mode: mouse, glidesensor or pentablet");
-
-static int hgpk_default_mode = HGPK_MODE_MOUSE;
-
-static const char * const hgpk_mode_names[] = {
-	[HGPK_MODE_MOUSE] = "Mouse",
-	[HGPK_MODE_GLIDESENSOR] = "GlideSensor",
-	[HGPK_MODE_PENTABLET] = "PenTablet",
-};
-
-static int hgpk_mode_from_name(const char *buf, int len)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(hgpk_mode_names); i++) {
-		const char *name = hgpk_mode_names[i];
-		if (strlen(name) == len && !strncasecmp(name, buf, len))
-			return i;
-	}
-
-	return HGPK_MODE_INVALID;
-}
-
-/*
- * see if new value is within 20% of half of old value
- */
-static int approx_half(int curr, int prev)
-{
-	int belowhalf, abovehalf;
-
-	if (curr < 5 || prev < 5)
-		return 0;
-
-	belowhalf = (prev * 8) / 20;
-	abovehalf = (prev * 12) / 20;
-
-	return belowhalf < curr && curr <= abovehalf;
-}
-
-/*
- * Throw out oddly large delta packets, and any that immediately follow whose
- * values are each approximately half of the previous.  It seems that the ALPS
- * firmware emits errant packets, and they get averaged out slowly.
- */
-static int hgpk_discard_decay_hack(struct psmouse *psmouse, int x, int y)
-{
-	struct hgpk_data *priv = psmouse->private;
-	int avx, avy;
-	bool do_recal = false;
-
-	avx = abs(x);
-	avy = abs(y);
-
-	/* discard if too big, or half that but > 4 times the prev delta */
-	if (avx > recalib_delta ||
-		(avx > recalib_delta / 2 && ((avx / 4) > priv->xlast))) {
-		psmouse_warn(psmouse, "detected %dpx jump in x\n", x);
-		priv->xbigj = avx;
-	} else if (approx_half(avx, priv->xbigj)) {
-		psmouse_warn(psmouse, "detected secondary %dpx jump in x\n", x);
-		priv->xbigj = avx;
-		priv->xsaw_secondary++;
-	} else {
-		if (priv->xbigj && priv->xsaw_secondary > 1)
-			do_recal = true;
-		priv->xbigj = 0;
-		priv->xsaw_secondary = 0;
-	}
-
-	if (avy > recalib_delta ||
-		(avy > recalib_delta / 2 && ((avy / 4) > priv->ylast))) {
-		psmouse_warn(psmouse, "detected %dpx jump in y\n", y);
-		priv->ybigj = avy;
-	} else if (approx_half(avy, priv->ybigj)) {
-		psmouse_warn(psmouse, "detected secondary %dpx jump in y\n", y);
-		priv->ybigj = avy;
-		priv->ysaw_secondary++;
-	} else {
-		if (priv->ybigj && priv->ysaw_secondary > 1)
-			do_recal = true;
-		priv->ybigj = 0;
-		priv->ysaw_secondary = 0;
-	}
-
-	priv->xlast = avx;
-	priv->ylast = avy;
-
-	if (do_recal && jumpy_delay) {
-		psmouse_warn(psmouse, "scheduling recalibration\n");
-		psmouse_queue_work(psmouse, &priv->recalib_wq,
-				msecs_to_jiffies(jumpy_delay));
-	}
-
-	return priv->xbigj || priv->ybigj;
-}
-
-static void hgpk_reset_spew_detection(struct hgpk_data *priv)
-{
-	priv->spew_count = 0;
-	priv->dupe_count = 0;
-	priv->x_tally = 0;
-	priv->y_tally = 0;
-	priv->spew_flag = NO_SPEW;
-}
-
-static void hgpk_reset_hack_state(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	priv->abs_x = priv->abs_y = -1;
-	priv->xlast = priv->ylast = ILLEGAL_XY;
-	priv->xbigj = priv->ybigj = 0;
-	priv->xsaw_secondary = priv->ysaw_secondary = 0;
-	hgpk_reset_spew_detection(priv);
-}
-
-/*
- * We have no idea why this particular hardware bug occurs.  The touchpad
- * will randomly start spewing packets without anything touching the
- * pad.  This wouldn't necessarily be bad, but it's indicative of a
- * severely miscalibrated pad; attempting to use the touchpad while it's
- * spewing means the cursor will jump all over the place, and act "drunk".
- *
- * The packets that are spewed tend to all have deltas between -2 and 2, and
- * the cursor will move around without really going very far.  It will
- * tend to end up in the same location; if we tally up the changes over
- * 100 packets, we end up w/ a final delta of close to 0.  This happens
- * pretty regularly when the touchpad is spewing, and is pretty hard to
- * manually trigger (at least for *my* fingers).  So, it makes a perfect
- * scheme for detecting spews.
- */
-static void hgpk_spewing_hack(struct psmouse *psmouse,
-			      int l, int r, int x, int y)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	/* ignore button press packets; many in a row could trigger
-	 * a false-positive! */
-	if (l || r)
-		return;
-
-	/* don't track spew if the workaround feature has been turned off */
-	if (!spew_delay)
-		return;
-
-	if (abs(x) > 3 || abs(y) > 3) {
-		/* no spew, or spew ended */
-		hgpk_reset_spew_detection(priv);
-		return;
-	}
-
-	/* Keep a tally of the overall delta to the cursor position caused by
-	 * the spew */
-	priv->x_tally += x;
-	priv->y_tally += y;
-
-	switch (priv->spew_flag) {
-	case NO_SPEW:
-		/* we're not spewing, but this packet might be the start */
-		priv->spew_flag = MAYBE_SPEWING;
-
-		fallthrough;
-
-	case MAYBE_SPEWING:
-		priv->spew_count++;
-
-		if (priv->spew_count < SPEW_WATCH_COUNT)
-			break;
-
-		/* excessive spew detected, request recalibration */
-		priv->spew_flag = SPEW_DETECTED;
-
-		fallthrough;
-
-	case SPEW_DETECTED:
-		/* only recalibrate when the overall delta to the cursor
-		 * is really small. if the spew is causing significant cursor
-		 * movement, it is probably a case of the user moving the
-		 * cursor very slowly across the screen. */
-		if (abs(priv->x_tally) < 3 && abs(priv->y_tally) < 3) {
-			psmouse_warn(psmouse, "packet spew detected (%d,%d)\n",
-				     priv->x_tally, priv->y_tally);
-			priv->spew_flag = RECALIBRATING;
-			psmouse_queue_work(psmouse, &priv->recalib_wq,
-					   msecs_to_jiffies(spew_delay));
-		}
-
-		break;
-	case RECALIBRATING:
-		/* we already detected a spew and requested a recalibration,
-		 * just wait for the queue to kick into action. */
-		break;
-	}
-}
-
-/*
- * HGPK Mouse Mode format (standard mouse format, sans middle button)
- *
- * byte 0:	y-over	x-over	y-neg	x-neg	1	0	swr	swl
- * byte 1:	x7	x6	x5	x4	x3	x2	x1	x0
- * byte 2:	y7	y6	y5	y4	y3	y2	y1	y0
- *
- * swr/swl are the left/right buttons.
- * x-neg/y-neg are the x and y delta negative bits
- * x-over/y-over are the x and y overflow bits
- *
- * ---
- *
- * HGPK Advanced Mode - single-mode format
- *
- * byte 0(PT):  1    1    0    0    1    1     1     1
- * byte 0(GS):  1    1    1    1    1    1     1     1
- * byte 1:      0   x6   x5   x4   x3   x2    x1    x0
- * byte 2(PT):  0    0   x9   x8   x7    ? pt-dsw    0
- * byte 2(GS):  0  x10   x9   x8   x7    ? gs-dsw pt-dsw
- * byte 3:      0   y9   y8   y7    1    0   swr   swl
- * byte 4:      0   y6   y5   y4   y3   y2    y1    y0
- * byte 5:      0   z6   z5   z4   z3   z2    z1    z0
- *
- * ?'s are not defined in the protocol spec, may vary between models.
- *
- * swr/swl are the left/right buttons.
- *
- * pt-dsw/gs-dsw indicate that the pt/gs sensor is detecting a
- * pen/finger
- */
-static bool hgpk_is_byte_valid(struct psmouse *psmouse, unsigned char *packet)
-{
-	struct hgpk_data *priv = psmouse->private;
-	int pktcnt = psmouse->pktcnt;
-	bool valid;
-
-	switch (priv->mode) {
-	case HGPK_MODE_MOUSE:
-		valid = (packet[0] & 0x0C) == 0x08;
-		break;
-
-	case HGPK_MODE_GLIDESENSOR:
-		valid = pktcnt == 1 ?
-			packet[0] == HGPK_GS : !(packet[pktcnt - 1] & 0x80);
-		break;
-
-	case HGPK_MODE_PENTABLET:
-		valid = pktcnt == 1 ?
-			packet[0] == HGPK_PT : !(packet[pktcnt - 1] & 0x80);
-		break;
-
-	default:
-		valid = false;
-		break;
-	}
-
-	if (!valid)
-		psmouse_dbg(psmouse,
-			    "bad data, mode %d (%d) %*ph\n",
-			    priv->mode, pktcnt, 6, psmouse->packet);
-
-	return valid;
-}
-
-static void hgpk_process_advanced_packet(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-	struct input_dev *idev = psmouse->dev;
-	unsigned char *packet = psmouse->packet;
-	int down = !!(packet[2] & 2);
-	int left = !!(packet[3] & 1);
-	int right = !!(packet[3] & 2);
-	int x = packet[1] | ((packet[2] & 0x78) << 4);
-	int y = packet[4] | ((packet[3] & 0x70) << 3);
-
-	if (priv->mode == HGPK_MODE_GLIDESENSOR) {
-		int pt_down = !!(packet[2] & 1);
-		int finger_down = !!(packet[2] & 2);
-		int z = packet[5];
-
-		input_report_abs(idev, ABS_PRESSURE, z);
-		if (tpdebug)
-			psmouse_dbg(psmouse, "pd=%d fd=%d z=%d",
-				    pt_down, finger_down, z);
-	} else {
-		/*
-		 * PenTablet mode does not report pressure, so we don't
-		 * report it here
-		 */
-		if (tpdebug)
-			psmouse_dbg(psmouse, "pd=%d ", down);
-	}
-
-	if (tpdebug)
-		psmouse_dbg(psmouse, "l=%d r=%d x=%d y=%d\n",
-			    left, right, x, y);
-
-	input_report_key(idev, BTN_TOUCH, down);
-	input_report_key(idev, BTN_LEFT, left);
-	input_report_key(idev, BTN_RIGHT, right);
-
-	/*
-	 * If this packet says that the finger was removed, reset our position
-	 * tracking so that we don't erroneously detect a jump on next press.
-	 */
-	if (!down) {
-		hgpk_reset_hack_state(psmouse);
-		goto done;
-	}
-
-	/*
-	 * Weed out duplicate packets (we get quite a few, and they mess up
-	 * our jump detection)
-	 */
-	if (x == priv->abs_x && y == priv->abs_y) {
-		if (++priv->dupe_count > SPEW_WATCH_COUNT) {
-			if (tpdebug)
-				psmouse_dbg(psmouse, "hard spew detected\n");
-			priv->spew_flag = RECALIBRATING;
-			psmouse_queue_work(psmouse, &priv->recalib_wq,
-					   msecs_to_jiffies(spew_delay));
-		}
-		goto done;
-	}
-
-	/* not a duplicate, continue with position reporting */
-	priv->dupe_count = 0;
-
-	/* Don't apply hacks in PT mode, it seems reliable */
-	if (priv->mode != HGPK_MODE_PENTABLET && priv->abs_x != -1) {
-		int x_diff = priv->abs_x - x;
-		int y_diff = priv->abs_y - y;
-		if (hgpk_discard_decay_hack(psmouse, x_diff, y_diff)) {
-			if (tpdebug)
-				psmouse_dbg(psmouse, "discarding\n");
-			goto done;
-		}
-		hgpk_spewing_hack(psmouse, left, right, x_diff, y_diff);
-	}
-
-	input_report_abs(idev, ABS_X, x);
-	input_report_abs(idev, ABS_Y, y);
-	priv->abs_x = x;
-	priv->abs_y = y;
-
-done:
-	input_sync(idev);
-}
-
-static void hgpk_process_simple_packet(struct psmouse *psmouse)
-{
-	struct input_dev *dev = psmouse->dev;
-	unsigned char *packet = psmouse->packet;
-	int left = packet[0] & 1;
-	int right = (packet[0] >> 1) & 1;
-	int x = packet[1] - ((packet[0] << 4) & 0x100);
-	int y = ((packet[0] << 3) & 0x100) - packet[2];
-
-	if (packet[0] & 0xc0)
-		psmouse_dbg(psmouse,
-			    "overflow -- 0x%02x 0x%02x 0x%02x\n",
-			    packet[0], packet[1], packet[2]);
-
-	if (hgpk_discard_decay_hack(psmouse, x, y)) {
-		if (tpdebug)
-			psmouse_dbg(psmouse, "discarding\n");
-		return;
-	}
-
-	hgpk_spewing_hack(psmouse, left, right, x, y);
-
-	if (tpdebug)
-		psmouse_dbg(psmouse, "l=%d r=%d x=%d y=%d\n",
-			    left, right, x, y);
-
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-
-	input_report_rel(dev, REL_X, x);
-	input_report_rel(dev, REL_Y, y);
-
-	input_sync(dev);
-}
-
-static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	if (!hgpk_is_byte_valid(psmouse, psmouse->packet))
-		return PSMOUSE_BAD_DATA;
-
-	if (psmouse->pktcnt >= psmouse->pktsize) {
-		if (priv->mode == HGPK_MODE_MOUSE)
-			hgpk_process_simple_packet(psmouse);
-		else
-			hgpk_process_advanced_packet(psmouse);
-		return PSMOUSE_FULL_PACKET;
-	}
-
-	if (priv->recalib_window) {
-		if (time_before(jiffies, priv->recalib_window)) {
-			/*
-			 * ugh, got a packet inside our recalibration
-			 * window, schedule another recalibration.
-			 */
-			psmouse_dbg(psmouse,
-				    "packet inside calibration window, queueing another recalibration\n");
-			psmouse_queue_work(psmouse, &priv->recalib_wq,
-					msecs_to_jiffies(post_interrupt_delay));
-		}
-		priv->recalib_window = 0;
-	}
-
-	return PSMOUSE_GOOD_DATA;
-}
-
-static int hgpk_select_mode(struct psmouse *psmouse)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	struct hgpk_data *priv = psmouse->private;
-	int i;
-	int cmd;
-
-	/*
-	 * 4 disables to enable advanced mode
-	 * then 3 0xf2 bytes as the preamble for GS/PT selection
-	 */
-	const int advanced_init[] = {
-		PSMOUSE_CMD_DISABLE, PSMOUSE_CMD_DISABLE,
-		PSMOUSE_CMD_DISABLE, PSMOUSE_CMD_DISABLE,
-		0xf2, 0xf2, 0xf2,
-	};
-
-	switch (priv->mode) {
-	case HGPK_MODE_MOUSE:
-		psmouse->pktsize = 3;
-		break;
-
-	case HGPK_MODE_GLIDESENSOR:
-	case HGPK_MODE_PENTABLET:
-		psmouse->pktsize = 6;
-
-		/* Switch to 'Advanced mode.', four disables in a row. */
-		for (i = 0; i < ARRAY_SIZE(advanced_init); i++)
-			if (ps2_command(ps2dev, NULL, advanced_init[i]))
-				return -EIO;
-
-		/* select between GlideSensor (mouse) or PenTablet */
-		cmd = priv->mode == HGPK_MODE_GLIDESENSOR ?
-			PSMOUSE_CMD_SETSCALE11 : PSMOUSE_CMD_SETSCALE21;
-
-		if (ps2_command(ps2dev, NULL, cmd))
-			return -EIO;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void hgpk_setup_input_device(struct input_dev *input,
-				    struct input_dev *old_input,
-				    enum hgpk_mode mode)
-{
-	if (old_input) {
-		input->name = old_input->name;
-		input->phys = old_input->phys;
-		input->id = old_input->id;
-		input->dev.parent = old_input->dev.parent;
-	}
-
-	memset(input->evbit, 0, sizeof(input->evbit));
-	memset(input->relbit, 0, sizeof(input->relbit));
-	memset(input->keybit, 0, sizeof(input->keybit));
-
-	/* All modes report left and right buttons */
-	__set_bit(EV_KEY, input->evbit);
-	__set_bit(BTN_LEFT, input->keybit);
-	__set_bit(BTN_RIGHT, input->keybit);
-
-	switch (mode) {
-	case HGPK_MODE_MOUSE:
-		__set_bit(EV_REL, input->evbit);
-		__set_bit(REL_X, input->relbit);
-		__set_bit(REL_Y, input->relbit);
-		break;
-
-	case HGPK_MODE_GLIDESENSOR:
-		__set_bit(BTN_TOUCH, input->keybit);
-		__set_bit(BTN_TOOL_FINGER, input->keybit);
-
-		__set_bit(EV_ABS, input->evbit);
-
-		/* GlideSensor has pressure sensor, PenTablet does not */
-		input_set_abs_params(input, ABS_PRESSURE, 0, 15, 0, 0);
-
-		/* From device specs */
-		input_set_abs_params(input, ABS_X, 0, 399, 0, 0);
-		input_set_abs_params(input, ABS_Y, 0, 290, 0, 0);
-
-		/* Calculated by hand based on usable size (52mm x 38mm) */
-		input_abs_set_res(input, ABS_X, 8);
-		input_abs_set_res(input, ABS_Y, 8);
-		break;
-
-	case HGPK_MODE_PENTABLET:
-		__set_bit(BTN_TOUCH, input->keybit);
-		__set_bit(BTN_TOOL_FINGER, input->keybit);
-
-		__set_bit(EV_ABS, input->evbit);
-
-		/* From device specs */
-		input_set_abs_params(input, ABS_X, 0, 999, 0, 0);
-		input_set_abs_params(input, ABS_Y, 5, 239, 0, 0);
-
-		/* Calculated by hand based on usable size (156mm x 38mm) */
-		input_abs_set_res(input, ABS_X, 6);
-		input_abs_set_res(input, ABS_Y, 8);
-		break;
-
-	default:
-		BUG();
-	}
-}
-
-static int hgpk_reset_device(struct psmouse *psmouse, bool recalibrate)
-{
-	int err;
-
-	psmouse_reset(psmouse);
-
-	if (recalibrate) {
-		struct ps2dev *ps2dev = &psmouse->ps2dev;
-
-		/* send the recalibrate request */
-		if (ps2_command(ps2dev, NULL, 0xf5) ||
-		    ps2_command(ps2dev, NULL, 0xf5) ||
-		    ps2_command(ps2dev, NULL, 0xe6) ||
-		    ps2_command(ps2dev, NULL, 0xf5)) {
-			return -1;
-		}
-
-		/* according to ALPS, 150mS is required for recalibration */
-		msleep(150);
-	}
-
-	err = hgpk_select_mode(psmouse);
-	if (err) {
-		psmouse_err(psmouse, "failed to select mode\n");
-		return err;
-	}
-
-	hgpk_reset_hack_state(psmouse);
-
-	return 0;
-}
-
-static int hgpk_force_recalibrate(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-	int err;
-
-	/* C-series touchpads added the recalibrate command */
-	if (psmouse->model < HGPK_MODEL_C)
-		return 0;
-
-	if (!autorecal) {
-		psmouse_dbg(psmouse, "recalibration disabled, ignoring\n");
-		return 0;
-	}
-
-	psmouse_dbg(psmouse, "recalibrating touchpad..\n");
-
-	/* we don't want to race with the irq handler, nor with resyncs */
-	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
-
-	/* start by resetting the device */
-	err = hgpk_reset_device(psmouse, true);
-	if (err)
-		return err;
-
-	/*
-	 * XXX: If a finger is down during this delay, recalibration will
-	 * detect capacitance incorrectly.  This is a hardware bug, and
-	 * we don't have a good way to deal with it.  The 2s window stuff
-	 * (below) is our best option for now.
-	 */
-	if (psmouse_activate(psmouse))
-		return -1;
-
-	if (tpdebug)
-		psmouse_dbg(psmouse, "touchpad reactivated\n");
-
-	/*
-	 * If we get packets right away after recalibrating, it's likely
-	 * that a finger was on the touchpad.  If so, it's probably
-	 * miscalibrated, so we optionally schedule another.
-	 */
-	if (recal_guard_time)
-		priv->recalib_window = jiffies +
-			msecs_to_jiffies(recal_guard_time);
-
-	return 0;
-}
-
-/*
- * This puts the touchpad in a power saving mode; according to ALPS, current
- * consumption goes down to 50uA after running this.  To turn power back on,
- * we drive MS-DAT low.  Measuring with a 1mA resolution ammeter says that
- * the current on the SUS_3.3V rail drops from 3mA or 4mA to 0 when we do this.
- *
- * We have no formal spec that details this operation -- the low-power
- * sequence came from a long-lost email trail.
- */
-static int hgpk_toggle_powersave(struct psmouse *psmouse, int enable)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	int timeo;
-	int err;
-
-	/* Added on D-series touchpads */
-	if (psmouse->model < HGPK_MODEL_D)
-		return 0;
-
-	if (enable) {
-		psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
-
-		/*
-		 * Sending a byte will drive MS-DAT low; this will wake up
-		 * the controller.  Once we get an ACK back from it, it
-		 * means we can continue with the touchpad re-init.  ALPS
-		 * tells us that 1s should be long enough, so set that as
-		 * the upper bound. (in practice, it takes about 3 loops.)
-		 */
-		for (timeo = 20; timeo > 0; timeo--) {
-			if (!ps2_sendbyte(ps2dev, PSMOUSE_CMD_DISABLE, 20))
-				break;
-			msleep(25);
-		}
-
-		err = hgpk_reset_device(psmouse, false);
-		if (err) {
-			psmouse_err(psmouse, "Failed to reset device!\n");
-			return err;
-		}
-
-		/* should be all set, enable the touchpad */
-		psmouse_activate(psmouse);
-		psmouse_dbg(psmouse, "Touchpad powered up.\n");
-	} else {
-		psmouse_dbg(psmouse, "Powering off touchpad.\n");
-
-		if (ps2_command(ps2dev, NULL, 0xec) ||
-		    ps2_command(ps2dev, NULL, 0xec) ||
-		    ps2_command(ps2dev, NULL, 0xea)) {
-			return -1;
-		}
-
-		psmouse_set_state(psmouse, PSMOUSE_IGNORE);
-
-		/* probably won't see an ACK, the touchpad will be off */
-		ps2_sendbyte(ps2dev, 0xec, 20);
-	}
-
-	return 0;
-}
-
-static int hgpk_poll(struct psmouse *psmouse)
-{
-	/* We can't poll, so always return failure. */
-	return -1;
-}
-
-static int hgpk_reconnect(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	/*
-	 * During suspend/resume the ps2 rails remain powered.  We don't want
-	 * to do a reset because it's flush data out of buffers; however,
-	 * earlier prototypes (B1) had some brokenness that required a reset.
-	 */
-	if (olpc_board_at_least(olpc_board(0xb2)))
-		if (psmouse->ps2dev.serio->dev.power.power_state.event !=
-				PM_EVENT_ON)
-			return 0;
-
-	priv->powered = 1;
-	return hgpk_reset_device(psmouse, false);
-}
-
-static ssize_t hgpk_show_powered(struct psmouse *psmouse, void *data, char *buf)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	return sprintf(buf, "%d\n", priv->powered);
-}
-
-static ssize_t hgpk_set_powered(struct psmouse *psmouse, void *data,
-				const char *buf, size_t count)
-{
-	struct hgpk_data *priv = psmouse->private;
-	unsigned int value;
-	int err;
-
-	err = kstrtouint(buf, 10, &value);
-	if (err)
-		return err;
-
-	if (value > 1)
-		return -EINVAL;
-
-	if (value != priv->powered) {
-		/*
-		 * hgpk_toggle_power will deal w/ state so
-		 * we're not racing w/ irq
-		 */
-		err = hgpk_toggle_powersave(psmouse, value);
-		if (!err)
-			priv->powered = value;
-	}
-
-	return err ? err : count;
-}
-
-__PSMOUSE_DEFINE_ATTR(powered, S_IWUSR | S_IRUGO, NULL,
-		      hgpk_show_powered, hgpk_set_powered, false);
-
-static ssize_t attr_show_mode(struct psmouse *psmouse, void *data, char *buf)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	return sprintf(buf, "%s\n", hgpk_mode_names[priv->mode]);
-}
-
-static ssize_t attr_set_mode(struct psmouse *psmouse, void *data,
-			     const char *buf, size_t len)
-{
-	struct hgpk_data *priv = psmouse->private;
-	enum hgpk_mode old_mode = priv->mode;
-	enum hgpk_mode new_mode = hgpk_mode_from_name(buf, len);
-	struct input_dev *old_dev = psmouse->dev;
-	struct input_dev *new_dev;
-	int err;
-
-	if (new_mode == HGPK_MODE_INVALID)
-		return -EINVAL;
-
-	if (old_mode == new_mode)
-		return len;
-
-	new_dev = input_allocate_device();
-	if (!new_dev)
-		return -ENOMEM;
-
-	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
-
-	/* Switch device into the new mode */
-	priv->mode = new_mode;
-	err = hgpk_reset_device(psmouse, false);
-	if (err)
-		goto err_try_restore;
-
-	hgpk_setup_input_device(new_dev, old_dev, new_mode);
-
-	psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
-
-	err = input_register_device(new_dev);
-	if (err)
-		goto err_try_restore;
-
-	psmouse->dev = new_dev;
-	input_unregister_device(old_dev);
-
-	return len;
-
-err_try_restore:
-	input_free_device(new_dev);
-	priv->mode = old_mode;
-	hgpk_reset_device(psmouse, false);
-
-	return err;
-}
-
-PSMOUSE_DEFINE_ATTR(hgpk_mode, S_IWUSR | S_IRUGO, NULL,
-		    attr_show_mode, attr_set_mode);
-
-static ssize_t hgpk_trigger_recal_show(struct psmouse *psmouse,
-		void *data, char *buf)
-{
-	return -EINVAL;
-}
-
-static ssize_t hgpk_trigger_recal(struct psmouse *psmouse, void *data,
-				const char *buf, size_t count)
-{
-	struct hgpk_data *priv = psmouse->private;
-	unsigned int value;
-	int err;
-
-	err = kstrtouint(buf, 10, &value);
-	if (err)
-		return err;
-
-	if (value != 1)
-		return -EINVAL;
-
-	/*
-	 * We queue work instead of doing recalibration right here
-	 * to avoid adding locking to hgpk_force_recalibrate()
-	 * since workqueue provides serialization.
-	 */
-	psmouse_queue_work(psmouse, &priv->recalib_wq, 0);
-	return count;
-}
-
-__PSMOUSE_DEFINE_ATTR(recalibrate, S_IWUSR | S_IRUGO, NULL,
-		      hgpk_trigger_recal_show, hgpk_trigger_recal, false);
-
-static void hgpk_disconnect(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	device_remove_file(&psmouse->ps2dev.serio->dev,
-			   &psmouse_attr_powered.dattr);
-	device_remove_file(&psmouse->ps2dev.serio->dev,
-			   &psmouse_attr_hgpk_mode.dattr);
-
-	if (psmouse->model >= HGPK_MODEL_C)
-		device_remove_file(&psmouse->ps2dev.serio->dev,
-				   &psmouse_attr_recalibrate.dattr);
-
-	psmouse_reset(psmouse);
-	kfree(priv);
-}
-
-static void hgpk_recalib_work(struct work_struct *work)
-{
-	struct delayed_work *w = to_delayed_work(work);
-	struct hgpk_data *priv = container_of(w, struct hgpk_data, recalib_wq);
-	struct psmouse *psmouse = priv->psmouse;
-
-	if (hgpk_force_recalibrate(psmouse))
-		psmouse_err(psmouse, "recalibration failed!\n");
-}
-
-static int hgpk_register(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-	int err;
-
-	/* register handlers */
-	psmouse->protocol_handler = hgpk_process_byte;
-	psmouse->poll = hgpk_poll;
-	psmouse->disconnect = hgpk_disconnect;
-	psmouse->reconnect = hgpk_reconnect;
-
-	/* Disable the idle resync. */
-	psmouse->resync_time = 0;
-	/* Reset after a lot of bad bytes. */
-	psmouse->resetafter = 1024;
-
-	hgpk_setup_input_device(psmouse->dev, NULL, priv->mode);
-
-	err = device_create_file(&psmouse->ps2dev.serio->dev,
-				 &psmouse_attr_powered.dattr);
-	if (err) {
-		psmouse_err(psmouse, "Failed creating 'powered' sysfs node\n");
-		return err;
-	}
-
-	err = device_create_file(&psmouse->ps2dev.serio->dev,
-				 &psmouse_attr_hgpk_mode.dattr);
-	if (err) {
-		psmouse_err(psmouse,
-			    "Failed creating 'hgpk_mode' sysfs node\n");
-		goto err_remove_powered;
-	}
-
-	/* C-series touchpads added the recalibrate command */
-	if (psmouse->model >= HGPK_MODEL_C) {
-		err = device_create_file(&psmouse->ps2dev.serio->dev,
-					 &psmouse_attr_recalibrate.dattr);
-		if (err) {
-			psmouse_err(psmouse,
-				    "Failed creating 'recalibrate' sysfs node\n");
-			goto err_remove_mode;
-		}
-	}
-
-	return 0;
-
-err_remove_mode:
-	device_remove_file(&psmouse->ps2dev.serio->dev,
-			   &psmouse_attr_hgpk_mode.dattr);
-err_remove_powered:
-	device_remove_file(&psmouse->ps2dev.serio->dev,
-			   &psmouse_attr_powered.dattr);
-	return err;
-}
-
-int hgpk_init(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv;
-	int err;
-
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		err = -ENOMEM;
-		goto alloc_fail;
-	}
-
-	psmouse->private = priv;
-
-	priv->psmouse = psmouse;
-	priv->powered = true;
-	priv->mode = hgpk_default_mode;
-	INIT_DELAYED_WORK(&priv->recalib_wq, hgpk_recalib_work);
-
-	err = hgpk_reset_device(psmouse, false);
-	if (err)
-		goto init_fail;
-
-	err = hgpk_register(psmouse);
-	if (err)
-		goto init_fail;
-
-	return 0;
-
-init_fail:
-	kfree(priv);
-alloc_fail:
-	return err;
-}
-
-static enum hgpk_model_t hgpk_get_model(struct psmouse *psmouse)
-{
-	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	unsigned char param[3];
-
-	/* E7, E7, E7, E9 gets us a 3 byte identifier */
-	if (ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev,  NULL, PSMOUSE_CMD_SETSCALE21) ||
-	    ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO)) {
-		return -EIO;
-	}
-
-	psmouse_dbg(psmouse, "ID: %*ph\n", 3, param);
-
-	/* HGPK signature: 0x67, 0x00, 0x<model> */
-	if (param[0] != 0x67 || param[1] != 0x00)
-		return -ENODEV;
-
-	psmouse_info(psmouse, "OLPC touchpad revision 0x%x\n", param[2]);
-
-	return param[2];
-}
-
-int hgpk_detect(struct psmouse *psmouse, bool set_properties)
-{
-	int version;
-
-	version = hgpk_get_model(psmouse);
-	if (version < 0)
-		return version;
-
-	if (set_properties) {
-		psmouse->vendor = "ALPS";
-		psmouse->name = "HGPK";
-		psmouse->model = version;
-	}
-
-	return 0;
-}
-
-void hgpk_module_init(void)
-{
-	hgpk_default_mode = hgpk_mode_from_name(hgpk_mode_name,
-						strlen(hgpk_mode_name));
-	if (hgpk_default_mode == HGPK_MODE_INVALID) {
-		hgpk_default_mode = HGPK_MODE_MOUSE;
-		strscpy(hgpk_mode_name, hgpk_mode_names[HGPK_MODE_MOUSE],
-			sizeof(hgpk_mode_name));
-	}
-}
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
deleted file mode 100644
index ce041591f1a8..000000000000
--- a/drivers/input/mouse/hgpk.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * OLPC HGPK (XO-1) touchpad PS/2 mouse driver
- */
-
-#ifndef _HGPK_H
-#define _HGPK_H
-
-#define HGPK_GS		0xff       /* The GlideSensor */
-#define HGPK_PT		0xcf       /* The PenTablet */
-
-enum hgpk_model_t {
-	HGPK_MODEL_PREA = 0x0a,	/* pre-B1s */
-	HGPK_MODEL_A = 0x14,	/* found on B1s, PT disabled in hardware */
-	HGPK_MODEL_B = 0x28,	/* B2s, has capacitance issues */
-	HGPK_MODEL_C = 0x3c,
-	HGPK_MODEL_D = 0x50,	/* C1, mass production */
-};
-
-enum hgpk_spew_flag {
-	NO_SPEW,
-	MAYBE_SPEWING,
-	SPEW_DETECTED,
-	RECALIBRATING,
-};
-
-#define SPEW_WATCH_COUNT 42  /* at 12ms/packet, this is 1/2 second */
-
-enum hgpk_mode {
-	HGPK_MODE_MOUSE,
-	HGPK_MODE_GLIDESENSOR,
-	HGPK_MODE_PENTABLET,
-	HGPK_MODE_INVALID
-};
-
-struct hgpk_data {
-	struct psmouse *psmouse;
-	enum hgpk_mode mode;
-	bool powered;
-	enum hgpk_spew_flag spew_flag;
-	int spew_count, x_tally, y_tally;	/* spew detection */
-	unsigned long recalib_window;
-	struct delayed_work recalib_wq;
-	int abs_x, abs_y;
-	int dupe_count;
-	int xbigj, ybigj, xlast, ylast; /* jumpiness detection */
-	int xsaw_secondary, ysaw_secondary; /* jumpiness detection */
-};
-
-int hgpk_detect(struct psmouse *psmouse, bool set_properties);
-int hgpk_init(struct psmouse *psmouse);
-
-#ifdef CONFIG_MOUSE_PS2_OLPC
-void hgpk_module_init(void);
-#else
-static inline void hgpk_module_init(void)
-{
-}
-#endif
-
-#endif
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 77ea7da3b1c5..e57d843d7b11 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -26,7 +26,6 @@
 #include "synaptics.h"
 #include "logips2pp.h"
 #include "alps.h"
-#include "hgpk.h"
 #include "lifebook.h"
 #include "trackpoint.h"
 #include "touchkit_ps2.h"
@@ -393,9 +392,7 @@ static void psmouse_receive_byte(struct ps2dev *ps2dev, u8 data)
 			return;
 		}
 
-		if (psmouse->packet[1] == PSMOUSE_RET_ID ||
-		    (psmouse->protocol->type == PSMOUSE_HGPK &&
-		     psmouse->packet[1] == PSMOUSE_RET_BAT)) {
+		if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 			__psmouse_set_state(psmouse, PSMOUSE_IGNORE);
 			serio_reconnect(ps2dev->serio);
 			return;
@@ -837,14 +834,6 @@ static const struct psmouse_protocol psmouse_protocols[] = {
 		.detect		= touchkit_ps2_detect,
 	},
 #endif
-#ifdef CONFIG_MOUSE_PS2_OLPC
-	{
-		.type		= PSMOUSE_HGPK,
-		.name		= "OLPC HGPK",
-		.alias		= "hgpk",
-		.detect		= hgpk_detect,
-	},
-#endif
 #ifdef CONFIG_MOUSE_PS2_ELANTECH
 	{
 		.type		= PSMOUSE_ELANTECH,
@@ -1153,13 +1142,6 @@ static int psmouse_extensions(struct psmouse *psmouse,
 			return PSMOUSE_ALPS;
 	}
 
-	/* Try OLPC HGPK touchpad */
-	if (max_proto > PSMOUSE_IMEX &&
-	    psmouse_try_protocol(psmouse, PSMOUSE_HGPK, &max_proto,
-				 set_properties, true)) {
-		return PSMOUSE_HGPK;
-	}
-
 	/* Try Elantech touchpad */
 	if (max_proto > PSMOUSE_IMEX &&
 	    psmouse_try_protocol(psmouse, PSMOUSE_ELANTECH,
@@ -2035,7 +2017,6 @@ static int __init psmouse_init(void)
 
 	lifebook_module_init();
 	synaptics_module_init();
-	hgpk_module_init();
 
 	err = psmouse_smbus_module_init();
 	if (err)
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 4d8acfe0d82a..783201301e5c 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -59,7 +59,7 @@ enum psmouse_type {
 	PSMOUSE_TRACKPOINT,
 	PSMOUSE_TOUCHKIT_PS2,
 	PSMOUSE_CORTRON,
-	PSMOUSE_HGPK,
+	PSMOUSE_HGPK,		/* No longer used */
 	PSMOUSE_ELANTECH,
 	PSMOUSE_FSP,
 	PSMOUSE_SYNAPTICS_RELATIVE,
-- 
2.53.0.473.g4a7958ca14-goog


-- 
Dmitry
