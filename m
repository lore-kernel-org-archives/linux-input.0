Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0473D47A3
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058776; cv=none; b=JJerLJ4DKCQ62c6DXiik9XL5WGddyzd/Nvq7lwg1kPnaWbwFJaDYtawn8AXJ9V29eX81BuVDbaJ/w0w/+KOtZI7zfk0tQUq8TnGwZhuKmHnKX5JQ25RBa7cID8fmRqO5+/EjA4ejkORWvFz8FunuSSTy8QTW86l4uVBQ/azzu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058776; c=relaxed/simple;
	bh=f8F+G7T8R4oS3yvKvZ5xEurtwNv5Rd9FkWBah5DjZWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YE8p4aZ2COE2Q8UK1qeipPXiIossNAQpj5VFGk0Q/UIVc+ulnLD2EfeX5qm10BGsaLWcBG+XdF9ozErRobyxqUve1M8wrQAcK9C2H9R4YhuoKpmczafvr1TyLHLnJQagJxBjWOrphe16P01dOltLd4gOzLw2nVYRXF+KDYTA2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=PTECPSPr; arc=none smtp.client-ip=209.85.161.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="PTECPSPr"
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-6949192b840so2020849eaf.3
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 12:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777058772; x=1777663572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqoq5cnoiQ0y9ErqwI6rgFHvZuVVz/D839q+d+059Nk=;
        b=PTECPSPrduHgPOfOmV6TGiKB2r7+lRAhMX58OEjdQf52KslXHZWgKmlykxETWnia1E
         fHRMFtINjVyyJXHib+1OktGLN4EBDkYcqLumhXQpxCAGGdskb4yBU7YIuhA73OLEpQSR
         z6jTU42c/HfUlZS2sVWgvdBQoxFwzGbQKWJRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058772; x=1777663572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqoq5cnoiQ0y9ErqwI6rgFHvZuVVz/D839q+d+059Nk=;
        b=m8IKh+3+/aUKNf76GNcucaTiKDoVrBfQrhFPhqe2VqDxXRNRDNfiLQeZqZNtqeGAB9
         DFgrvCbyQV0jtc/hAaZN7SGWX3sD6ubfG5EM6kJFCBXPFuoSNnljYKZ0vliHw+QxTkPf
         E/O3b/E0wYsicSUyTcOTH8I+m4Apt2WVCo8h2vhbbhqH358P/DLQo/XiIZ/4cvu3TPAb
         3xfh2BuxO+cBNaLJFrObJ06j3bK//exsJG0shIc3dYfmKZ3cVXviFKc8AbqqCFYDwvLq
         1G7QGGhJGrNR+sjn8LvTJRurGmTp86SafT0DYN6PYwTtVWJTTpt3aB/1JKfkS4FoywuX
         qJ8A==
X-Forwarded-Encrypted: i=1; AFNElJ8mK9B/jFR+bLsbzraNLGtHCjd7K8h5+gI8Bf0C65+ucvdMiCtkjFHl2ZyrXdu8uXKZ/pICyU/Z3nZh8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIbQ428LG614ferWaufO+6yAl81RUG8vig6m6QpM2KlmF+L6F
	+UGH8+R2sUIfL0nnjUL77kjjnkWQrplKLqtebraF7N8/U9yLuOO+EISfsiDDiiJvWOm/rhbwjH/
	eLT0zpHH8yu5z5fL5aSsgCu26gfc8vWhQbEPW
X-Gm-Gg: AeBDiesvbSIfN3sog3fp2TUoAYYde3hubZyVTVt7BcLLHL03XD/P5TxLvxCyZVmYRGS
	p7dqz3dIU9+R8aNVirPZ/CN1zBXhxJTR8wnuySoiaQ0eeUCqv+XPjf0XYv+E0EGpZjraT9rp28t
	hdMMJoYtl5NfZC9iuhfB8MSIOV5eQ2TFbNhxgg7EPElUYysj739V0HkMLerI7rIKtKo5hkvMAdj
	fFprq2B8xeOUghukv5tiHHFn+18XapVk6rLDdGDvrf78xxujU5jhqT2dkKgrCD8RVztzGwMG2te
	gTUudFnJzBHvE/zVDAq/8qr6omlevWmt+HzFuxKi3p5QDnmsxpzTtxkLhfL4QvkSaTow0mHCd98
	Ug5Qfw83BLXrKdRxRUmemgMe1tl5U/as7Wto490wl/N4rj4DS14mDlLxotKs=
X-Received: by 2002:a05:6820:8c3:b0:67e:447e:d1a with SMTP id 006d021491bc7-69462e21352mr18123352eaf.6.1777058771728;
        Fri, 24 Apr 2026 12:26:11 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69464e60aa5sm1275226eaf.7.2026.04.24.12.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:26:11 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Fri, 24 Apr 2026 19:25:34 +0000
Message-Id: <20260424192534.3504976-1-kris@embeddedTS.com>
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
transmit all 0 bits, moving the 3 bytes to a single message.

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
 drivers/input/touchscreen/ads7846.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35c..599793d27129e 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -327,7 +327,7 @@ struct ser_req {
 	u8			ref_off;
 	u16			scratch;
 	struct spi_message	msg;
-	struct spi_transfer	xfer[8];
+	struct spi_transfer	xfer[7];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -403,16 +403,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
-	req->xfer[6].len = 1;
+	req->xfer[6].rx_buf = &req->scratch;
+	req->xfer[6].len = 3;
+	CS_CHANGE(req->xfer[6]);
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 
-	req->xfer[7].rx_buf = &req->scratch;
-	req->xfer[7].len = 2;
-	CS_CHANGE(req->xfer[7]);
-	spi_message_add_tail(&req->xfer[7], &req->msg);
-
 	scoped_guard(mutex, &ts->lock) {
 		ads7846_stop(ts);
 		status = spi_sync(spi, &req->msg);

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1

