Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791583;
	b=Fdk7VBxFJpuzwxYwDcObDg09Rk8Dv2C1Iurf3PQTvmYNuoDXDDa31vNA4K0c8JC5jTmr
	 h3fvdmL9T579Mag2AVp1n0uEJpIoDvX28N20836K3zrknqR+p8GcdZlti2ZBFwTbKbLDt
	 ZhP9e46Xipn5mvvtQHim/UlVufwo6MGswuIpYF5mTg0ArJ27eznOT77MhpZmMbkU8Gx1K
	 Hi//ySxw9oP+fc7gwnsnCtfXtfWqWBqDCZm9jrjSvgMukeANstzQvX6Rqyc2ZnSGtot0d
	 KqnmaNfSog2wflXak7sAGMSKvbo3ar5XcTDFQ/xO7YCwypn0TveXWQwaTfYdF8ZAG5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791583;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=zn37mbZD3c3SxXYmLD8l2IwYS7yfb1wo7nxAh3Xr9ig=;
	b=VM2JSjKenLrXPHYzt3sX+uW+Dm5T4HhDMZxUEFA2u82g9+ZVUDncq3yJCyPwPw6Npa+c
	 n0bYPE0T/NyTvo3VwTb9sTFrsZidVjPGX3pxSgk+O+SBRQhXH/IFg/licq7e5sK/yRWmU
	 qr0ZPzAVQedP0WUwycYK8q7eB8ytkWcWTfK4WkOR7K9ARy5CvCpRqL6l6dwwexHbx4CKb
	 f9T/eovZy2DQzq/rEh7C+HA82oRqyy+PF095CS7WJ+0RLwGu8OzVeXxWUT6erxmNqN+Gu
	 AWvVvoBsMtcDH9T+hG8pyTa1314Jk7ItMDCAbrgYsHWXdLHuRNQDKbfUpiS0BJM0+pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nlwAT6iF;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1C606A31E;
	Fri, 27 Nov 2026 14:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53F1C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nlwAT6iF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zn37mbZD3c3SxXYmLD8l2IwYS7yfb1wo7nxAh3Xr9ig=; b=nlwAT6iF9JBm0YKZMEqlsenYFZ
	QWRT4+k/otBsZ7yKOt9IoqbtCkNekFoqlnlyN2pcok3f/UxYyh//NvlNWhzi16ICLW4YpZaapOwGw
	IG+nBaPX5gz9uuVHmxvPn/rEvarklkvuXal6LzgUFLT4ZHF3qu0pn4dBpWNhOcjuQr1pL9xqpb0wp
	JLWJZwxrIH+b6RXKkXebGtsBGj/kmBkTrexd8uLqfDYwkUU6i6C7Cd51VT93nPsNYJlF+Bwc5MVRM
	5oVY92o3SXsESVH7jR7iMHIAq2SkcO8Eq0SoZB5h+ftV2HjHV1zSRNVz4uP7tESSx/HYW/N+ww5yd
	O9KaSAYA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWxQ9-008Q04-2B;
	Fri, 27 Nov 2026 14:59:30 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] HID: intel-thc-hid: intel-thc: DMA lifetime fixes
Date: Fri, 27 Nov 2026 22:59:16 +0800
Message-ID: <cover.1795791500.git.emfox@debian.org>
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

The THC DMA engines have no defined lifetime: a failed write reports
success, the channel that failed to allocate keeps the tables and
scatter-gather lists it did manage to allocate, the engines are not all
stopped before their tables go away, the SPI gear table has no entry for
the slow clocks some controllers ask for, and the drain that follows a
stop is a fixed 10 ms even when a receive engine is draining a whole
frame.

This series gives them one. It is a prerequisite for the IPTS backend
series that follows: the recovery path there relies on the engines being
stopped in order and on the drain being long enough.

 1/5 keep TxDMA write errors
 2/5 free the failed channel
 3/5 stop all engines first
 4/5 add the slow SPI gears
 5/5 budget the receive drain

Changes in v3:
 - Rebased onto for-7.5/intel-thc (4f048c56c), which carries Even Xu's
   safe DMA read series; no functional change.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-thc: keep TxDMA write errors
  HID: intel-thc-hid: intel-thc: free the failed channel
  HID: intel-thc-hid: intel-thc: stop all engines first
  HID: intel-thc-hid: intel-thc: add the slow SPI gears
  HID: intel-thc-hid: intel-thc: budget the receive drain

 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 45 ++++++++---
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 77 +++++++++++--------
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |  5 ++
 3 files changed, 86 insertions(+), 41 deletions(-)


base-commit: 4f048c56c2697000105a75c28b918ae76f11fcef
