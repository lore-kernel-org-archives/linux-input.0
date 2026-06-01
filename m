Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7503ACEE0
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321289; cv=none; b=HhhFSNEFE55XsyvXmd9x+DmQStR1KAYKSv7QbV31gVtt4HEM5d8Kp5Z2ROpADWG445Va7dHincWEfgGRhlb+uApoqQ9O5g40fDkQVc5uznHz8dbtPYTj90EAXgSQeQs8VHFRatUIrHHI2g3tUvm969/PB2ZkQTqjZXqwnQ21ZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321289; c=relaxed/simple;
	bh=N+t2xw/N9UvZQMbKVq3rhJOSoOqLPghAmgvArJMgyts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnk0mlExF+Kwl3TMmUtK+Aaq1DT8PMqjB0D6AIGQX+TObKj0ccDvoOmZBoIQw3WSujA/RJcA2BRS+/g55Piha4eq5lVpKiJbptOg8KYL68XiFqHAe2SdvUt6GXRUA1GAE/7aa2fAqBF/q+gHVgpO3DAhwIhSF6yfA3rEtirOtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/c0xXFE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/c0xXFE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1891434a91.1
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321287; x=1780926087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7DVQL95atfUox+Ke0yfib+1TSwLTYfFcQgsjoIo9Eo=;
        b=S/c0xXFEl7KNvG5ZE+1U5I0ORxmV+ipRghuIhOgKJpfk1wVouBcmgWTtsDOith4YEx
         4Tnqfi8o7LBL2QFH87duhEoM8+o5rJnWsRmhuJu6/a9ArysacqRXwjBg7ZfzBnwd9R7x
         pJ5HEDA9nBdh+FIGG/NjYfJPBagSdQRlMPaQH8zJ49JkTdl1uZNoR9XyzBnUP7jQ+f1y
         3EONxk84ZvMm3BG/Bg9pP3MbapOtvZs2j/DGi3wWfxmSLj1kMzxNgiluOMb++1SHXonT
         OvmgCVLoHxVurueYvvniosZVj+MT97QSmq0x+Pha9GMgxyRn4XavTGTLRBczJd0ceTW1
         VSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321287; x=1780926087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7DVQL95atfUox+Ke0yfib+1TSwLTYfFcQgsjoIo9Eo=;
        b=Bp+j0k/IhS89kM4f9Q8mjBMORAwzUofv/rvC94GEXqdrlIzwbi7TTaIznY/3cyfv7I
         E04gFX8pPwaZYkRn1AugfLFkt/NhNYzRkMcp7/2xfu8Y3ndoLos5V7RuJw979zMGopVB
         LGASgDtTB66b58d1X/fj84dlt3/zdmYfbEeDDqoGiEXKS3mg84BMbJE6PtZXA3SNK4bY
         /Vos1axUpPujFdp/jSC8taePw34a+KQMl/LH8k8m272kC1P6fGijnHHbZqvF2A/WNpwA
         YTxhCpX9kKoN3cdD00eJCj4z/ZrtxBEufNEfCJAWUsuWCCpgNA04UkoNyCwn64Yzv4Bt
         Uwew==
X-Gm-Message-State: AOJu0YwwG5oKKesz/WoHYvCoD+q4eROcIzPM7DDjt3oti0WrPinty9gx
	GUSCqR6YW/mV/N+PzuMlSnNau0Qac556YNUuWimuZ8Q+Bub/+MIX3RPNadfexEuywwjVMQ==
X-Gm-Gg: Acq92OGg/cO573yFmn9xH7AKVMNdQgXjv7mGjVfuwpLZwq8BoOSnPokCothojmuHZI9
	ao3mD59KXx3dpTKkJcaetLBVlMwlkOOEX9yVD7U8e/zQHgKOube3etxG8P0kBSLVuZrGpDav/sF
	XXbqoLKk2hQk/rNxyC7t55mxhh6rHAEfHWijRs/VEyRwd7T6bC/l3ivSGPoQhump8SSJrZojNEl
	fmpkTgsn5/93neYvRN0RTnntqMbsuVpbdY2GXxJZEP67AS5TJUw9WQMdlH0SRV3cNyFaczuLlij
	iUBluxLH590wlqUxb7QLTfSi62GMqT3eScdaPnlTBaaGcqoBH0HdUbV5+T/6zvqgMRmMClxSXXC
	fZ7nytlfot+KYZPU5pY63/AZyUYMte1dPCPmXptcv0Dfl43+kgKzP4/4mNe6bYbI3NOlIVGtuWE
	9Od0fK9HifVIgw7QKo1uLLN/t0f19E2A+JXvwjjft98keiHlDj2/WDLiUpWGI=
X-Received: by 2002:a17:90b:5184:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-36c501c16cdmr9130545a91.17.1780321287232;
        Mon, 01 Jun 2026 06:41:27 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc65e8490sm11496959a91.3.2026.06.01.06.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:41:26 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	jinmo44.yang@gmail.com
Subject: [PATCH v2 0/2] HID: wacom: fix sleeping in atomic context in wacom_wac_queue_flush()
Date: Mon,  1 Jun 2026 22:41:22 +0900
Message-ID: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ahu2oxLwkgMlwXu7@google.com>
References: <ahu2oxLwkgMlwXu7@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

wacom_wac_queue_flush() uses GFP_KERNEL for kzalloc, but it can be
called from atomic context via the .raw_event callback path. Patch 1
fixes this by switching to GFP_ATOMIC, and patch 2 converts the buffer
management to use __free(kfree) cleanup as suggested by Dmitry.

Changes since v1:
- Replaced Suggested-by with Reported-by for Sashiko-bot
- Added patch 2 to use __free(kfree) cleanup facility (Dmitry)

Jinmo Yang (2):
  HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
  HID: wacom: use cleanup.h for wacom_wac_queue_flush() buffer
    management

 drivers/hid/wacom_sys.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.53.0

