Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838346EF94
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248999; cv=none; b=Jk1dB62ZDSV0l2oHgTrn7jRcGOAUg67HKyU1JpvfMAzhmpL0DwR5723D8V8p01FLy16KpSYp6AevjQsaQS1RtpEbjA4/LecokKGMZreIB8qhWftjQz9DX+7XMla8SFUykW2DUQVdvNABtdfKkmeaRvjRWgH3ATc2+CXzVdL26Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248999; c=relaxed/simple;
	bh=rlbm//2B5OdqBjqqr608z7OgF45U9aPq6hwy3/UJHTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMtGBqZKvDG30R4nnQtodH/bbOJU8ECVKI+UZuCSrhZFN6BbAXfYUMnyxXRTPPunYRJ9/atYYOwPCtoSk1rkCWLUHn2D/gf9smb25M9KNKx4pSQGbKa5pKE5iE6V/xe1MWtui72nTaa0JRP5KLRLwGT6D71A2qI/ClMX2KFvCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VBP/nchK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VBP/nchK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d9004f39d3so27644615ad.2
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 00:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788248997; x=1788853797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppTKN+ViX0ps4m1x8WbWgM6kLhXVltmE87oNPgspGL0=;
        b=VBP/nchKDZDalaoDZl/c3b3OHY3d9H9nDT0Ay8vR+0iR1ALVod1jsqaIQNBBtzbhWJ
         DMKJdyyEGJu6HMQ1AsWQR18Afjekvsm2nTRKHXPTyuXgJ1akYTXyO+Rexjpef19azrzq
         D5jCSe0A+6GJu5CmP8ephOuFZNMJ4XzTFWp4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248997; x=1788853797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppTKN+ViX0ps4m1x8WbWgM6kLhXVltmE87oNPgspGL0=;
        b=Puz+0/vEHHSJY/qp8/9X9kK0Vx4G7xt3DiTjD4JGVGri1x2x+n9ol4rYajL0o3B7Y7
         JnGxbYedslj9FqDSa3GcifYZTSz1ZPKQtLkv/el5d29H4+XpyHT1fKYSoVZfnhmZxChp
         80MNW/ygddhxokK4GSUTD2ZNEGAOKQONdi4HyiJQl3RubJtLPNq+NJQ6gpQhRSETToKu
         9yNJEDQ9HSq0iw1UTMWpaKlQ39M9o2FH4oLStVv7RnzdrY5TCdsM7qNnvU739qlql6vG
         xAOl2Nu7MTVOUY0Tkt+DVnx9s8T6o600anMgCh16TbfhDYW89dsOsgN5ep16C/Sgt4Vh
         dRWg==
X-Forwarded-Encrypted: i=1; AKwUvBzUb67wakjweTg6dYnp1AnbYizFQwUnCTY6nSCUcepe4GDQ5Qkak9r5CqbMzO04HIZSpBufLDtPg/inMg==@vger.kernel.org
X-Gm-Message-State: AFuF++kb8hTDVfP4+lo6bi5HeQamqYxTrvM6eVd+5HkiN4ff8RracMg6
	eWw3t2EJ1lGi1JWk7Rgoqy6BtcnsgaBHQCmFYfthUa1KNVZ0qJAhg3MBCf+4MFxe8Qr/QoTTI85
	6SeU=
X-Gm-Gg: AYBFou3uZ0r4WLHe+YNGCkGPMCQ+BOZ2QGFDEj58LlxMyPOLRR3w8RflmRl0Cblk6Ox
	SGD87Yb+WorO1IQY9hCiIriHmxhQiRZtS7h9SEeufQeUKK0h6qAaZEUbNnf+BgKztoqtGsP5EuZ
	B4UYA9BQGPF3u3dcyY80JW99YK9vZ7ET3YIfnrPXzUgFnx0CkxEiI+4xr9jF1mt6BvtpsnAy4qw
	V0BvF893z+fyTvijJ1P6Ajvyld06PI9yQnsDeHdZ01cQ7gPEuzW7ZSAp9NjbWFhz0C3oAg7MGe5
	KLUoaUYYyy3C+1EELHhOfIuh9gLwZ189cj6p4/O6M0Z5I5Hmvr97zClKIOfCFjGHrwS8nHmlWgB
	08lX+02FtcgcC+DgcqrzhIjScNoz4EPyP8qpxs83ybU4Nv6w1UT/BQ/Y/Tis9S5tYdG0GQFX/yt
	ehge7+Vp6UI8N8cekz8kXHuoE1q4hJDVNhawtogsO3FBbR1uI+pyxRUzVJpng+8LWU3ZJ5FsFfD
	4bXfj0jbcqpQfJRGbHPrZd3Y2rt2mwYF8w0QUkP4EIyWmQ=
X-Received: by 2002:a17:903:3883:b0:2d9:216a:cdd3 with SMTP id d9443c01a7336-2d94a93609cmr90196685ad.18.1788248997383;
        Tue, 01 Sep 2026 00:49:57 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com ([2a00:79e0:201d:8:8cf:6df0:9c4e:f5e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988b699sm48142515ad.59.2026.09.01.00.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:49:56 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable+noautosel@kernel.org
Subject: [PATCH v6 2/8] Input: elan_i2c - Wait for initialization after enabling regulator supply
Date: Tue,  1 Sep 2026 15:49:20 +0800
Message-ID: <20260901074930.764550-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260901074930.764550-1-wenst@chromium.org>
References: <20260901074930.764550-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Elan trackpad controllers require some delay after enabling power to
the controller for the hardware and firmware to initialize:

  - 2ms for hardware initialization
  - 100ms for firmware initialization

Until then, the hardware will not respond to I2C transfers. This was
observed on the MT8173 Chromebooks after the regulator supply for the
trackpad was changed to "not always on".

Switch to the new regulator_enable_and_wait(). This makes sure that
enough time has passed since the regulator was first enabled, satisfying
the power sequencing delay requirement. This allows the delay to be
skipped if the regulator supply was already enabled by some other part
of the kernel, such as the I2C OF component prober.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Cc: <stable+noautosel@kernel.org> # needs new regulator API
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- Added noautosel tag

Changes since v2:
- Switched to new regulator_enable_and_wait() API

Changes since v1:
- Delay only if the regulator was previously disabled / turned off
- Link to v1
  https://lore.kernel.org/all/20241001093815.2481899-1-wenst@chromium.org/
---
 drivers/input/mouse/elan_i2c_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5e505edbc33..4bbc6cef8be6 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
@@ -47,6 +48,8 @@
 #define ETP_FWIDTH_REDUCE	90
 #define ETP_FINGER_WIDTH	15
 #define ETP_RETRY_COUNT		3
+/* H/W init 2 ms + F/W init 100 ms w/ round up */
+#define ETP_POWER_ON_DELAY_US	(110 * USEC_PER_MSEC)
 
 /* quirks to control the device */
 #define ETP_QUIRK_QUICK_WAKEUP	BIT(0)
@@ -1260,7 +1263,7 @@ static int elan_probe(struct i2c_client *client)
 	if (IS_ERR(data->vcc))
 		return dev_err_probe(dev, PTR_ERR(data->vcc), "Failed to get 'vcc' regulator\n");
 
-	error = regulator_enable(data->vcc);
+	error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 	if (error) {
 		dev_err(dev, "Failed to enable regulator: %d\n", error);
 		return error;
@@ -1416,7 +1419,7 @@ static int elan_resume(struct device *dev)
 	int error;
 
 	if (!device_may_wakeup(dev)) {
-		error = regulator_enable(data->vcc);
+		error = regulator_enable_and_wait(data->vcc, ETP_POWER_ON_DELAY_US);
 		if (error) {
 			dev_err(dev, "error %d enabling regulator\n", error);
 			goto err;
-- 
2.55.0.897.gb25b4bd76c-goog

