Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CE3D6CD2
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424658; cv=none; b=GzEkj343k/ZRQODRHxdfafrhUCVIAkLCTkpP4oQzYt9czHs95ahIlkPSRCItT5pxQaEBznZ3wI9ZzJgY2UJoepyLBfNXkayCqGGBQYVcLlMZ80BNJCxDYW4D3NuaNLpPrucaRCcuMrVbVpJeASjYMQsLa/b3gC/cwpaUM1PInUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424658; c=relaxed/simple;
	bh=W5eJA3FdCXRXSD7P9MhLPBb4XjdipUURsAA1OWLjpPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYnHdMmpFkb/WMgIDExiN6ql5pGCVdbKgKdoM/0AQqg5tKj2051NgdwCKS6wuNKdqBhjKDufI/ugDJ5xvhRdBOp+82J0qOV2c9Tn1qn2em+t2M2F1m4QYFR983DVL/yyFNPd2N7/QNOMiqbifiPcxtmy/7Ly7ULGyS8Z+LlMmC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=Ma4HJ/e7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="Ma4HJ/e7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829b2019b39so1451197b3a.3
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1773424656; x=1774029456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6Vh6fXAGFY1am9qZuBu6ZtGkBan5ax492Gc8hpmDA0=;
        b=Ma4HJ/e7sDsBuKKPvaOz1SQjayT1mNZB9Sc0twHqZK4oK89pLogS8bL1+67gTX+JCc
         kCX1PYDp4Z8sSOhJjVHyhizxuNMuUteQZQVw5N7W95/foKbUt+mEkgXxoqCfak7Gx934
         JgkZZT8SBxlGYXdlDBVv70hTGZ58EZqDdp+wscHw5tomlInoSropypaUwkIrda53a99h
         jWumhpbn0TRfos+JQKSZ7YKmOaWUWO983f4HWBtNempuTXarkm5moRArgvNldTrpUvgW
         SMLZ4xJUBo1ODMoawZc7JLWlPGsFTRfN+WBDGUyeQ8GOE+HrQDXCY0dQPb96tTYcp+BH
         lIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424656; x=1774029456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6Vh6fXAGFY1am9qZuBu6ZtGkBan5ax492Gc8hpmDA0=;
        b=aJE3BmVXR4sxIvcYgekturnJuYmmwOLbL5xB6xIanJHaQP+ahlP93Ozw6VjrahaPT0
         ilujPV8w+J61QMEK84ZhxQMFn/GLefPhb8rBDrtkWga8UjVWEWScgyll/lusOIiHEKUp
         rIQRr5SiujiSIahVV3pvTfy7RqE7pY6r0kyJ7fsy5y9y/LYbuW1iaH88bzOKDE1fnRLF
         yV/HNZo6s/hIc0UHY017sBkVt0J32rcwJnS8o7sjcPYL2F/BYgevBaxhFC9d2vzZVFLZ
         ynQcR/qrrdiygJdrAOjpXjISf5B4U1vnDQ2wqI8nYOKWAO8nzM6xxepQc3YtVTkkspP3
         nXSw==
X-Gm-Message-State: AOJu0YwaL9YTnu3L5iSOz1C5wgGSFTjD5VT135rl+IiP/ZA4vVEu/4GB
	asdhlqLe1t85+Gqeq9hje0MXAs2wMRvEt6GBecSooVCfUrpoY5WUpXDLhq8Qc2djHt30CxC8H2a
	wVWvi
X-Gm-Gg: ATEYQzyTTR0u+30jivLW/u2YDRdM5ssOBVJX9ksvpX+KAEW5V4WHwTx1izyHNFburGu
	VyZcSjQCsn+63H+jmjdiKYTt2n/Fe13gErqYEBTqEkUPR3EZ46rqqsRtWpYVYZ6MKPxyHx+rdQg
	AgiJfhZGE1lNtCFMruY3VkPmLwr/xHMqr2UlbqORSrH5ae3XaksHAtz0YdW7Uld4fm9nAI1EBHV
	DGIiOeJPLLghzTs+yp7FvhA+TEp4/Et35b3usaJfs+ZVCpYSiU1k/NZkibaLwDcRQs4ZVaJ8Xvr
	VbsuMRLeP5swWn6e0OgKZWktSXkLJ3dou8o5q1nxHueG5ROqiMpdwgwgswMBBUVJNqS2cuKsL3y
	sl72Uobtu6ac5Q5KNDSiZLe5U/VPEhnHZ15Nz9twgVr5iJXsYSMT7tX+RFizn7JcN6J23cUqBuu
	bZgbr83FAoDdrj8i+p/9ywT+BRm0KNsiXXiC80vIKuRLvcyedaebQS28l4zuPY3iEhpuPjidYoA
	ZXjlaSgXWXpDnNUUw/GUwZFyPtdjvMgxDshxblgGjdZM5jXshdqCzq04vHWVTzD+1tPJgHRgvBG
X-Received: by 2002:a05:6a00:a803:b0:823:1c83:e4cb with SMTP id d2e1a72fcca58-82a19922f1cmr3487746b3a.62.1773424656090;
        Fri, 13 Mar 2026 10:57:36 -0700 (PDT)
Received: from nixos.home (2001-b011-0001-3a55-372a-4d8b-a513-4837.dynamic-ip6.hinet.net. [2001:b011:1:3a55:372a:4d8b:a513:4837])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm6265488b3a.8.2026.03.13.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:57:35 -0700 (PDT)
From: Daniel Schaefer <dhs@frame.work>
To: linux-input@vger.kernel.org
Cc: Daniel Schaefer <dhs@frame.work>,
	Richard Hughes <richard@hughsie.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux@frame.work
Subject: [PATCH 4/4] HID: core: Export device version via HID_FIRMWARE_VERSION uevent
Date: Sat, 14 Mar 2026 01:56:59 +0800
Message-ID: <20260313175659.268094-5-dhs@frame.work>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313175659.268094-1-dhs@frame.work>
References: <20260313175659.268094-1-dhs@frame.work>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the HID device version to userspace via the new
HID_FIRMWARE_VERSION uevent property. This enables userspace tools
(such as fwupd and hidapi) to retrieve device firmware version
information, providing parity with Windows HidD_GetAttributes() API
which returns VID, PID, and VersionNumber.

The version is exported as a 4-digit uppercase hexadecimal value
(e.g., "0100" for version 1.0), consistent with how USB devices
report bcdDevice.

fwupd can handle this since:
https://github.com/fwupd/fwupd/commit/fb0d4cc98abe253003ea0e1837277fd42971e0de
But the kernel hasn't yet exposed this.

hidapi patch is in-flight: https://github.com/libusb/hidapi/pull/777

Cc: Richard Hughes <richard@hughsie.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux@frame.work
Signed-off-by: Daniel Schaefer <dhs@frame.work>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index da57cbf0af26..c2075d5b40c3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2884,6 +2884,9 @@ static int hid_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	if (add_uevent_var(env, "HID_UNIQ=%s", hdev->uniq))
 		return -ENOMEM;
 
+	if (add_uevent_var(env, "HID_FIRMWARE_VERSION=%04X", hdev->version))
+		return -ENOMEM;
+
 	if (add_uevent_var(env, "MODALIAS=hid:b%04Xg%04Xv%08Xp%08X",
 			   hdev->bus, hdev->group, hdev->vendor, hdev->product))
 		return -ENOMEM;
-- 
2.52.0

