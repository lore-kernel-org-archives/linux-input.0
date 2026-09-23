Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319142F715
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190107; cv=none; b=JYPIVSb28s8lSunppUhJkWrabCivJEYs1I9DBaqb/9fjNOg1awruUbbm2HN9R7YxA7CK49Upio5Y5w3tZ4bl14chE/Aw7JphTz7QDfQyu78vxn73R/wGt7OOCItNV3BFBRdbWGPAXcPBPCExT8BM+5b0dxRj5Im+CRT9H+wnvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190107; c=relaxed/simple;
	bh=2+sAdtNYkAUmzvkU5wTVUo7h5W67JxWtzAbCnDD1E+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhGxWPr3MTrOY8B70MjThChDEEKQpiNizRo7wjXTmi86imtMIyXLdkB6HB4356O847D83a47ounUu4oM648Jc9MYOiofog9n6arvMX7pFD+7MbuM9ib1wKdakFfFCGl7z8EQStEozT1pzbgQpJ4vv6NWwBuEuSr1UtTstDMpc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZxhkhaz; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZxhkhaz"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so7181665e9.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190104; x=1790794904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q6Scvv3eUeE3my9e5y7jMPOIpDoXcixl5UFkPjL5a7k=;
        b=hZxhkhaz6FbBTfwXco1yTZw0zaPS9NakPKO+YG4vs6iAVhBjndfFHP6kM8f2RBonk1
         UWfCbuRwU3uuitgbW3eO4tGfXHWHHhli8tk8Qc3wxuBpt0f7vGp1rMu+xjg/n7+HnW6h
         txvvw7+nuNWbdeOvF4rboL4gYOXzHCHlQrZA7PnbwfVtOWv7lJVLUyl+G/FeZ+CoerZp
         Z9bs1v1gy8YFEuvzjqJJoA61tNStQ4AKO2g1PVVluL/mQUOv7AHyfivfcEfxkglevOre
         G5PNXbPQQjN33MPNjeenCKsXRWTccNBGQJ3fBfWye1cmsOUh9GhE1T1KgclQCkmG8uVp
         nzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190104; x=1790794904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q6Scvv3eUeE3my9e5y7jMPOIpDoXcixl5UFkPjL5a7k=;
        b=11+nhVMKVC1ogGpxxYaCPFbSUw7iyJROA3NTn9fxcGGL+vj2yquaFZxv5M6jJuUdPt
         5PIR0CexUxm0aNgChjB+WHS27MGNtCpE7UDI5qyDEJnqKNOh7Zb6CTz2FAbBXCJJffd6
         zedXz/GR6bN5j1dfY7/V0YpeZPeSDAVtQdcd36nmZTs13gjXCjJQnZ0pmIk43b5tsBBZ
         BtiFWRfgPw1SdrVAzm+ETVPMuQUYtvJUD+5Ce1fU+toe5xx2Lw3e07KS95V2YolHFu+Y
         Zcq4tmdyzxXH5S9X2D5nuB/jc2g5eKDoQpZm7LtIqz9sU8R5KS1FXub9GoImShvkBuDV
         QaCA==
X-Forwarded-Encrypted: i=1; AKwUvBx5bwwtKOVxRV8eRI5lJ5qo5bTnNOCGTagmm+j0UeB30TjxUmXN+jtbNx065TfhYoc5fydlamlE8s7W3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lnvNdXzNTxasUFad/qp541DG3Ub8c4I2M9Slcxv6DqMpZuToXs
	HxK31SBj0Zcw3mQ6p4I+0db3JoV2bMO5wYsZlwIu8rKncVMu1s7TdSzT
X-Gm-Gg: AYBFou0SBxrzSVGi3WG5IczIc8ZDVdJ64kMeW44tcFvleY1EBQSdz4+qiCg7xgmc16E
	fiBg/QlKpDCxV3mvkk+FoUkAWcHOH2Yx3DXdd4JSb95aRsth4ZA7BUp1tqf//wgP1PMNzD681JJ
	MEOKudlYxzpXVPEbyd3u7cx3Ucp/Xqhcv6rQSDMs/9aMGbelYAZs0s+wvywEbfYB+Im+ICYzXr0
	nUuZL6qBg0wVnn0aUp8cpoDhYJJAUKOnHejWPec4kw14vWyH++O4s7D8kb63+kqSPB6n3Z2XSum
	0f763/3QPu4CbnbBMsZZX956pQ9nh7Afz7ZC05P87OEzMlewwyMtOJ1XSnqHdX0Dk+hMDmHTG0m
	fnERN1udCN23A+aQTKflJikj3itWs/ZptkrP9mdCo4y3kYfk7XRVvaz486b5bopWl5z/MLGOjeS
	CeceuqBTpuOrLyZE7xmpQbOrW8i27mnsYwhB+JUCG0IEpDuh6rboAhqf0STx73nkWeF5PV29ZBl
	dhhwdcxhctS2FCY1sedAXkVjqgDkeDxV8NFfNo2tBji
X-Received: by 2002:a05:600c:4ec6:b0:49d:e0c:e55e with SMTP id 5b1f17b1804b1-49fe66f9ddcmr2113795e9.23.1790190103535;
        Wed, 23 Sep 2026 12:01:43 -0700 (PDT)
Received: from cachyos-x8664 (213-225-11-125.nat.highway.a1.net. [213.225.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd3d5csm6639235e9.14.2026.09.23.12.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:01:42 -0700 (PDT)
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
Subject: [PATCH v2] HID: logitech-hidpp: do not overwrite the device's hi-res wheel mode
Date: Wed, 23 Sep 2026 21:01:27 +0200
Message-ID: <20260923190128.10394-1-roman.stingler@gmail.com>
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
mode instead of forcing high resolution, and scale by the multiplier
only while the wheel is actually in high-resolution mode.

The multiplier itself is queried regardless of the current mode, because
hidpp20_hires_wheel_raw_event() uses the cached hires_wheel_multiplier
when userspace later switches the wheel to high resolution; leaving it
at 1 would make each sub-detent tick report a full detent.

Note this changes behaviour for devices sitting at a low-resolution
factory default -- the kernel will no longer switch those to
high-resolution scrolling.

Link: https://lore.kernel.org/all/20260920094508.39682-1-roman.stingler@gmail.com/
Signed-off-by: Roman Stingler <roman.stingler@gmail.com>
---
v2: always query the wheel multiplier, not only when the device is
    already in high-resolution mode. In v1 a device probed in low
    resolution cached hires_wheel_multiplier = 1, so a later switch to
    high resolution from userspace scaled every sub-detent tick as a
    full detent. Caught by Sashiko AI review on v1.
v1: https://lore.kernel.org/all/20260923181203.422097-1-roman.stingler@gmail.com/

Lovekesh Solanki proposed an alternative in the report thread which
remembers the last mode seen from userspace. That fixes suspend/resume
but not the probe cases above, and he suggested sending this instead:
https://lore.kernel.org/all/arJs7GjCP3r4IaM-@eggarch/

Tested with an MX Master 4 (WPID B042) behind a Bolt receiver, built as
a module and loaded at boot:

                        stock   this patch
  suspend/resume          no        yes
  module reload           no        yes
  cold boot               no        yes

The v2 change cannot be exercised behind Bolt: there the wheel reports
arrive on the receiver's generic mouse interface rather than through
hid-logitech-hidpp, so the driver's multiplier is not in the path (that
is the separate unscaled scrolling problem being addressed elsewhere on
the list). I tested it over Bluetooth instead, where hid-logitech-hidpp
receives the wheel reports itself:

  - wheel set to low resolution, link dropped to force a fresh probe;
    with dynamic debug on, the driver logs
      wheel multiplier = 15, hi-res = 0
    (v1 would have cached a multiplier of 1 here)
  - switched to high resolution from userspace, with no further
    hi_res_scroll_enable() call logged afterwards, so scaling comes
    only from the cached multiplier
  - one physical detent then reports REL_WHEEL_HI_RES totalling 120
    and a single REL_WHEEL, i.e. correctly scaled

The same probe also left the low-resolution setting untouched over
Bluetooth, as it does behind Bolt.

 drivers/hid/hid-logitech-hidpp.c | 33 ++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 493763a12518..53b344c9b741 100644
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
@@ -3908,9 +3908,16 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
 	u8 multiplier = 1;
+	u8 mode = BIT(1);	/* the other paths always end up in hi-res */
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL) {
-		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
+		/*
+		 * The wheel mode is persistent state in the device, so read it
+		 * rather than overwriting it. The multiplier is fetched either
+		 * way, so that it is already known if userspace switches the
+		 * wheel to high resolution later on.
+		 */
+		ret = hidpp_hrw_get_wheel_mode(hidpp, &mode);
 		if (ret == 0)
 			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL) {
@@ -3933,8 +3940,10 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	}
 
 	hidpp->hires_wheel_multiplier = multiplier;
-	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
-	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d\n", multiplier);
+	hidpp->vertical_wheel_counter.wheel_multiplier =
+		(mode & BIT(1)) ? multiplier : 1;
+	hid_dbg(hidpp->hid_dev, "wheel multiplier = %d, hi-res = %d\n",
+		multiplier, !!(mode & BIT(1)));
 	return 0;
 }
 

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.55.0

