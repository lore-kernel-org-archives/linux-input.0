Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985039;
	b=wgx4J+hSEV03ircR52XbbsTvrIzxrC+rK5hFbv1SBe3wEoB/KNbQVL4hw4Q68d+ROKCD
	 MsVsSrPMV1mtXywWnbsiJL8yxy8LspJO4P+EG0teSXM/DX/b+NoPaQnAe6NjepMZrJcxB
	 SVYUHkDDX2mTqT9W324puONLSw7BWVajzaKA72vuszWmyU//BRpVRWrn+cKNgd5K6aSOY
	 j25uQrNyw2UI/VhAZ9t3Ap6JMudzsQ5IZ4bZuse3ol7bR71NBKGCOYbXKCo8p/MLFS2yN
	 WC/gg7ciA2ovCGO3a/kTgQjHgz83Gsck6YbjRGdDPYI5uMwDrS3o7w6EOWMYlRWsf8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985039;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=Pb3HjAPtMU9VpD16QbGpQcKr/vglWbFlJ7XLzvMerRk=;
	b=rz8M7SLR5ZCiYik9BGWyJLIZGni3HvLbBX1vezPRK9tBbkIRM1HixV03pNXQ+pE77f8O
	 fVDDRTiFxY4ZDM26TcD0YIWMrCr6YiHAvg6gtrOqGggSo353I92CwFWOIvYVUzngplqRh
	 rajH49KAlrO4/2jJYjSS3WmeEvIVum0S7tICYL5NKPmHF9sqOxY4iypqVSbr3tT1/m7NP
	 rgRQBDIm9WkgDTUXJtX6x2Lg/N3oF5SH8gcCF7recJRT7pbWXJ3hyC80wzq9R5/2jvqrF
	 lq6SVVbhAIwJWIkJHUg8YnThMsZUDCKQDk8UeXO367OAMsVeqqJ5DRV2S31CuvXpdyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pydFasZP;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78077606A31C;
	Wed, 18 Nov 2026 06:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78077606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=pydFasZP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Pb3HjAPtMU9VpD16QbGpQcKr/vglWbFlJ7XLzvMerRk=; b=pydFasZP/71sI40PTpkBJhDN6j
	pF1MUQ2KIAB0Hc/qZMDeb2cNKUTC8UI/wIu+gf6mailOE+69mtYOFSjNckbbXp7sMVpIZxQwQg/s9
	oD0r2hkVEcdRFbZqFTDwks6SEcYCXqE7uPQ5RhrnFApPWse/btFXs9ZKKDuAa5uj1XeEG1nbY7uLZ
	2YtROQFxbu7ZIibrS9DLHu80Ai+r0wWwoh1gMnZ59dd8EAa03sLM8gpu7G7IGM8wZXDUh8zKcLTRO
	c7pUfdMcuj8nniIfOtiIXHj/1xPp0bALe5kyJ0SqOHHG4Sfv51BIfIKUAdcAA1GOnzUayK2v0tNs6
	Au3OGSgA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTZbT-0017sd-07;
	Wed, 18 Nov 2026 06:57:11 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: intel-thc-hid: intel-thc: raw spinlocks for registers
Date: Wed, 18 Nov 2026 14:57:04 +0800
Message-ID: <20261118065704.672557-1-emfox@debian.org>
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

The primary interrupt handlers of intel-quickspi, intel-quicki2c and
intel-ipts reach the registers from hardirq context. The map is a fast_io
one, so its lock is a spinlock_t, which on PREEMPT_RT is a sleeping lock:
taking it there is an invalid wait context.

Ask for a raw spinlock instead. The accessors only touch MMIO, and the map
is fast_io precisely because it is used where sleeping is not possible, so
nothing else changes.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7feda4160..e318f26ad 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -49,6 +49,7 @@ static const struct regmap_config thc_regmap_cfg = {
 	.reg_write = thc_regmap_write,
 	.cache_type = REGCACHE_NONE,
 	.fast_io = true,
+	.use_raw_spinlock = true,
 	.rd_table = &thc_rw_table,
 	.wr_table = &thc_rw_table,
 	.volatile_table	= &thc_rw_table,

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
