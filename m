Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835928;
	b=Qb6nft18j9+QgO9s6VgNqD+iADjW1B2sK8sma6hcr7aQV8dEiYFO7tVPYi1Ki8JjQbrm
	 IukUKCQhUmADwkF3OuFYJMoOxfseOygTLpvgbHGEtgLPg8tzToz4wmmGdgx2kkyh3EX6I
	 85sBVGTdZKYfZ4Ov1sgjGNYD45f0conQFAraBwIp6VWcZsRyB34YmNpzfXlgthkmD96XB
	 fMw51SVV+Hck395OdZ9U3ZcXCw3DCFF7/pbpu909TYr9lmSZ8TOrBC//Fig/TnqZHYkK1
	 8PHFIfono94OXyK+MoJbrudlNkwZp63fS4XG7xyYOX5d0Tep1ejgcGQ2KaIy3m8r9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835928;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=d4RiW81h8UyNIqIzN+u4H4jyhUOLuosf9QoyMugLv8E=;
	b=4bKWmkJp6RU6Es2xUm6haqSwHUjvzojdJZUzqGQdOFaiJyDpG3kcBkFrbLpy3AM6i9qU
	 BLyJB8yEhQRMMmg5P+n/cx5krpbEY33Cj//HRuzcTZncRK33UnFMMWpEnmTEWJ5Vzh1e1
	 QS6eO60rTqOgtuA8M+upwMxdLFR4WLNPdTxElyeq0ZtIpP90GbNWOMb55n0PsXY5OG2oG
	 AUNuLgELULH2jDO42p/Q20WlKpi7PoXCo7dMHAq6bIu5SCC+QQKq07hk1aSb5Geth0Dz6
	 /g5iNujAX76oUspxJoGyub9QnoM1N2oAuvDGSWNLTIUD0pGppsEze5AP2OSMNSTyFJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IooXGo8F;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424B606A31C;
	Mon, 16 Nov 2026 13:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5424B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IooXGo8F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=d4RiW81h8UyNIqIzN+u4H4jyhUOLuosf9QoyMugLv8E=; b=IooXGo8Fv0ToqOsDQTzPLzJGWk
	1QvCdoORZJ0aiGBfuu9ozrs+K42+q0ZyL3m8ma8eUu2NoKrGa4XD+/BnQO66jOzRj4h1mY5teoBDb
	CBxfy2baLW+81URNFO/dW46IlVsOLVG/GCNweawZlyDyHO6nHMyXCLE4cQLwh+8zbvSyz54DqAIz/
	fb03XkFnw177myeez9xcWTkbMW1wzdYvWim3tr3pgHGA0B9qZgC989buSJ+dyeYjqNcJOOjL56ZVv
	0aWhgJyMNuUY4kAjRM0quvfWn1Bq82TrYrZuLIeuL+cO/FlS/86iomMZOaTfWA/RnrX1lnBoqNb8M
	0uvmZ8xQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSwoL-00HCTo-2J;
	Mon, 16 Nov 2026 13:31:54 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] HID: intel-thc-hid: intel-thc: DMA lifetime fixes
Date: Mon, 16 Nov 2026 21:31:27 +0800
Message-ID: <20261116133132.1282020-1-emfox@debian.org>
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

Patch 5 gives the receive engines a drain budget that covers a full frame
at that gear, and leaves the SWDMA path on the old one.

These apply to v7.4-rc3. They are independent of the PRD table capacity
fix posted separately; the two are both needed for the recovery path to be
complete, but neither depends on the other.

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


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
