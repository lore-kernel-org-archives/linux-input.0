Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951E3BE64C
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957207; cv=none; b=ZODpIm/PG0+Bm6ClbjE1Ht1M9bCOYzCA6LN3MeuwJRI27TtoOi1kyepe3H9083rWMG7eOcKEGvxUNUffgotroTDgGHB9WTwOCpxGEykwCtIgPDqjtuYgfLKVYZzwyHOO7nZh0UmUPMPcuocVQjBcTInmeAwif5j0BeWo6c78fxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957207; c=relaxed/simple;
	bh=TEvCiEbQhzE4Pn5a92hAxEUB6/ep5l6pVtFMl8q6X+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WviVhh35NYmatjSkRyZRARjSXpuvQjyZUPWIrzDxVmA0H9y7O4KTPMtl9nrc8umi/VBICeV7EvgjtVrmZu52gXpoMhO2Z0Lj5lkUhilrcSExl9sDkf1FvDzLvx01+y78WntXqKLrHL80HzWsH1R+lDBw+g5FwHg4zm8xF0zXPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYA47lWI; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYA47lWI"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso10802666c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957204; x=1778562004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYBlozxzCL/KPqU6onSXZMaSuqAKVSHz3cyPWSVaa6M=;
        b=hYA47lWIWimqmlEsOKM93i+Sabxh2xCpfkxphpCcI2aeIGNnVNg0PtymoVTnSinmtA
         oOjxNNDkA8JOvWdebMJvlgcu/hWVuymZV+dKuUOcabE1JswwiZzIAa5JU64DOQ/QGn7L
         TSzmt36o6KWS3YdQQhsemquqvFQO1ayAya+NEQhxLffUMdP1y20+X4B8PJgkkpiXnHDk
         Y3Nwdr1G/mxTR5/HNraZd2/LyXocFiRmMeIaFBjW6JqWfr8bR4cl1Q89AWSy2F+XTRRH
         FGUtWZN1woWVFRqzkYvKDqZIXkpjFQV7HBUzheZaoatDhruHaR+1Se1KJdPeW6epxc6I
         Rqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957204; x=1778562004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RYBlozxzCL/KPqU6onSXZMaSuqAKVSHz3cyPWSVaa6M=;
        b=hlKAVhm5dhaxfZCPliCqNbqxL4BQGjHcdaT0Y/o0hVLAF9jS89FXHOD41irN6RZwZ1
         e5jr6XOWv6SuFTKVR7+32mBjAw5XBhdbYBrJHQSVpOd3DxX5UuFhgPG4yJtUbKHbtndm
         naPP7F4ZkwGdWHuBRr01P2zKrf5ixDaSxoA7YBnBrHRMmmRX5bIv6iFy0CW7Pe0mIDpd
         eWIDl795EQWUcKdvlrTS1Z2K3SUmIJTjRsZ8HgayUPBeZONAj8Pogi6EoFk8X+bZwUSV
         9K2Z4MZMJENbnzgdxwxuAGiY4gYIFh7LNDRtNTVsWT7Z6KLtqTkKHjM6r9PlLST4N3iE
         khYA==
X-Gm-Message-State: AOJu0Ywnr7mdISi8QObOF9suWASBi1KV8/WCK2gioGrISWF1UVNwBwRr
	Uh1HakfEQWPS7cy2JAksWK82lGq1SIgngItCv3Chfw0n4IPnvdQkg8ywZkv0VQ==
X-Gm-Gg: AeBDiev3vWzaZCXI+p8oLFnVZ5PJgKTH5JqBa9V2tbXYDrONzkuvGztCru37Ke+94GX
	vZJhKpgPsD+tZ2zZb6iJ1BcBb0kjpqiB57lmBQYIpvRxc2VGhRA9qLEFnvjATL92mf6JMNfbgt7
	o6xjoMgM4/0gWotqXuHyTmfcKpsWeVm84DGsg0Z+2nlutt29+w/rEA725NT+Oe4pqNiJvU8SzRM
	6MBehycfNlJhOzhc1NngTBtXbILgFPf+Itc85Q6XcFby/ZeTu7/FKucjsK6sTv2Knl43ceTOsn1
	gVfvIlRdcDNrspxt7ej53ZBeh9sqHbck4uRz/fT1Kl0X85CmMHwm55yE7Ynu33x2qlsX1pq6S/q
	1oynTyhMyeoW8K/cJVX512RB+J5LD8jIFLr2K18X5Z8KtZaYmyQHLHNyaU2OCfebz/hABQRghRL
	gU6xc/V1jQH8nJuiJ+SfxPTOOnvCFj5dj4rQQZemOlR4EinEjyb22H5pFJmhGehNj/s4HymdWg5
	qF1IaxCnp7AzxbGjiTUxFO0Gw==
X-Received: by 2002:a05:7022:61a:b0:12b:ec67:3529 with SMTP id a92af1059eb24-12dfd7fc727mr5726975c88.14.1777957204506;
        Mon, 04 May 2026 22:00:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:03 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 05/20] Input: rmi4 - fix memory leak in rmi_set_attn_data()
Date: Mon,  4 May 2026 21:59:35 -0700
Message-ID: <20260505045952.1570713-5-dmitry.torokhov@gmail.com>
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

kfifo_put() returns 0 if the FIFO is full. In this case, we must
free the memory allocated for the attention data to avoid a leak.

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 75949fb1a922..d873c7f08e42 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -183,7 +183,11 @@ void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
 	attn_data.size = size;
 	attn_data.data = fifo_data;
 
-	kfifo_put(&drvdata->attn_fifo, attn_data);
+	if (!kfifo_put(&drvdata->attn_fifo, attn_data)) {
+		dev_warn_ratelimited(&rmi_dev->dev,
+				     "Failed to enqueue attention data, FIFO full\n");
+		kfree(fifo_data);
+	}
 }
 EXPORT_SYMBOL_GPL(rmi_set_attn_data);
 
-- 
2.54.0.545.g6539524ca2-goog

