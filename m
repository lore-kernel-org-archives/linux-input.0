Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E22D77E5
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567422; cv=none; b=iGbGk+jeYeNO6KnwxHr+lgDK2C3HH9/TBVLwVmD4hDMLXoYAFMSD3OmmIyoHG+JLPmyl8e4hZ3ZGiGfWvJOiYzbJpDQ1gENIXkumG9mRniWLYebJ1dZ56LaALoDyqbV/Y67RcE8a1jJ4CXytWQ8Rw2tHiBl4F0EkKO5PJsBPWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567422; c=relaxed/simple;
	bh=wDvJY4AIdZ4qHjzjrMZqmgb+k6atKSB3v8/7tRUZvRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1u6rreF2uwznvd14l6bGl3G00qWBLBnAFgA+i446KVpfQx3tJmkJCbTPNVrAkVxrzMe4Sg6Ln3SrwqAFr2fqyXGvAwB4gOUQyQ8tEfa//WYyFNyEaVs3pJAIMQiFm+dPHQ7pmTtjOa1CPTbg/2ogHyvbYjANtYynndzVDCR84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnoBLHEz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnoBLHEz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e7c6ec9dbso22648785a.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783567420; x=1784172220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHLeQHtxlKhAviEfRfghZBlKG133emkXTKZapKypMR8=;
        b=EnoBLHEzvwuP94UKvebkptVGFvl2JqXVQ5mt6BxF2HcsH6ckcKsGw3wL7ON8gp9pRS
         K9ZZp9wPA0epDM3N1o5q6/4JAruQ4fzFKOCpwxPqE//LiScgSoHPu/4oMKiBSdEA0H2c
         Z1HVqat5mDsTgtDjOwuIiFiuFmJNoxm04rk9LK+ZyLkIxzMGoePASbUQqc5I64TIB94I
         7BixFDzceeCFQc/vW2yoDm/ux+fMI7vYQfnejeZD2DZYc3yZVYPSvTNvJ6bdERCVhbL6
         L/y0WiKoVH8e6808ZJiOngoi2iZXw34NO5C0iBjUIYCZtyW/GVOvdn9m+ZhTrgQU6NGp
         VtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783567420; x=1784172220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHLeQHtxlKhAviEfRfghZBlKG133emkXTKZapKypMR8=;
        b=L91GCWSt4ShnJlzskyTefLPpXcxbcFa0fp+KZp2p04Q+0b42x9BkYlOsafrE7D6xeI
         JOJnGpxl/buiLewx28WBcHgOGz8Hy0gznUWWNSK0f0JLNoGrw6hKu3Ji/9BfRgG4u19W
         P+bsFPoEtNvWIsWC99GSlyyBonbwPCK4qyu0rvlElirEX4iq6Wp6ML300u9pfNVQ3PV1
         qs7i3hP5+41Y5qPisXxDS1R3YbPC3kOTyG3OPAcXDXQ1ZzXF+sttjBILrATNwRnfdVU5
         3nEeqAThSw0Ez0VXzs5ZprgoCI+w9aINRgpAagvVax/Qz1vqtk400L67Ga7kDyo2guo8
         WOfA==
X-Gm-Message-State: AOJu0YyUGIAKGK1h/Ap27uAFt4gTnhsajwNfMxgR9wms1HzRg0mGY9LL
	UKpXR1Jo5+QLckcIPKMVswtUwgEqt6JUyHXt6P9763AnLeQgxTjEWPIb
X-Gm-Gg: AfdE7ckhwFD9axw3MjDWvKDcDmlqtgOBHRzt+qI4QyB5ZEewfGAK9o0gsRsFHso+rLB
	zNJQ8n98ykuxalBnt0jTFbPCLpFyyTM4H9TR7TriJQBcWNhICEVI5+qNYUmFsb6YevhNx+fYmGS
	WltQidvryfVdru315JWRWilRYnu3J3R7ri/o1B515PPrdtt9JmIuYGbxModHfVb9KDNTf6TaDok
	avvh4z+qo0HBDMzu48Qs39jv6fzDGOJ3FOROKte5HkBY13lI1E64R+vzbR7vTzoS5Kf7zY/yT2S
	JDR0bIcsEHfaVgjMfVIv2AClXAdxLE0YX7O9/SyghrK/21fYCS4B8fGyBSskRMGnBhZSu3s7Qj3
	WZXSh0blj353B4ay6FcMAurXnvu3JYM3Sq8/cEBQ62bBQLclk63u5DEQ5hvIbIJwjzd4lppshpJ
	AXly08w0tXza1r7R7DkT5xteEYw0d+CdpEEb+NOYGRXriVckF4F1/yhdsCOp0N+yKRilXERMZ6M
	Z9nrhiU
X-Received: by 2002:a05:620a:6cca:b0:92e:8405:7ae8 with SMTP id af79cd13be357-92ecf58cc0fmr562372785a.4.1783567419759;
        Wed, 08 Jul 2026 20:23:39 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e9c0f7de9sm1336872185a.26.2026.07.08.20.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 20:23:39 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
X-Google-Original-From: Sriman Achanta <68172138+srimanachanta@users.noreply.github.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v6 0/9] HID: steelseries: split out Arctis driver and add Nova 5X/Nova 7 support
Date: Wed,  8 Jul 2026 23:23:07 -0400
Message-ID: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sriman Achanta <srimanachanta@gmail.com>

This series moves the SteelSeries Arctis headset support out of
hid-steelseries.c into its own module, reworks it around a per-model
device_info table, hardens the battery power-supply lifetime, adds an
asynchronous status interface, and finally adds support for the Arctis
Nova 5X and Nova 7 families. After the split, hid-steelseries.c is left
handling only the SRW-S1 racing wheel.

Changes since v5:
 - Nova: rename the Gen2-only parse function and device_info to
   steelseries_arctis_nova_{parse_status,info} now that they are also
   used by the Nova 5X and the 2026 refresh, not just Gen2.
 - Nova: add device IDs and a device_info for the original (pre-Gen2)
   Arctis Nova 7 family. It answers the same 0xb0/0xb7/0xb9/0xbb status
   opcodes on the same interfaces as Gen2, but reports battery capacity
   as a discrete 0-4 level rather than a raw percentage, so it gets its
   own parse function that maps the level through
   steelseries_map_capacity() instead of using it directly.
 - Nova: add the Arctis Nova 5X, which shares the Gen2/2026 protocol.
 - hid-ids.h: fix a whitespace-only bug where the new Nova 5X macro was
   space-aligned instead of tab-aligned.
 - Rebased on current master.

The Nova 5X protocol was verified against hardware by
sp4m.an.joker@gmail.com, and the original Nova 7 protocol was verified
against hardware by colin@1101b.com. Thanks to both for testing. I
previously ommited other devices in the v4 patch series due to being
unable to verify.

Sriman Achanta (9):
  HID: steelseries: Fix ARCTIS_1_X device mislabeling
  HID: steelseries: Split Arctis headset driver into separate module
  HID: steelseries: Inline and simplify SRWS1 wheel driver
  HID: steelseries: Refactor Arctis driver to use device_info framework
  HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
  HID: steelseries: Correct Arctis 9 battery calibration range
  HID: steelseries: Manage battery lifetime with refcounting
  HID: steelseries: Add async status interface support
  HID: steelseries: Add support for Arctis Nova 5X and Nova 7 families

 drivers/hid/Makefile                 |   2 +-
 drivers/hid/hid-ids.h                |  18 +-
 drivers/hid/hid-quirks.c             |  16 +-
 drivers/hid/hid-steelseries-arctis.c | 718 +++++++++++++++++++++++++++
 drivers/hid/hid-steelseries.c        | 406 +--------------
 5 files changed, 759 insertions(+), 401 deletions(-)
 create mode 100644 drivers/hid/hid-steelseries-arctis.c


base-commit: 7404ce51637231382873d0b55edabc2f3b841a9d
-- 
2.55.0

