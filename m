Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173825;
	b=XAbbMc2dh8e2JGnWyalA9ZlIQ9D7Z0CeWikR2lCQMztuLRMOqsFVX1ehAsLpf0l4jyuA
	 /xqfgxNAM5brVBqeyHarUmgQYCsEWcZQEtSPDHbmTbjCkbVCv70m44YL7UfiLh9o8Jfbp
	 U5MLNiTAgar75t37e2UlDlyUoP9t/BzHwVK+qCB4XWN9LeaM++KNz/8MK7g2LXq16RiRE
	 0nvq3t5z7SjixCF1sLlMeQrgmfaPk8Omp0yqKon8nFDdlo4J/J2KyvLTnP+NjGqKek+xG
	 OdrDv5ymxGBGqoqtfrNqUGow3tXdSSWsiMjISDnnjOGXJR4FXCjGJxNyvJtUJwiLFnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JAGmMop/rvSN6d+KRjZFTkwYCsZKr/1kSugo2sOx9jM=;
	b=AN41ZLtEGmrOB0Qq2C+iQ+NzvuKu83Qo4vy1TqhOzrz9ySPrAq15w/x52xDm60CVxfxN
	 DQ48KCZIdjDzU7nJOK6+sDctJcWeuUpC91P5oBCfvh5EVYUbP6j4m1VOe0tNqFIAce0Hx
	 hO+qRHX7zDt6SLAbXO0AafQE+MuaJZDIYynTJUcKaNCMDadY0dlPLohiFvxtMytXXw2ZH
	 /s/u6mBLvy0HGDyft0Hk8lmPkBtvA5iKjhwYFqEncJLK9u0HBKJ/XKQk43ZZ5bCyM09NT
	 o4eIx36HfRlYNmo4yd9k8qPT2TnicwaakjSfq6RLHSKnEq3KuiXJWO/mfGy1lvNBnEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0WhQnpYV;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13783606D808
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 21:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13783606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0WhQnpYV
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so2889815e9.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 13:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794173823; x=1794778623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JAGmMop/rvSN6d+KRjZFTkwYCsZKr/1kSugo2sOx9jM=;
        b=0WhQnpYVJlFMoCs9uuNevqxP8Z4tvh9vdtDc2FjfGxNFWsbrZcmNCOh1W0LXGjUqnh
         n0och4KQwz+EQ9I7LMymNGeAZLd4BrJc8677zkCId66dgI5AMAf8blMSYwwm0tqWu+HT
         00Yn7HSvs1CVr68NkCsCu/rKD8lpVW2SrEzotBM4U9PQ0vzrFij+jAwtOJqUvUZG6/W2
         xx7ZO8guQddn8Q+av8OYl3YlMN+f1yaVWV4AMI04QM24r7LUpDdebZtQTTyLEB70Al9H
         H68izfiovJ8zIYOY+wRZi55ej+bREqJFgJ+l7PKicN2DJzCRdRWFOBaJ/6B1KpN1F4+j
         Noig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794173823; x=1794778623;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JAGmMop/rvSN6d+KRjZFTkwYCsZKr/1kSugo2sOx9jM=;
        b=zyQXfAarv5fmE0UYSk21ggan5W5fQN0yRPeIXZQ00q5pcFOxvUg66zOIDkorWr6lH/
         dt5ZBCdUNhdNL0yB41pQdi/nUfW9tDNWm4BaR6FP1Ap4SKpayv2LSmkA+JIFWjF7lzO1
         7Nc5sKFi0Rq95Xr3/zql8+ph0adqCu6tlwPVRweJochoKQ0uWrqrNEdrEsqhHzEMe82e
         +DXS6lGurKVZrwZIqfsLpnjX3a69TmCX0h9QAiVMobrmXUSmdCcb/kQ7JHCCf95fOufM
         MLlRuJp8vXt02rGu15MGXtzFulBZ/6pvKet2st7Gw0mUHOJSJAivI75rl8Qz0KL+HYrH
         +iMQ==
X-Forwarded-Encrypted: i=1; AL+hErGnIDzuM6DptxBozhgOvywz2NTv7y/irUauF3AiJiBAM1t5iCstRF02yIiQ3jj6gmdwVdPwHhDINPj1Mw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Geuf1vzYdiTnHb+cEfxxve2aunAwh0ZZmVZKXT5++s2Qs0glU
	tUn2rCnN+6NyeFczqiSqu0qXfFt7RjEkic7Cn/P+GbsUJwajKBOHTive
X-Gm-Gg: AYBFou3Zw+TTXOhFZK4Dz0l8ArG0R0oNrOWTJbm8kcvJiCNztTfEE358IsoKK0P/h/8
	SOMkt90/nekwyEtM6c8asrtEd6AucSvGhXf98ek712Ip3UvqDLiAEXhdA8tmSBoKvTTZ7wCtrol
	qNiFF0dMTp3cRLStlTOW7IXyWXGPFi1FUJYV8PsAtlrfHJ/z1P+zG1Fi7LamQVxyujGs+BEWi8s
	FUrpYXN/D2NfTEJ2eLf/0gYWmSg8SdQLE4TrqgtkSQVxhSLMfyUk4rvbkAy44j74+LY9ztPzYoD
	luwjtXnZWglOSvWfUoc9fPC3PuvB4GinPsvLGTqcLtzNZtiFese6/PLxLSupwcwaE5jrddyZsRc
	IQ9Y8r8FrBUmG35lMcDPsXNc8+zPl62BTTjsRvTcFwQGOrxNrdoApg3yMB7rFviXZ0Jt/Zw72lQ
	Z4CXg6Ow+Ep1ZjBTpchoxLB1oHSbXJEiUQ9MyUT+mGpfTsiAiRs5T5AtyldbyEBT4RB0FJq7G6L
	k6kWB3Z3lWiEUdOFKgTts1Gk2FZCSqHq/WUQtCpPFKL/gDuevNKam5XdE8UgyCdLHg1fdMP4igI
	zSvQopTOE5nJAZbByI7RSUXMMzO9n16I3NCpZ48/PY6epjpoCE4gpYhjZEkS
X-Received: by 2002:a05:600c:198c:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4b9633ce4a4mr47702765e9.8.1794173823321;
        Sun, 08 Nov 2026 13:37:03 -0800 (PST)
Received: from SurfaceArch.localdomain ([207.188.128.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee247e9sm92178595e9.6.2026.11.08.13.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:37:03 -0800 (PST)
From: =?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>
Cc: Sachi King <nakato@nakato.io>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Antonio=20V=C3=A1zquez=20Blanco?= <antoniovazquezblanco@gmail.com>
Subject: [PATCH v2 2/2] platform/surface: surfacepro3_button: don't load on amd variant
Date: Sun,  8 Nov 2026 22:36:56 +0100
Message-ID: <20261108213656.13031-3-antoniovazquezblanco@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108213656.13031-1-antoniovazquezblanco@gmail.com>
References: <20261108213656.13031-1-antoniovazquezblanco@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sachi King <nakato@nakato.io>

surfacepro3_button binds to MSHW0040 on the AMD variants of the Surface
Laptop 3 and 4, where soc_button_array is the right driver.

surface_button_check_MSHW0040() evaluates function 2 of the MSHW0040
_DSM, the OEM Platform Revision, and binds when the result is 0,
assuming that only a failed evaluation yields 0. The AMD variants
implement that function and legitimately return 0, so this driver binds
there as well.

Decide instead on whether the device implements the function at all,
which function 0 of the same _DSM advertises and acpi_check_dsm()
reports. Of the 32 Surface models carrying MSHW0040 in the ACPI dumps at
[1], only two do not advertise it, and they are exactly the two this
driver is for: the Surface Pro 4, whose MSHW0040 device carries no _DSM,
and the Surface Book 1, whose _DSM advertises functions 0 and 1 only.

The driver currently reaches the right answer on the Surface Book 1 by
accident rather than by that test. Function 2 is not implemented there,
so the _DSM falls through to a trailing Return (Buffer), and
acpi_evaluate_dsm_typed() rejects the type and returns NULL rather than
an integer. The revision is left at 0 and the driver binds.

Keep evaluating the revision when it is advertised, so that it remains
available through dev_dbg().

[1] https://github.com/linux-surface/acpidumps

Fixes: 64dd243d7356 ("platform/x86: surfacepro3_button: Fix device check")
Link: https://lore.kernel.org/all/20211109081125.41410-1-nakato@nakato.io/
Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Signed-off-by: Sachi King <nakato@nakato.io>
Co-developed-by: Antonio Vázquez Blanco <antoniovazquezblanco@gmail.com>
Signed-off-by: Antonio Vázquez Blanco <antoniovazquezblanco@gmail.com>
---
 drivers/platform/surface/surfacepro3_button.c | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index b38aa010053e..2d95a8ef3e23 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -148,7 +148,14 @@ static int surface_button_resume(struct device *dev)
 /*
  * Surface Pro 4 and Surface Book 2 / Surface Pro 2017 use the same device
  * ID (MSHW0040) for the power/volume buttons. Make sure this is the right
- * device by checking for the _DSM method and OEM Platform Revision.
+ * device by checking whether the OEM Platform Revision _DSM function is
+ * implemented, which function 0 of that _DSM advertises.
+ *
+ * The returned revision cannot be used for this: 0 is a valid revision, and
+ * the AMD variants of the Surface Laptop 3 and 4 report it while needing
+ * soc_button_array instead. The devices handled here do not advertise the
+ * function at all: the Surface Pro 4 has no _DSM on this device, and the
+ * Surface Book 1 has one that advertises functions 0 and 1 only.
  *
  * Returns true if the driver should bind to this device, i.e. the device is
  * either MSWH0028 (Pro 3) or MSHW0040 on a Pro 4 or Book 1.
@@ -156,21 +163,17 @@ static int surface_button_resume(struct device *dev)
 static bool surface_button_check_MSHW0040(struct device *dev, acpi_handle handle)
 {
 	union acpi_object *result;
-	u64 oem_platform_rev = 0;	// valid revisions are nonzero
+	u64 oem_platform_rev = 0;
+
+	if (!acpi_check_dsm(handle, &MSHW0040_DSM_UUID, MSHW0040_DSM_REVISION,
+			    BIT(MSHW0040_DSM_GET_OMPR)))
+		return true;
 
-	// get OEM platform revision
+	/* Fetch the revision separately, it is only used for debugging. */
 	result = acpi_evaluate_dsm_typed(handle, &MSHW0040_DSM_UUID,
 					 MSHW0040_DSM_REVISION,
-					 MSHW0040_DSM_GET_OMPR,
-					 NULL, ACPI_TYPE_INTEGER);
-
-	/*
-	 * If evaluating the _DSM fails, the method is not present. This means
-	 * that we have either MSHW0028 or MSHW0040 on Pro 4 or Book 1, so we
-	 * should use this driver. We use revision 0 indicating it is
-	 * unavailable.
-	 */
-
+					 MSHW0040_DSM_GET_OMPR, NULL,
+					 ACPI_TYPE_INTEGER);
 	if (result) {
 		oem_platform_rev = result->integer.value;
 		ACPI_FREE(result);
@@ -178,7 +181,7 @@ static bool surface_button_check_MSHW0040(struct device *dev, acpi_handle handle
 
 	dev_dbg(dev, "OEM Platform Revision %llu\n", oem_platform_rev);
 
-	return oem_platform_rev == 0;
+	return false;
 }
 
 
-- 
2.56.0

