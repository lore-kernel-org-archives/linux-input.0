Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79DB640
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786202273; cv=none; b=XlM5tGr/uhhJ0ErgSjie4kr4w0XDf62qToy3B4hHwLY/i0ZmmUOZA5X3e9QHNH/MgmK3l4CRjcHJZPF1UgCFc3E1tr7dZe+bow3x2+5gt/lmBzMI+qnq3bBONej7T/uIevDZ8TP2bW2CFTEsqjeIsHoHtyMo+/u/LoCD32bysYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786202273; c=relaxed/simple;
	bh=xssF2DxPlOYLL/bp5ut8oCHqoOExGf4sNpWxtIRWBpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD7IfGnJdIuQ5mwmtpezvn6z+YvpbitkVM3wXLwzoEOXa9iVihYUx1PEWCdvUUPf2SwL/4udnV4rEiWI33ZHl022BIOkKzbZybK2S6qzoZZqrDIz24/kdS2WHIeG7LlRJ68CJ6rtePKseI92JxerMuSPAFMLgcz1DNJO3GeVF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQp3flAY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQp3flAY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84f3ab8750cso484545b3a.0
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786202271; x=1786807071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I4mXlEdYH/oZx/ClkXFbjfrGF0NBgv0NP1SaOJhxp9k=;
        b=JQp3flAY6Nj0jlUNocaSczF3vhorJOuxIN+ncj1B3EHuSz5O6Gqkl1rLXrLF30lcxv
         yh03NgXAtbxxA5enBvqTg2Ff7DaU2UCBncCGdt4mkx/GkyydbdT7/lmfNNwe0W2UUsbW
         7y7IAvoZuMwB3PezpYSbVG0uEciwHEbMoEraXXUjWCRyBSAudeH8DZ/Yzhn6oUO4z2Sh
         isZGlzaJlLlwcNwMwlf2BSpBUJgd7rT7RZqH2DC9zobVfgWbEiPbXoOZ1igjSvAyZn1C
         2K9R73wVsvPmbU7te7XizLGWJRviPJS0bu5kLiUDMMqcWfQeimKdOl7QJ1NrwlGeczVs
         ly6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786202271; x=1786807071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I4mXlEdYH/oZx/ClkXFbjfrGF0NBgv0NP1SaOJhxp9k=;
        b=IOwMg1JJifBo+3gAyZdFBec9FxfolteJsif/MudbaNziQks4Ym6gz0lOaylluMV6Wz
         lgpiE4btCSoQbZZl1Gh9l/CrBlS1Phu3nKDPcP2QX2+ycWjCp+MGUuBkJpW6Xf1PuN0z
         jr/tD10vCdAcOTMIfmxhVfQanQyE8L4QKlx8I7kdPkZ54xMn1y/ZA/oYOvIZCmkP0iPR
         CeNeRWLeV3pMtfei5CMGsempKxy/fa/z8Q4TLbbhSw2VvxszEy33vELcNNDbSEbCHPI+
         +ZZL/IUnP7nMcAjJJrhCPgCO/djTBRJxp25z9YMzzgjRxSDad7He5F4PF/y5lUt/p9tt
         IZeQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9di/mvw8peFptXKuc0NTdZytwMU6sGey0Trfem5utYPj82cdTzHDpU5OZmaqM8VfVaMTbL6ROymzi5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YycHGpUJveQK8z2GiO2aCZ+J8oq/AGgPGNgQ9zmQNOYCUHVAsg4
	OuDtEOd40Y7LS3/fSXPDnkN3182jgrO9i3EfpNoCUwAbFSMbTtysZHr+
X-Gm-Gg: AR+sD12jx+APOjZNRNo7zgEk7pEd6H1OVigvO/RnbIk5YmMRhQVZ5Edp5fajFa4yP/B
	bOWw5KGnIQv2RY2JhRTIdu1pdXqro7YavrPrZdfaS/cDg21rztb7Nc0uh6yCqjjXCjizu1bwE8k
	dwolC/Vq51uJ2hWvkeG62KaPVYPw0U700Ag1kwsX7dtPMba9oUDctdPXj/zARDgCt+rbHOzi6X4
	rPSIHLyxPuacHiU4PjsnJrXO4ILY9Znd0Nag7nl71fVPEDV10mMmeYunFbHbJmaxTNT+rCuH6qa
	yZ3sVLO1wQEefup1N3FrugendP4zUD8yvPseyWGZiLblRrycTghlDJyWsJP03TyBfMy2u9AKRAs
	283fEQiPJxmLXOizvrPrOW0JXi5uge1JEYCnOqpFzwTNV5FQlGpiJRUDMR+PJFi48eeEQRWKZ60
	v7XivXPsGIF5qOJKNOSldenjjkk26Bctl9VpZjnc54DcOk+Z5+3nsCaCBhCpQgDw==
X-Received: by 2002:a05:6a00:99c:b0:847:80f5:c616 with SMTP id d2e1a72fcca58-84f2dfc89b0mr34455767b3a.10.1786202271396;
        Sat, 08 Aug 2026 08:17:51 -0700 (PDT)
Received: from lgs.. ([152.32.188.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f35b0c3sm1953618a12.15.2026.08.08.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 08:17:50 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Danny D." <d3z.the.dev@gmail.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 23:17:36 +0800
Message-ID: <20260808151736.2934050-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

quickspi_probe() calls pm_runtime_use_autosuspend(), but
quickspi_remove() does not call the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 6912aaf3fd24 ("HID: intel-thc-hid: intel-quickspi: Add PM implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 4ae2e1718b30..3c87519aca84 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -713,6 +713,7 @@ static void quickspi_remove(struct pci_dev *pdev)
 	quickspi_hid_remove(qsdev);
 	quickspi_dma_deinit(qsdev);
 
+	pm_runtime_dont_use_autosuspend(qsdev->dev);
 	pm_runtime_get_noresume(qsdev->dev);
 
 	quickspi_dev_deinit(qsdev);
-- 
2.43.0

