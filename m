Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079543;
	b=SKVzUPTITvFQe73zacTBftW1iUQWw5gRgZ+qVsohDI5in+s8amANWOfRsT/6b37954PE
	 Rp0rnT8XPaaSs6BaJKg7TmOGMECUmkEUHbWLamuzuaM6c6Tfg+CpxWjRU5JeZsFQwAz8/
	 4EuRhII3P0HkVzIKqFaRWhXOVH4NCEWh2wh8SUsaQBfK5O5SiCDl1HpqTwl3w53NWh3D1
	 +9fZC08VCi3eVx1zbmfAdPK4VGxbiab7lUUC5DjWFHkOXRPrNQYPThFzDCMekkpTaENC8
	 Ljbn3ck/7+jLdhPXeF7z9T1qggLRa2kiukDp5bhUHWYx0LnvB13aVVSCH71iAacY5Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079543;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=LwfzcdPLgAYPklabzhnDVLveLnpJV9V0WhimYlGNkEQ=;
	b=EPQGE5tCxOHY0Y+6wKvqEChj57WYI5Ss0dJkulROE7z/K/xVahbw43CRZiNCL75IyYDF
	 Q3xmru+p+1Ej2VoZlm+8AycjMGNtw5XQ73zI/Bh8Bm2Mj54FxaylcHEHBfG8qUC3LKlc7
	 WAan5zk93R/beiBHoFaRTTUiVQB8CtOMSWdCJZrb/FU3XkkRFXCYvZ9EN5Tfm2t3W3EJI
	 FhQmabdBS991DIgq2T1XipVQVNixe6Npfx7S5U5+BKXP17IKVLtJINxbVAu3bxKqIUS6/
	 RjJ7hEqxPwbTNhHBtBChWYye/1qhdPG06dK5BJpykWAEII1wF6ZCmQT8taZim5RRKZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=W0naXsSU;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE34606A338;
	Thu, 19 Nov 2026 09:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCE34606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=W0naXsSU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LwfzcdPLgAYPklabzhnDVLveLnpJV9V0WhimYlGNkEQ=; b=W0naXsSUhCWnPHO6UM98i+T9Zq
	N9E/noeEkF+UjHHS4J/YwVLQh2P+al2O36O4HAf1vFwdfzAAjIwY5lL06moikK+MEfWP29BvDDHlN
	64+snywuQ9R9xyxGrLA8SPdWmLv2CdEvz/zy7sHkHfz1C6vQg34HpkpJR+wCoUZzwLMuBaeqlOy7E
	Wg1YFNsC2JSGXjIof/3u3H1XoHTmzhDi/+MXpA3edMFj604WukfABSIjVp8QE+JfO6DWEegYmflEX
	lv6CB6CBJy5otk5hpkLCz9n6xu6uJMsTUZyd0CO9RkHYbjMo+NzB239lccqJaE4xk7qLwgIVmvqjb
	n7PciJCA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTyBc-001yxW-15;
	Thu, 19 Nov 2026 09:12:08 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Thu, 19 Nov 2026 17:11:47 +0800
Message-ID: <20261119091152.470384-1-emfox@debian.org>
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

Link to v8: https://lore.kernel.org/r/20261118065725.673090-1-emfox@debian.org

Changes in v9:

  - The reset count a feature answer is compared with is sampled inside
    the send, under the lock a reset must take, so only one that started
    after the frame went out can change it.

  - The interrupt is masked before a resume brings the port back, as probe
    already does.

  - A failed reset no longer wakes the queue, which no waiter could act
    on: the port stays masked until it is started again.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: add the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           | 109 +-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 989 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 201 ++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 201 ++++
 6 files changed, 1517 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
