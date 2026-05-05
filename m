Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D13C0605
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957203; cv=none; b=ECrjrAhkQxMsu++1Bx5O3bzBBSMmDrbxGu4jI9Ij5McsKzE4y0+q8OaQBolkirGotsrxjgd1X6w0grmWDNv/T234CJjeMvxzYlt4OhstmssqA4epnks1TO53ynjUGnpAAqECGuOPd1BtOEqnksuMtE0uCa/jsPwOjth0oU1AP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957203; c=relaxed/simple;
	bh=5rynYdstDSidD8j/koIGOQVJQmbG3RqF9LlqykFyDW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lV2qgFuxl1NtLowCkTaGmCeU/YxFI+NdcW0MuB3Z859I+vDgKmEMbc6eRMLfYkLKxmiGepWZbfUnzu5/3XvKn1GPwrblTtaZu2UhgU6Sc+ITePF0z8VuWTH+YFK/l5jcB0C602MaQx8uLYK8XOPYW+WCl52rCuNp9nWuWuKZIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQESCUo2; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQESCUo2"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1305908ae11so954601c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957201; x=1778562001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9AIIjE/oL3/1g9erZ/rZjvg7OI/hW1eJeMwxNk6yK4=;
        b=XQESCUo2ymAJhm0ey7Gcij7Cl0XNN4sT+sOKXie5w7H0eeUjsjQ8m7J9MGKM8dlPae
         tRp1R4ugY5Gi8mmOx4adhPaaMLJfRvr8CLxd1gLfhvRPol7E5MxyvLM7OigxB/snBssf
         nfBpw06uvB2ozTjesVHZJCOY0cDswExWNm6UnkTTG63bImJJj3zjWHcn0vn0jRbR7VRW
         bwP1jzdPVbflOKpHYE7yrL+TbdWjWxfILNmQKvOX3cbcTOVLbXLuchJOSeaRkxI2e++Z
         ygmcm7YtYiF9VVC0Eh2FDMIRrQh4ofiPQTrEOhGIm2Icduho2tMLYnIZKeA7d/U/gWSF
         YC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957201; x=1778562001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9AIIjE/oL3/1g9erZ/rZjvg7OI/hW1eJeMwxNk6yK4=;
        b=VNzcyO5NWMortT/VHgfPU2PKDk2cxyVRrDaiLMldYYziroOr0YY8fQ/GvL8KsOHcq+
         tVJPYV5O83XUczTLeXuiqHO7gpIVlwTm5HDktQsoMi9IgI0YU2lgNFzah2tDLWe38CqJ
         6Dsnr/zXgVA+1iOdHh3L4a/Qi6+45CFMrVqR7yTJWaAtQ7F1CArTToKRvjN2UDPY2bF5
         umPwXHriArI0vT7lg7GHhJpM6XwPEfZh6Clu4KYXwTIRZ0Nup+1gpI7oifKrYwfiG2kF
         8SF5+lnjIEaT+24cnH1Gm4R8bBD/lDGio1+nzko1+ZnEHr20GYwn9FBs4faqzBbxxZdI
         bC1g==
X-Gm-Message-State: AOJu0YxuxtgqtclXx04CqfyZl/asJRhAzycyT2IoSP/Ak+wXJ/7Pw5AW
	NagNwW6iuKxpyoHShK/A9OcHOfymwvwqa4oj6fMtJPnJbFRDGbqFs6MMQ0t1+A==
X-Gm-Gg: AeBDiesvBeUDp2LCY78Fn3Vo9CoGcdh9yNEnGlGte41Qcfkk/TM3b3/dcrHKObtteAt
	yKgOzJbZjbMVcYsKnCk6nCNCWthXfNiDfTm7K4JwA6FLb/svuPKJDVtPsZVeWlaFql2EHv4VKUa
	saAjN1JFp8hyKSENfkF/vSCtbp8NSvStodEPH9p/YTLUGMpAOP7BzlzZNz62dlQHd8A/2o2LKiD
	AHgBuugk0+5gsIc0oG0DiKvFjMrI0qs62jrcgEP3ZckcCCA2gKPCUJP6ouQYhV0QBYUPEdbQQHs
	xRDlx9XRbCBCaQk/bhaGX+kdbW2f7fnLKC0dbO6TVV9iRNx/Qxo1ydJ6FveEBFvbRLsT/oTQkYt
	2HWU1GCE/5GJJ87ayEj6y0oQYtrBznAZFl9am+tFAZqeanCoAT0jiEJt3RISRYn6FXDn1XI40qa
	GWpOzSrbFvwyZomyXrH3nQ97Wc7WV9FbTy9pePyXkRKH2/fp2J0H4XARbTFb0jfgjZWLg1WARnz
	wnCNyDH/osrZGWDHJysnKLs6w==
X-Received: by 2002:a05:7022:4392:b0:12a:713b:896a with SMTP id a92af1059eb24-130b1752d68mr981710c88.17.1777957200796;
        Mon, 04 May 2026 22:00:00 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.21.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:59:59 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 03/20] Input: rmi4 - fix type overflow in register counts
Date: Mon,  4 May 2026 21:59:33 -0700
Message-ID: <20260505045952.1570713-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The number of registers in the RMI4 register descriptor is populated
by counting the bits in the presence map using bitmap_weight(). Since
the presence map can contain up to 256 bits (RMI_REG_DESC_PRESENSE_BITS),
storing this count in a u8 can overflow to 0 if all 256 bits are set.

Change the num_registers field in struct rmi_register_descriptor
from u8 to u16 to prevent potential integer overflow and ensure safe
processing of devices reporting large descriptors.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e84495caab15..5f769fcc758d 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -65,7 +65,7 @@ struct rmi_register_desc_item {
 struct rmi_register_descriptor {
 	unsigned long struct_size;
 	unsigned long presense_map[BITS_TO_LONGS(RMI_REG_DESC_PRESENSE_BITS)];
-	u8 num_registers;
+	u16 num_registers;
 	struct rmi_register_desc_item *registers;
 };
 
-- 
2.54.0.545.g6539524ca2-goog

