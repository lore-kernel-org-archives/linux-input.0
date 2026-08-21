Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BEC435AAB
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355468; cv=none; b=jrGSH8VYmy8/1zQX54q7vw0LCrtVjPQm5X0gounOV5JOExnH4TVp69NUuFTPumkNzugWR9rpaOV/PHSBouY+9Oaxfcll86cLs0qTBJyhZ/CdOgllS+XiOf8+lB2/5zJ17/g5poJ8hXRzZRTHSiQsMDz0fmRmFBbghw+kwpeqGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355468; c=relaxed/simple;
	bh=Crpzy5EBrcPrgxg5bwZ9gBe8cNdpZOCf5sRTxUsiAsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XovQZsq1pcVB+oYzdBRLYw/f9v5LqEtxZnOKhyGnoHS9t7Ko2niECdLJmfkEHhbi7e+Z5XPfNvFoff2Iu8SLwC90M8EKg8OEfkgCL+2eeiq7hmTlNmFKw/+/g/LNI10BLv2KK5bbl6h6+6vpvB9I2iUeupWQ8MpGmLH18kQI7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2s9mEc2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2s9mEc2"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1664683a91.0
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355464; x=1787960264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Op76CG/nwpuv151WXYSm8x7TlB0GS97YootXc2xz6Js=;
        b=N2s9mEc2j143H77diuDtaUqf9gQWVSHF3n45K8V/ByLnwYo944jEwlZY2Ts+ZmsNsh
         rv9TxQQ42eWCYukiBPQSaNGTvHJpqqACusA0lyNo1ORVUW004fg9IcDZJyINrCedaX7W
         QpUEed/pyalJLsOwq0A+k3hRjW3Afqmna0Q6Hr8jzKgu0PBVueOEgqUdIXkaqJ0bI6PB
         Frh+Md8ZC4+Sx9u2cylNEMPPM3Eq/s/F/NJeiMOFXA9DiKWeCFSLOxJRFAqMz1JAOQpy
         zdpGza9qHVpTW27I8C2fHuQocDEjNSkpQ+5V83VMY38wsseGsQSXxrbdSfsxoZlfdAuV
         1N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355464; x=1787960264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Op76CG/nwpuv151WXYSm8x7TlB0GS97YootXc2xz6Js=;
        b=XCTI7FDBfCVm+7IM4Ix5qz340U0WnIvQdDOn5QQ8vYtXPTofqg7MeHRROZ/UtWAjdm
         VgCW+f59eEWo6akyLYTrlAMo5ptFdG3JKlaFvMBPmLSBF33gWCLdlSHz0NBYGy9agic6
         G9dDp7eFOuYt19xOdVOEAEE1vbEju71Xq/mnZ/mny/Bt1t3QBnsGszHqe4EVXkOCl354
         C5hZkOvE55pH9W6UY66rw9Z42I8PFVbWmS/QSFutULEwSkNKvRq4qFWjS4Ctqj/FEfLh
         O+H/YHEyq+GtCwbxt9w/cLr4dZTA/XHiqgoEBolfNVc4+635UOpCipb1NTiCg0fcXjUA
         xa1w==
X-Gm-Message-State: AFuF++kGOldyJHb80FfOpTDCUgnpnTQ7ONUT6kQS0GuPz/7wpmBfYllU
	ss1tOUf9qKwMpjX0rqOgFuzep+aLTHUmVrhHhxWH6V6CgfAqa5a5n04o
X-Gm-Gg: AR+sD10nbSgkH3Fq4gagb3e6hS96ojffd4s8MnYvk5j5FIyMjt5Pkgtaj++fUaUCQ9l
	xsdYFk9rr54PPuEsAhXT2PCHIlHuwTv6lKZffZtafif0N/QiPqPdJYLts4MLQCYfiIaFMa3L+u5
	V8znvF+2PMEkIY7iq4Y2AX9HdEVjIpWwEscV6QHIAtf4E2LVb3Zk30jAwY9qIlFYW858d2QH0/6
	muSgz5k8qIYs1mwWEQozB8F6eiOpECPNQCuTmVLOHeHTRGDGpovGTiRSrLeUkSf18cXh6MKIcSq
	YVkPG6UGbtA24qMbZwig/SZPxWQFx9VBksqYlfcHQylTEBg+/xMr/8Zs758oicMogDgew2+TCO2
	VqYhm3oTHLVBLhqBCKoU4oV8Y5fyCfKggl+4Lw/GNhYRgi0aholkWyv0OVyaoJ2tVY0EgCtQRfJ
	gF/Oyo1bGJVML9XV9l2RuRY70DXKA2ZqiDmfstiv0B6psf75LWXQJsfjPDgFTDakq5UME3ErpXE
	dMVrfvcLQLbb8R7rIgiqMkRkV7z8aG931s9PnOHI3GXQbj0Y8bK
X-Received: by 2002:a17:90b:2808:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-395df289c4bmr3680987a91.9.1787355463940;
        Fri, 21 Aug 2026 16:37:43 -0700 (PDT)
Received: from hanzj-mi.. (ec2-99-79-140-187.ca-central-1.compute.amazonaws.com. [99.79.140.187])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4a4e5ecsm585305a91.16.2026.08.21.16.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:37:43 -0700 (PDT)
From: hanzhijian <hanzhijian1991@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hanzhijian <hanzhijian1991@gmail.com>
Subject: [PATCH] HID: lg-g15: fix kernel-doc comment for TEST_BIT
Date: Sat, 22 Aug 2026 07:37:31 +0800
Message-ID: <20260821233731.2331171-1-hanzhijian1991@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for the TEST_BIT() macro starts with "/**" but lacks the
macro name line, so scripts/kernel-doc reports "isn't a kernel-doc
comment" and it is silently dropped from the generated documentation.

Add the missing name line.

Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
---
 drivers/hid/hid-lg-g15.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 02ef3e209..c22820243 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -35,7 +35,10 @@
 #define LG_G13_BACKLIGHT_HW_ON_BIT	23
 
 /**
- * g13_input_report.keybits[] is not 32-bit aligned, so we can't use the bitops macros.
+ * TEST_BIT() - Test a bit in an unaligned byte array
+ *
+ * g13_input_report.keybits[] is not 32-bit aligned, so we cannot use
+ * the bitops macros.
  *
  * @ary: Pointer to array of u8s
  * @b: Bit index into ary, LSB first.  Not range checked.
-- 
2.43.0

