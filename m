Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E04363C5E
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823767; cv=none; b=spUqY6iAnF+VDvxZ+D0ey+MV75HqsJM44uBmMX4kUHw80KlCqQVQzElkQJnk/V9sM8TN5eUcwnlMhVOEJvxTdOGiRhz4CMXTkWaL6gNI9k1xC/7opgghSp8oJX76wQqi4K/kkimCJ1Voat1H5VB/M9mry537cSUtzNXnlJ02/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823767; c=relaxed/simple;
	bh=Y73P+DS/FTU/93/7veziKipaMWdTKZWFtdrT9hZPEZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS35EZ6j2L6dKBV6hoXpfFv1y0gva0TqgiiZoYc4xnalB6xq2sDLE65csfafdIfpi5NLSEnfvFWWyCizg6To8Oxs2xtKp64jmFr637UZ9a4sIsUIw2/eCanDahrpWXpxPutfA2ah0EGJADk5jjivrImul4pelRgsa/HT+GSMMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Uqhr98; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Uqhr98"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-837b39eb078so6016111b3a.2
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778823766; x=1779428566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QMruzNzp/w/H8WMl6Rm7xeR7IZKT2QV9Y6KPDlL64Q=;
        b=h5Uqhr98A/S+sWa891n/nmnzzvr/7o+Kxt+YySgyGIP/67X2XmE6pED4cwveVgY9h4
         hMxNtNMkWN8M0HfhFnJ6Y1K0qZHZ+E85ByyTCh4Biu9psn3h8fTEyzg4JxZMlrEzNjXW
         WdEsY4brrHD1CreJVnYW+gEjohMz1F8teTntonshydl28SBQL0hQjD0Gsald4IFPn2kf
         gVnmoObBr+8R6Iis3BRWgMQlSyL9fMdMfVowozSpmg6iHw6W8oEgm1r6rUHTUpG26WFV
         3Fy/Qqiai9h6wgM/BQxmXsjeLpLogntYV34iSsbUKXgIIekGljwC564i0Mvz8AVvEsVi
         aMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778823766; x=1779428566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1QMruzNzp/w/H8WMl6Rm7xeR7IZKT2QV9Y6KPDlL64Q=;
        b=p86I4JUrdtT5XrS2Mu62K605/D1DYlRfC7AnijM6VR0a08bFuRghk6lXZQAm1pvEBX
         3IvXrcJkeqkVSCiDXA0JQ22SXcVke00YWPTIHzgNFLl6zdYPrPsv9qIIF1e9CRr6/saI
         fEuDeYIvXqnQoQMwEWmkBJkTMPj6x94xUypm7kQI2tDI71/jqnhlw3+SPASmGdhJLY8H
         TuzJ4YizNPjHced5fsGfUkTKicXYJ1/13aiuYDwlxIOd++vdHeQMXf1g3cLJtEKtUqze
         hRLW7vOrLToZrK3QLQDLvkmIBoSpP2aN3ZRp73KzSqZpiHmNnJAvFisIkVjoWHMg6yiN
         j5+w==
X-Forwarded-Encrypted: i=1; AFNElJ/eAYJ07fAHaIvxvev5a7r0+nzNObzBeWf8/uS1YVoPP3ktnVp6edJdwEUjs2Wqj9A+4EoaZJGX2liVmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uGVv6DCYZz3AsviyKEOn8vQVoMknSIU/YD98ccaazNgVv8kr
	7bnT+9IPKSCfMww2n7AVtcAKGX0i97f/+6/FKTvF5sXnwfgkuAEMpvTD
X-Gm-Gg: Acq92OFjesuLe56/mfvF05NP11lrGf2j437fTzu+w9+GjtdKyLhmtesFaQjNgyfmtDp
	6VXUK0ZGbDsHQI2kjkXqTFLOOe12xAKTKQ9ySANqW+PQLqcHIRBvpHhnHWf7DbZOLYlfV3MIJti
	Cd58mtdpry6pCkorvc91YYY6Tce4qzj2zIqe8cgB8dbt7OTSWK4OxA/mk1UxcSa+RxBWkQ0heTu
	HIptGuKx857Idpsoe/OZc3Q15B7iSQ1ooYHagrTuFC0SQhvpXK9ysJMkeXt0EJ3BCgifkdGiYWg
	fitBpTDRRs4FoYGmw1c2yCe+kFq0D8CZ+Kc6C60gACfdLFawUDyLA7uZChhQ6TM33wrBXGdip9V
	4vdDv18l8ywQ+nAti7rep/+guI6UBNRBbcPiPEnuu+H2KA/9tiYJc0WFxuU1MPlkBbJWKK+e6Bz
	U1PvPWsGaxgT5fC430EZ2zEv8z5cB8qrnrTSPVMhUR6nTufGrNowl4lY3Dc8+1Fc+pLQTeEiU2F
	+U9oWoujgsTR0wWDlV1/zHWyrM=
X-Received: by 2002:a05:6a00:340c:b0:82c:6b46:271d with SMTP id d2e1a72fcca58-83f33d0a2e5mr2772793b3a.48.1778823765596;
        Thu, 14 May 2026 22:42:45 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com ([203.117.161.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:42:45 -0700 (PDT)
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
Subject: [PATCH v2 3/7] platform/surface: SAM: Add support for Surface Pro 12in
Date: Fri, 15 May 2026 15:41:48 +1000
Message-ID: <ab458aadea651396d9ea7629419a32dc7510c593.1778822464.git.harrison.vanderbyl@gmail.com>
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

Add a SAM client device node group and registry entry for the
Microsoft Surface Pro, 12-inch with Snapdragon.

This set enables the use of the following devices.
1: cover keyboard
2: cover touchpad
3: pen stash events.

The battery info and charger info devices have been
purposefully omitted as they are also reported by
other drivers and cause conflicts.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
---
 .../surface/surface_aggregator_registry.c         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 0599d5adf02e..884049961415 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -422,6 +422,19 @@ static const struct software_node *ssam_node_group_sp11[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro 12" first edition (ARM/QCOM) */
+static const struct software_node *ssam_node_group_sp12in[] = {
+	&ssam_node_root,
+	&ssam_node_hub_kip,
+	&ssam_node_tmp_sensors,
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_sam_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_fwupd,
+	&ssam_node_pos_tablet_switch,
+	NULL,
+};
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
@@ -500,6 +513,8 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	{ .compatible = "microsoft,arcata", (void *)ssam_node_group_sp9_5g },
 	/* Surface Pro 11 (ARM/QCOM) */
 	{ .compatible = "microsoft,denali", (void *)ssam_node_group_sp11 },
+	/* Surface Pro 12in First Edition (ARM/QCOM) */
+	{ .compatible = "microsoft,surface-pro-12in", (void *)ssam_node_group_sp12in },
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
-- 
2.53.0

