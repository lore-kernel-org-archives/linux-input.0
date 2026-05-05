Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73D3624A6
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957229; cv=none; b=kmLfOcxkQCURdAGkmbcQrc27p+OvZMg2dfVDlR/7e18faJsCc+1Y1gapNMCunOxF8tPaUVP+hpFmn9y70t69eShxdVsUIKC0K3305vFbiZvBh7+hNDx0nuJ43gtNUdvFxSOy+jhnjA8HrZZZCnuPZBu6OIe0xtRu90m4aUHwiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957229; c=relaxed/simple;
	bh=sn7hWkVgJ9Xvo+NwG37NxtclSHZBcaETnwuaFtdk+cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hd3N5Ah6it29DDNpWFPjKmIty40GTgf6lUA3kr1KPuYmwj3Ww9sKYH1bXEM/oBantyfM83fINlqSe3g68WAxTISzYkVcAqQdM37Ug/hFtG7IdSFCRDdu39jQK6uteA0/Jta3/aoSds6CYEHUhEI6WV+Ec8pDin0yjYyoOS4jIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvNUJjhb; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvNUJjhb"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-130b2295ed0so880544c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957227; x=1778562027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2PZxk44k0cFBM3w+vTH8vhndlcaSkCCqU+5WuQXX1o=;
        b=OvNUJjhbTADIZz5RSzqXDgb/1iK3luGNvKR6fSfmalhuyZFKIETtMNWrl55aF3Ktj/
         F2rFCj7x1imnlVwWBAV3FJm0eX+f9NFp9zEOo7KMtOQGq1dj9WQB/su6QROXZ1Zc9rPV
         xN/0MR4hcIulmNxtgPS8gFcH9jxuZP2RTGIdzbXpyYFoaGHW2rnemIqw48ru89iJluq+
         AlY89PXiD7I0SdUBP1Wop+3L/8EFanBn67LNydjXDQcFP+F4NR8BgQL4fuNw/IZW9Dew
         8c3daRkhLayeF+7iWMaGG4nFIGddttJPOdOv7vGoZWb5LdJxEHF9VFleNYla6fESXSwO
         JCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957227; x=1778562027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2PZxk44k0cFBM3w+vTH8vhndlcaSkCCqU+5WuQXX1o=;
        b=T0aq5IoiIIutBe9B6rM+InaiNvL6Pe9uMbi/70pBt4GUZUuWF5QOafq32Od9o2AEUZ
         ROmX5GyWyZPV8SZ8jNKl5v14nDUKqtbf3Ezpi/cZC+5+BaI4HySeIyGonUMm7pwfF4b8
         +lQuX4oAQB9iW1Xkn6UcLWrvFg/VADEE9qK6LsWEOLBCEdc1W1YpqXcQWcr3hiMHgUIM
         mq16szT0HjMchYT25bT0d5683ElPkshErE70n1vKndQoopSsbdPSASrvQGcbHBGV0UUk
         Aom6czp4lUT4kYr5vBxFY3OvnUVkejYwdV719gTsV7EwJ4lL9C2ioZEGpuEB9YRVMfCK
         V49g==
X-Gm-Message-State: AOJu0YzR2UhMIQpk5K1HBGCTfuM42/5BR5BqMOAjd3e8DhtFURmQPIDc
	49seLihWVcG1iNEHdPGwFUhN/w0Y3gLZux9PYjPl55UsMhHfSIHt7puZ+Q+UCw==
X-Gm-Gg: AeBDies9s5/PxZke8UZnJrfrp3e0/MvZjQ8WmlwDO26Q2tvGB0AY5xbfZAByBBvInzz
	bVfvYF3CK4OIVgq33BVkXsGbFrIDlDGtJxn+52rMWZGi8OGVmexfd+GL2DHlIkUnn4b8qXs85tm
	TmncuYGJq9PXzx0kSYL2pC1jQmiCXcVEKApYstj7V+juFjYkUszSJr5cbK2AWIhJHdNNGgyKwRS
	UPmhaYVljDyhcXXtTvTh58beml+mJQSPHhegr7zzQSeET6BAnTgyn4p4JgrR1EWx+tI7XBKb6Ys
	pt1a0i5ZZuqm1MvIONVtlRcSMgwuXOK9OFOIZXNj+cONqQtWm9BPBA4lP/mrd1bplMl1R8Tx5FU
	bDTrB3ulVHGdek/iVgLmCmHI4eT2iuQ7mupnnjaviIohu5xFQvSk+CE4uUEHC7LO488XOgT7ihR
	G6XWDX6kIZvGwA4xxz2hd62Mk1NtHv9Y3mR57IQ2qOZ8CqCR7GwyElSTkBFUy4xHCRZRjaHb8Zr
	o4I5KNU1r8VNR0pEcIeTVEMSA==
X-Received: by 2002:a05:7022:f94:b0:12d:c039:65d1 with SMTP id a92af1059eb24-130b1541dbamr873802c88.1.1777957226974;
        Mon, 04 May 2026 22:00:26 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:25 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/20] Input: rmi4 - use devm_kmalloc for F12 data packet buffer
Date: Mon,  4 May 2026 21:59:46 -0700
Message-ID: <20260505045952.1570713-16-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sensor->data_pkt buffer is used exclusively to store incoming
hardware data during the attention handler, where it is entirely
overwritten by either memcpy() or rmi_read_block(). Therefore,
there is no need to zero-initialize it during probe.

Switch to devm_kmalloc() to avoid the unnecessary memset overhead.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index b9cd70422b68..01838907c64b 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -452,7 +452,7 @@ static int rmi_f12_probe(struct rmi_function *fn)
 
 	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "%s: data packet size: %u\n", __func__,
 		sensor->pkt_size);
-	sensor->data_pkt = devm_kzalloc(&fn->dev, sensor->pkt_size, GFP_KERNEL);
+	sensor->data_pkt = devm_kmalloc(&fn->dev, sensor->pkt_size, GFP_KERNEL);
 	if (!sensor->data_pkt)
 		return -ENOMEM;
 
-- 
2.54.0.545.g6539524ca2-goog

