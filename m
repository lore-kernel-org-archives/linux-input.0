Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B80B2E62B7
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720166; cv=none; b=GDrhJ2KCS46hwbPKoh8F5VZb/RUQ2KuTB17Lj0n6yO5N4yfqolGerYvW7iUWf+ACiSO6+9UF3ajcyfhOL24vzZraj+RN/+OT5USI4383r3dA/itPJxyCpNGvnu8NXgW8aRvUVLJdMw/DrFfI98o4WdMDj44I/Vuq3DR5VAP9arM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720166; c=relaxed/simple;
	bh=w60xHHDm9F8SAZ2d6EJehwap+FjePOGuUHew2BGk1MY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sw18dmamOV3KZtpyx1MzH3E7WQsVLXIBhlRsC8Qrn3nQ9WSt1kU//GZ6UUKkKmJdzFzcGirSVG50ESWPWKQuugMVmhEe455uZDWLc/DFryXCaQgzeYveBVfMsdQZgiOhlE2fh8UhK8kL5Ywek5HidacciTIrhYTYfQpWrrzmd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6mg78If; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6mg78If"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso1673036a12.0
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785720163; x=1786324963; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pinT79H7PFWF2UbBIjosXbbXUGgPnltGssDiSYyEm60=;
        b=r6mg78IfClrED0yFkVm8CpmWD5SxI9GYXTvQ7ZisiLfDEKpTGlFMAI2wP7Oi73neVu
         sXU8bXoIqHEdWv61GH/CfcUxZ1b36pKtraaZPnarsDCkTsPsE63o80v16zk5BmVxdjZE
         0d/TedcQgV/wCsmSTIBMUrPLQs3tDvmJ/v2/nbZliYBeQ2IDItBjUTHwPs9U2UP3uZro
         qLApBVw7dVr1bp9R1dIBRf/NDI9QuDKf5b+P/C2BGJ5aD0xXKenqyJF/wmvKZNSfx/k7
         55MPwYgLJQ6NW1DnIWP8SjRq7TUcZRLY0kbxLrcVsXMzv/tmzRnImUuwhG29X0zO0E8z
         vsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785720163; x=1786324963;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pinT79H7PFWF2UbBIjosXbbXUGgPnltGssDiSYyEm60=;
        b=EgfvOl/dlkZdiWvfPPMuPIE/DfA59W9UOGNSQ3Vjw+PIOk9wsiI4kpUuTcidPfEfx6
         VeXn7ymBifChJ9E566Hf26rOa5njtbn9Qla7keIk4kMxwEs+74b1vy8Hw895AstPt77Q
         V5MFj7wys5SIPJYJtNYn4JIGTBK+waWi+6v88p/jnJ/CGe8HCkThWsBm++MPD2+Z005j
         cklX/rTjuqk3Zep7dQL0xVRPf4/skYXcDVVMopN0LwyfGrWUW30QUvtkY63Xt1FphXf5
         7KtliZ0NMaR83m0jGTC57CAdWOO7SkoKM5CcALix4ID5TUhEYkKeHH0lvxJbvllZ+cPt
         6ZQQ==
X-Gm-Message-State: AOJu0Yw3tc6yj3EzM148jeTePh0o2xsXqQcM8040GtvypW2gIlfMJJSF
	mhHoCOKdrXtb3WntguRH238jHHWcE+BLomhthT37NfnnbZojcjZUPzsCXzkvzw==
X-Gm-Gg: AR+sD12WBvovCwo9J3FkhyAJ+oh5FiZ1clE3IjE1k/UT5LbMN+o7k0clbRaYvfcwksa
	8Zy5fL0fDh4VJ84FXmaiiORZ6tPncPtp5sUrbKWz3adJHvuuX/WxCfJ4KVCy9KpPczogTRn1kfy
	hwiZJl5Q9RSvT6FTII0wN3S9Q3TZC9y9Ftyx8cfTFnlI3x2katBwfsZwL6SEbhU0qYC5unsikyw
	2x/+/WsbkO7PX7UnnYTNF0X9X4IEhbtOF2q/oi8qXoC7pLAZ2J7/HpfK54ypvC/XU9uY3I9b+9L
	s0eBIATnkrq0kNkGzWaAq4Da/QgZyXjuWdyt4NHZrVWaznAyRQnEkoSgcB8T1A62CQk7UXzXb47
	fi+QBoEL3IhoI0Ybk8vUVDV2r/C7KzcZQ8IwaGArsguZnNbxL7ftusaMQyLOQ9Rui9z4ycVi02E
	wW/vTGQMmVa9rjyCUDj+M14r9GXlJEPLcKArf1x2r9mwI4WpB/1UHFtonBCYPPJ4lvmW1hFmZSK
	hp8O9bGEMH8iI3h6KwZIQb+6o839Q==
X-Received: by 2002:a05:6a21:3390:b0:3c4:3ada:384d with SMTP id adf61e73a8af0-3c92a57baf2mr7063094637.30.1785720163372;
        Sun, 02 Aug 2026 18:22:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153db2f911sm35037247eec.0.2026.08.02.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:22:42 -0700 (PDT)
Date: Sun, 2 Aug 2026 18:22:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Richard Davies <richard@arachsys.com>, 
	Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: focaltech - use signed coordinates to prevent
 underflow
Message-ID: <am_tH_F938rK6ask@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

focaltech_finger_state stores finger coordinates x and y as unsigned
int. When processing relative packets, negative deltas can cause
unsigned integer underflow if the finger moves past the left or bottom
boundary of the touchpad, wrapping the coordinates to values near
UINT_MAX.

When clamping the coordinates in focaltech_report_state(), these
underflowed values are clamped against priv->x_max / priv->y_max instead
of 0, causing the cursor to jump erratically to the opposite edge of the
touchpad.

Change the coordinate variables and limits to signed int so that
negative values resulting from relative movements clamp correctly to 0.

Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/focaltech.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index d3ad4af5aa09..c6f6540e3e29 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -78,8 +78,8 @@ struct focaltech_finger_state {
 	 * Absolute position (from the bottom left corner) of the
 	 * finger.
 	 */
-	unsigned int x;
-	unsigned int y;
+	int x;
+	int y;
 };
 
 /*
@@ -108,7 +108,7 @@ struct focaltech_hw_state {
 };
 
 struct focaltech_data {
-	unsigned int x_max, y_max;
+	int x_max, y_max;
 	struct focaltech_hw_state state;
 };
 
@@ -126,14 +126,14 @@ static void focaltech_report_state(struct psmouse *psmouse)
 		input_mt_slot(dev, i);
 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
 		if (active) {
-			unsigned int clamped_x, clamped_y;
+			int clamped_x, clamped_y;
 			/*
 			 * The touchpad might report invalid data, so we clamp
 			 * the resulting values so that we do not confuse
 			 * userspace.
 			 */
-			clamped_x = clamp(finger->x, 0U, priv->x_max);
-			clamped_y = clamp(finger->y, 0U, priv->y_max);
+			clamped_x = clamp(finger->x, 0, priv->x_max);
+			clamped_y = clamp(finger->y, 0, priv->y_max);
 			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
 			input_report_abs(dev, ABS_MT_POSITION_Y,
 					 priv->y_max - clamped_y);
-- 
2.55.0.508.g3f0d502094-goog


-- 
Dmitry
