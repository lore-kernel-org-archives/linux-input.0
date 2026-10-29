Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283041;
	b=dkYKP1WWSDn2ymaR6pHM+qH7S58ueHM8EsB6gWylGzGuLPKOYGfLSWsLHZ7t0KMWPCgm
	 dQudI4x1xLx60iFegi34UR2J7M0A7HLCTQUFDCiI+Ubk4UnaC4pLmdJVDShksj/akLciL
	 loLB2v+fLmFcqAbHMvbX4gqEudgZS5XCvDWIx7GgMRAHVcuzo+p/g09W2TkGD5KCUcaLo
	 j2NQYuEcccvX+FILGtTHQ/kzwKu4VuRO7iJOWb7M7K3NMxi0If5fGjn87R4rmGJeYl68i
	 fWe7GH/TU9JFaRWAOOk/CpdYDD2L4iQhTHiuk4x70jVnfzEtRdfvUHas50+KPbM2UEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F0Pjn2BqzzaqvJe+lN0bPMDDItv7FxWwhFqAjmgdB4c=;
	b=X2zOuv5lg9E8s/ZonRuMkEcWnIi4hq5B6LK8VOY0bExVn8JWNNyq5UlejWqxuQmQk7py
	 oBwj9PpnfsskLJ9H3TYghEU1Rwp8aFz86n2fKldInW7khQvpr3nd9PLQh2OtRwLFtIUCm
	 RkecfoBwSmq+HcrxdSeUHpIj1k2SaLiLn9rLG4CdorR6n9VC6VoFDz0+SxO95RfDjCb+v
	 HhUEfBaVIrOMymBbGkNnmQjfEKI8Nb6Y09ODOJlNpUXXQH7aLmZaQF3Pf+BwodOhciP+N
	 uhlrv7W6qdauW0j06uGjUUTnALhg33I1zGVYAo0Od2FvqT9HguneV9htjRjosDowXVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y37EPxlC;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F3606A31A
	for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 14:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 848F3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y37EPxlC
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso22530385e9.3
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 07:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283040; x=1793887840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F0Pjn2BqzzaqvJe+lN0bPMDDItv7FxWwhFqAjmgdB4c=;
        b=Y37EPxlCyrUha6uIGc+dDcOlep9u0jlBuh9fefBtz5OC8Ej0GyRjlf1upZ6AEcsEm9
         SeVoZvh0dSuCshpsoIpwW0lhTQgm6BFz36rnAVwpIMqbndLmzK7Yf1nVDX3592ZuAhpb
         r2uj3+n2fbHUO5CsmG3Gg35f2XraLGLX0tWgp1aXpM1fW1+KYEhRRjmi6wPJxyPyEIan
         nXrT9f/UafSDB08BmzgqpQu/76HvX88HiJz/Qagxs8FSa0QDM+nI0GTkIQlAQsuu8H26
         GKc/t6x6fsJLMXIYwBJMASle5zJedGXsqlgXXoGo9ETPIwMdveKcO1kTbILfl4v+WfOu
         qHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283040; x=1793887840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F0Pjn2BqzzaqvJe+lN0bPMDDItv7FxWwhFqAjmgdB4c=;
        b=Zm8KUNYYEwjiIehTZielos0vIseoERU4p50xvuiP4abMO7MN+HpJjJk7onzChnLUSh
         oqeFjCrlBCX/QM6yxuhL6UKIlmCIOS6+ap8qQnPhHIfQNlIcp2TAUIrvIQ+PWVaSpYBa
         y1Zcj9rtZh7T115kBx/PMhjVg7ZCka3tbJe4HPCkA1BQc5hNk7484c+G6oVoF9KSUeV0
         E+U5fquB5Ko4ODmyKzQO+GemttqEEJjA3Hk0Kmbvea/Am8YC+wRxS3SVaTWziAOmorIb
         pBPLdYkTFRBeKecikIf09cnaqQNtD6pOXoGjYxG7VivIXnAwh2CNo5xu3mLRsLonGhvI
         F8rw==
X-Forwarded-Encrypted: i=1; AKwUvBwBgB4sWLcgohAGoy0wQSv4mEIOtcazoQx7d+05DimAd+yEZ2Jj3DayMXOks+X8JZp5IQIKDMvK646hAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJuhRDxHtrECXClYCF7JVWiUO+A3iZGYhp2BshP0XrTttMX1zpn
	m/I4EPgK2XmOVvW8EUho5qGt87M8pWx+x9wa1V5lOIXL1QnYcz/mlHA=
X-Gm-Gg: AYBFou0gxjz4QcCroIp7L4L/GB0hyXrEa/hMMQvFC/HOfrJKXiF+YsvSgC91QReoJx+
	hnFlBz+d09qe4GyRwgH8cOL51sy6VUNQP2addXp96os7r4sxbGH+znuoS9K/+XTGYK8H2ffOP19
	wYch3bNRRN7JFltS3+s4ZeeFOgAJVdgfdiwulYE8Nc2QWXu4SdWaQzH8b5aHxEQyC8KSQNsEnI0
	5jyfg4YVKi3UXA1VKg90nnhrjsarpg1ol7Jl79i5T+Zf8Mh/L5N9OTYubi6irfPU5Wx4LhQnXAy
	u6niOXek4WqiM6FWucqYkGbRtsVOw7znRhD4ptzso7Bec5+jokf1qk92fxV3cxoDm6uRwToiY+/
	XylIUTjVUpJCjAnS81o+vG654D2t4eR/u//+0XGiMj5GccT+BsKmx88q107Lk4cKzMlUpjH/HSa
	6ca9snt5BtgsIeFAmdIoQGnNJpxa8yF3aBuQv5JkpHdGiOU7pKrzeTyRBOh4HvABylxLrn7mTLT
	vVTgbn5mb6sgT7GcorGWVaAf7bSX5JasReuEu1UI3jpdOsYmdY1Kr2Gw71DHhSvV1YuaKctOg==
X-Received: by 2002:a05:600c:b8a:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a96667c848mr120870685e9.10.1793283039641;
        Thu, 29 Oct 2026 07:10:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm35906848f8f.18.2026.10.29.07.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:10:37 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 0/2] HID: intel-thc-hid: validate ACPI buffer lengths
Date: Thu, 29 Oct 2026 14:10:34 +0000
Message-ID: <20261029141037.2655603-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

The QuickSPI and QuickI2C ACPI helper functions copy firmware-returned
buffers without verifying their length.  This series adds buf_size
parameters and overflow checks.

Changes in v3:
- Split into two separate patches (QuickSPI and QuickI2C), per Even Xu
- Add kernel-doc @buf_size parameter descriptions

Changes in v2:
- Use overflow-only check (>) instead of exact-match (!=)
- Zero-initialize caller stack structures
- Add missing type validation and kfree in DSD helper

Tristan Madani (2):
  HID: intel-thc-hid: quickspi: validate ACPI buffer length before
    memcpy
  HID: intel-thc-hid: quicki2c: validate ACPI buffer length before
    memcpy

 .../intel-quicki2c/pci-quicki2c.c             | 42 ++++++++++++++-----
 .../intel-quickspi/pci-quickspi.c             | 37 +++++++++-------
 2 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.47.3
