Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188113FF8AD
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510532; cv=none; b=ZqPvAKW4igoDi5AXKoHTBEe3Hf6g7Rdb8B8KE4iTDZol/6sj2flFuP2WKh7L5mrEuTLH0XuFTYg4vjcGufIbf89oiP2NxqxSx9GLiaFJXCxQXF+0Izs3s4HCpZl3F4tTZIO+OY7kqmtqhF/Tht5f6ytXs2JTX4zI7x1XTlS9Re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510532; c=relaxed/simple;
	bh=S3PdCabnSrFoUeTyBVHTl40IeEnbtsQwr3e7rmq5QOk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOFV4dsq9e8DsKlGmt48GoNq/lWlTbxcXRBzrjzI8YaJTv+0VHu87Y1+uUoN7rfyB87Cs1nAP/YLeAfBEQkbbJrJuDFLYpphrJgH8zY8uISKfC11Qd7tjLp4AB026yHSw4PFaHYtt8RHkhcVW70+4BBqiHSXlzYC2/eG6Ka4kxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+kui6Jc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+kui6Jc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8354461da74so2045704b3a.1
        for <linux-input@vger.kernel.org>; Mon, 11 May 2026 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510529; x=1779115329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIhyE/GwzdxlerouNKloxYd+dLgQAeLKvtkm5THrDBs=;
        b=p+kui6Jcf5M4///AXlQe3VZbX4kSNwFH51g5MSLkyPmp4OaMtqnZZQ6gyI485wvPRQ
         NYXGUjrASWRJPGf0lrnqU4npdDg3W9153kOrm2SOixnmxv0zkyaeGrGsfG97jgTc52ko
         94lmyvnWvWB0xD5KpB0Jzccvogy8v2/SZJXCd0RpaWxdVsxrjvhucZFSvIF62K/kvMG8
         onnGS1DVtsXKYoE06ISi8JFALnXUkiq4qarJ8NHrFFkPj/hIIfHVmQxAh9ilyE8oEgzx
         R74EgrO7layLnaQ1kk1tFddBrrFw5SayQZV64adNWg1sBpbFTLpXo0HDCRoQDsOnsKTU
         5w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510529; x=1779115329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZIhyE/GwzdxlerouNKloxYd+dLgQAeLKvtkm5THrDBs=;
        b=ZFdEaSJm2GNP5jhQVnjXfKTGcLcssQ7zTxH++96i6n1/oaiLQ2FdBIFvAVaAReQBgA
         2VzqpfvOhSf5cAEDS72njg7cbxOtnd3q6Xx2bg6A7n0x+lAwMkLa/fZM9PBH97v80cDM
         FuCiM4SUCsiycsOcII7g3y9oqgSaq/kBWVEfSY5QuVqXVBBqOj+Axkz7JmPUwy/DywZ8
         /Un7GtlSiF4kxMTiFxFc7RYTPyg/hfHd7ew6KqI+ZJaPpM/syhYzN46AekzKibry6npq
         bfYhINbbI4Z3+00bNK9omwfPPqehzBR6JW1MU0LMVsTcGE4tmxuaAmggU0m8vYvEAc4W
         MUkg==
X-Forwarded-Encrypted: i=1; AFNElJ9xjNwkL983j9ChMICx6lexQLm1kycq7Y869TFUwLGIQBIzikYPVNSMCdDYPh3QWHE/hB4gmwUWfytoMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywum8GINB8bLmGe1jV4WkGqd8pXY7oZejidrUo7hZHifa94ptKA
	l0dvBtnyhZulSy+xMf+i3yqVYVeyx6BWup8JYAd1L8Qrp0+j0ScIYKq5
X-Gm-Gg: Acq92OHEjqA6/wI9vOe1exfxlaKkhCYjaaaWqX9wYUKwTBaT8dC7n044i1kVxD7fLdT
	0YJSMQgZ6zAr0tHcqc+Uzj5u80w5dUqNOc1bydNB6u1AK5qaIE5l44KbitL1q6N8/kBFQYwX+Jz
	017Leeu9evAo902r+HR7cN8ijJZJc5ZzRWOzAbIgaelBLNQY6MfLz2ydwb9c7m3srMC5OTFVddo
	uJhVUoZ79XGoZXG3+wZjWU0mswWwRIVmtIisz57wz43ZpothyoTmmggoDpl45wKaSGa1u6xdPcw
	JS+LUFmO5odMaYnawwVdjSi/H7LxFDMzsZMFQkn51nkuSjrzsV9eDKosOAHzIzKgBJU5o5pf2Ne
	iTwfRadNMx7e3TmJADhl3sCV5HL4wERjjgPy2deQGkceAOzdai2bL933HDh42ypK79KwcaU816u
	g1qjTKN0+gid3c6129P93qxBeSn6trYkOfeuFwvZ4A01k+uGb5ejXqoN3n+Z5Nna3c0lt6g+N5C
	hf8ZCYGOvxD+A==
X-Received: by 2002:a05:6a00:8103:b0:83e:ccd6:2dc8 with SMTP id d2e1a72fcca58-83eccd62e1bmr2441380b3a.27.1778510529332;
        Mon, 11 May 2026 07:42:09 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.lan ([58.164.4.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f11csm26012405b3a.3.2026.05.11.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:42:08 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: linux-arm-msm@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/8] hid: Pen battery quirk for Surface Pro 12in
Date: Tue, 12 May 2026 00:40:54 +1000
Message-ID: <2702fbde567457ea0835ba12cc29421590e688aa.1778498477.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778498477.git.harrison.vanderbyl@gmail.com>
References: <cover.1778498477.git.harrison.vanderbyl@gmail.com>
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

