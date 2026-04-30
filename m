Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC72848BA
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570669; cv=none; b=Ll4L3QTIJdf2a7WPHXtsSLO6nj5Pp1Kldj9CHH+P7zm6twpjzMWFcYJ81zTLl1z4yaq6KzCL1+EWVGt2ZPTAG3ECgAe3T7Eigk4LrmZAhwBiSso3eBtcsaqCsvuvsvJFUtNwgLluU1U/1c3WWhw/zUpU2RMYWxn9UB/rB4Y1QQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570669; c=relaxed/simple;
	bh=5gnK1tx9R1TIqAr0DRz3D3VEyLs5AMY8kWNvCmjXrIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uiAw7uYy1KFHa5BDmloBYBpKSY3kzVUeEoBaC8SC6ofQMJHGRFVoilcCaAdW2CtJTR1YuebXDYDCqStRAc2InZnPDFKe5Cli+zOVGVl2DRpdx1teoti07HmBNp6McFp9W/dR72/fqlYGUvBELQLYCURIgA6yQbdnM9BCbol9XkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=b3xAbvZK; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="b3xAbvZK"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so16700996d6.2
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777570667; x=1778175467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwA7m5EZ1edlmfqcnWuJCjFmtNnRxo71q5/2JyXSmfY=;
        b=b3xAbvZKBh+Sv1rUR+6E8p65WT3rDeNjsvM3i9KEfaGSzM+KLEwNJaDwBZPve0HDsO
         Sd7AD3pPkEk4ev/z2peub/8mpkr9EexfZK8vQABZFfeIETzS8SVZpEmBIsnX3D90ahrE
         Qy+KbhnCNXnPCUI/8fZ/uupQmCBnw9KH2SpDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777570667; x=1778175467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwA7m5EZ1edlmfqcnWuJCjFmtNnRxo71q5/2JyXSmfY=;
        b=jq+PTvXoYzYtdBsn270dTuXb/H7wG/Hg+nyHrJxv3LA0a+iM4uadMloGUz3IKy/gvA
         AgHrpDootSd9oIzONjK2nlMKFqgrPelqG+9FXq72PalrHo71VGF4NlVvTleaaY1YkCcG
         8mAwAh4VjM+TzpykZu9k40Nub1+YoGg4aYz7ec/8AZxlc71Pf5Zcz2P9W8MIUc10R6jh
         S4Z3BHkv1ceDm8G9vzpiLDCCQsTk09wPNuqfDkK+66itZ3ff/M43sR1PDZQcXXn4qbQl
         90tjGmLOeNL1sAmII8nd5mk+0noCWmQwmVasFRytXgGN0igMPKuld1cFyxI2eDbQ0/q+
         c9sA==
X-Forwarded-Encrypted: i=1; AFNElJ/56UtFfS392xvxKdgPNM3h6CMNz3SyL6+pPElR6RROI4LeYxhD9aLK66zv+VxM9jp0QpZcDmlEEHzORg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3hRqRy7HXuNw3TaZQcpThawEnJf1X/S0Pd+ggfvshJtkEPK6l
	UCYqYFgYVjCmlvPT+bZucosoLdofyaK+eMTjYABUd6Gk7JaNacPn0xrTLabmcTPQwAS02ezTsSL
	2ErECttVjcDPexYebibvKoLaTJd6/CtwfNbSH
X-Gm-Gg: AeBDiesxkYv+EmgFidvBlVapIcpmQKDMAiyGf4MLJ9TDGQQ03xE9V4Iq2ReIhNn04K6
	VAJ7C5Xnew3UhOXN+4RqEp1G6yjvrJOBN9ljfV9L1I+jF122srbDh+3PCSIuyvv3J6cNK/X/ig0
	PemLpeUxge8sXR5vzFkfSq28Mvpl8gkkMHep+eXgvGxk53O+ejnFdNUdrz4PHxgDggXgzS4Ymgj
	quv2kytJ6VNbAwcm0K4tD1svZgEWVd2JZZoBYhJih99n09M8BIRFXbHtjCJQcZKGQyTACbWiGiU
	w4VCz3UuZwodgWdEMhMFkqWQFXKyenlJcyj12EJ9Wrl/4AKEijYYqFBh9sxoP8yZu3/YPsZ/zoW
	DymeQtS9AZ41/g9bve0vB9ALkR4SVlGdyJGGzFh8P/gHkD6rPFNkGWozaxuU=
X-Received: by 2002:ad4:5bea:0:b0:89c:8a0f:55a0 with SMTP id 6a1803df08f44-8b3fe7b6ab2mr56073336d6.16.1777570667338;
        Thu, 30 Apr 2026 10:37:47 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b3ff315986sm1535706d6.6.2026.04.30.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:37:47 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Thu, 30 Apr 2026 17:37:38 +0000
Message-Id: <20260430173739.3843425-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workaround for XPT2046 clears the command register, giving the
touchscreen controller a NOP. The change incorrectly re-uses the
req->scratch variable which is used as rx_buf for xfer[5], so by
the time xfer[6] occurs, the contents of req->scratch may not be
0. It was found that the touchscreen controller can end up in
a completely unresponsive state due to it being given a command
the driver does not expect.

Instead, rely on the spi_transfer behavior of tx_buf being NULL to
transmit all 0 bits and use the scratch variable for the rx_buf for
both the 1 byte command to and 2 byte response from the controller.

This change was tested on real TSC2046 and ADS7843 controllers,
but not the XPT2046 the workaround was originally created for.
Confirming that the original modification to clear the command
register does not impact either real controller.

Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
Cc: stable@vger.kernel.org
Co-developed-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

V1 -> V2: Don't use rx_buf when clearing command reg
V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
          output on xfer with len and NULL buffers

 drivers/input/touchscreen/ads7846.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35c..488bcc8393293 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
+	req->xfer[6].rx_buf = &req->scratch;
 	req->xfer[6].len = 1;
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1

