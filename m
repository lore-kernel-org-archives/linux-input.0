Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794980417;
	b=uY61DzfB2zHY/jXyhSCyF8tL+jKACms0vRNaj/+L5Nssyb1ZTAk9d7ZJcmpXc43fCJgF
	 T+HbCC4UJ3s1gXETI2Xiv9F3t9g3lnehwhMeffBTLN2uWHhbWyvlwPhBAwJ36/qvbi4mT
	 aMr48FCScFv6GIEQkvSyazOSnwOGze/UAGNfWuboQEa9gRY1WhUhp4kVasI1aUhB2cfCx
	 HhU83x9HESmeKvMBHMyPXbFj6PRAZvBdveGEwt2l64dtF6Pe9GUdsYplIM60B+jJJSWwf
	 h/kPuNUKGO++bA58d5qMOl+jvqvXrzAI7Zba10jmppJZ4bQ1uxJbMqWBKCFEjYw7SDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794980417;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=GqV/HuIUXYu3NJal3ATCEuPQ0viX5TerGyzwkL7k/e0=;
	b=cy+AzKOJiVv7DLzfrDkQdrvoiIgDCO7x/1swVh9n04WgPB3RrI2gy8kZTxhrgtjTyOCa
	 +98esnJJS69yrFKdsZ4DgQ+uDKk2ThfdvqP4/IVLWmo+4/Sy9cbt2abNj1q9P2MAV+UFF
	 ZGOKymmX4TAtmtkXHsuFeMlcHkE5UcOJUrI+ANMqUWgh8jEB01SsgMXPyUJfohjoIEdKk
	 TWl+xXbBb2yDWVLcvvEB1nh5mc3WPqdnFkyMnl9Q6D/Ii4D83PAAT3FwZJF2BxPQQQckR
	 pOonW3vEjxFfWdtAXgpMrxWYr02l/UdXkR1/lDt2Zsc0TsvA+5WgHw1l+/ahIYfOctw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kfFEGjCr;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91639606A31C;
	Wed, 18 Nov 2026 05:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91639606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=kfFEGjCr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GqV/HuIUXYu3NJal3ATCEuPQ0viX5TerGyzwkL7k/e0=; b=kfFEGjCrO+Zc+GHniNt/fhEXA2
	1VoGoNwaqgae2D0LdvowfO2TCuvHRVgFooHPebPi3qDIrTx0IQvwiI41s5kBQMT9Sxd0Pl3s1UF4t
	eUCLJH+7HT7rVhIHQhEpObURh76aMaMHl0uDA2U7zg7PtSfAdnopuK9GIYiGtBDAig1udQ/CGvtWG
	Zc/+LNJhVd1kx9aDgzOVegJZ64B2q9LHM1G3BP07akH9OmL+RiAQfg49m7nvDYW0buuUw08pwdhLH
	hOBEKStgtUpT9YnhxuPhEsvSJorWO+fJZMbi4suKYnyol7Jp6dzTBj2uPNiPx0ndV15vB6ZW54e1u
	NaFs0IrA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYOv-0015JH-1S;
	Wed, 18 Nov 2026 05:40:10 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Wed, 18 Nov 2026 13:39:59 +0800
Message-ID: <20261118054004.363766-1-emfox@debian.org>
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

Link to v6: https://lore.kernel.org/r/20261117073554.11557-1-emfox@debian.org

Changes in v7:

  - A reset no longer races the threaded handler: the port is masked,
    synchronize_irq() waits for a run already inside, and only then is the
    engine reset. A run that acknowledged the end of a frame the reset had
    just re-armed the engine for would lose the interrupt announcing it
    again. The two flags are cleared in an order that cannot turn away a
    run which found the reset finished.

  - A request that cannot complete is refused instead of sent: one issued
    from inside the threaded handler, which is the thread that has to
    deliver its completion, and one issued while a reset is queued or
    running, where the write would wait out its timeout holding the bus
    lock the reset needs. The descriptor path retries both a reset's
    refusal and a write that lost its completion to one, since a
    descriptor request carries nothing a late answer could spoil.

  - The waits happen outside the lock, which now covers only the write.
    The handler calls into the HID core on its way to a report, so a
    request issued there would wait for a lock its own thread holds. A
    queued reset leaves the line open for the same reason, and reports an
    overrun once instead of once per frame.

  - The feature gate is released by the caller that takes the answer, not
    by the frame that brings it, and the check and the copy happen under
    one lock hold. Only a timeout shuts the channel: an answer dropped by
    a reset was never left out there.

  - The port is masked before the interrupt handler is registered, so an
    enable left by firmware cannot make the shared level line assert with
    nothing to acknowledge it. Teardown keeps the line open until the
    write already inside thc_dma_write() gets its completion, and waits
    for the handler once more after the buffers are gone.

  - Smaller ones: a descriptor larger than HID_MAX_DESCRIPTOR_SIZE is
    rejected before it reaches hid_parse_report(); the SPI timing comment
    says fastest, not slowest; the DEVRST comment says which way the bit
    goes; the two comments that disagreed about masking are one.

  - The documentation names the two steps that precede the first
    configuration read, gives the bit positions it had only described in
    words, points at ipts.h for the offsets it restates, and says what
    system sleep does to the hidraw node.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: add the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           | 109 +-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 975 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 200 ++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 193 ++++
 6 files changed, 1494 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
