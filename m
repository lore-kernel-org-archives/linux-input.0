Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD8280A5A
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025949; cv=none; b=BzvXyxTmtBAx8MwO/0qMqxq7eWxpTMmCgUcskwtQa4xJKr2SnFAjhxHn3IphgqOaJN8TzgB2yhHs2BF6mc+7HrdG0c4KTY3T6gGo5P86TepuLaXSWTroV3YjjDJ1179H4Q2OnPmSaS+vbdiZBfnycZHFAjx6ruFFGYsoYvDJBr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025949; c=relaxed/simple;
	bh=DQk88FRBKoFkhbRSS0uCRp3L/0NcM92hszhkFvzYeoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGCMIBuWNlMVPgnEbGulNDn/Pm0vUlUZRLPn4qMjqt4svmMfTSIMue9y3p9cRL9FOjxlBznQDyhGaSO4vXRTkKEJz9BRpCXnY9Ma17Yb5tPz62Rf9b0OJTo413Kn8pvuhe5KAv1u8W044o2zCt3/SoI5AzfYcQT+yDPFLuY8v2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG9i7Dgs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG9i7Dgs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b9ea536877so6582815ad.1
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025945; x=1779630745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQuWt3uDzlCPMeJpucga5L6Dcu7cKi0WPlFjpk2QwOw=;
        b=MG9i7DgsjP2oE94PnkUEjycigaWcHjxeCDWeQpYQ//Tdj3/8/jYFJ6dqoJOjqHyrt1
         Bh26IQKK2QoXteIKFB1b5TB3g856r2EojoHA/Z0XsfDKCQrXn5L2rQ9EHFPVBHHdO1BB
         QeMHK0Y/6KBqSzCtO7dTRM9j5SXnhvpwoDeD600TfkjWo72DiXWNSoICgHSgM+CmdWuw
         mAPGHq65INjYtwPNbT2XsD7CQ9ZYIDJRPFs8QuC8fYfxj7cYi/zD1vcGTKCYxcqXUSoA
         umrldlLZGh0Zu54q5XAZjFkJNwT9faqrXtVazL/eZRzzSTa/X1SvkKBLsDovnqdehEss
         KpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025945; x=1779630745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQuWt3uDzlCPMeJpucga5L6Dcu7cKi0WPlFjpk2QwOw=;
        b=gpEYmNn/2Mx16yQJEcItx1vV22lWwSIayobkjmpzoPykHSSW8hpVOaiYok9QiXGVCU
         1TD7IXsMK+FvMRo1HvkflR68kRmRfukid0imOzluRJM41W8vCPhu32l9ASf9QO++t3Hu
         JxjegJb6E5QYdbufa6OR/sQabRi5of0fM27M8D0wyRpaPh7CvI8HZJSRfWdXn3uzTo4s
         kxs49w8TfRFsyI/hpgWGDUeinqNvwrfnvvxvbCSMJ+B4VnpyFi6JBDRHA5SsvRo/qSm4
         fuUuougg58XPH63lEnuzsvRkcM9tFPDTtRxgL261Gi/KrvxqDQ8r1Ux9d++P02wtq+rm
         uYVA==
X-Gm-Message-State: AOJu0YzW3+IYsCAYVnLjFhLwCF53HW8AUjgSQ1UUMmTKqsKG8J1nPR4Y
	WnuuGDJgLGgkK/Mu87MCbcZyh6Z1dqnwwxgg1UNN5Mt4fIa5x2xbVhKbVOfcAehOZ8FjqA==
X-Gm-Gg: Acq92OEp7OH9fCMipaDW3yWqclm1pPhJYKNmZ9rCsDsJ+TX4xMZ3ldQ7uaZApJUEpCf
	mdlhIrVSM3a3v/nogDrFP493mxN5jywemR0UZj7FBF8WPJCwL6poNJ3zjpoz7MNUIt/fj/f6dqK
	zHQ25TTkCjMWuOKK0p2KSzf1HIj4Fy0Lhr+FnDNsGFpsPC54Rw7Be9TCUfLQTKOal0pO5ggFl7s
	MFSg3XL/DOHcKRZ4KjnRqOivuV4Dk1/YtBQFySS73XcKB6OdJTTaMi0O0D8dvppHBHsaZARyDQC
	7TImlRvN5NauwRuY6kIz6mPmSuACWQ7lbUnjYibPY9RGaVmq+U54bBIkH/rO2NVySjVZRdmEBMl
	j042W601RKiNtBGIcFDXWuMFRKYBHfMkZgc3wP3387t++luvwF6zKWQlRPOy0Gvz1OVE6hKT8VX
	7nGxrVVyaS+aR7tPBGgSb+N+cbwcJo9fvXPkAOYHHx/9esuKzu
X-Received: by 2002:a17:903:2281:b0:2ba:7617:a755 with SMTP id d9443c01a7336-2bd5283b74cmr140145355ad.25.1779025944534;
        Sun, 17 May 2026 06:52:24 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:24 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 3/4] HID: wacom: validate report length for DTUS handler
Date: Sun, 17 May 2026 22:52:14 +0900
Message-ID: <20260517135215.2220117-4-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_dtus_irq() accesses fixed offsets up to data[6] in the raw HID
report buffer without validating the buffer length. This sub-function
is called from wacom_wac_irq() which receives the length parameter but
does not pass it to the handler.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add a minimum length check in wacom_wac_irq() before dispatching to
wacom_dtus_irq().

Fixes: 497ab1f290a2 ("Input: wacom - add support for DTU-1031")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 873d58a6d..269e8318f 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3479,6 +3479,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 
 	case DTUS:
 	case DTUSX:
+		if (len < 7)
+			return;
 		sync = wacom_dtus_irq(wacom_wac);
 		break;
 
-- 
2.53.0

