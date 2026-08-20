Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AE2DF3F2
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216969; cv=none; b=Pcmp8d0N9dzTVCWMTndnQjM9LdbueXgTBVsQyfMEFepet4KEB9n2S4ZObfmI/UfF8I6VdyIdgy297XHCHU43gCPBtvgdOtdnboVUc9uog9ErR4IDErBtqbI7A2n2rfn7Rpbg34oMK35nGfEPokqprY/LmCwDjunGsUWKlBbWMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216969; c=relaxed/simple;
	bh=wwvuPjuapQjXU5LmAnDyj/eJ3RlH36BJXhA7nPtYmLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV7y7+CviCTJc5LsBP5FRBaJIT7vU8UUJ5t7GIzJS4zlKezXzkfPCTk/vqaMOgOwN+T0/jHX2lyLvuh6wK6sJYJrucu8nqX+E1F3ew27Q6tv4DRqezPqNo2glrvhQ2MZrxpQceWmlAG3WZ4LFj3kKhdafsUSQomXn/6Je/N8eqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eSHCjvnt; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSHCjvnt"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so10217555ad.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787216967; x=1787821767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/aUN9M/7MSs8KdZPLXuIjECn3fEzCZmjfMVoJLIM9zI=;
        b=eSHCjvntCdONimzcOhm231RWsbbTOWMG3oknKKwjT0nE2klqc/4uRQPjiG1bZdYPZn
         7Jke73Zncxrud2Xi+RkDOuk8S85Mubr0CJKfCDLUwfCcqhj5QWeDBFmIAdAWy7JsPpff
         xPdovhQJ9caENV6iY0/jAGuEknyUryFV9A4NbzoyY5dJpqOQBdudON2doIggCLZFArBF
         ppmsZVsr4hoLzlxcgv0uRRiAuYU2CTzqYvWbO0SHltepqFXJiK3fWOaSpv3eToOPMfVB
         hjm8A/D7NdonjoCu0V/5Iucq4rs49s+tnW6Ul0aMPpdIMVWdTLVLW5sLqkECjGVBpfA4
         SkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216967; x=1787821767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/aUN9M/7MSs8KdZPLXuIjECn3fEzCZmjfMVoJLIM9zI=;
        b=ZAjdH6WhWi4yW/ngRJjVpZExX22N1zBtj1JTp0+uUdRPcl9PdSiNcxOFvw23I5ZYBs
         YMr7HpQKsUUPoybjZvbinNGDRFCZbxDPLtaMHr0Zn5W3SmVZVkfDLAfuRghPtM0jFbsu
         mqy0vihvVjzNEiFlW9IeIA3VZNblPyqcldBp76+qPF0ld2uXNbvNoYuuxKuuuQw8w0sT
         Vu5lU+G2XxSDCkBviBm2f9tFtgiTpwx2hifwpQDE639LpqIIHBvUr1iRHm9MeALzVnGl
         yoB7YDOy3loAMLZt73BFJ+vS/FwYDR7tW9fD3WH+TnD4gscB7/kF9wjiOvP49+MoEDpg
         QGpw==
X-Forwarded-Encrypted: i=1; AHgh+RqhvoV7xHicexxFqAIURTGGzwIRnRmQGqfF0E1x6jKosKY8XZ6uuS+2CYyvR57qPNeq+pGyEXueoC7m3A==@vger.kernel.org
X-Gm-Message-State: AFuF++neBp0+Y/tIDw4UAqgklgbihXJFitDvSQ3F3tqUVtTVBKtu3uiP
	ROOgDmhB7CpfheNEcPjGMYhjkINtTK75j5CRMx8M4Ka+maknUOcUg+A=
X-Gm-Gg: AR+sD116qGgQvFvn/BZlo9OZGSmRJqU8RSFV/JLYGlOwc4kUxjVpplNFL+Yg+DPeUkK
	zySAlluoXGabVKa9qayJmRptO4ArywOELWOPaOwAST/doYWG8pL8svsAsMAskw21mlNH6zBCJrz
	W95tdkhY7iNB6TBL0p1rsC4j1JhTW2u2tiOUZeuJaYuXzWvDimJfNHY26QQ53dLnPJH0Gv8HHym
	wle4wWwLh/NmY7RSxHigE1H0YgHVpYfCtNXziNq1j8zYC0Mhns370r6p6wuOWorp3O+PQXlQZbn
	4mmMD3mDYltqjxwerkTiXIoPlpzQ5oDXkuui2/jG/Lno4PVFecBafgUnEffcSD1vn3egHtxT++9
	evbLrGjCEv0LNRjeeKYwmvGZ9q/bF62jFM15MC5X/MlMtRy/pA6+fMVW8spaGbHHAt0L3RvfQ93
	T0zXwlIZ4dYpChazk68FkO80ueJWzeOo7FDKyTn2gx22wDPstmLdQLW7aWldGoddQmMvAyo+nHL
	w==
X-Received: by 2002:a17:902:e5c5:b0:2c9:e9db:8167 with SMTP id d9443c01a7336-2d601860803mr196465635ad.7.1787216967200;
        Thu, 20 Aug 2026 02:09:27 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62d58a811sm4190305ad.25.2026.08.20.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:09:26 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: basavaraj.natikar@amd.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] HID: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Thu, 20 Aug 2026 16:09:21 +0700
Message-ID: <20260820090921.2113684-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS
to DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend and
resume callbacks, and reduces kernel size in case CONFIG_PM or
CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 8 ++++----
 drivers/hid/hid-google-hammer.c        | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index eda26a094d3f..731dfdd459ac 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -560,7 +560,7 @@ static void amd_sfh_shutdown(struct pci_dev *pdev)
 	}
 }
 
-static int __maybe_unused amd_mp2_pci_resume(struct device *dev)
+static int amd_mp2_pci_resume(struct device *dev)
 {
 	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
 
@@ -571,7 +571,7 @@ static int __maybe_unused amd_mp2_pci_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused amd_mp2_pci_suspend(struct device *dev)
+static int amd_mp2_pci_suspend(struct device *dev)
 {
 	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
 
@@ -582,7 +582,7 @@ static int __maybe_unused amd_mp2_pci_suspend(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(amd_mp2_pm_ops, amd_mp2_pci_suspend,
+static DEFINE_SIMPLE_DEV_PM_OPS(amd_mp2_pm_ops, amd_mp2_pci_suspend,
 		amd_mp2_pci_resume);
 
 static const struct pci_device_id amd_mp2_pci_tbl[] = {
@@ -596,7 +596,7 @@ static struct pci_driver amd_mp2_pci_driver = {
 	.name		= DRIVER_NAME,
 	.id_table	= amd_mp2_pci_tbl,
 	.probe		= amd_mp2_pci_probe,
-	.driver.pm	= &amd_mp2_pm_ops,
+	.driver.pm	= pm_sleep_ptr(&amd_mp2_pm_ops),
 	.shutdown	= amd_sfh_shutdown,
 	.remove		= amd_sfh_remove,
 	.dev_groups	= amd_sfh_groups,
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index c99c3c0d442e..d7a504e48775 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -132,7 +132,7 @@ static int cbas_ec_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static __maybe_unused int cbas_ec_resume(struct device *dev)
+static int cbas_ec_resume(struct device *dev)
 {
 	struct cros_ec_device *ec = dev_get_drvdata(dev->parent);
 	bool base_present;
@@ -163,7 +163,7 @@ static __maybe_unused int cbas_ec_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cbas_ec_pm_ops, NULL, cbas_ec_resume);
 
 static void cbas_ec_set_input(struct input_dev *input)
 {
@@ -289,7 +289,7 @@ static struct platform_driver cbas_ec_driver = {
 		.name = "cbas_ec",
 		.acpi_match_table = ACPI_PTR(cbas_ec_acpi_ids),
 		.of_match_table = of_match_ptr(cbas_ec_of_match),
-		.pm = &cbas_ec_pm_ops,
+		.pm = pm_sleep_ptr(&cbas_ec_pm_ops),
 	},
 };
 
-- 
2.53.0

