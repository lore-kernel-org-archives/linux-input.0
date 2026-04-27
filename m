Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523902E5B02
	for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312023; cv=none; b=tzvCNGdn4Y9xQNbjIHNRjFoI+8tAx9oTpN5JVpFBYlHXTsyw2nnzPw/6h5e7rIxEqYFMwO+3vyCPfojxwLnu3ViuVhfNvl+3sYl2agihW92xz6qTtvk2JhYeusSov9bKXu0tw8Dx9CpaAK/39d9sTxL+c3GAiWWGdgW2hO/M6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312023; c=relaxed/simple;
	bh=SCT8D80G+jmfhUjd2eDo80+D2h1zd7FvDnYKrKfZlvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hbuhPsRr+vhqdQNxSdlFoxgR4VJZ3w9gpJU8E+jWM3BtsWPKFpMvzJVd7o5gpyA8mbueDVc1O98nBWL3zipxRTkvpffdxtnMuijxdZXH/g7CDFdmBNu3Wqp2a4qgDJdtnipiJgOYg25IeGB297RZwp3QBzBphLsoyxs5oYBE27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=c53Uaxsq; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="c53Uaxsq"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-35d95017a68so7048538a91.3
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777312019; x=1777916819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtxZYUJWsG0tUhkOglqtm1G9mRh7DJSqPuF8GOXSvQE=;
        b=c53Uaxsq4nE3rDd4TaJgn083FKMCeiaWDqQvC1TgBcjzIB8nvhyBeQy3vQG4wqUJn4
         Rh4u9h+67agyO3g3a6YhOOOZydJiClmmWZXIUyMI90YTXYs8TxwkP+TCRvG94rrUJiYI
         BYwygK5DwT2u3Z5S4JrtUU0P1t//Ya7CAQO1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312019; x=1777916819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtxZYUJWsG0tUhkOglqtm1G9mRh7DJSqPuF8GOXSvQE=;
        b=nbKkJ8bkDa9TvR2VANKsx8qo8qt/Y407pZgCcbfjm8ZyOyeytBVLI9uS4LEE1Akyzy
         CgcbDDfzQiY3hBnhBPbIROrS7erioNDlK9nAEyK0DCLOJV8ap2ehU7ogmnMih67ORjdc
         MiTud7JhQdsTIl/IVOUyjZmSsNvj7DrMnCIOO3zVxRo2VnAfRgU3BdY6P03cDvgnfD9a
         02t/VuAghuD7x7hRjLYQLCjC7/SMMPp6ubTBqeb2J7LlHynoUOZgFDLoScRJtzCvVWmy
         6cuQFSWXE6fMsetpthZysOxrJaMNyM0L9Q9Uw5P11R8WUA9TC8CIpvCibO3p9dVMcpqd
         0ayw==
X-Forwarded-Encrypted: i=1; AFNElJ8aA5V2PN9uUPnb+MYS5PFbH6xN4FvmugupOuFzjHEOqG4Wn+KVCdqK/+aRF/fCGwNbZAYR7UhPq9gGxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4qkgUltU0e8kjYMPG+iKYuv5BLc212qFT44VaaBpeyZ6DZ/U
	xJ7t6AX5FgC3Bc0OsGIkQf8FAwtzlL+EJMMecsU2Y0//EH+KR2ATk3j8LbhlQz2af727xVC2TEl
	DOwJprUlnfhaeIjRdgXF+dZspDgVh+fM+McmH
X-Gm-Gg: AeBDievLXGmM35gVUeUidfLIgIPlJQqc8nh1MWMVWo1eDaGk64edyDj75/LYsAyiU7B
	AV0oeer1cAdyzsnToN63b5za/b7DAoxVLBF2ZayM0ZKWfP7TOSjpPAg6Pz7UYpmdK4KCTikZOu5
	7LOLILvCgfqJuGwk7WoC4rsgJv0WCHje7xEouAure3fD54o1j0UGJyyWNXfnQ+fs6sHA7F1od3S
	3X/Js5a4cPgFozobs8qEOzI10AjLhunCLv8NgSSojLzz/pSKwX9sVHzoj4GRe3fjUNse2w7eDU0
	+JFkkb0X+F5walQCOg7bDfMm04CcSjYgwhTeVmzOCwRpifODMJIGcL6Qx3KmeS4fKM6R65lv4fh
	22O8r7HqRkO1X8IecEWTZD4dtvWhgXfrNPr59bZrKSsCnuIPKpa6Y0cxo1QQ=
X-Received: by 2002:a17:90b:3bc7:b0:35c:30a8:341 with SMTP id 98e67ed59e1d1-36490c99b61mr60652a91.13.1777312019609;
        Mon, 27 Apr 2026 10:46:59 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-364902f5c44sm18498a91.3.2026.04.27.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:46:59 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Mon, 27 Apr 2026 17:46:57 +0000
Message-Id: <20260427174657.691272-1-kris@embeddedTS.com>
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
transmit all 0 bits. Also set rx_buf to NULL because the value
returned does not matter. Thus moving the 3 byte pattern to clear
the command register to a single message.

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

 drivers/input/touchscreen/ads7846.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35c..93edd2419db5b 100644
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
@@ -403,16 +403,10 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
-	req->xfer[6].len = 1;
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

