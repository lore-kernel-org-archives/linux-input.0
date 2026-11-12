Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442611;
	b=mMpuHVyULPx+9S6DGw/BuRjIx5um4zdVbIicwJB3KD2MZs0JzcOzpLH+yX9nhkDNAFx4
	 lL9aYh4wpBu/z0r9B0u7BYPC+SpmKaAoechhgceRicUqAPDZ8+LbY2RYf8G65eVxih7Ln
	 QEqMSRrjcBXqtiNBc05SgjgoAuFQL5L9jDxC9BdbdU4+WH8x99LO8Pce16xYMrXrxDye2
	 HfFU2Gy66K8M8dDk7mhyDV5FoGez3TXxzIepYvAjQ12UY/hiAUM7499X64gOQ0K8JbhrP
	 x6vA8H6RgpdLztuK4pCyW0YT+tj24Nf9LAwjN0fKic78erA3POvtNH5aI0mmu1/T1Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BFLYcLYyJpDgB8FwsuriCtQnWcNZlWPgX5/Y0ltka4Q=;
	b=VamIGBu2wyEblUKChHFdWvJuneOXpP+Cms3fFQd62J6q06zGviN0PwS7Ldjxx51NdMod
	 7InRPPIXc2b+CGSAhx0EgYRTr9CdsKwkyJpDdtAhbLbDz42cekLbPQflUnSDvNIfKxcc9
	 jt4l+O2XfiFHaaUxQ4XMwHi8eXO+9FU5QrNjWL9G4eEwneMmOhI+qcujZknm47N6j/jNj
	 Sue8oI72LkwmancdDmxxQ4ifSwl3EFIDgbXas4SSHTn8MU9OQbTqPG+xa7m7RNMuo+uDI
	 /Mt6HWfzXow0bMu/SpTnlAmeIvfxPwtXgSy/TM00KGmBIkV3YhqtCRpW4UcE9+jaFJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxl9rao+;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C6606A887
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 00:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC9C6606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dxl9rao+
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36dbde64409so7479273eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 16:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442610; x=1795047410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFLYcLYyJpDgB8FwsuriCtQnWcNZlWPgX5/Y0ltka4Q=;
        b=dxl9rao+Mve2THh2SlKEiLWxcU8xmxDUVWW9ZzDnBNaloGcEPR2gnU+RF0iacvpgRy
         qBDkN6dDwY2DqaPsLjVKfgSwV1+C7D5SjdeLSsIuu7fMX7RYF1Rg8T1h3358ueumZfe5
         vCLZsLR4aGWsz4j/Bq7dtWoMpy682KSkmpf+H9HP8HzkLmF92GUZ2wgjkiLiuRaz7+RF
         lG5ajUD9brwDyJNcJ3B9VuHoYix0WvzCyaGHtTsjVGkBAb2b5OMeWju0nA7wzKc+Xt6D
         0W4l6AeaT72UfoNCyfaFOoZan2h3s4hsEjqA9oj5Kn16XbUH8v2CBdGxOlGGkMN3GZ05
         KdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442610; x=1795047410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFLYcLYyJpDgB8FwsuriCtQnWcNZlWPgX5/Y0ltka4Q=;
        b=CKV0vlrVtnu6EA3tXOcN+I1i1u3WzuNO89Qm4lpsOAS+Anayk3eW2cXkUiY6wUjjk1
         dpNjG1jUqD21GPWYM+s/vENLvrsuIwFaTkvYSBh03YPIwA9E/SLRqrJPXtCmyjD02Xg4
         vs7FluaZIJQtTZ+8Z9qH0Z5G8p2CihlZl37x2SQ+0yqMK33Am0xiezaJJglz5UQRM9xR
         CW9aeynhgwAbB5UTjcr4zAxaKvaiRRW/UBXlV2ISV7/ZcnB3cKASy7+GV6aT+qoMbMi6
         hizsG1arxnskcqceeZp4Wc+gdi4d6wPr0s3fN4ouT9+cKixi20OfVqMcVBVaD3JBQAbf
         Pm7Q==
X-Forwarded-Encrypted: i=1; AL+hErEdFePWwFe5RYqXda17q/g8dpwJXUUoatU5DkpwL3MQsRyD6mAPKcNfr71YnQtLjB8mPOLklHWuFEkeiw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/4a58PsR5llKLtZBpyfGTnrOZL2y/6FnRj9R3VaiEZtkG8HJk
	ZvF1fPxpXfwGB5ZFyC9Aydh4dAonHnCJqEZKuHlM5W4vEVZZ+ODCgZJ2
X-Gm-Gg: AYBFou0YFWGe1fnPXcTp5YrRnnq42Glhgn8UWdxv6Kfs5Xc3dY15fLclfL846ZxpbaW
	YiT96ubfb9MXC6hWz1gozq1VnUz7NeuBFcR5fbNj1Dj1WX5pMNgVSxCNmDyaWy3Jdkk5JP67XHo
	5Tc02hmAl1+OBZ+SIwPLdCK+zHn6dy0NNvVduWTYVCTqXbNbYRx2F1VUqZGwLL0XVSI/C5evsva
	3D58hSq+0oXFvHEngpaUoDuV9/GeYLtCGLLHK6hH3sXHwCnn3LZ3Z7r2OT9yTxRwiMTIvtliAHj
	TIEoK0lqpnFdLVMI1sOBVtoq2TlDGkPkWkthQT/e2SpGcSHv8AIfTNVif1fCyA4Bk5wS3R9zELX
	dhqYV1gRiASWmPcStQ8I7p09vs0iysR2cIe80G9rWKggzYjZDhxOAlRzhBX8I6L6lpNCdYy7skO
	L0hwd3p3TRYw7y+Dt6HhhHH4X6a5xqpoOoAfxPAEpIQf2fhPmrgZEdiE8Tnvv6t9jylzmeZN9LY
	6B8ImGYsZ8BWJPkrDODusdGCBpgvQseeJ906xFjcCVW+tR4D/8UuwJl9CVmomxmCkZ9YuKsN77s
	wBeCRKv+c64UJqllMH3ESiiqlIeNbR2BJSj7JgaVGFc4NDaCh9n3Wlt4OYpuJCwVmp8EyG1hEt5
	SqicrvpeO9nHJy0VkSkkT0sFKenegsjvZtTwSew==
X-Received: by 2002:a05:7300:6a8f:b0:360:e2e6:f849 with SMTP id 5a478bee46e88-376861732afmr3870927eec.28.1794442609584;
        Wed, 11 Nov 2026 16:16:49 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm40492697eec.16.2026.11.11.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:16:48 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Alfred E . Heggestad" <aeh@db.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Shaun Jackman <sjackman@gmail.com>,
	Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
	Florian Euchner <florian.euchner@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Xue Lei <Xue.Lei@windriver.com>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/configs: drop CONFIG_INPUT_CM109 from ppc6xx_defconfig
Date: Wed, 11 Nov 2026 16:16:41 -0800
Message-ID: <20261112001642.243554-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
References: <20261112001642.243554-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cm109 driver is obsolete and being removed. Drop its module
selection from ppc6xx_defconfig.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/configs/ppc6xx_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 29acc77573d6..4ba35b9377d7 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -537,7 +537,6 @@ CONFIG_INPUT_PCSPKR=m
 CONFIG_INPUT_ATI_REMOTE2=m
 CONFIG_INPUT_KEYSPAN_REMOTE=m
 CONFIG_INPUT_POWERMATE=m
-CONFIG_INPUT_CM109=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_SERIO_RAW=m
 CONFIG_GAMEPORT_NS558=m
-- 
2.56.0.567.gdb80ae8cd5-goog

