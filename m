Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39984356754
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730443; cv=none; b=TsESztMmzBZn2Z7DyrHWkqZUvm1zAl+CUSDTouPlbBfAK7xo3G77rKl6/PnE7UG1OtUtBFlwG1SMiitpM/tKLCnQpMClJRzvVF4mlS1WFhZMJUpSvgKuLt0S4RSxBFc5IzQd7RIy0xne6zxh3XBEzxdXRYqNeNAjPl75zUGTKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730443; c=relaxed/simple;
	bh=yxyu4TafIzC4Fzi3U2zMmEJdSaIIbhl+1/fqKiyfzh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY+zQJRrWbzYulMzX69fZPT75VGFUw5vxD8YZKwD+EqFRkbeUvLLuaHHSehuo7wxMD6P7dcw0rGFpNPw+wN/CqxFPVv8ERvD4nc9HlGdLbPzJ1a5bQpIeBwUHBX0dpkbdi/+l0WmfeYGyabkgudk7jlX3QbxFqyIxz2XuRTiu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRBGS75l; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRBGS75l"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51a868b6962so144523191cf.2
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 07:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784730440; x=1785335240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBogkq6bXpW2SrdB8gUUtEgmwXCQCaUQO6IY6/OhnhI=;
        b=LRBGS75lOV/DcveESgD4t/LPpzJS7gPRVWMJ+MRrLxyfEtAqcGV7cB+twMotMIgbvQ
         yE8MvXWY7f6RZPl4PMxvbwM0sU5mo+ql6C7u1CqMd2QcLN9bWM+LIPqrbqHu4r4iKIJO
         uAmR3WaNUFjZmTnKhdaIf2NLyRjuTWAWoAqK5rgswQZj4dj+gz2dFrlmHDwV04Eu6tdS
         X46y5nOTKw+gJ/W1BK3+xIxEa/XSoOTrfIxSC7SvY8scvx+mTDn7ztLoLkIn9qxywS+F
         yhLXk038N2Rp7INTxjxtiv/2s2roHkfk6oRDhTitXlIGi7xzTOffWDbva+kTsPbSNM+2
         W3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730440; x=1785335240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBogkq6bXpW2SrdB8gUUtEgmwXCQCaUQO6IY6/OhnhI=;
        b=AMmDOcQMgNrYXXpXT79d4ZQ4jeMfY3utqzXTn1iiYrfuGadH/q9jkDoCKmkPFQBQ+3
         aUR8cVa3NvCONKxnsB0/M8Y5cawii/pYAVpmssUa0evgiALlsEqD7nxXbJ/kSj6IkM2C
         va4flETjoySE1gBiE2ekS2R/DvMTc8QrDnTD2YfW1eZSTUr7JQW+IHNACKmeGcu8Como
         7OqcVuwh73Or0dJo31ucp244ItxMqsIarHbl1jftPIEOr3hDHq19JoBrPbDYvI9kYibT
         3+b38S9NUCqoyVFzZiFATwnW1nyocg+ZkVs/4pI8guheGy+l7jtwP3NfWuZAFQLj1SxC
         1LpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrbDumCGwhMcy1UIQhKCFdPBdeLPqJn+qXlVNDncczuBDzklrIsIjtNrxipn3RfPdylPue2ut2OCTAoHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6rAXhj4v5loqyFLvJHHRb53EQF5FMdHmH63lqJ/rtSDXTIni
	SXyBM7yIdgAWLsD1dqXG1lYbb5ruEtGERu+c8rLWBqHi071/g/A9oy9W
X-Gm-Gg: AR+sD11B7h020qd96rbnESXRxjvQ1ESLvrSpBe9h0g1JvGsgdd2Qdqb18IhTnpFYA8t
	VuTlIbeTYgS9clv3UoPhaffZdsTh7IyqtkO0m1la+4uYtXKVLTmo0ZBO8m+Bt1JXem3v/FQ6J1O
	JvKDHLT2fBGUm2S3PblR9iKgrx/jdii7sA6hqBHd5zjTqBMLYVFe6QD0ly/YwwY2JfRKEPn3lrh
	59/FbA1uajv8eDFk7t3SIJqYWHmlgCt6j9zev5ENPEDnBSNabM54hkgg9Xly3Tnz9s3Nh3RS5Rn
	cv7U491w2NEKpBYYSJBBXcrDpOR8J2A5a/myariE6nitXnCoBw5wHW46LEjxG+zM2EFjlrpOht4
	1yFpJpbdloofDiesH9CvBPcS4jEbwql4kY64VsR7iDwHDNo51wJkyZ0Ru8N+QJXIbHLeZHYN61T
	Y=
X-Received: by 2002:ac8:5d88:0:b0:519:55c0:a1e5 with SMTP id d75a77b69052e-5213c8e3aa1mr212142181cf.8.1784730439956;
        Wed, 22 Jul 2026 07:27:19 -0700 (PDT)
Received: from fedora ([2600:383:441:9b80:8f82:4b87:4a4b:5554])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4fe92sm16224981cf.11.2026.07.22.07.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 07:27:19 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com,
	W_Armin@gmx.de,
	ilpo.jarvinen@linux.intel.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: [PATCH v13 1/2] platform/x86/lenovo: lenovo-ymc: Suppress probe on Yoga Book 9 14IAH10
Date: Wed, 22 Jul 2026 10:27:10 -0400
Message-ID: <20260722142712.814597-2-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722142712.814597-1-carvsdriver@gmail.com>
References: <20260722142712.814597-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Yoga Book 9 14IAH10 (DMI product name "83KJ") has a dedicated
yb9-kbdock WMI driver that registers an input device reporting
SW_TABLET_MODE to track the detachable Bluetooth keyboard.

lenovo-ymc also loads on this machine and creates an input node with the
SW_TABLET_MODE capability bit set.  For input switches, the presence of
the capability bit has semantic meaning: userspace (e.g. GNOME) reads
the switch state at startup from every node advertising the capability
and does not expect more than one such node.

Add a DMI match for the Yoga Book 9 14IAH10 to probe() so that
lenovo-ymc returns -ENODEV on this hardware, leaving yb9-kbdock as the
sole SW_TABLET_MODE source.  The ymc_ec_trigger EC write, the only
other action taken in response to a YMC event, is guarded by a separate
DMI table that excludes this machine; no other functionality is affected.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
---
 drivers/platform/x86/lenovo/ymc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/platform/x86/lenovo/ymc.c b/drivers/platform/x86/lenovo/ymc.c
index 470d53e3c9d29..a13c89dcb285a 100644
--- a/drivers/platform/x86/lenovo/ymc.c
+++ b/drivers/platform/x86/lenovo/ymc.c
@@ -24,6 +24,22 @@ static bool force;
 module_param(force, bool, 0444);
 MODULE_PARM_DESC(force, "Force loading on boards without a convertible DMI chassis-type");
 
+static const struct dmi_system_id lenovo_ymc_nosupport_dmi_table[] = {
+	{
+		/*
+		 * Yoga Book 9 14IAH10: SW_TABLET_MODE is reported by the
+		 * yb9-kbdock driver.  Suppress lenovo-ymc on this machine to
+		 * avoid userspace seeing two input nodes that both advertise
+		 * the SW_TABLET_MODE capability.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83KJ"),
+		},
+	},
+	{ }
+};
+
 static const struct dmi_system_id allowed_chasis_types_dmi_table[] = {
 	{
 		.matches = {
@@ -101,6 +117,9 @@ static int lenovo_ymc_probe(struct wmi_device *wdev, const void *ctx)
 	struct input_dev *input_dev;
 	int err;
 
+	if (dmi_check_system(lenovo_ymc_nosupport_dmi_table))
+		return -ENODEV;
+
 	if (!dmi_check_system(allowed_chasis_types_dmi_table)) {
 		if (force)
 			dev_info(&wdev->dev, "Force loading Lenovo YMC support\n");
-- 
2.55.0

