Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588432860B
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512817; cv=none; b=ECrx4RYWpqCvWhwPtIWmIw81dBEnzXaNawtw8b0ijJ/PUbKyVCIaWO9a1LJcMSgcaHM8GMov+QdnNQ/XWMvPnI9PpR6v/GaYu2npbSh+79stBr7zhL7E9Rvw5QcUxZKITO6h1nKevdLbE9wEv8Wh0PWmp13VTgmRRfPOP93HyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512817; c=relaxed/simple;
	bh=MDzmd62AJTHlHIH2co8oyK9ZcbspJpvz8LerLf4ymA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrR9QjDoHZrF8mv/X5walPBwcetJ1FgFTrrEFx3K9GnMk56EyEBhdAV8w09lH4huj/9MZebt1taNOXUeBta1q51Vgt4xh9y5XuzDqq5LgvCNklgps9bnShFjqjPLliCDokDg76rabtWiftIRtyNgkuFZlnGT3X6/gTAtz/AYxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afTTDxB2; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afTTDxB2"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3044857f09aso2830355eec.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512812; x=1780117612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7a+I4YbWgCb4RQjRS7D/qsAOOz1ec58M0Yo5rgLJumw=;
        b=afTTDxB2Xq526omDABUSUXns0HCOROZV3Jxfag825q9srUzG50RiBkLZ8UqbZ691LI
         MZbwc+EnXOFpp/IVjigEsdzvt8WmmSrhFpDi+SlUeV+Ie9JOo+vK3vNr6y/IOIrzosUQ
         cYA7zVRf2ro1AXdqdE8CJCLRyohLS/wfyEMKIsPfSXqj66x086rQRlmWO2C6jg2Dn+Qs
         n0Pbvxs8AWEdSeOrkuuDJTmY2xdBhc/49x7sYhixxdLMQ7MsSflwYuAU4ammqS7WH3W1
         7PDBevQhJVTdCDrnYQSAHy70xbP9CBPFDgcpkHIrJw50e+Tu3rCB+JqrhpP34blUUiJq
         S7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512812; x=1780117612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7a+I4YbWgCb4RQjRS7D/qsAOOz1ec58M0Yo5rgLJumw=;
        b=czCNzP8hOBaXWhhLKbC9y/Z7ueuTEDnTv1xzDvjX63aB3EUuVnI9KRjBCNWeTsnKpZ
         iQRDZ5LKUTHyt6NMNl6BkhgF6m+TwKbNFX7DAvyL5Yxi9IZBD7gE9Hf6XbiEccFFiS8N
         PIhyGCoCBqC971lKGAPqGD5O1gaMhDgq4LCF1iajBmq7iE2k9DeikDm4qxHOq5OV4ejq
         4Uv1QUpE9CkRNr5vNlVLfm8D4FF0ZShM5Ny555WeckIFf6KwA33h+0I6VuGty5vM0wFp
         XWB6D9zfAcmklgs2uauf02UwfT7XvRDiLF1qa+PEtuap6eqgz3RqkhFE9CEYmnxjPSTe
         lKxw==
X-Gm-Message-State: AOJu0YxB1HMgsU+nUn2n4idzOApI7PrPtOn0UoU/aRYlskBwZ2qIvI8F
	IqW9FF/0kInxe4IF++i3zURrXdq/0sO3jrogoSQtorNFtv0dRuTNFbcNbVZqZg==
X-Gm-Gg: Acq92OHy25COaBp2IOUTi/lF+O1/xgZkNeFXQD3hoTq4eL2tnqjBuJcnRKdvGePLPz4
	R+P/zUzx//NESt37YXOeOyCESfAitn31sTTFMsnjiaCaE807rs9ZWY2cjvogJ0+ujifoXrWFxGA
	/z9Ep+/kaSz1LMwiXnFXE0w7g9zMLtxVJ6FhgaC4AgoBa+ugi71yt5/F1k8KALNmfaHoaOVKLoQ
	U3+vtpJxi4XqgnFWFyO03pBs/3WYa92gM3HDFNwb9mxH6DGLLoGG6KCUUhweH4zk9FpSP2E9/8b
	SdphtOKIT1Qs3jQ1684iiAUBIb93cu/3zZUWuyou81XMyntjGqSPr5evhyUMsIOVlLAAU1SRvSp
	YH5/zm5sdKYDO1dSa6d6oqsO2tK+BwSxwXEaAbVo7HuGN/ClVJDn9/7fnIt3DL4r4PrAKSNiW75
	a+JnAaUZcrzraKnt2bCUrXdeK+gImNJlHrAJl8/3ykBVQmdS/IMuMCiAskwHKJSq1xuRE4gIJHY
	E12S79z4n3USw==
X-Received: by 2002:a05:7301:198a:b0:2d8:7302:d3d with SMTP id 5a478bee46e88-30448f4b600mr3397307eec.8.1779512812030;
        Fri, 22 May 2026 22:06:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:49 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 07/11] Input: ims-pcu - fix logic error in packet reset
Date: Fri, 22 May 2026 22:06:25 -0700
Message-ID: <20260523050634.501509-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ims_pcu_reset_packet() incorrectly sets have_stx to true, which implies
that the start-of-packet delimiter has already been received. This
causes the protocol parser to skip waiting for the next STX byte and
potentially process garbage data.

Correctly set have_stx to false when resetting the packet state.

Fixes: 875115b82c29 ("Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 0e7a783526e6..cdb46b2297a2 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -440,7 +440,7 @@ static void ims_pcu_handle_response(struct ims_pcu *pcu)
 
 static void ims_pcu_reset_packet(struct ims_pcu *pcu)
 {
-	pcu->have_stx = true;
+	pcu->have_stx = false;
 	pcu->have_dle = false;
 	pcu->read_pos = 0;
 	pcu->check_sum = 0;
-- 
2.54.0.746.g67dd491aae-goog

