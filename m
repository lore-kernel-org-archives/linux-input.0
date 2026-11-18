Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985056;
	b=Ky5/6/jOX0eQCa5379qd9xiKB9xacMt/hjKBWrb0UJKRQvucTCbs9ivXIZMyAepxKlbS
	 2I/krQVO4kEeWxUmbRLdGEL0EHXQGPe/nixhsagIw+9TIXvUkGiW2o58L0cEhygIYgwsC
	 HJWHVaD2u0dEcZFTiN4uJLNiUIWf1AGt5IYtsT0X1k1qGQ2TrEGH9NCTG1PaatJhEUaIh
	 6l2PylujM7KSDDYqR4fvjgdWBgekBii4dUE0ehuIjnPXZiodewSqaSWv2Aarg5+zL8k/O
	 AMNCxKzgjnSRGEr6HO1zLB/Z567qLG3SUltOC9kFfwZ7VJRGMVjHlGZ2FGR5axnpjuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985056;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=wFs4xm5MsSM3Xsm4E93a7wjpoFaC4rO3h+3o7wL6/o4=;
	b=kpiP34k5WYcV7q/4oCbgNoc62MgoMcGJdHifolzRLKPocMamJBu6PsIlMbWsPTi9ZHZW
	 NA/fqXhSHODbezJt98kjhLtYcRfo1Pw/tyF8iaqvpTTcKRPziMNuYx7T+m3zSB+iU3dbP
	 RLOFKXoR48/PHha9OtpYO1T6uCriYLeWqHHsJTmJYNwYrCalwyzmVXQRJPPjjiWxCOjxc
	 jrUEaFLUkOR2mJTKR1LbLABtPW97B+S0msJ1GFoeU0P5ilOT+FkoCMEYlq/JBq90eej/E
	 Esks1KMRsbNawT6D87pKXcglqQ0KPAouZpu25XDr4H+7qS41BBgvyATOR4izQ7RiRBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=KWWKk5Jw;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93CF606A31C;
	Wed, 18 Nov 2026 06:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=KWWKk5Jw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wFs4xm5MsSM3Xsm4E93a7wjpoFaC4rO3h+3o7wL6/o4=; b=KWWKk5JwP6affb5T6EFgtOQxG/
	m4ZL5UR3bU+oC2AtgxSNHUSa5G/3qOAR+Jg4h87erpAVN02KYAJPx3Antkq6NLogj8uAm0cLQa/hU
	OJ/GhErEI20phF7ZxwAov++WkxEtZM+ZenG99/4wYcEo/CSTUdlCsVZv8C6hqG3IeZ0m1vS+ACfxf
	pg77+cIZiB4LoOF0F+fTsXPgb5f7rtJ7NWC7qEYBK6/UFkXDwLtDBHN48jlbCzlm23BXqi0s3qpNR
	/gK40c76kW9c7YPkWQ1X/BeZlpcNTI1O2RuCpQuWMyoQZ9tavQ5xLY8E/GVxRM5izl8v9PUklA0HP
	GBjBJSSw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTZbm-0017st-2h;
	Wed, 18 Nov 2026 06:57:31 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Wed, 18 Nov 2026 14:57:20 +0800
Message-ID: <20261118065725.673090-1-emfox@debian.org>
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

The THC ports on Tiger Lake, Lakefield, Alder Lake and Raptor Lake run in
IPTS mode: plain SPI with a private framing instead of HIDSPI, which is
all intel-thc-hid handles today. This adds a backend for them next to
intel-quickspi and intel-quicki2c, on top of the same core.

It is based on v7.4-rc3 with two core fix series applied, both still
under review:

  https://lore.kernel.org/r/20261118053132.253448-1-emfox@debian.org
  https://lore.kernel.org/r/20261117105420.318995-1-emfox@debian.org

One gives the DMA engines a lifetime, the other keeps a PRD table from
overrunning after a reset, and the recovery path here relies on both.
They overlap in intel-thc-dma.c: apply the first, then the second.

Register, DMA and interrupt work goes through the exported intel-thc API,
except in four places where the core has no call for it: the reset,
port-supported and quiesce-state bits of THC_M_PRT_CONTROL are accessed
directly. Nothing outside the new directory changes except Kconfig and
Makefile.

The hardware facts - port IDs, configuration block layout, frame codes and
header sizes - come from the ithc driver linux-surface ships, at
https://github.com/quo/ithc-linux 6d53c9c (dual licensed GPL-2.0 /
BSD-2-Clause); no code is taken from it. The layout, the frame format and
the ordering between quiesce, interrupt configuration and the DMA engines
are the parts most likely to need scrutiny; each is argued in the commit
message that relies on it. All of it was confirmed on a Surface Pro 8 with
a 045e:0c37 controller.

The first four patches each leave a state that builds and loads: port
bring-up, DMA and interrupts, HID registration, system sleep. The fifth
documents the frame format and the IPTS handshake.

Link to v7: https://lore.kernel.org/r/20261118054004.363766-1-emfox@debian.org

Changes in v8:

  - A request from the threaded handler is refused by comparing the caller
    with that thread, not through a device-wide flag.

  - The reset count a feature answer is checked against is sampled after
    the request is written.

  - The line is masked again after synchronize_irq() in the recovery path,
    and the thread no longer reopens it during a teardown.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: add the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           | 109 +-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 982 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 201 ++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 193 ++++
 6 files changed, 1502 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
