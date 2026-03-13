Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0A3D649B
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424656; cv=none; b=VFIb9zq63/D301Lxff/pWRUS1gvMg6ye7ainXv8LkPrdbj0Rfx4Xrwv6rR6NTIfJKB6pfZR69SVr0QaGAWXeoB6lZJrZxDJcZ676dFzctu9BVvjF/WUe7a5wsH3/32pTg9qFNnXbf+m6HRa3FMyZpNJ8mG2isLkEYgAZOPP1ef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424656; c=relaxed/simple;
	bh=7DvK2Cesq3uS+IV6OjvcXU+zucdaoOaGHfwvTfAN2Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWBqqRKFbIgb9DXtzrTTHpZ8In9x1brLc/RuYKQoYtF3YclXo1eZft2w8A7H3yNJSO/qSsie50yGcdXqzHFkr0i1t0EN37ts9wcWS7GBz83J/rsIih7SjpZoTidBaBy9wZijIhuY0qr7yeize1+GN5kiQKYCYVgy2WT+WzRxusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=FhSxc7O7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="FhSxc7O7"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82976220e97so1503608b3a.3
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 10:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1773424654; x=1774029454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYCXjjkNHpaGN+AzxKSxGelwI1KQeqm0qICTePFBM+I=;
        b=FhSxc7O7H/d/Ynw9ObokG63ku1+fSytONt03idecLRvifHBrzE9GTWgFd58F4CR57j
         s7mXSDtJVxUlHkakNpUK2RxyBYvNQmG1Pvnc7CjS+evxWISfUDwnU3zjrkIV6ymAoEMO
         oLxNtGYrkaQgXwh5bnLQ0mYyRCkHveMeRntagS+Sn8pmxy2R6IOAS2zpgYmzEA5ZBUNV
         j46lJiy2l5uqk+yL9J0pp5WMdxNnazk8o84b7aIzcYQ5IkjHvWuEWb6ZLtkw7RsDAlIL
         zG9DuprAMOZx3lH5iDei4/fHG7eYiJpCI2NfEN5elzG/Cd/q/VYOM8wwFVuk3MLTT/e2
         8nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773424654; x=1774029454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYCXjjkNHpaGN+AzxKSxGelwI1KQeqm0qICTePFBM+I=;
        b=ezuW7DsWADFM5abU5Fg7E0bEeJYRwGM+KuV2rga9gR3rmFwUi+ORY03AsoqlKz1zp6
         IJkuIktQYBj+9FUyMOgowB2whp38i9zFgbiGMPJdxmc/mM1eXbihRPA2Oxza9h/02YrN
         bK4Qb0m2j/y8JwOp5Zpuzq/L0TYpXgmNBg6GyiVjA1R/iNJb5rhpVu4O1ZS72zHtE7gB
         Y/O/ZRckhaz9vEXPtu214xto0RgilXBSFb92UISjzz2NQgdye5Nu6vgR4q3xnTDG5Az5
         5+iWfi63V66PwlqbDlAVtYGel/nbDaqgworymzaQAHVLnyHJ685lTzfpXXAh83zJiyxZ
         M34A==
X-Gm-Message-State: AOJu0Yzvn2SNWGMGgUhoAQGvuWQS29spX0jS2OP0L35Op/gDKRlRIdI6
	v+agCFhN+uw8zMjGwSXi3/2L51wmnJfFwcUv6BQJYBL+ev3W9LtpsvG9XPUdHan4VwBsopvBzBG
	jHsxq
X-Gm-Gg: ATEYQzwX/RHOGlpBGvJFJtIppWrqAGWgTNYQ8AMvGUco7DR9qD51q7K3RjjjQ6IriOh
	4/kFNq43BbYozR4vYyJELJxMs7dx28/+05qxldO8sDm1B0qshxnMsYtj4KPMAQi94n5Uq81xdxo
	ipJXWPYR0w4JUOvmeuvEQ9XcncJE23OkfNOSCTWgPQmBGPYaJna6HV0NCGpfg14U32IpFDtxCQ4
	OaBSEGQW8ktrKRZIuGstyq48deNtAou4Jzxhtoy3U5sfkI7s5j8re5GtkVPk49G3PmaOEZIW8kt
	8juiRBlbAouW7JGGIsO9LcQjXSvF18cpNDXL7Cyus4wZjvvX79Eq4awBEwi2679V4c2dTG7Eqi9
	T5sS22V4Kxtx+fccy9IhjoPOipeh3tp6gJSfXtCI1wt0Tc1k4Wnb/pm+lZI6+pULOfcPfgRPJ01
	QNlb+9HkAN1j8Ndbw9Cy5vXc2geUHodbKqWuCHfVbJn5GOtzIiroKJbAMzBWz78tkAeQX6Jfqs7
	BKGDVOc576rRhDr4TH/sme09XlzUGWrt5GeDQH2bVXKUmvNKK84jmaO7YHF87e3QolU+XCE2qXp
X-Received: by 2002:a05:6a00:a112:b0:822:1dbc:e75d with SMTP id d2e1a72fcca58-82a196da79emr3553360b3a.1.1773424654180;
        Fri, 13 Mar 2026 10:57:34 -0700 (PDT)
Received: from nixos.home (2001-b011-0001-3a55-372a-4d8b-a513-4837.dynamic-ip6.hinet.net. [2001:b011:1:3a55:372a:4d8b:a513:4837])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm6265488b3a.8.2026.03.13.10.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:57:33 -0700 (PDT)
From: Daniel Schaefer <dhs@frame.work>
To: linux-input@vger.kernel.org
Cc: Daniel Schaefer <dhs@frame.work>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 3/4] HID: surface: Use device version instead of HID spec version
Date: Sat, 14 Mar 2026 01:56:58 +0800
Message-ID: <20260313175659.268094-4-dhs@frame.work>
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

Use attrs.version instead of hid_desc.hid_version for hid->version.
The driver has two structures with version information:

  - hid_desc.hid_version: HID specification version
  - attrs.version: Device-specific version number

The current code incorrectly uses hid_version from the HID descriptor,
which reports the HID spec version rather than the actual device
version. This change aligns with how other HID drivers report device
version and matches the attrs structure which already provides vendor
and product IDs.

Cc: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Daniel Schaefer <dhs@frame.work>
---
 drivers/hid/surface-hid/surface_hid_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/surface-hid/surface_hid_core.c b/drivers/hid/surface-hid/surface_hid_core.c
index 6690c24f28f0..e31d6597bc9b 100644
--- a/drivers/hid/surface-hid/surface_hid_core.c
+++ b/drivers/hid/surface-hid/surface_hid_core.c
@@ -206,7 +206,7 @@ int surface_hid_device_add(struct surface_hid_device *shid)
 	shid->hid->bus = BUS_HOST;
 	shid->hid->vendor = get_unaligned_le16(&shid->attrs.vendor);
 	shid->hid->product = get_unaligned_le16(&shid->attrs.product);
-	shid->hid->version = get_unaligned_le16(&shid->hid_desc.hid_version);
+	shid->hid->version = get_unaligned_le16(&shid->attrs.version);
 	shid->hid->country = shid->hid_desc.country_code;
 
 	snprintf(shid->hid->name, sizeof(shid->hid->name), "Microsoft Surface %04X:%04X",
-- 
2.52.0

