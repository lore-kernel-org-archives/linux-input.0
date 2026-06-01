Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8434C124
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348732; cv=none; b=mDCApbw2vitL+IK89VRCWOPupump5z6TqxDKwHepeh7KgHvZVTCFE+dv9tD84FJKiur+/0aEjt2xmWBpGv0zCOxt9mujr20T/rT2lKuliyjC92lVXrD4mWkmj+DrmYXekCCr1YPkm/YiyKrr5h9GwNAILUtW/MPlgWpkl/LhvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348732; c=relaxed/simple;
	bh=2W1EiUsb41sQZLvW0BtrYyUc4hD9Om3xDGa9qo8ynCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1iV+VC5U3NVplS2gMiQq/st7F+lBt/UiRBI9NZFygV9Rk/oCIlEUDYwW7VPtyCisD/uE3lLggkIX3mIrR4Vbuj6UqnuUyailvqR9BEB+yBaXfSoX7KHbFnAm7mi246Ou9uXxRnTUYIPjoysHdEc5IWPqKGNTKzIHtUIDeDf/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGcg25Wf; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGcg25Wf"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so108757745e9.2
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780348729; x=1780953529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53lhlNrcHeaopLhaDamN7acjaUt2oSMtLVE43w15JsA=;
        b=kGcg25WfOq2R942DzVbQJ7Rb6TLm/LkEtd59hyiKKN+HtIKyllRpWIYSJFF2XOKOfh
         m0SbXCzH52xx4aOcs+sSGZQ/nnNsp2+Ex5gEh6OMuSnVuqFlxapm8PezvFbU0pbLLHos
         2brs4LHv+1zhSU/M68zvdzPsgYyInhO3Iyn5EAMSDuEGD2o0cuN5yFc1wUyzg0A7Ohij
         SokCJuLDMzGFaYP0VWUtBftaGwCpkKm95DYI0SpxdOKoaLVlLMiOCxVGxkBeeBpWfUAU
         V5eY3NuAtQA2DyADc/YmGjMrmZGIbj/GrhmuiSDbU7X/mqTUlz+In1StqJSrcgKpbLJt
         oX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780348729; x=1780953529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53lhlNrcHeaopLhaDamN7acjaUt2oSMtLVE43w15JsA=;
        b=EZRNz5nY9shpCLUeSCyQI+gLGtm1JUDPE8hqRycy1+HCRjAuMPngQu9RhSjhImTE87
         4J2oEINSZn4g4kk/cOLgGYhquOmFwcX5ybwy1KXGeyDE26EIxBKrzPnf9cD7w0CWa6wa
         BoQMb5RD2ifcKG4CFNL6LFzt8AopevCWOLWZL3JnDJS6gGZEktStm54YHsdA/l9pabhe
         XtltY2TVkciH+MtYFmG8ilCRqAM7gTl7upsf1UDKyAnRhECoSTCxvWELw/cJwCS642gL
         HAY3ZfODuCvYLopY+9xNJWmZvOaZ/wPhgWMRwCNIRnuXGB5CG8XgzrCgDl/jW5dFq/3Q
         6cig==
X-Forwarded-Encrypted: i=1; AFNElJ/OgPvoRdAq3Hsxj/4Tn4+cx59te2PdIWModLEJL9DVwTVpCPkyqOmwSK7Mlm4CBbEvsYVLuMUd5tJO/A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36bxbYHw//ICpod9a8FBa6n01RHJsKf79ockkos+1XVg79TYp
	Hu2NPmfDLVF35liegGPfOuiBLSysTiukkiqjNvJFYRHbM93U0MA8cUyB
X-Gm-Gg: Acq92OGlfoKOSQjfkehyOPotXGOkgkjm3ztgzbKsyRKPClbsuXkf0pJ81V3XmgNbpzA
	vRAR6IuWG744nFGfrSxaqG+CsWy0TP99QKp3nrTuLstEplrQ8Eo5iurXZjFxJpu8PL31aY0AVsR
	8bJXrd7xSC45b2eTFWCHC5Py0f3qb41H503yyQSk4EuDNm1KY8K5CifJKwTJ3z1gKWojQWuwLBw
	VRAGfJiWw0kdMQjEzUuu/o6W62nQIaOwDCHYpH5EGK2P4JOy72tz47Jt6hKrktv8yQSkmiAfn3R
	rhPfhLiiDn0t1W4sxUx/NzQ0G9NhKFiBh7nvxDhzNBYlImEZRnRUeDel3BSwhwF6FhL9KQVKvgL
	9O+S+oxqtQ/tF5vlffoGrUXaqDrIijvugh24Y1B1Q+7Sdfi+kcuS/9MZfjWCR/YOzikCKJim1Ns
	hmPxiZAk3ithBeRtvClz2ogjMb5ZaRIvI/JJ/SnIcPjAMZ2KJ5lVtDscX/p6gWE0VxHUgi/ONnm
	JJ2
X-Received: by 2002:a05:600c:a4d:b0:490:b1ab:e41a with SMTP id 5b1f17b1804b1-490b1abea47mr5163955e9.32.1780348729014;
        Mon, 01 Jun 2026 14:18:49 -0700 (PDT)
Received: from machine (host-176-37-220-32.b025.la.net.ua. [176.37.220.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09ab75sm84481435e9.6.2026.06.01.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:18:48 -0700 (PDT)
From: d3z <d3z.the.dev@gmail.com>
To: even.xu@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: xinpeng.sun@intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	abhishektamboli9@gmail.com,
	"Danny D ." <d3z.the.dev@gmail.com>
Subject: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume
Date: Tue,  2 Jun 2026 00:18:28 +0300
Message-ID: <20260601211828.112626-1-d3z.the.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danny D. <d3z.the.dev@gmail.com>

On the Surface Pro 10 (Meteor Lake) the touchscreen stops working after a
suspend/resume cycle and only recovers after a reboot. The driver logs
"GET_DEVICE_INFO: recv failed: -11" on resume.

This platform suspends through s2idle: /sys/power/mem_sleep exposes
"[s2idle]" as the only state, there is no "deep"/S3 entry at all. The
touch IC nonetheless loses power across that s2idle suspend, the same
way it does across hibernation. quickspi_resume() only re-selects the
THC port, restores interrupts and DMA and sends a HIDSPI_ON command,
assuming the touch IC kept its power and state. When it has actually
lost power the HIDSPI_ON command is never acknowledged and the
descriptor read fails, leaving the touchscreen dead until the module is
reloaded.

quickspi_restore() already handles this for hibernation by
reconfiguring the THC SPI/LTR settings and running reset_tic() to
re-enumerate the device. Make quickspi_resume() do the same when the
device is not a wake source. A wake-enabled device keeps its power and
state across suspend, so it stays on the light restore path: resetting
it would discard a pending wake touch event and break wake-on-touch.

The non-wake path mirrors the existing quickspi_restore() sequence,
including enabling interrupts before reset_tic(), so it introduces no
new ordering relative to code already in the driver.

This change has been validated on a Surface Pro 10 running the
linux-surface kernel across multiple s2idle suspend/resume cycles; it
has not been tested on a mainline build.

Closes: https://github.com/linux-surface/linux-surface/issues/1799
Signed-off-by: Danny D. <d3z.the.dev@gmail.com>
---
v1 -> v2:
 - Only run the full reset when the device is not a wake source
   (device_may_wakeup()), so wake-on-touch is no longer disturbed.
 - Reword the changelog around s2idle: the SP10 has no "deep"/S3 state, the
   touch IC loses power across s2idle.

 .../hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 60 +++++++++++++++++--
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -784,20 +784,72 @@ static int quickspi_resume(struct device
 	if (ret)
 		return ret;
 
+	/*
+	 * A wake-enabled device keeps its power and state across suspend, so
+	 * only restore the THC context. Resetting it here would discard a
+	 * pending wake touch event and break wake-on-touch.
+	 */
+	if (device_may_wakeup(qsdev->dev)) {
+		thc_interrupt_config(qsdev->thc_hw);
+
+		thc_interrupt_enable(qsdev->thc_hw, true);
+
+		ret = thc_dma_configure(qsdev->thc_hw);
+		if (ret)
+			return ret;
+
+		return thc_interrupt_quiesce(qsdev->thc_hw, false);
+	}
+
+	/*
+	 * Otherwise the touch IC may have lost power across suspend. On
+	 * platforms that suspend through s2idle (for example the Surface Pro
+	 * 10, whose firmware exposes s2idle as the only mem_sleep state) the
+	 * IC loses power the same way it does across hibernation. A plain
+	 * HIDSPI_ON is then not acknowledged and the descriptor read fails, so
+	 * re-enumerate the device through the full reset flow already used by
+	 * quickspi_restore().
+	 */
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
+	/* The touch IC may have lost power, reset it to recover */
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
2.43.0
