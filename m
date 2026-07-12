Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDE430E85D
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783872935; cv=none; b=heOQ4icWVAe5Ab/+0uA25fbITKbdnI35WTTvG+rjKYFeyyW3UFzpybmMcUCkf12yPArxE004nNjfvarT0+Q9/g83CyA8xm5ySikFt/G51awimxmojKmPUtDT5/8IFXHZ8PRzo875xOJRIfF57VvPrPMtDXRbauIBi0bX0+bfCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783872935; c=relaxed/simple;
	bh=zTYHVWB/ww2MpQMv9VB9DxLFqqRHqJuSrc1EoMv0eQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fG/VN1Usalyzx45JFvmdpsyZ6S4yS1XwQbh5QNq66AJ+qPKSwyKMhQuHSZxi39qfuH++ul8u+VrNxibSIZvnYeEGI8MA0IoUPrAEd2fwaSywxt583yly2BflTNRMlF6sBiVuTAofYyxrOyn7uFgylUBwni1ml1Ky1zROhyYiDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so1741302a12.1
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 09:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783872934; x=1784477734;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BB78WwYxxwZ7HeA3JuVfN9r7sDH8CdPWPJM6l6nV4eg=;
        b=N61QaEahF+LdzBgzUPi0UyOhR8FBFS2RAKAkL07EluaVCnUAPXzfvYrvo2us86YLof
         U1urhtiimv4PvYlzY30acUtV6u6A+p7nRbkF3DjIp1Ywrl8fBMqAgzu2js+LLAQW1dxo
         D7HwA3s4b83jzy+MGZ/3AMjvUNE+wYFoHbuh2J3o/klLUdiQ1sBhY46/2j35IVNkSl62
         CzPhEuRYIzIrOHRz6oplnEUfptI3bvqhRKeuOVDwf4Z/fHsEmxm/v8GvyFoIg/sSSTrV
         F+go1/1S8Sed/eOH4Ip4sAvXQxgVL2OxTRfajFB35KVy3AdAZmEIo+QTV38dHHPDM7bp
         wdhw==
X-Gm-Message-State: AOJu0Yy/x4e3Lgd4jLMEPDkPLvf0jtIxbu0DvOfeSgDwRSAt7v0ZQ1AK
	GnVumnBjg8eNbb5qfUFU6onbfCrCWHjaXR9cyVDVgwH+5CzBvZtExJA=
X-Gm-Gg: AfdE7claUrIA7nEOc8xHLVS06tJWWzC7Yml2hBwEjbcJqgNB+Gue1BA/lpg6u0oPAC6
	yQnnXRGzaCyig8rmZfprJJUq+2AT4zXrtFWev7KPYQnubxWzTVpwMRNJewAXsB2A8X662WNPIR2
	JOHUMDAkSu//+aiIe8PmFGpNZAQf7NpDoi8aSDGFYFDM2Qf+ZxJgH8rO/jdiaIEt/Pmi9spXS0A
	0w11Io3x5qVLOhfE4dVCl71PAIGwSmyd7VtZITD/SaccFJ+y0vJIhq8F6T5qFET448r7aCbUdWT
	O45UfF8rU3v89lgEzV8kvBIxBTaP0PsDVD4+NQzskScQ9IVPuoVeb33jh5Y7gGmXQl4UQzkcJHN
	Xgy0GdjDHjj21bCXCJ63XN3iMpBeacOgGtBu3xuIEs34K7WyV1S4lckGjj591vFoaA6rXQSmIPb
	4sH8MkH8eOSLwWb/NQwKf6HCBmi/kMWALyWfmLHTq5Jui0vSxTUbJH8MsrDKdcxLTKN+F7W2k1o
	qQ/rqXLMavR4SZczV8qX00x264S
X-Received: by 2002:a05:6a21:4598:b0:3bf:b755:ce6f with SMTP id adf61e73a8af0-3c1102a1692mr5830737637.29.1783872933743;
        Sun, 12 Jul 2026 09:15:33 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-44-142.dynamic-ip.hinet.net. [61.228.44.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm51034331eec.20.2026.07.12.09.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 09:15:33 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH 0/2] Input: applespi - probe and remove fixes
Date: Mon, 13 Jul 2026 00:15:25 +0800
Message-Id: <20260712161527.7350-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes two bugs in the applespi driver found during work to
restore MacBook8,1 SPI keyboard/touchpad functionality across S3
suspend/resume cycles.

Patch 1 fixes a probe-time regression introduced when the touchpad
registration was made asynchronous: a deferred workqueue task could
complete after the spi_device was already removed, causing a NULL pointer
dereference.  The fix registers the touchpad input device synchronously
in probe and removes the deferred path.

Patch 2 fixes a use-after-free race in applespi_remove().  The original
code called applespi_drain_writes(), then removed the GPE handler, then
called applespi_drain_reads() -- but any read completion arriving after
GPE removal would reference the already-torn-down applespi struct.  The
fix uses the existing cancel_spi + wait_event_lock_irq mechanism to
drain all in-flight SPI transfers atomically before proceeding with
teardown.

These patches are independent of the companion spi-pxa2xx series also
submitted today (MacBook8,1 DMA quirk and LPSS S3 resume fix).

Shih-Yuan Lee (2):
  Input: applespi - register touchpad device synchronously in probe
  Input: applespi - fix use-after-free in applespi_remove()

 drivers/input/keyboard/applespi.c | 160 ++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 33 deletions(-)

-- 
2.39.5

