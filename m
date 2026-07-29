Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B19346AC5;
	Wed, 29 Jul 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366199; cv=none; b=FGbPasgl8qesgzZoBDG/sDJIyZXzPx7B9MBYZYrKb76Rzy7WYnOUWbz3mSHeUX3SXFrqFZyWkBT8CJBvEaYssgZTAk+tnzR954kIVbzqlasiaCqwL/pTFPZ3TWtyMWBBAM8ptFktPBLq/E9A/6reEGn9aMK2vbdK66s+7pyvTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366199; c=relaxed/simple;
	bh=9COC2foR8iEM96eCf+Fh3xatOuIfLIPumEcKTD/v3Is=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pT2BdOV6OvwUy/3n22QN+AWOrsg7fqApg0ETa98NkYwrh4cu3VRqOn5e/vJ9eMNHS0ah4bdojCJ6rP/mI1EhGIfpNbwGPh/yRuPsASG/ZHn1k3RZe21CkFVvadrAZNMS9M1TEuZRA8ay4aah0oScfqBKtSeIqignezUoDg8fllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org; spf=pass smtp.mailfrom=fastmail.org; dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b=p42QFEsX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2lLcjBp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.org header.i=@fastmail.org header.b="p42QFEsX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2lLcjBp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFC647A044D;
	Wed, 29 Jul 2026 19:03:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 29 Jul 2026 19:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1785366195; x=1785452595; bh=4e9NAo2+gK2NcHne44+NqZz/A2+bMnU4
	21a+tpJj74c=; b=p42QFEsXEvoFpw9wKtqmJtrfWcONX7UrEPqn4zd3BVYEJOrL
	KNzX00bRAn6C66ZF1RYiJip+T6rnliui6PG/xd9TQvGA3h8UaqRQgVmyckiu/+eM
	H8HcjN3D1ZCc2YtRI3UK+5Aek3ePDac7PVORtrDApz19gJLERIXgUZB1SB8KWuFA
	Mw5BH20fD5YC98RxY61StfwZsyV/vz2YANptGqH3Nc/fjgD1icomcrTOCLVBuffZ
	3FubXjIpziavNOm8F6HVYQExl9wDKtJDdcYo93ruJDLPhygwsmooDbdPL+4++yNJ
	QtbOSAoX3m3zmUF2ak9B2kPXXpik2SufwzzE5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785366195; x=
	1785452595; bh=4e9NAo2+gK2NcHne44+NqZz/A2+bMnU421a+tpJj74c=; b=i
	2lLcjBpveaZr8En/FRK0c7SvucUYTpXr6FAo6I6eInCAki1+KAGeCxB6SPhZRTsw
	lWv9lr/KTHYuvhx9JeQel2DPnbqfc8CFxUm+tpxLOO/OZ7Qe8wxtc/PQbSC0voMX
	CRaX5iDVsc+XuKv+Yiy0u8CLB4e9/tlaP4WEWMMqq4KByMZRgkzphtXLZ2lqrJqP
	nxJifvqZgHWjqmI2ix2irUs5WKpMc6vVXNQTLDYJzr5O72RIXQLV22Lqmz0t6CFM
	Pv/J/MfJk0PKOAydWaiGM+NFuNDCDXdn4CkvYhczrm/o7MPVn9j2nayjatYKEpCr
	eQSKm/XwlUftdurXRANfA==
X-ME-Sender: <xms:s4Zqar2x7oBHLuTHHCs8pyS0YGJ-yln8USJhNnuOsQiQb0ghLybs-Q>
    <xme:s4Zqan6JrfIZ-aL1speG344zTqpRFrTGgNLNpNKF3n1n8fITuYQ4UOPcwJqbcI1m9
    mqPMUKSuZ26cAk6p409a3lZJDIEJZb6AWgYkid2V_AuD9pDoUfaS1Iw>
X-ME-Received: <xmr:s4ZqamX00-6D5rpFyHaCoSRRf4VQ4jQ2SXNXUKcKi8H_S-6hbMRwwj3Wx4c>
X-ME-Proxy-Cause: dmFkZTEvjTfT3TEtsR/jTgCObJiAIWsRdgTygop3Ct92NPCCtPS0XNdp47DoTtrhlyxTa4
    hhFO1XGKYvho88Y/8yru7np4bKwyxOr+K+QktD796fgxqCfh3ydODxaKzKKrUAzT6Cz+cB
    bcFm0sRywTGlcjUhxvcGq/x1o0ZKdiBarI+gngUam34UwLPr4DR97ZrXX9v9jbiwT6V2xT
    X+hDIlhitODtz+UNx3nH+ztOvuH7iBepIX00cOczsfwirQ8+BUJqrwy1+ZY0pQ1lPvHwSy
    1dnSnUFSTt3cA1v9K513e6aP5MjXWBbhcBJ2TPxomRc1+8Zp7r+GjR3ol9YzEUFgoE8pfD
    +tBZf9r1SbjlyLcrIXak/eNbGM6TCEWweY9iGFKfzdMsphtz4YiLWUKCOl0mCgHuGEB1fz
    T91PqUcw9sYOnIYQqxmt47M55b4HqQ6lJt6g2o2YlIhT73jQj0setnSAfU01UM57IQ5MXu
    mK3jG5NQmAbtZA2p0eTPVIPdzOqvLXJK9ZvZDLw9vbtF6zwiHWs1ZkUqMRt7P/ZDMlUp3f
    ZoxyV9tOacPmc+p3CDjNpKoISTpVPfilY6vuzhvqLY49AZt2DniNr/Fd1nY1SHJ4f+EjTP
    zT00zyhPYhn2VEJGCj6zqhv9uyuBqu9VUWABrDlPUIIHp/p5e3Qw+JvYrOaw
X-ME-Proxy: <xmx:s4ZqauAahE_Lf9xXni8-QuBZRol4hfO_h5MObJtFYnwPL3FAI_r4ZA>
    <xmx:s4Zqat7EzxmOHJ-Lkd8zSYRASqoW0LN6Ja1cZ0588AREA6PZrL0J_w>
    <xmx:s4ZqahwtK8Q3EDcm-W0LIlZblEKQvgKYeNeOBD75vYPjmgz4Cqb-dA>
    <xmx:s4Zqaszvy9E_u61Koi_vLRjTW1kHq5KOSg_3JLy3O4WK1HIuLrzX0g>
    <xmx:s4ZqahwVatBVP0mZm0TItiRI36IUQ2DdEhSgVFaix9IcY12sRngyVIeQ>
Feedback-ID: ib53e4b78:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 19:03:15 -0400 (EDT)
Date: Wed, 29 Jul 2026 18:03:13 -0500
From: Ian Bridges <icb@fastmail.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH] Input: wacom_w8001 - compose the device basename in one place
Message-ID: <amqGsb0A6_dr9JLA@dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The device basename is assembled by appends spread across
w8001_setup_pen() and w8001_setup_touch(). Each append restates the
buffer and its size.

Record the touch name suffix in struct w8001 beside the other probe
results, and compose the whole basename in w8001_connect() with a
single scnprintf(). The setup functions lose their buffer and size
arguments, and the append helper is no longer needed. The produced
names are unchanged.

The single compose point makes the possible length of basename
visible to the compiler, and the pen and touch name writes then trip
the format truncation warning. Write those two names with
scnprintf() as well.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Link: https://lore.kernel.org/r/20260716103236.28c1b5bb@pumpkin
Signed-off-by: Ian Bridges <icb@fastmail.org>
---
This is an optional cleanup on top of the already applied strlcat()
removal. That patch resolved the unsafe calls. This one only
simplifies the result, following David Laight's suggestion in that
thread. If the churn is not wanted, no action is needed.

The suggestion was to return the name from the setup functions. The
functions already return error codes, so the touch suffix is
recorded in struct w8001 beside the other probe results instead,
and the pen suffix follows from the error code that
w8001_connect() already has.

The patch was tested as follows.

- W=1 build of drivers/input/touchscreen/, zero warnings.
- A differential harness compiled the applied code and this patch
  side by side and ran both connect flows against identical
  fabricated query replies, exhaustively over the device state
  space. The composed names, return values and id assignments were
  identical in every case.

 drivers/input/touchscreen/wacom_w8001.c | 42 +++++++++++--------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index d8d1cdc3f09e..320ef8ddb331 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -94,6 +94,7 @@ struct w8001 {
 	char phys[W8001_MAX_PHYS];
 	int type;
 	unsigned int pktlen;
+	const char *touch_sfx;
 	u16 max_touch_x;
 	u16 max_touch_y;
 	u16 max_pen_x;
@@ -417,15 +418,7 @@ static int w8001_detect(struct w8001 *w8001)
 	return 0;
 }
 
-static void w8001_append_suffix(char *dest, const char *suffix, size_t dest_sz)
-{
-	size_t used = strnlen(dest, dest_sz);
-
-	strscpy(dest + used, suffix, dest_sz - used);
-}
-
-static int w8001_setup_pen(struct w8001 *w8001, char *basename,
-			   size_t basename_sz)
+static int w8001_setup_pen(struct w8001 *w8001)
 {
 	struct input_dev *dev = w8001->pen_dev;
 	struct w8001_coord coord;
@@ -460,13 +453,11 @@ static int w8001_setup_pen(struct w8001 *w8001, char *basename,
 	}
 
 	w8001->id = 0x90;
-	w8001_append_suffix(basename, " Penabled", basename_sz);
 
 	return 0;
 }
 
-static int w8001_setup_touch(struct w8001 *w8001, char *basename,
-			     size_t basename_sz)
+static int w8001_setup_touch(struct w8001 *w8001)
 {
 	struct input_dev *dev = w8001->touch_dev;
 	struct w8001_touch_query touch;
@@ -505,19 +496,20 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 	input_abs_set_res(dev, ABS_X, touch.panel_res);
 	input_abs_set_res(dev, ABS_Y, touch.panel_res);
 
+	w8001->touch_sfx = " Touchscreen";
 	switch (touch.sensor_id) {
 	case 0:
 	case 2:
 		w8001->pktlen = W8001_PKTLEN_TOUCH93;
 		w8001->id = 0x93;
-		w8001_append_suffix(basename, " 1FG", basename_sz);
+		w8001->touch_sfx = " 1FG Touchscreen";
 		break;
 
 	case 1:
 	case 3:
 	case 4:
 		w8001->pktlen = W8001_PKTLEN_TOUCH9A;
-		w8001_append_suffix(basename, " 1FG", basename_sz);
+		w8001->touch_sfx = " 1FG Touchscreen";
 		w8001->id = 0x9a;
 		break;
 
@@ -541,7 +533,7 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
 
-		w8001_append_suffix(basename, " 2FG", basename_sz);
+		w8001->touch_sfx = " 2FG Touchscreen";
 		if (w8001->max_pen_x && w8001->max_pen_y)
 			w8001->id = 0xE3;
 		else
@@ -549,8 +541,6 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 		break;
 	}
 
-	w8001_append_suffix(basename, " Touchscreen", basename_sz);
-
 	return 0;
 }
 
@@ -600,7 +590,7 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	struct w8001 *w8001;
 	struct input_dev *input_dev_pen;
 	struct input_dev *input_dev_touch;
-	char basename[64] = "Wacom Serial";
+	char basename[64];
 	int err, err_pen, err_touch;
 
 	w8001 = kzalloc_obj(*w8001);
@@ -630,16 +620,20 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	/* For backwards-compatibility we compose the basename based on
 	 * capabilities and then just append the tool type
 	 */
-	err_pen = w8001_setup_pen(w8001, basename, sizeof(basename));
-	err_touch = w8001_setup_touch(w8001, basename, sizeof(basename));
+	err_pen = w8001_setup_pen(w8001);
+	err_touch = w8001_setup_touch(w8001);
 	if (err_pen && err_touch) {
 		err = -ENXIO;
 		goto fail3;
 	}
 
+	scnprintf(basename, sizeof(basename), "Wacom Serial%s%s",
+		  err_pen ? "" : " Penabled",
+		  err_touch ? "" : w8001->touch_sfx);
+
 	if (!err_pen) {
-		snprintf(w8001->pen_name, sizeof(w8001->pen_name),
-			 "%s Pen", basename);
+		scnprintf(w8001->pen_name, sizeof(w8001->pen_name),
+			  "%s Pen", basename);
 		input_dev_pen->name = w8001->pen_name;
 
 		w8001_set_devdata(input_dev_pen, w8001, serio);
@@ -654,8 +648,8 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	}
 
 	if (!err_touch) {
-		snprintf(w8001->touch_name, sizeof(w8001->touch_name),
-			 "%s Finger", basename);
+		scnprintf(w8001->touch_name, sizeof(w8001->touch_name),
+			  "%s Finger", basename);
 		input_dev_touch->name = w8001->touch_name;
 
 		w8001_set_devdata(input_dev_touch, w8001, serio);
-- 
2.47.3

