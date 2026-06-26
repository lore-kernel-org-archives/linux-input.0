Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2788639524E
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451097; cv=none; b=RB08gK2gsrXYZX+3Ogtt46tVHSYbBlE/zgpCRTtqvCaDVPhmBWh+7hM4ZFdm0r954K+lUhdNGD1tMJmrtZ1An7wghZnRzg3FhJqWIdl3q1s45iORof9FdcMFuor2LM4UfCWjfCdT4BezoRzGhJbEk4J9W7/T9taLNlLFdpRhilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451097; c=relaxed/simple;
	bh=jH7yxfAWC8FtCXBmBiE9SK+l95/euwLj66x/Rb8M4CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0MjDokgS3yZ1fKvAK91q5s+5iCxrKxoliC1aoqHNBdNFpb2CC4/j+TYi3cMKPnUSdAZ8acgE3W3f7OUUQEKWuGVAIDmobqm0Mo/AL6ubhQZq1rJhE03IbY8SMLUzKib0exA6umMOZ6/3sGvfyPU+nTw3t68295/XNjoCRB6sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQ0QhaXk; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQ0QhaXk"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30b6dad2382so1285061eec.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451095; x=1783055895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtcerxrkCDiELjGdG5Zz4juXMZ/LQY8Cpjf1LHHQ2PQ=;
        b=NQ0QhaXk3diD8JH9JWypjya9K2iQYfmZC4ucfrQ5Bvm2AMz3U22WRmva1okoX2giSa
         +sFJfMgws0PDCovEW5ZYhbcbmfs6wT8zvy8BCFTWPLVUUUSStD+BhQAH2tq3oUojCV2c
         ftn+ZH+1K1hBJu0NdqxRFkctNPlh3Oc+NLFqghKQcs6NkUsBchVr9Z8Cp2ni4raxuQqj
         sIGBJD4S/1YeaWkn6G/yWiLiWrOlS6LLEmT/ofiW31cRn7j480UO29JXbGpuUPzYnZBp
         LkAzM4GktVLDDaLYUERKBUP1dAilIZrBCkagVCYtvm37pRkqWUCqdx5xo8OhK7bcS25B
         nzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451095; x=1783055895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtcerxrkCDiELjGdG5Zz4juXMZ/LQY8Cpjf1LHHQ2PQ=;
        b=AudbNLTITGunHJ64jWvnNLpwx82PtQMKgfAU3vUx/Wc4s1IZ/c2SquCSRNur8gJH1K
         QUrC0NjJj4vWQHxQGSoL4z4KIZafwTd+LU3TpivnS72DmXcvHrDsl22LPYJ/AlT+9wpB
         rcRi5geBFr4k9j7LiKEj+V0R5xbOInyq8A0uAPIjEe6PMmxJmwEmIpf6suSjH5XokPX4
         RT6YYY0YuLl5qL2XdFpDSJB47Av6gsDCwIytcyIT4Q2CRjtMES1c8pP9PV61EjkpCNgK
         M+wZaaSDe9SYAmel55HDC5KPlQfFA1FtjueC7GaIU6FHokDAqrx4gTxGQTiWPfLP+EbU
         OHFA==
X-Gm-Message-State: AOJu0YzdcRhNZC7wvj+bUE58ifApX4DEKgXqj+xHW+bnjCVEKBg5bDtc
	VPdabUjrD7emQmmpuWtMuecqRZ5RSACkVMiLtmH9l39dW+euHl8VtWfx
X-Gm-Gg: AfdE7cmBXcLIWMDXOF0PyIhzH4Gx8gGz0wWdR6YlexvqgnWFHF+Tw2zKnRK1TCciesg
	iyktGF/og+VQc9xkylsFTruepHMDsx7+qyG+I2tENQnx/4u6SkLMF0YXOqiOKwYS/2HIJF8fEij
	IcdzMxahXbo0x2kPJih3mrlH7CwScNSMqz1KAGWM81LR3P55KPiKVGzpHNylV4FsgzBC5BWWKtV
	nWdNyQNrX7lG86yoBc4fsCJEhpPZAKQVvmuF2rmAvFDi8khF2KF0McN88Z7hx0BYqx/LsYdqmMj
	CqvyT46+jW3zAECUX4Bn7GENE0hqt+g/ZD1rl8d/yluRLdc7QEQe0RZ6n2DEs8y/gMMttCdKVlG
	els4/NRiOGCBrkdJmmc5JZlgM5VaOeGNj5FVm9bsY/BSsWPRKlPg0v7v3oKjLp+Ykb1bzVkqmsv
	czdf8KcTbyjyFdZC1+xrmqQnrJUtstqjMP8asxtK6B9r3VHy2CtOxhHT03fJC3n3PVowYs1srGI
	0Md
X-Received: by 2002:a05:7301:3f0c:b0:307:91f5:92e2 with SMTP id 5a478bee46e88-30c84b2b217mr5193094eec.4.1782451094992;
        Thu, 25 Jun 2026 22:18:14 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 07/10] Input: synaptics-rmi4 - check V4L2 buffer size in F54 queue
Date: Thu, 25 Jun 2026 22:17:56 -0700
Message-ID: <20260626051802.4033172-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a safety check in rmi_f54_buffer_queue() to ensure that the
requested report size (f54->report_size) does not exceed the actual
allocated size of the V4L2 buffer (vb2_plane_size()).

This provides a defense-in-depth measure against any potential size
mismatches between the V4L2 queue and the driver's internal state.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index c86bc81845bb..93526feea563 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -354,6 +354,13 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		goto data_done;
 	}
 
+	if (f54->report_size > vb2_plane_size(vb, 0)) {
+		dev_err(&f54->fn->dev, "Buffer too small (%lu < %d)\n",
+			vb2_plane_size(vb, 0), f54->report_size);
+		state = VB2_BUF_STATE_ERROR;
+		goto data_done;
+	}
+
 	memcpy(ptr, f54->report_data, f54->report_size);
 	vb2_set_plane_payload(vb, 0, rmi_f54_get_report_size(f54));
 	state = VB2_BUF_STATE_DONE;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

