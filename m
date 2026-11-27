Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794714;
	b=TiAc0X6s6LCasImN0ZK6K2ayJJHHd3YIMq8Ji38B/yUCw7SJItdf0ExX4y4YK2Z2JB/9
	 NPbauFgR0t81LnANXnb4gTNl+TVBNHxUiabMqKQr1Iz9bQwX1hQxoR8Lo9KZoGcG80Xd0
	 BSMvk8QXRQfL7lY2ZdVDFjLeA5ZR+aW44QfhrN2tWdPTwNvCvxNOhRF2Q/hZwPkD66Hk2
	 yGL5kNGqFGmaeaVIoiJf2AmY8NejXCjMslu/lDFNCiCYUdXS2bcXVdSMtS8ap+9EEvVOg
	 0f7vKxEgIDY+uJMz7YnrvdregikZHxAZHe4+IEUmW4kT5+I1xfWzjfO/BjHIevrcRtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794714;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=JK5qLI9MkXIWdTPiVSAoFW7LJLMeNx6yLtg6Ek0KznU=;
	b=PM8+clXsME1oD+rD5c77tZTQGraRRFlyzQaplgSW90XNWyvN2F10fpfPqBhfisqadQRS
	 AaNI0eRZtvWrYuyJ7PtUwf9fLZLH3ugS/QtpTDApwA+MCxw8CA94knolCiDCJHCe0wlQy
	 vPFl1G7TFtIj9Ta1Xo1B84KtmkPxxYSMlsxix4Hj4xQkKcBRo/iGZ3TzKezGZnvlg+p1r
	 fSADe7/wQ6AnEzVc6lARqc8oZUqNB6IvDeLYf+fcG8BPkIJPnGI6AAysEmahhEsNrnp2J
	 chRflvSC2GLaCzp5tBshu4izWezfgv+e0i8O4NNnAXH+4e0xo2rVzIjO2HH5AjU3OjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=USWCtIMC;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55072606A31C;
	Fri, 27 Nov 2026 15:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55072606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=USWCtIMC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JK5qLI9MkXIWdTPiVSAoFW7LJLMeNx6yLtg6Ek0KznU=; b=USWCtIMCyfU8uBLztRm4XGkM7x
	X79F6AwODK9ORtaUn4cuvIXgTEBOxYpfLrNMqiPON3wGuygDCYvsnkhOPauXZiEMeoNGh6XfUh9WN
	7rbWSn9VPOtwAO8s38WWrZ4yYAbovZik/2D+tftZ0Eo4Usczn1GbO7uz1/IvCOZnDnSdwLMBqfO2K
	CZI9V1ZwO8akfuhijiBDsTHkAZTMGoiDpIEgn/y2JXUBwr59gGo+sXTmKElo8XE3G+sXfRjt0nX2A
	bte/mHgvu1iOBp12kcRsDz4mGdROoa6bfPUKU2SH1iNKHDmqakf8w7EcpFs6iw5ANyQs1dLQgefWl
	ldkff50Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWyEj-008Rr7-2q;
	Fri, 27 Nov 2026 15:51:46 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/6] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Fri, 27 Nov 2026 23:51:34 +0800
Message-ID: <cover.1795794049.git.emfox@debian.org>
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

The THC ports on Tiger Lake, Lakefield, Alder Lake and Raptor Lake can
run in IPTS mode: plain SPI with a private framing instead of HIDSPI,
which is all intel-thc-hid handles today. This adds a backend for them
next to intel-quickspi and intel-quicki2c, on top of the same core.

 1/6 expose the operations an IPTS port needs (core)
 2/6 bring up the port
 3/6 receive reports
 4/6 add the HID device
 5/6 handle system sleep
 6/6 document the IPTS mode

The first patch is new in v10 and answers the layering review: the
backend no longer writes THC_M_PRT_CONTROL itself and no longer keeps a
copy of the SPI base clock. The core exports thc_port_supported(),
thc_port_reset_release(), thc_port_reset_hold() and
thc_spi_hz_from_div(), and thc_interrupt_quiesce() stops warning when the
port is already in the state that was asked for.

Changes in v10:
 - One core patch plus five driver patches; no direct register access and
   no private SPI base clock left in intel-ipts/.
 - A state machine (DOWN, RESET, CONFIG, DMA, UP) replaces the running
   and dma_ready flags, so teardown knows how far to unwind.
 - The hardirq stays out of the status registers while a reset owns them,
   and the threaded handler neither acknowledges nor claims the line in
   that window.
 - resume_noirq/restore_noirq mask the port as soon as configuration
   space is back, as asked in the review of 4/5.
 - IRQF_SHARED|IRQF_COND_ONESHOT is used only for the legacy pin; the
   MSI fallback is not a shared interrupt.
 - Headers are grouped and sorted, and the series is clean under
   checkpatch --strict.

This is based on the two intel-thc fix series below, applied in this order:

  [PATCH v3 0/5] HID: intel-thc-hid: intel-thc: DMA lifetime fixes
  https://lore.kernel.org/linux-input/cover.1795791500.git.emfox@debian.org/

  [PATCH v8] HID: intel-thc-hid: intel-thc: restore PRD table capacity
  https://lore.kernel.org/linux-input/20261127234500.424242-1-emfox@debian.org/

The first gives the DMA engines a lifetime, the second keeps a PRD table
from overrunning after a reset; the recovery path here relies on both,
and they overlap in intel-thc-dma.c, so apply them in that order.

The base-commit below is the tree those two series are based on. The six
patches here apply on top of them, not to the base alone: 1/6 extends the
core file the first series rewrites.

The hardware facts this driver relies on - port IDs, the configuration
block layout, frame codes and header sizes - were confirmed on a Surface
Pro 8 with a 045e:0c37 controller.

Emfox Zhou (6):
  HID: intel-thc-hid: intel-thc: expose the operations an IPTS port
    needs
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: add the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           | 109 +-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 976 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 220 ++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 233 +++++
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 107 +-
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   |   4 +
 8 files changed, 1658 insertions(+), 9 deletions(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: 4f048c56c2697000105a75c28b918ae76f11fcef
prerequisite-patch-id: 1921888f4500ace81255e73142f40b89e4a75fd2
prerequisite-patch-id: e87bd84cb62f9d122e80b0636ec02103ee4eef96
prerequisite-patch-id: 682e6eeea6eb7792c7b2f00b14226cb9a3d1c56c
prerequisite-patch-id: efd51e0ca2778c5028ba030ddfaee6da5a82622d
prerequisite-patch-id: 1fa0e32622986734adb7ce7040400f169bc26f2b
prerequisite-patch-id: 06a128cb2c3db1f80116b314d11d69cda0d4dce0
