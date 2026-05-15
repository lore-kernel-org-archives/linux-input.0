Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB63644D4
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823775; cv=none; b=iQBOgGcpqLmzRaBNhLUxPv1JVYJMYE5SwCQ9uvTdZFnDSa3iXiitQmJpoJlmcJYbEq8cGMnvOig1notDIsSs58H7/8vTjexYUwlxzWlYojP1idM4xdvKHErWnXPJoYrSwiUFHnZIPEgCgq4NdwreqjhyrfQNIeRtlh97uyJxfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823775; c=relaxed/simple;
	bh=GnGzQTNG2sWXCYiVIHV6PxxXdvgI+nP2hkQMIdexBZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGvr28bCmh5pkMYo4bHTuP8R4tJ38vW6tYAwBq1FkudUZhtUE1Ef8yWubsPjmSP7+f7rIH/KQ2+ErdsosvHP04FSGPjgi4GA9iJq0LyN69dbCsK8yaxd+yd38enxsR1+Q6K2Sl3HITlGw62VYxCVy4Xr1zpf+fUpxEugpuf6MtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeVeAtJj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeVeAtJj"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so4034962b3a.1
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 22:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778823773; x=1779428573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu8r9w9o/+B86iBJC+fZKkUwDRzmjJF1xgahG3OvjQQ=;
        b=IeVeAtJju4/+vUQAXwnjDov4VYTPkTmxzLXBJaqJ5dVcHLFzly+VOfRY6jY4kl3Vut
         YZ0uFVkIJw3/0tH6XOb1c+lxX+hBBjL9+0/KqENkkcLYEwsuMnvfu08U8ujHWh7UZtGF
         vhsBZoNinnxsxp6z87QiRL/+Z1lESdhyAaztjtDrjeHLmLbOkJvK/DFrn/jBrORl0Pjk
         zceUQdWI2nUx3Ggi5khpRYqAGOtwpJvpfgrDTQlx2Sxr/02P0mPDXBY+98IeoAA4d4dI
         BIZwurFwOZs/Avh31IrqaImqDSFQFyby+ItLgMY0t1fpfxXbCnZRVxMLyw+LHRK7oCA/
         wnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778823773; x=1779428573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vu8r9w9o/+B86iBJC+fZKkUwDRzmjJF1xgahG3OvjQQ=;
        b=rs2PK7zPZ8nr0TjVffjMtU/cos4jwQgL5iVIy/RGlygMj9ChBLxKrce0coD8Vire+7
         4fuWEheKYNV71SYUmKY+yN4bY4/bQsIlRgpxsg3bQW8/YjbuRMonJd7iKxHO9HXcC5Hp
         BBpW71t4R32DRvkj1p5PN+Ishzar1wXltDJIUSPHlg/cn0HbrkBu3FASERvMD9PXaaG6
         bdIDZEK02qUolRYAPjl6p9IaGh0a7180fjqMAmXip1do5A4X63ccfIcgUOYWqM45VNjZ
         39+U8zZgMjtCbHhSXiRrpWlkQg1UDBbMHvlabJ5jXxmvvzEjtxwe5CziH0s8CSVhe7bp
         tmPw==
X-Forwarded-Encrypted: i=1; AFNElJ92KgDIOk5hRwFKHCnmGOjwqigV69Y/Eyl+1Z1p5NsKuP33KxxDr8IVvs4moSQdIn/Fwl5qesgPQ0/jTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ipE300Bxs7HH++FQVXgzofUKXQmMIX2888whjbvNJ0ngIb3e
	rABlANiL/g2sGoiUiojaSqwX33g9pNS8ftliEgIMGBGXPZ3y5hnWjHnz
X-Gm-Gg: Acq92OEgUs2cVzsZmWIvulv1fuG3Ltp9aBOb9dw/48VjL7SgM+t0yCXrxqVMM28mz+J
	kFLLADDHfaTci10PW0U9okLIgHdWqQ21KWVmzkFxoS/rRX4Xek2FMMAUPWY6HqcwcWuAouQigLR
	ynrSKVxciNi70XL8T99G61iH8/eSD3YIy3HMOQINbrSX2sqUWy8TznVk0K+dKOopKDelipox2XZ
	1HTGMGh2SY5Sa7RUWLIsb6ygzUS0yVPzMtDLH2dsOSWxOK4Rrne7rbQGdF16ETaALB8S35+/6Iq
	GNkbx3zfLoNq2nFcTuIKVZa1u0cpfIzyMeAjZS6pJGyjZU1S3VWZqsu4MOA+TlVv27DJ//AbSYj
	x1C6nyF+T2C4rYRForfNC7A/M1Q6Bdp2rWlwKZ9Jg3oOk9nI+nR80mmWAWeG+lS6iQlTlOjTmlG
	baqmLwSh/MPkcAhbwk+sB4AzHO/IHqLTntuIV8xxrtZ7q+Jv8ktCixrU/n4llWJKpdRuse7bHod
	lxLh7DEO63oHKSb/eLhtoY8AYE=
X-Received: by 2002:a05:6a00:ace:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-83f33ba720amr2908112b3a.8.1778823773353;
        Thu, 14 May 2026 22:42:53 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com ([203.117.161.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:42:52 -0700 (PDT)
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
	platform-driver-x86@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v2 4/7] hid: Pen battery quirk for Surface Pro 12in
Date: Fri, 15 May 2026 15:41:49 +1000
Message-ID: <de275cc63e764d2acddf72bf3f50e89f307f41b5.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pen setup for this device uses bluetooth for
communicating battery levels and status instead of
reporting it over i2c.

Without this quirk, the device either reports an
extra, broken phantom battery, or hangs.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf63742315b..d16f55479786 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -459,6 +459,7 @@
 #define USB_DEVICE_ID_HP_X2		0x074d
 #define USB_DEVICE_ID_HP_X2_10_COVER	0x0755
 #define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
+#define I2C_DEVICE_ID_SURFACE_PRO_12IN  0x4376
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d73cfa2e73d3..61ecd840d0bd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -395,6 +395,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_SURFACE_PRO_12IN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	/*
 	 * Elan HID touchscreens seem to all report a non present battery,
 	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
-- 
2.53.0

