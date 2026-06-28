Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD023BD1B
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665221; cv=none; b=PcyE0FA567DAaH/MwUl0aZ3X17CvBFvLRokw6n37V502g9R9jqXlbfHbcUQa4APbCS3cYaX9yujA+E3gdLQhL9P2ECS7vjB7KBkFXdXjJHT4BbtaR+MIm223T2nWMtClZENsuPkFmhOPXEWSEXrJ/B2/vnnJhFJ+Fh5LqvjMlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665221; c=relaxed/simple;
	bh=5gd6GaXYemQn3bjFuTsTrUQliIBG/SFUr2HzcpB/QMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzY+kjbJCFvEMRvO42bNGHwfj7+zqFYcjYazkuPbFVZxZkQTO1XHQSTGsdlOXyS3+7WTpqqqT8v5Uqp0hEunNxhuCpH0wFSINCU1z+ZaWc4mcNE0UGfjt6S+Cc34k+0OHJ+AzgwjTFIEFRvFTyi86ikA6U2c5T4ps7guvR2FNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUopzp+L; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUopzp+L"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so7025735e9.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782665217; x=1783270017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qzlkLhjbs2w3dy46vx0q5tqaHqyJ3TWxMpmHk+cSsU=;
        b=hUopzp+L3hkEALFeWCJOTh5ng/VjmJrLmrlXAzDprnEeT4x79vpZZP8iSDKgJ5+xyD
         hbdu2GIiytdDE7ZdElsghQrNAha7yIgj3fGK/2Yopv0Ah3E7ugtTM4MeM+8yXDDQWGvD
         clRtZUa74RjPukllSbByAHqE6/EUb49AfuGhd4MOC/U0qhDhUhMYTcPXt8Rw6QAub9jF
         N3mlP2PwtoGBnSpu/5rC9hmXYeg2nnp5Cxeub8QNDnTpbzOwpp+Afir7u6K+zYZqM+2a
         h74e3E04s1WT5/4Z02TYT0EHX3bvs20vczS6yg02BWKHS1gUvWl/K+gJ2fFPpNupyQpD
         JYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782665217; x=1783270017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0qzlkLhjbs2w3dy46vx0q5tqaHqyJ3TWxMpmHk+cSsU=;
        b=XDaO+bQxYGTfh3ETg0pvEKVFRe6mlderPxbxqvjDb/162WAuzs+0rZQ1lMfAXcl4cW
         sFtTQBVGz2+2ZAxNUeOaa0I8RIDWLrLlnEdHUaONm8vRo2Sx29nlMlhCf24Eiof0X73V
         C7toLvNa6C2b2yEsex0fcwj8bXHN5vDOdjuDevSWtKWbGSyM0QC7RupDSD5UkYnfjXsX
         GsgLQLx/x67gdE6N79miXQTr8E4CGe2UcotvvzlbLQMKY/XNojGBKrQm9IwOtd0ninbL
         UUpDRzKBkYZBg+67v3nEwH/BNl0sdE+0sSEGP0ACy7zVaK/4WRt2ChRkgZYUT/NVCxOo
         vQjg==
X-Gm-Message-State: AOJu0YxzNmqMmlb7ptRcDaJT0sqAmh94Cu5CpFimpIOWZaxpnO0p5eY4
	lPm8e7x5FWAGVa8a6tFA41Mi9Z3YhYYjhsBSENkZgPd6fvvU6wzH4rWg
X-Gm-Gg: AfdE7clCbE0HOrI9DDfS7+9sYy1V3Il3Wgtbnp5nYoW3NvW2WVQ4jUvTUQ+vtbOV/bY
	zBBfpvA+nk3yu/MDuTElmWz9Fba6BRRPIN3s1EAMczRx3LbxcSceYKA+oOoXIZ4aRIQ4lHAB459
	ERh6nS9MZAWqM9wKWNn/dSDBo7Mz33XYi4XrpT+Yd8iPMx+5aVT3ltiv3eRwf08b+TKZQA+Igqb
	uhIsIl3geblAeAcSP2jlkqgKEcqSD2k48nEZfJ/i6CsN10+++v2KLq7JbFEU9b+hWASmWNex+aH
	RZW/4pCunAGI8wN0nxvckvq/PNymswJjeTC+DbK4AW0o80D3BryEYfO13eJs5i9/qWSXunOgxiK
	plnFN1eMC0SV86ykqlhx+1/n4CdDRhJqjF9HoiDyXjyepIIJDt0f/xthxUZ0KySV2RW4jDGW0Wx
	OZ8hsbiZciZpfKezO45mgCFqCXrA==
X-Received: by 2002:a05:600c:4fc2:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-49266423f79mr189832825e9.14.1782665217301;
        Sun, 28 Jun 2026 09:46:57 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c285fc1sm162770715e9.1.2026.06.28.09.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 09:46:56 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH 6/6] HID: roccat-ryos: reject short special reports
Date: Sun, 28 Jun 2026 18:46:11 +0200
Message-ID: <20260628164611.17467-6-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628164611.17467-1-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ryos_raw_event() forwards special reports directly to the Roccat
character-device layer, which copies the fixed five-byte report size
registered by this driver. A malformed USB device can send a shorter
report and trigger an out-of-bounds read during that copy.

Only forward complete special reports.

Fixes: 6f3a19360545 ("HID: roccat: add support for Ryos MK keyboards")
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hid/hid-roccat-ryos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index db83f42457da..5087defc7c37 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -189,7 +189,8 @@ static int ryos_raw_event(struct hid_device *hdev,
 			!= RYOS_USB_INTERFACE_PROTOCOL)
 		return 0;
 
-	if (data[0] != RYOS_REPORT_NUMBER_SPECIAL)
+	if (data[0] != RYOS_REPORT_NUMBER_SPECIAL ||
+	    size < sizeof(struct ryos_report_special))
 		return 0;
 
 	if (ryos != NULL && ryos->roccat_claimed)
-- 
2.54.0

