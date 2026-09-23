Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA73D890C
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187261; cv=none; b=EDBi+qhTfvEhxVXdiYEs61jZ3+YpPVq3X3luq72cQQ9nIemNMMaQ/lol7SZd9HLQ9rmPQ1MFfGQ7tZ514lIvcqRi1HEU2Xd/5Ok0bMKoZfxaqpFV24RkA+PyyxKspd6aT9CuxiedTRbwPqb+PLT4g5ruW05prVcH1tW8HsoFvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187261; c=relaxed/simple;
	bh=NoYTdwxwn+++VlSqYDmNkTbGe8sVLyF98wvRfV4aZr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbOhMQL7BKnyFqqFtUX5mK0NvrTH39TdDdFJi9bGjGGmj1pKNMLAhEM9nVIl+49IhOCOVK3GwIFrFb/28Qt2AxTloqBvEuZJ+eDgotP5XbXeuqC/pmdOLvRZoHqCmrsVW9s6UQuqts+mRKDDPC7O5/3hszXf2ZXfPyHE1vN9NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daLc1ivM; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daLc1ivM"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4858bc96fabso1092256f8f.3
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790187244; x=1790792044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fkORU3gh/MDLpHIFia2dyxO/HqIPBw2hOdFlH/z2RPg=;
        b=daLc1ivM8Lac88tYJsbt6TEpP2R1ZLbolFtdlpp0wSYnxGbBvd7IF5M39lcv3SLnLP
         36KEvz16fAprr2EcctZLsn7IdqmNEt4QNoc2Hy1qOIwZ6WTXXAbUNxuWhwq9k4SHZc0W
         TArLvkQFVwjOvsGJ611XK9m9pnPA3M8lHRF7J+CsvAVZ6mrodXjzeLE90PqcWd5Hs8Eu
         ZBVNZJleeiOarrH88nwwZWg3OKVY/4liFaItd80wBtfJ2KVOrnnZ2A4JI7xHrlyn2xvt
         beFnK7q6zrcX+jU/RWsW/IInOfBtmUadTB/DuFfl05gI+gRHZ38BsMUddgFW0fdINEQp
         UkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187244; x=1790792044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fkORU3gh/MDLpHIFia2dyxO/HqIPBw2hOdFlH/z2RPg=;
        b=WL0G6UZo91TNEI2hAQhFZjJyIatYhjMVEz8FbKbtSQB0ZX0hhO48AHMqU4jlB4XF6O
         MWYZOAAiuavUrUgNTcesKYZzQy3RJMwJcSdb/XOWZ/9TGCfFYdpJyeRmZejORUqv66zw
         beUVT2a3WvmPCQndNjUiqvteFod/t+tQRMXSJG7wFHGdR1RScyAqtc/KacIJ8AgP/EtV
         g92PddbGExLVyn/460VAw/N6uo5oDT5dVAODCHF7KPRgzK3w8WUxZXaNraC263VnSJb+
         CeyTDJE+p4R22+eqQRSYFoO7zhhqpEegbr8dhSf4saMWyTyaISY082AKrZwHjI7VWuOn
         5CHA==
X-Forwarded-Encrypted: i=1; AKwUvBznIhThZcueJnNk0XLY52h8v8BfXhysbVOwpplJ/gzDq6hHMawafbVmT3dh7ogmsSJaVG6UAOkbgh7Tmw==@vger.kernel.org
X-Gm-Message-State: AFuF++nY1f+sMRInrdpcnd5y0eZ+AuHwZbTa00OR5OR0HyGhCgPT0Wlc
	6sj/CglzCnLcYcJ9TlE9c4hPxpax7sxyVz1Ezy32FvlU2rmPEaXYbMLv
X-Gm-Gg: AYBFou11/l008hMXnUpwv7yogyXVYVw0N0SzWRVOugD2VIYAhkMGs23bsXalT9RkM0j
	YZQcwASiSvWj1GeZ3lQwSjWHg7KAeoFV7SAGxix3m+dvMRKaTzV1dtTiWycNQxrfltwLCllQ3Iu
	iTCUU8sfDLNjoe9kEHJsEEoo5f8v+ybkG4gnGv/iYV5nGjElSHfCeS8gNUKVJ/VmH6BLKj+/pAw
	t3lKBCv4mheynT3Lh+5M4LLMsDU+QgcPt3Ijv8Z+DcbhvLuzOSyCMu0d1o/y4iF1o7R81g82ZXs
	kwlPLbTKgpcitlagOwaxHsRAb46Vqd+fnLUbnjQEtCBfnt9gWbT7HaRA5JZ5jx434T4e6fKzY64
	PcZaV4Md0vn7JF8A5ONRvBLujDQ86AubUb6vc7YzpCChSju0WDJ4r2hNVp0FzHi4DJQX+IWVkwi
	XAZOPxpWbOW06SPBu0mgYSUQwZ4aPWyoh02RnIYK+6xz5sPuk5WFABTfiRoH3HP4z4RSwjiqZD+
	j4XvNTZX5QC93ROjr2Dr0AQGYGdtE31a2U2iaED2+zU
X-Received: by 2002:a5d:5d0c:0:b0:487:aff:9952 with SMTP id ffacd0b85a97d-4886706f69emr6125723f8f.16.1790187244370;
        Wed, 23 Sep 2026 11:14:04 -0700 (PDT)
Received: from cachyos-x8664 (213-225-11-125.nat.highway.a1.net. [213.225.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684862a3sm8007107f8f.7.2026.09.23.11.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:14:03 -0700 (PDT)
From: Roman Stingler <roman.stingler@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Roman Stingler <roman.stingler@gmail.com>,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	Erik Hakansson <erikhakan@gmail.com>,
	Filipe Lains <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [PATCH] HID: logitech-hidpp: do not overwrite the device's hi-res wheel mode
Date: Wed, 23 Sep 2026 20:11:29 +0200
Message-ID: <20260923181203.422097-1-roman.stingler@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi_res_scroll_enable() unconditionally puts HID++ 2.0 devices supporting
the HiRes Wheel feature (0x2121) into high-resolution mode on every
connect event.

On at least the MX Master 4 that mode is persistent state in the device.
With hid-logitech-hidpp unloaded, a mode set from userspace survives
switching the mouse off and on again. Writing it at connect therefore
destroys a setting the user configured, and does so on every probe --
cold boot, receiver replug or module reload -- so userspace cannot
reliably keep it either: it gets no indication that the mode it set has
been changed underneath it.

This became visible when Bolt receivers gained support in 7.3. Before
that these devices were driven by hid-generic, hid-logitech-hidpp never
bound to them, and nothing in the kernel wrote the setting.

0x2121 exposes getWheelMode alongside setWheelMode. Read the current
mode and scale vertical_wheel_counter.wheel_multiplier to match rather
than forcing high resolution: a device left in high-resolution mode
still gets its multiplier, and one the user configured for low
resolution is left alone.

Note this changes behaviour for devices sitting at a low-resolution
factory default -- the kernel will no longer switch those to
high-resolution scrolling.

Link: https://lore.kernel.org/all/20260920094508.39682-1-roman.stingler@gmail.com/
Signed-off-by: Roman Stingler <roman.stingler@gmail.com>
---
Lovekesh Solanki proposed an alternative in the report thread which
remembers the last mode seen from userspace. That fixes suspend/resume
but not the probe cases above, and he suggested sending this instead:
https://lore.kernel.org/all/arJs7GjCP3r4IaM-@eggarch/

Tested on 7.3-rc3 with an MX Master 4 (WPID B042) behind a Bolt
receiver, built as a module and loaded at boot:

                        stock   this patch
  suspend/resume          no        yes
  module reload           no        yes
  cold boot               no        yes

With the mouse left in high-resolution mode, a full module reload leaves
it in high resolution and the multiplier is fetched as before. I checked
that the mode is honoured; I did not instrument events per detent,
though that path is unchanged.

 drivers/hid/hid-logitech-hidpp.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 493763a12518..338477bfcaeb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2044,6 +2044,7 @@ static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
 #define HIDPP_PAGE_HIRES_WHEEL		0x2121
 
 #define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
+#define CMD_HIRES_WHEEL_GET_WHEEL_MODE		0x10
 #define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
 
 static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
@@ -2072,12 +2073,10 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	return ret;
 }
 
-static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
-	bool high_resolution, bool use_hidpp)
+static int hidpp_hrw_get_wheel_mode(struct hidpp_device *hidpp, u8 *mode)
 {
 	u8 feature_index;
 	int ret;
-	u8 params[1];
 	struct hidpp_report response;
 
 	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
@@ -2085,13 +2084,14 @@ static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
 	if (ret)
 		return ret;
 
-	params[0] = (invert          ? BIT(2) : 0) |
-		    (high_resolution ? BIT(1) : 0) |
-		    (use_hidpp       ? BIT(0) : 0);
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HIRES_WHEEL_GET_WHEEL_MODE,
+					  NULL, 0, &response);
+	if (ret)
+		return ret;
 
-	return hidpp_send_fap_command_sync(hidpp, feature_index,
-					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
-					   params, sizeof(params), &response);
+	*mode = response.fap.params[0];
+	return 0;
 }
 
 /* -------------------------------------------------------------------------- */
@@ -3910,8 +3910,16 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	u8 multiplier = 1;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
-		if (ret == 0)
+		u8 mode;
+
+		/*
+		 * The wheel mode is persistent state in the device, so read it
+		 * rather than overwriting it, and scale to match. A device
+		 * left in hi-res still gets the multiplier it needs; one the
+		 * user configured for low resolution is left alone.
+		 */
+		ret = hidpp_hrw_get_wheel_mode(hidpp, &mode);
+		if (ret == 0 && (mode & BIT(1)))
 			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.55.0

