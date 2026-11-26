Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661028;
	b=TT9fFRRe5wyOHqBEG9hpCn8x30JYbOmDrM3bxqRGuxNh+5J04kHkSeanc+G0ZPy9DYSm
	 0fSHdShM7qYOMjzvHdrbkYZSndIImSGr733d1iz643giqe1c86bJjH6kgBtwQMIg04AwP
	 Njko51oOcAdLNwpstEUkaF9n7evoSJLgBvq+htS3msFf6j6hmOVbuiCjT0Ld/3spOkimK
	 VBN1/BKyQ8V7s+bSNq+dJBkkMcacDHtqjdLWrqRRFviPdLH5xLC2aoA3EG7ySyEfs5N2P
	 HwE6XP4lHicRMHS0IDa0udiw+XVC/ZZemANEpxzhxIVtqJe9pYdw/NnQE+Pv4h9Fu0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wlB0rbo2aRHGXw7eVLnZ6xPO6friQTpYCVcGasiGcT4=;
	b=jRRjURz04TkESimj5a1WiSHNWMg08gv5jHAAMARqwv2bqN70468b3BCeQBbrz042KqXp
	 UMr+hjpWenfSRmIoLYswLa8YbmnCnwVE3g5EC1YXRLLXr63+gpPGLlbiix1jIj1uqgIXg
	 oVY7ttbs/1tighi5fSTNOndROavnSyn9GxdLKIuRR7B6pmXxTs1wBpjXI2Dzkjr2M+hYn
	 wqrxl3DtaxWtancwnbztNuO7M7+B95aTwSidHa2VafwkINiz7TkzT74nzchtKcV7ayGCu
	 Hv3XvAL0Bk8occEOexliM8yHu+OFUwHWpXJ2ZfBUJpbkxQDq9pnM12xka42Hbjo/CHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--svv.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jz4NK4DJ;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64A606A33D
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 02:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F64A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jz4NK4DJ
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386a0f79047so6894180eec.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 18:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795661027; x=1796265827; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlB0rbo2aRHGXw7eVLnZ6xPO6friQTpYCVcGasiGcT4=;
        b=jz4NK4DJXBmQolbmhPdIrhh8SREy/rLdKzBNoXmGmylMmaSll/nWJb3IGnFwXe/iK0
         UB3xgtzp0xuFPSvEnRrCE6JozFN7BgkFYG2npatues7UdMYvzr0FwLK/VqCTP69ERr6u
         yqZOhk71A5Ed4bx3YIGbBbdrlRtZHvrQbUtn9a0Ye7f6pqFpqVhbCZrusvZKUCZT1hj4
         jgCWoMvlDyVqYHPDbCNBEuRb8Cc5fU3/pR32Y13hbiIIXuioabI5YK7ES45UQt19RD9k
         qIdQmzUVbIXe2DJJLSQ5tc4garDc/bMNP65QkTg5MqCxp9q3OXVIPW37lbE+LuXbazDT
         tfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661027; x=1796265827;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlB0rbo2aRHGXw7eVLnZ6xPO6friQTpYCVcGasiGcT4=;
        b=QV+zHYwvbdSiRSlLbHRrB9gLmEsg5gU8RWWx08/uc7KiGndDm30kb1CqtPMo3WFngE
         Fg0QteRdSAKAIpXd2XbhZQ5Tkw4gVkC9Mj4vKCZ+TkdsgtbDvUKWeWgMeyM0h6duQwRJ
         MaDCDR6cZhBLaYis/91QObuMZmS5ZJBZlfo+yQf+2knW9vZd7EYhBXSNptnWfqOUemBZ
         wjwTtUG1g4Ge5fkZBA+HwPUwxqB5moEYk8JzfQLR+2N314UZi7Ov6dECwP3yWMZUQFII
         M4Qg76SPeEpISUDxJLsiLllIamuDvjpvtDzfnpGjqySLknAAo9JcuukYwl8m9QMaV44n
         vMSA==
X-Forwarded-Encrypted: i=1; AL+hErEAfUT2DUhlqcrHUAY+IGuK2QZ4IW4ScBz3+0x+2k9TfoiZjr1sHCt0IYTi+a6Hd5Sj8hHRd2Mym4wBQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WlpiQ1dvVjKlA8998Z8jNdVvewh/sc0q5/1uSXRU4IVhQDoGO
	CBLP/oRh4qFWgz8sh7n9hE+wCrdZsm1j1bgFLNHEMVvUP3DQCqrzr1WOZzv/4wqrdz3INA==
X-Received: from dyrp20.prod.google.com ([2002:a05:693c:69d4:b0:386:b61f:b88e])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:6010:b0:382:105f:e7e
 with SMTP id 5a478bee46e88-3857170e441mr24867685eec.36.1795661026952; Wed, 25
 Nov 2026 18:43:46 -0800 (PST)
Date: Wed, 25 Nov 2026 18:43:35 -0800
In-Reply-To: <20261126024337.4168845-1-svv@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126024337.4168845-1-svv@google.com>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
Message-ID: <20261126024337.4168845-2-svv@google.com>
Subject: [PATCH v2 1/3] Input: add ABS_TWIST event code
From: Siarhei Vishniakou <svv@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jason Gerecke <killertofu@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

Some styli can report the rotation along their long ("barrel") axis.
This is typically referred to as "twist".

Unlike ABS_MT_ORIENTATION (which describes the 2D alignment of the
contact ellipse on the surface, analogous to stylus azimuth/tilt
projected onto the surface), twist captures the roll of a tool around
its own longitudinal axis independently of tilt or azimuth.

In the HID usage pages, twist is already supported as HID_DG_TWIST
(0x000d0041). However, this usage is not reported to userspace via the
evdev interface today, since there is no MSC_SCAN equivalent for axes.

Peripheral OEMs get around this today by mapping this axis to other axes
like ABS_Z or ABS_RZ. This is not a valid way to report twist.

As a result, userspace programs that would like to support twist must
account for the various ways specific OEMs map this, since there is no
generic axis for this.

Unify this behaviour by introducing a new axis, ABS_TWIST (0x1d). This
axis applies to single-pointer devices (such as styli), as opposed to
per-slot multi-touch devices (which would use an ABS_MT_* axis).

Document ABS_TWIST in event-codes.rst with its value semantics:
clockwise-increasing when viewed down the tool's major axis toward the
surface, 0 aligned toward the top (-Y, north) of the interaction surface
matching HID_DG_TWIST, supporting either non-negative [0, maximum] or
signed [minimum, maximum] full-revolution ranges, and resolution in
units/radian.

Signed-off-by: Siarhei Vishniakou <svv@google.com>
---
Changes since v1:
- Moved ABS_TWIST directly below ABS_SND_PROFILE in event-codes.rst
  (Dmitry).
- Expanded event-codes.rst documentation with precise value semantics:
  clockwise-increasing direction viewed down the barrel toward the
  surface, 0 aligned toward the top (-Y, north) of the surface,
  non-negative [0, 360) and signed [-180, 180) ranges, wraparound
  behavior, and distinction from ABS_MT_ORIENTATION (Dmitry).

 Documentation/input/event-codes.rst    | 23 +++++++++++++++++++++++
 drivers/hid/hid-debug.c                |  1 +
 include/uapi/linux/input-event-codes.h |  1 +
 3 files changed, 25 insertions(+)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index 77a6c9b3956d..4f03dcacbd55 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -247,6 +247,29 @@ A few EV_ABS codes have special meanings:
     An event is emitted only when the selected profile changes,
     indicating the newly selected profile value.
 
+* ABS_TWIST:
+
+  - Used to describe the rotation of a tool (such as a stylus) around its own
+    major (barrel) axis. Unlike ABS_MT_ORIENTATION (which describes the 2D
+    orientation of a contact ellipse on the surface), ABS_TWIST reports the
+    tool's roll around its longitudinal axis independently of tilt or azimuth.
+  - Values increase for clockwise rotation and decrease for counter-clockwise
+    rotation when viewed looking down the tool's major axis toward the
+    interaction surface (e.g., from the eraser end of a stylus toward the tip).
+  - A value of 0 corresponds to the tool's neutral reference orientation (e.g.,
+    its primary barrel button or flat edge) facing toward the top (-Y, north)
+    of the interaction surface.
+  - The range reported in struct input_absinfo may be either non-negative or
+    signed. A non-negative range ([0, maximum]) covers [0, 360) degrees.
+    A signed range ([minimum, maximum]) is centered at 0 and covers
+    [-180, 180) degrees.
+  - Unless the hardware only supports a restricted angular range, the
+    [minimum, maximum] range spans one full revolution and wraps between
+    maximum and minimum.
+  - If the resolution is non-zero, the twist data is in units/radian. If the
+    resolution is zero, userspace may assume the full [minimum, maximum] range
+    represents one full revolution.
+
 * ABS_MT_<name>:
 
   - Used to describe multitouch input events. Please see
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index f44e6e708404..2e9ff8a3b2cf 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3518,6 +3518,7 @@ static const char *absolutes[ABS_CNT] = {
 	[ABS_HAT3Y] = "Hat 3Y",		[ABS_PRESSURE] = "Pressure",
 	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
 	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
+	[ABS_TWIST] = "Twist",
 	[ABS_VOLUME] = "Volume",	[ABS_PROFILE] = "Profile",
 	[ABS_SND_PROFILE] = "SoundProfile",
 	[ABS_MISC] = "Misc",
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 4217950e5d16..d4ed115fdeca 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -892,6 +892,7 @@
 #define ABS_TILT_X		0x1a
 #define ABS_TILT_Y		0x1b
 #define ABS_TOOL_WIDTH		0x1c
+#define ABS_TWIST		0x1d
 
 #define ABS_VOLUME		0x20
 #define ABS_PROFILE		0x21
-- 
2.56.1.911.g883d8bcb20-goog

