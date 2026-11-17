Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912880;
	b=1vS1BAW5Wc2cQN0sjcGxZRePTM4uCRpY+u2jijiRY1o/ZY+WlxXJzWQLHUz5VL1TFIbc
	 3gAev2eDf7sqJDDZgmpo1tJh4Y9IhoMJa8arROp4TH08by7ouBqtSpo3S6GCHLHj1acwe
	 nB8GnimO2TVgDvwRfNK+b9iWbeIEbvwB9D6ye/S85wXp5mnxJrF4QnCkA3rRi5bGU53Ul
	 4SgsbRgtN1IMNEe33WrIs4txHCM9aLy0eReHH9Op6dlnpff6OanwUy336uB4A6nR3mKC1
	 +CMbKCwoj93w7ob+4kzic6n0R44MBTmdwel14+0Rxuk0pn9nAGfg9WNfrbMnMFTUYRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912880;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=lMR0V5iCeG8r9cnlEj7OlCRe10wKQ+/vRrGaJzms+/E=;
	b=VSk+1BVscxKsqetH4R+62iGiRrshlvaAgMtCHcECVJ94HR7DLzUFlEASPt0KP4EKl3zJ
	 FpxuvQEhpBoOd5X64TbFgi2KyABm7BPK1XdbKcqusz6R4UnPL9mzrKj+vTKe8nhdqT7d2
	 yEDMcq2t+eAiupTjZb7XjrHqQ5mLY5XBafnzqRB4qByxowNoLZDMWTznRISqQqA658Pog
	 StlGATJVKpB2OyEf7TWM9+hFkhQnBatuTFpuiwgBvHNfwtSj328z1a7r4wZNk1/c48wun
	 v3xzZwdFFzCRUhNaTftL8NqTowwx9QdzuiIBSKV1ymoTynEaso4MNhfy/5z3qpFdhmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Jidcw0md;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494E606A32C;
	Tue, 17 Nov 2026 10:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9494E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Jidcw0md
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=lMR0V5iCeG8r9cnlEj7OlCRe10wKQ+/vRrGaJzms+/E=; b=Jidcw0mdKO5/+YI/WdS+8+sJut
	tJG0/HfubMn4HntOD5bR+vBKASbdfzqiNmHVUZwHzUcsHt3Fu0BbQR0dWM2/YUCtdrQt/O10Lhghb
	4ZMVWHH6PuPkFLPyvHWE64cTKQ36bgqdmgUQWBTaebwVDWqwH/eHl7QIQikCXy8kl2CKIEsiO9Au0
	e8MVBrMaCTE2hDUUCHft68PAD1SMDXhrJ4v3/SA/J7+p0nU2blLxUb2WiFIkrZIBM1UaYpg/fEAcG
	blw3SIwcRuX2FVfi473nXzVpCGBegbAdLxNdLXDM+Oqmkn+NXzFwPAZ9MyzYf/EPmA0JEoxAqeUlR
	H6G2FP4Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTGpd-000Tyn-0j;
	Tue, 17 Nov 2026 10:54:33 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] HID: intel-thc-hid: PRD tables under a drain
Date: Tue, 17 Nov 2026 18:54:25 +0800
Message-ID: <20261117105427.319242-1-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
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
X-Debian-User: emfox

The PRD tables lose capacity when a frame is left unread, and a drain can
reach a ring that a reset already rewound. Rebuild the tables before the
engine that reads them starts, hold every path that stops an engine or
moves its pointers under the lock the drain takes, and stop the drain from
treating an empty read as a frame.

Patch 1 does the ring side in the core. Patch 2 fixes the two callers that
go by the buffer instead of the length they were given.

Changes in v7:

  - The two Fixes: trailers the second patch was missing, pointed out in
    review.

Link to v6: https://lore.kernel.org/r/20261117102711.270303-1-emfox@debian.org

Emfox Zhou (2):
  HID: intel-thc-hid: intel-thc: restore PRD table capacity
  HID: intel-thc-hid: quickspi, quicki2c: skip an empty read

 .../intel-quicki2c/pci-quicki2c.c             |  3 +
 .../intel-quickspi/pci-quickspi.c             |  3 +
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 89 ++++++++++++++++++-
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  8 ++
 4 files changed, 99 insertions(+), 4 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
