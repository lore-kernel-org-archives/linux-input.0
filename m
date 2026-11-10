Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286044;
	b=zYx4XyFoArivf8vvf4VAeby1XWgJqvhdPXdkCW6Gq7pjpxDVc7HmfRlHbzibGjBzytG2
	 nfJWibn9y02wYuTIUzhccthtetrAJaLEn4QeZcJB9QbePDxexyXVYYQI0z9GKqODYqgGz
	 38TahKdoVa68epyrO4KZxlmK3i1s/DbBKoY1Z6a4T5G19or0TJWUeTVUA0farNZLnNaNR
	 13uewSKyOESy2dizyJ0IFTH9GNZui103ShS7PFQl66TPQiMhGyBxW+WoOlHpCR+2dSEPD
	 RH4h0siQMaHop3a33xiSp3ffpBoYukjN8RRggNd3zJ6MnOBHVrpp7eOOjAPbnQaGXEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XG0VksmSfVKTtdSN1LbjQIB6bZPmaQKbfPiHZ6IjJLw=;
	b=Ur8YE7lEDGYfGlMB1elO3DEazyUs55xwN/cly0wAUnqXXmZWimbPewsL5g7tZELhaAKQ
	 332nIebi79nk9EWeYQpFKjcWJ5ZW3XNQr31CWZOfYZpsvdGunaiqgNrJCC1E0CBPMu7Gi
	 BJ2F0/+SMZlHlKgk68wdnkuRdTQbNVhlx1DO9KiIa4cJOjywXSgV7diJ3Q3gbyOcJlva9
	 rhly7nidg2sl3iisXfi1FRNEsav5ZSTP9Mnj5evy8zNA38yfkO1CcEj3y3lEsz2EXa02q
	 sGH/75KVXrEcl0jHPWSzt+tUhzxgESWwjvXoGWSttnvzdCtnGkYGzXeTNfQc+iwayLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wci7ijoM;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34824606A321
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 04:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34824606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wci7ijoM
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ec2d42231so17559296d6.2
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 20:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794286042; x=1794890842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XG0VksmSfVKTtdSN1LbjQIB6bZPmaQKbfPiHZ6IjJLw=;
        b=wci7ijoMJ3lK7M7H1VgZd/BhKNO0ynHkaqiv4EhkkwgSVCCdpyqdPNxzKTzOhhbD3z
         zmw5o8CpYMGtSgCGbmkt7csgw4X54zPgwIdCorS5eJ66Cv31ckBjsXKHJbJSSaJFrAcT
         48IgtBwMLoo6HGKZCB5MrnLezUPgECN5E8PQ2C10uADwgb3X/+PluYknJBPs2m68pXM7
         yFoLPzpNgNnhcvjyTx+8o31OUmeD9KIQ+ayrF9lf/tshib3EZKkB/Yq/h/tQfnRwvaZt
         zmSJ5PJRSDC9NND/Tlraez7PbP5B6he7qfxrMjdwXPwTnKoOvywETkQFoAmHKcc8IpTb
         xt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286042; x=1794890842;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XG0VksmSfVKTtdSN1LbjQIB6bZPmaQKbfPiHZ6IjJLw=;
        b=X4BXCiGlC8porNB9Ddvjaq9Z+tZtk4mebbM44TNVTpje1vGOybofbVt22L2FiNt5oe
         QsjLvUEKjycq0t0+yQhoh174Zvgl4EKrQ9LSMmnwseo81Dgm85Rf8Y+Emlk/ouS8JukP
         MBSSet/PXPFsO9kplHEvDQB58erKCvISg8AZTbSRyG2kqs3/22sqAoDs/T181WK2SM1a
         20RtRBWi+bh8IciLkJmsyj8+b8J5L4UygOWxZJqD9ltLTzGg1RBG4/QrNQy97UQ1jwGi
         p6HeTN2+fM6YKpSJV/GieJ0cu5fppCram7xEkKmMqX2Rnztm7pAWK8f80vXXeuP0ii7B
         Fj2Q==
X-Forwarded-Encrypted: i=1; AL+hErHlJ0jnMtDRD1oTBywKbLiQSEY7KHGYN7VhpCzx24FLtakOTQ8O4/km/iy7K3DG8L5wQJg4n5k+E3wjJQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/S+TnZr+Aah55059RWf3G3WgKGHBQLawXrxfkchGhy8KjtFbmn
	tMOxGve19kr4WGSEx7up9EhPcJEyr9Wkt3T34e4ALqhkH26dW/vU7a8=
X-Gm-Gg: AYBFou1zoT3Nml1DS55mvA+Im0TkB690+tj/jAmMbY/+vn6D67iU7q/caJg/DluQRlJ
	2+bScY1t+79WUw+g8hqq9zH+WPO5PoLfOw/wMe+TV1wxT5pHc+YK41dBJtLdwMbdPOgL02NJozx
	8JhXDqgOvmuZUyjLuIRNE9GNE4EA/2jS1CaHplOUL7c+/9/czo7IEzZBjqMR9TcsFAhKSMIzMZM
	t0jCl4lYVHnsVlZ6hUQjdb+YNOwUwwq6PR3FSrkRertRsx8On3TwnklCwHDIpXY8NjQmX0jZVeg
	o3RmmvLTNcjCNHFfMarEiuYfpTQxUBvkE6wkGe2H6zmh5gt/qGcR1k0j92abcoFYASsIUD+HCq5
	JdLgfXOxQBuXEjCHR1zano/ZvS/OaTqDEgQMOFvnxOYa/SLcMCXmpnIEmwLQAbRM6pDcZ5HRhFm
	9VwPgAxTLqRgpPPPF9MC+GEUDhWXDQgDLIw5u0M1R5d461phLqN23af0vSmKnApHUWHatte5lGa
	SzBRqrlUw3KDXX2A/vWHgq5QfkzVOxGr0Ny0E4YmR9TiwP1DmvlNufwS4b6feewHwp5KG8Qqu8x
	V4gnEUvGWQFOuCDbfRU6LRv1D9eZJKE54yVGYa7EZlzfpTl9YUdwYISj/ck7Q/47ABOH7vTryA6
	rSKgN5sTMOH2NHnAhtolBzwflUEpo/ozS4nNGYLJV1vtkKKabHF9kNx3egijse5iFKt4accC1FD
	Q9q3f1kCXLPA==
X-Received: by 2002:a05:620a:3914:b0:947:9410:f076 with SMTP id af79cd13be357-9479f2f6069mr234609985a.55.1794286042116;
        Mon, 09 Nov 2026 20:47:22 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73ab4bsm137920185a.14.2026.11.09.20.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:47:21 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2 0/2] HID: intel-thc-hid: quiesce IRQs during teardown
Date: Mon,  9 Nov 2026 23:47:17 -0500
Message-ID: <20261109-thc-rebase-v2-0-mhun512@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rebase the original QuickSPI and QuickI2C teardown patches on mainline
b3dfbde62cf1981c4638939c159dfd087b7a72e9. The source additions and deletions
are unchanged from the original submission.

No hardware testing.

Changes in v2:
- Rebase on latest mainline.

 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    | 28 +++++++++++++++++-----
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    | 28 +++++++++++++++++-----
 2 files changed, 44 insertions(+), 12 deletions(-)

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.53.0
