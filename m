Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2423DCDA4
	for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800993; cv=none; b=T8QusBjtAmvLWaergWosU/9jbx2Xpcp6aOiB2hTd/SYOFo1xlULTQP6zvnls4TWXmPIEaermm7lBhjqSFQNGM1X9vPp/jFGfKJGQAC3fZDl2l7l5F47vQI9IEQ+O8uDjbESrouHGxQ3s8Y7FrmehqbkIyzgb5pcB2j3hdxHrdhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800993; c=relaxed/simple;
	bh=yAahJwXkWCO126tqmFg94b0yk2S2R571DZmsbo72ick=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SUtBSNNiHN343Ny7/JAko5E1y8yydwH94vh70hC1pb32oPsXbn340in0BT02sCzxOS8t9tiMq+sFppQCUmWv3KHVOLPnZ2tikKAZ8iRQ2xj/vk6wNFpslS4XHRaJe/JckyZvKN9rvSRCZ21kwFDvtr5A2BdrJU9RdVPMTp2/Oe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbghiF0C; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbghiF0C"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a4190174eeso787550e87.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776800990; x=1777405790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKuae0vpvJ95HIhc8nyWaIWBHRclDLR6Nz0GgGjCMyQ=;
        b=RbghiF0CGc86DHCTxyr/zSWUnOqCQYwqZEwjjOI9R6YDt1qz4RezbGr5aKpVxUjk2T
         jmWwIHrEu3zqNHs8cAEIPm59+fvLSfDXd1kz5YhMi+8LHAxmstc7o0NWRrV7EgpyMSa/
         GuFb3QL7U6KxDp0tP+DWA2HVneBO9tErmvBMae+oeY9A9TWJDDZDESeBDPv03BHPWSyO
         Ro6VtyoUkCPLZXTvmlLeyplKIN57lyxHX2tc4eefe8hyniZ6LM5Jqv+KCOBwy7XhGVtB
         oRBq62l6W+dD3Mr1MiZ+PCEJLVeI1ASaz9Rrj/IYopxTiydaA1bQ9QeOmmRn1a6dsZsv
         1j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800990; x=1777405790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKuae0vpvJ95HIhc8nyWaIWBHRclDLR6Nz0GgGjCMyQ=;
        b=X0LZ1kMNiz37m6EKTtp09IyLvcZxfjVt6y1MjM0QrCLwvRwLbJHTBEdRGOeqyz2oov
         Kn2x4FIg/hPt2XI2UUvMx2aT5JWTjFnEaarP4MvHVVnbSK+TKcot24tW55YBY9S80xCS
         5+KFaLsQTLMPhg54f6exBa4tyns6gEOWRDhOF2PxgV5TxPnM6AM9PvfwGAuVfZHeSj3r
         6HCiNkHHWPcmZ6au7ypijtyVdz28xXB1X9pp4AeZr1u8UmIuO4EvkVtPJhOJLJLcf2Vl
         rmKaVAqtNxatbsUVuVIpzx9sVqQ4J+h0JhnDJSdvx4pbn3csWvU+0Cg/5XydyH8AGdm4
         0Kmg==
X-Forwarded-Encrypted: i=1; AFNElJ/wkIPEZ0X+RqRLC1W5bZIL+pA2oYwnHdhzWSqYkj6PJzVy5iMK+6NFrrwCud61rTEW5wHl+IJ0RlGr7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIJzugZOFYbatX4tPwpkDbcM21b+G0kAH1DTWcOjFSr7ZDrzV
	814HaBWJDDbSVP0UNpi2PsI1CzP2nYmqxc42gkoGI5e26bVf+7KRIyr6
X-Gm-Gg: AeBDiesiGvwzDNzeoL9pUKPHcax9AWmdAqzgZr2oRZMdc+2PUkmg/TvQTaPga12uCid
	V7gNnAz3URd+p5PCMSJ7DSEvGDz5HpxM6bp90lz/R7A9M9o3mgQUc6S68Ba2GNdz4/3k2t/1c7v
	hSQC6SzYGJlTbht+1XF5vPKhb4qSICTpymeOp0V2vgZOxkqRCH8V/QtDhFMwympQiB/YSOLh2S9
	JW7W1nVEllpiLARAXOguwDR0Ozm9GvtQ7I1VxGvsRj4BLQk4ftQwmIAFHJi9z6nUlZxdEHL3qaM
	sCpV5aBRTl+dQPE/J+2BdRaLA/Zl1m6vdivPpDod+M+zrU0eo5qv8oKYcpBVeCruK9BOfy65ToZ
	WCxDZf+aEW4Ov0k+3T7Ig7nEehSfliO5h9Cvw5fFM9oU4aVEuj/Q8jYyudpXifwnrMN+Y+5wzRz
	s6Jd5zJL9fmiFw25UEEYQLRVbQwTQxZod3lYzrbgfE4iuygVA45SHmwGhxDTz70wnEi0bbKmQLi
	0bRNRWbU1+Eq0g=
X-Received: by 2002:a05:6512:10ca:b0:5a2:b8ca:a7e0 with SMTP id 2adb3069b0e04-5a4172f82a3mr2730837e87.5.1776800989499;
        Tue, 21 Apr 2026 12:49:49 -0700 (PDT)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7a3fsm3864781e87.59.2026.04.21.12.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:49:49 -0700 (PDT)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: oleg@makarenk.ooo,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tomasz.pakula.oficjalny@gmail.com
Subject: [PATCH] HID: pidff: Fix integer overflow in pidff_rescale
Date: Tue, 21 Apr 2026 21:49:41 +0200
Message-ID: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rescaling values close to the max (U16_MAX) temporairly creates values
that exceed the s32 range. This caused value overflow in case when, for
example, a periodic effect phase was higher than 180 degrees. In turn,
rescale function could return values outside of the logical range of the
HID field (negative when logical minimum is 0).

Fix by using 64 bit signed integer to store the value during calculation
but still return only 32 bit integer.

Closes: https://github.com/JacKeTUs/universal-pidff/issues/116
Cc: <stable@vger.kernel.org>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
---
For inclusion in the 7.1-RC period

 drivers/hid/usbhid/hid-pidff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index aee8a4443305..fb9b4f292732 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -326,8 +326,9 @@ static s32 pidff_clamp(s32 i, struct hid_field *field)
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
-	return i * (field->logical_maximum - field->logical_minimum) / max +
-	       field->logical_minimum;
+	/* 64 bits needed for big values during rescale */
+	return (s64)i * (field->logical_maximum - field->logical_minimum) /
+		max + field->logical_minimum;
 }
 
 /*
-- 
2.53.0

