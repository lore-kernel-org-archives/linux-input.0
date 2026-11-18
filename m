Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979930;
	b=PeD7pVv9EB2FfAUBenoD19rPnITH2a5ssCPQv+5Aa9h+SDVAqp/wXNyVzhXf0y/JnlUT
	 bhKeNS2olpABAlqycU9zrRPMOJKQIvoHTCIaNE9e15CNNMbiCwqK3sgRvl2W/dD/KdtNr
	 4MjZ75SUDSStKZ0e61kIaIBDchvlQDTS7+dqMhZdGmjaldyq+5/BZg8uEtny3eJ5Sc+28
	 Mc8JQk9kDKk+0Rf5Q8JPETrmRel4WTjKpUVJ1GkrDzUHBgSfG6jbVlEdtXFWSOBnncVkW
	 RnKKso3wbpckYPd0qiFiRpIgZuUvthtwgMUM7sPtLn6m2rAEDs8Y/fImOeN6/S0VK9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979930;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=/Qz0goMhB/ZiRNL+IlXte9tofCUh6JVCmoBTwmpmZ54=;
	b=kB8KUG0CkrnDGtNV2x8AmxSlWjB4HNPfnqKuQyODim4d6CJawM7z8fWolbJuswsPsfGY
	 9QEXr5DnovvBVAfDC3pnQGHJG5J8YJS3GXVrORtS1BdIFY0A3ATrSIXGZChS5fKc8sKc0
	 6ABuUvLw+FkTXjyY8MtkfWwAKq9xR5/cE4QszflJ6s0sssoTJGGCyseMBYcHpbVGybZ5T
	 eAPMZah/fZV/kx68P4eNOwBDgoPe2t8E5iZUIQAjMQxBx0fInilPTXwr5WpWlLlRhIBm/
	 BH1gRH8laAfCbAQx+Qy15+t46brrNCUD0Muy2ulBom//pHfhV3JyP5ZzyP7rUTXxoMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=X0VYIMd2;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EE606A31C;
	Wed, 18 Nov 2026 05:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B4EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=X0VYIMd2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=/Qz0goMhB/ZiRNL+IlXte9tofCUh6JVCmoBTwmpmZ54=; b=X0VYIMd2Y7opLEXLNrNpyokXSY
	MwK0iLXxjhQyKdjnqxbEp8U6d2WGi0nL13sJej1OtHw6iiy0+ho+LODnmOzIhxzOZ7SHgYrc5JrDB
	1An/Gu2SLzqqHqR5pwiiJBYu/fwCowU5RsjbD78i+8MLy1GSwR22SUFA0hRVSoU82qZTGGzpmigLp
	Z/Tp9XmttWZAhYICzCyxYm5CYT7TGIehOFDThtI+/wAqXS+/4jIyExyYC+v6+VTN1/7njsL7tcWd4
	/bHsHiXId00uTf1PI1ehoPaI1eNYBiwjagzouxg77Nb2GCF5zI9+RaNdh+N53rHhPpEzufYxIVaRY
	AEujmd/g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYGx-00150x-0T;
	Wed, 18 Nov 2026 05:31:55 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] HID: intel-thc-hid: intel-thc: DMA lifetime fixes
Date: Wed, 18 Nov 2026 13:31:27 +0800
Message-ID: <20261118053132.253448-1-emfox@debian.org>
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

This series fixes the DMA lifetime problems a protocol driver above the
THC core cannot work around, plus two smaller issues next to them.

Patch 1 makes thc_dma_write() report the error it found instead of
overwriting it with the result of the interrupt restore, and stops a
signal from turning a committed transfer into a restartable one. The
completion interrupt has to wake the queue with wake_up(), because the
new wait is uninterruptible.

Patch 2 unwinds a failed allocation through thc_dma_release(), so the
channel whose setup failed is freed too, and frees a scatter-gather list
that was allocated but never mapped.

Patch 3 stops all four engines before thc_dma_unconfigure() clears their
PRD base addresses; only the two receive engines are stopped today.

Patch 4 adds the low frequency SPI gears, down to 2.23 MHz.

Patch 5 gives the engines a drain budget that covers a full frame at that
gear, and leaves the SWDMA path on the old one. thc_dma_unconfigure()
waits for the engines with the same budget before its caller releases
the tables: a start clear is only a request, and an engine still writing
would reach pages that are already back in the allocator.

These apply to v7.4-rc3. They are independent of the PRD table capacity
fix posted separately; the two are both needed for the recovery path to be
complete, but neither depends on the other.

Link to v1: https://lore.kernel.org/r/20261116133132.1282020-1-emfox@debian.org

Changes in v2:
  - Patch 5 waits for the four engines in thc_dma_unconfigure() before
    the tables go away, and is renamed from "budget the receive drain" to
    "budget the engine drain" to cover the transmit side as well. The
    budget it adds is named THC_DMA_DRAIN_US_TIMEOUT for the same reason.
  - Patches 1 to 4 are unchanged in code.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-thc: keep TxDMA write errors
  HID: intel-thc-hid: intel-thc: free the failed channel
  HID: intel-thc-hid: intel-thc: stop all engines first
  HID: intel-thc-hid: intel-thc: add the slow SPI gears
  HID: intel-thc-hid: intel-thc: budget the engine drain

 .../intel-thc-hid/intel-thc/intel-thc-dev.c   |  45 +++++--
 .../intel-thc-hid/intel-thc/intel-thc-dma.c   | 127 ++++++++++++------
 .../intel-thc-hid/intel-thc/intel-thc-dma.h   |   5 +
 3 files changed, 126 insertions(+), 51 deletions(-)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
