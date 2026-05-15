Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A1364029
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823743; cv=none; b=NW1OXp3S0mdadbgg14bV4xFfqXSsNS93NaS9b6+ZCkcKRtendqon7768Cvw1OT6gWIX04/iK66wgVRp9src2SjZy6M06WLiW5YPKOvrGCl38ddosW7gupJFi49TfTmUC2CvXLWt3hYsTrKdp/PX992be4gYIp7E5G1ylAa/rbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823743; c=relaxed/simple;
	bh=4ujO8YPn+C6kly/QIxgqk2+iFaoJUzR0JdPeVgifXGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvqinM4H8mizcQ8KgnQHPZx2Bf3SyYzQgcZ/ykhUUS4OViL2BUIikPxsusSCryH9/W7FLTHxXrZaIq9xuWBn1AGN9dPNbBG22zc86iUg6ldSzOUSZnvjRK0RN29QR1HYnM9wd1Iwm7FBbBBEiryp71vrrG1rLLg4IB4nSwCPoPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/uTGYHL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/uTGYHL"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so4034817b3a.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 22:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778823742; x=1779428542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BD6jb0vjKtzgJh8F8xKpey20kEfF+Odim4ezk9P1XI=;
        b=F/uTGYHLT8VYmGW7uUL+D8T/AA74P6prWB53VB35e1Kcxs9A1li02lUUJfl59m2XPG
         UY9OLwSN6S+/GyHL7u9w6UurHJG2uXT6EofbCa31igySqpYGx2ecTIpBe5XaqdKQrW0c
         zMB0Q5Vt/vCsG/kUXnNwsxqCm2edDNVb6h7iwTs6LrrYPs0mGDZOywnYqXOq//V1Xq8N
         Z3CgISE7MVDvS/pAtRj4lRWSEYv5Mbaxe+nEhv/DucluH8eIFkne84tkuLaoGmLlu12m
         Y6Wr6qgXaZu8EKxu1EzW/9XGVTu+kYxXKeeW/icfozYKB0+QwoxhDMuq+FGy/7nj9Oxd
         8Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778823742; x=1779428542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BD6jb0vjKtzgJh8F8xKpey20kEfF+Odim4ezk9P1XI=;
        b=OcZpHvgZPqYkDjUH0LraYGRPT1m4mw3hg7W8hgVxwWat4sH9SRkapR/e8+6Wd2xh7I
         lP6rIzXbdJV+ge1BFN3ckE5drO66t9THOyolDlim5jbNjZxoIYDQQgQBs9OPg1rOIO/Z
         PKqmNQYU8WibjBndYI5icgWAJpModilQi76eTIm/8C8UzLp32l4zgllFHA2My9ijnm7o
         K/vZsqimeONn6j9gXlE8YSyrA7wP/DoYU813asupaOeXmudrUZd3OZcpICMDm8hy+jML
         AuUJ6BLOpJFVe3yzNU0GxwcHwSuAVdsqMy5CZcldVp+i8dw77AZv30lHqLF1G5FmKQTa
         cMJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XSLpEhhs3pfDxTH1/cayxY2cjk9mi3ItZUijVX63IF3WXylWGexvll8qsmcFIV1uXWT4G72hujBFNfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAv7N97cNE+kCPyviOwvafrxygGd3m9NZ7uaQnIfZHxl37gqWd
	a49CJPWUX0Zdw6/ixjSN/qO3nJ6CXtc/qK5rhuyJbhNFu+1waiz0OnIO
X-Gm-Gg: Acq92OEWltHEK3zcy3nr7pyoLrnKAKeDlO6SHci+QLYx2CFXQ87C5CGfxvauclgaoiU
	pESHZ91suKVhZZH2yN9vlZ5uVld/Xx2UFKX+LHmKftXPzAjUNVyGYPmpFRbELWU/GFa0Jv0ybEw
	O2ayDXSWCaNJJajWQKWYIPn5rElbWSHnYllG47wx40oxF06U7VUQEoFqoMrSQLTVq/D9zpD0728
	XxKoQegF8ogrAQNHNfNcSpkZi/CbGZygwbo3hOgck0ZUMzTZFrbJFe1b0Dun4/jexE7xpE2Dk6c
	9qCbT+3QZv/U/xfOBz0try7dct7vqpRGtX222Ib+GYLeOZYxOPqWSpFNMduX+Wibj3jd4GkH0/+
	KuRsgmfpnQsVrAyOpFWjG9yKd/k0M2bkrPs/fNBLDhpOH6t9Q8SuBHWLcxei4aG6TVyzRQldxxO
	54LLONzPm+lOjijEeobIXvTkU7TsTM7xlt38UgCwtUPcBtMoNzeyFT5PwBSyIPDcTLCcIgTGO2G
	D5ftug+ourfK5Jp3KdcahfnkEo=
X-Received: by 2002:a05:6a00:1954:b0:835:366f:5da2 with SMTP id d2e1a72fcca58-83f33d80937mr2828691b3a.37.1778823741521;
        Thu, 14 May 2026 22:42:21 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com ([203.117.161.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:42:20 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	davem@davemloft.net,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jikos@kernel.org,
	bentiss@kernel.org,
	luzmaximilian@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 0/7] Add support for the Microsoft Surface Pro 12in 1st Edition (Snapdragon),
Date: Fri, 15 May 2026 15:41:45 +1000
Message-ID: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <177869930359.1496076.12020223802779537187.b4-ty@kernel.org>
References: <177869930359.1496076.12020223802779537187.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
Ice device tree: 
 - Updated to use 0x0 formatting

Panel: 
 - Add edid to commit message

Device tree:
 - Fixed formatting and ordering nits
 - Removed extra dmic audio declarations
 - Added suspected devices on i2c busses
 - Fixed incorrect usb regulator
 - Describe panel pin regulator
 - Added defaults for volume button GPIOs

QSEECOM patch (4/8 in v1):
  - Applied by Bjorn Andersson
  
Hid patch (5/8 in v1):
  - Acked by Jiri Kosina, but not applied yet.

Link to v1:
https://lore.kernel.org/all/cover.1778498477.git.harrison.vanderbyl@gmail.com/


Currently supported:
  - UFS (with inline crypto)
  - Touchscreen, pen, cover keyboard and touchpad (via SAM)
  - USB 3.2 x2 with DP Alt Mode
  - Audio, WiFi, Bluetooth
  - CDSP, ADSP, GPU
  - Display (BOE NE120DRM-N28 panel)

Not yet supported:
  - Accelerometer
  - Front, back, and IR cameras
  - IRIS video decoder

Note on the compatible string: unlike other Microsoft Surface devices
upstream (denali, arcata, romulus13, blackrock), this device does not
appear to carry an internal codename in firmware. The DSDT, SMBIOS, and
EFI variables only refer to it as "Surface Pro 12in 1st Ed with
Snapdragon" (SKU 2110). I have used `microsoft,surface-pro-12in` as the
compatible. Suggestions welcome.

Although the device is marketed as just a smaller version of the denali,
it has enough differences that it warranted a different compatible and
device tree.

Tested on Surface Pro 12in 1st Ed with Snapdragon (SKU 2110).

Harrison Vanderbyl (7):
  dt-bindings: arm: qcom: Add Microsoft Surface Pro 12in
  dt-bindings: crypto: Add x1e80100 inline crypto
  platform/surface: SAM: Add support for Surface Pro 12in
  hid: Pen battery quirk for Surface Pro 12in
  drm/panel-edp: Add panel for Surface Pro 12in
  arm64: dts: qcom: hamoa: Add inline crypto for UFS
  arm64: dts: qcom: Add Microsoft Surface Pro 12in

 .../devicetree/bindings/arm/qcom.yaml         |    4 +
 .../crypto/qcom,inline-crypto-engine.yaml     |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi           |   10 +
 .../dts/qcom/x1p42100-microsoft-sp12in.dts    | 1201 +++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             |    1 +
 drivers/hid/hid-ids.h                         |    1 +
 drivers/hid/hid-input.c                       |    2 +
 .../surface/surface_aggregator_registry.c     |   15 +
 9 files changed, 1237 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1p42100-microsoft-sp12in.dts


base-commit: 5d6919055dec134de3c40167a490f33c74c12581
prerequisite-patch-id: a34133ba03bd1d31c0ed08612c31131b62015654
-- 
2.53.0

