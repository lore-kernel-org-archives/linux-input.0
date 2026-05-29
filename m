Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C2E35F18B
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093349; cv=none; b=dhmZc0OyfK6OZoPFgtf7bXDXbFie32e+Vh04HPvMxxocqCapVSvy6SwhioZxnLkANfLggD+jOgqoDlWIH3XBMeZNWdcoUg+raa8g0TYpWM+1OdxsmzEmwUm2tPteaI1jrnT/fpV/XJBvbWrySQTH1Kij6iJzKr3/gpeZFkqPh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093349; c=relaxed/simple;
	bh=JEuQL2RJL9RfwrvEv1c547OKbPPTm0o029ut/0JwHsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibIK9so3UxvNAEW/G9nZ6nFoifF+sAULu8YaJhosHWsqwgLZ7TDvFjhRGf6oDsQWHOwlChF5mibIT+5bUlJMrdgl5O3uSIIef0unJNQWDPSAmEXXYbaFCOcJhct2iMVXMY3U/t/DRrAp2XjAQvf4iM+yo1Et9IVudYr/d1RlptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEiSm7a6; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEiSm7a6"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-441209fb77eso8876243f8f.1
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780093345; x=1780698145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELmzuHQxMU1Wo0i+tJpd+1vni6BbbsF517DJDCEMeA0=;
        b=SEiSm7a68iSpsewPY8aLbRVmU2xbfSR+q1qOh1WLvNLJftVz7ZlW7fZdXY10jWbFgY
         DYCNwIk2SFOT4nIyywd/zHmdg2cuNLl7W5iyAeCP744pA1UR9ZPtE0gxNv8enW5LpPDM
         EmZDhxTenDrSCaBCtrHbfhW89ZNazY6/T9V0KTu6k4WR7pI4G071N/LbD02qSYUP809J
         vpAINPq1Hc5k8fzWjUUikPkG05ab2pxwiP3jQTETA2PqKRywMhrS889yMzcn0I1JrKyW
         7cP8PdPiFkQVtxcPjAxqJI6bf0kBskx8+zJPGBiOzxP5EvQdFuI7PS85tqdrhGr2SmoE
         jkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093345; x=1780698145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELmzuHQxMU1Wo0i+tJpd+1vni6BbbsF517DJDCEMeA0=;
        b=T8UVMDfPMCIn2W9ayPQZfMN5g7pZL5DbRPspJWzlShTSQJLn75Z3MYq4zn6nzCX9C7
         F8d0MI7AuQNCHSZAdaUr67NNvV/aZ4VovTFF5NlNLSo6fw9LHsN/mfzMG68GEEif5ld2
         9rM3LTTbYuz3dAOBUNzLw4uMmbvVt1jClRl9bOEqui6qBb5J37hsyVEpnzRcOnJ71zfD
         Qmws39WF6d6Z11el32bfBX6S3xDdQeYDDYh2p0+QQnMz8Orf5b/0JKLafX5i4Xna0hzq
         mdX/GPBhRRQMvN230HfwuScd68D8R3nQUEZYkRKm5YBACxQTI9MZ2I5WtKVEWCeZsGWy
         QxtQ==
X-Gm-Message-State: AOJu0Yy0T3qsHp48+xdzyXx2nbX2Mx7+fr60Jq9r/VaukJ9djQCmIk75
	EJETBqIilgeoKIzlgbVuODqs5+7jBejD8/90XiZrdMX1mhhgpsURHOfWvjZUuGW9Ok0=
X-Gm-Gg: Acq92OH+7yTHTnDYEIHaVVj8ESn1tH7UDcTWR04uHZlhISeqBr1CkHNcsFZvxQAhSHb
	ZdwaCeW7DEURf93UdFA8+bGKNCyYSLzqQb7g0GGsVQrYG34NCtlL3mxohm1OxICihScHRJfPoaH
	FMqzUFwaiVaxkF4Kdy/YuYTvd7tz5n5WbQlQkCM4Yztl7eS4HGeu2NidVMElSdepIIWP+N+Th0r
	OWK8MDdMWVe7rN/iOnOfwA5aYmZDWca7lvX0ZFFSc+0u07IhKdvWjkHHQB8pA0Y6+iwvbGjBrBR
	5RLyDPbrwvpe/PpWkYVKNOb/0w01D+lfSGJb99BHPmWrNi7IrZoJuLaIVSvCXCY3bRIVCEiqqAH
	4kyyUuFbHtJRysKWb28rFicn+tOnXWcW14z7u9UbabvIRq+5vuE7aRmdEOva9O5GFUnUfvt/iSf
	dPvD8Ozj19/gR/Dw+tVS89HnoGu1u2bm0wP9m8GO8vFfgRz2KASGnCV9kk5nIkLprwcw==
X-Received: by 2002:a05:6000:1869:b0:45e:8ad3:86a9 with SMTP id ffacd0b85a97d-45ef13397a5mr7475761f8f.8.1780093344577;
        Fri, 29 May 2026 15:22:24 -0700 (PDT)
Received: from machine (host-176-37-220-32.b025.la.net.ua. [176.37.220.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b5bdsm6068735f8f.21.2026.05.29.15.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 15:22:23 -0700 (PDT)
From: d3z-the-dev <d3z.the.dev@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhishek Tamboli <abhishektamboli9@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	d3z-the-dev <d3z.the.dev@gmail.com>
Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume
Date: Sat, 30 May 2026 01:22:10 +0300
Message-ID: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the Surface Pro 10 (Meteor Lake) the touchscreen stops working after a
suspend/resume cycle and only recovers after a reboot. The driver logs
"GET_DEVICE_INFO: recv failed: -11" on resume.

The touch IC loses power during system suspend (s2idle) on this platform,
the same way it does across hibernation. quickspi_resume() only restores
the THC port, interrupts and DMA and sends a HIDSPI_ON command, assuming
the touch IC kept its power and state. When it has actually lost power the
HIDSPI_ON command is never acknowledged and the descriptor read fails,
leaving the touchscreen dead until the module is reloaded.

quickspi_restore() already handles this for hibernation by running
reset_tic() and reconfiguring the THC SPI/LTR settings. Make
quickspi_resume() do the same: quiesce interrupts, re-select the THC port,
reconfigure the SPI input/output addresses and read/write parameters, run
reset_tic() to re-enumerate the device and restore the LTR configuration.

Tested on a Surface Pro 10 across multiple s2idle suspend/resume cycles.

Link: https://github.com/linux-surface/linux-surface/issues/1799

Signed-off-by: d3z-the-dev <d3z.the.dev@gmail.com>
---
 .../intel-quickspi/pci-quickspi.c             | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index f669235f1883..d59278a3e5c1 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -780,24 +780,54 @@ static int quickspi_resume(struct device *device)
 	if (!qsdev)
 		return -ENODEV;
 
+	ret = thc_interrupt_quiesce(qsdev->thc_hw, true);
+	if (ret)
+		return ret;
+
 	ret = thc_port_select(qsdev->thc_hw, THC_PORT_TYPE_SPI);
 	if (ret)
 		return ret;
 
+	thc_spi_input_output_address_config(qsdev->thc_hw,
+					    qsdev->input_report_hdr_addr,
+					    qsdev->input_report_bdy_addr,
+					    qsdev->output_report_addr);
+
+	ret = thc_spi_read_config(qsdev->thc_hw, qsdev->spi_freq_val,
+				  qsdev->spi_read_io_mode,
+				  qsdev->spi_read_opcode,
+				  qsdev->spi_packet_size);
+	if (ret)
+		return ret;
+
+	ret = thc_spi_write_config(qsdev->thc_hw, qsdev->spi_freq_val,
+				   qsdev->spi_write_io_mode,
+				   qsdev->spi_write_opcode,
+				   qsdev->spi_packet_size,
+				   qsdev->performance_limit);
+	if (ret)
+		return ret;
+
 	thc_interrupt_config(qsdev->thc_hw);
 
 	thc_interrupt_enable(qsdev->thc_hw, true);
 
-	ret = thc_dma_configure(qsdev->thc_hw);
+	/* The TIC may lose power across system suspend, reset it to recover */
+	ret = reset_tic(qsdev);
 	if (ret)
 		return ret;
 
-	ret = thc_interrupt_quiesce(qsdev->thc_hw, false);
+	ret = thc_dma_configure(qsdev->thc_hw);
 	if (ret)
 		return ret;
 
-	if (!device_may_wakeup(qsdev->dev))
-		return quickspi_set_power(qsdev, HIDSPI_ON);
+	thc_ltr_config(qsdev->thc_hw,
+		       qsdev->active_ltr_val,
+		       qsdev->low_power_ltr_val);
+
+	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_ACTIVE);
+
+	qsdev->state = QUICKSPI_ENABLED;
 
 	return 0;
 }
-- 
2.54.0

