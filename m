Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794900973;
	b=fdLwN+7ZP9RLuNW1Ashq7PFNaooQB7WFsTKaYJOJm9Mc5QrsY/Ol/NMpgOLyoG3/rbgS
	 IsEpaMpoxNitTAE7jpUs7CKRT6ZJEXKRMlqD1cjha2IB5He1lSrzmH3vLWde1fpveOQbJ
	 UlAkZlil6zR4100BwL7Qtf9ZcvzdfalTtvGrTGHOlryEJMOCtouekRL/JG2MiNDcFh0x2
	 3YtaOlHCAhb6QukWIo5Lmy++ANDK/rVeIEk9fWMUvBuEBxrc5/hcbnh+0bpiCe7q/Xmoo
	 Jm3xRYFbkJjJMzhqdu5ZhhiJFdN0limmGEXpAm+86QU7dDcVSqVmM2Kko0iny+F2+oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794900973;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=C55dCPqy8a12i6CJiauywXuAhnDN7yrt43I64w3Ujfg=;
	b=RTIUjaXtYA2dXIU+gyl6G8Dxuh4WXuMesN2o8orSfNZHoY+zU7irNCrv2ZQKIbZztTK3
	 6Yi+oMVuQntRisUSOKl7AFsXHSWs1vjjTpN8ZDGhteGGxZ6Lqcj7AUNNq/Qe9QrZt1DTl
	 kLD1Z7XapKGz9DxJ+u6/qjVGLVf9YUKIplRGfBLoYC5JdYg2ZIS+rkVvJ31nN7mg/FD9F
	 Ipdj/4mdBiVyl3fmzq8zB81hyUGtNiJM9ioeZg5rzPBf1nWLVg+0T7iRqAcwmm/j0Fyan
	 /UXbPba4IJ3ypHzh4IdJNEm9uZhpkGy4eYmxMRXC8bkj0rlShUttgL/euuexwM8in0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UHJuSfoZ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39D606A323;
	Tue, 17 Nov 2026 07:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC39D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UHJuSfoZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=C55dCPqy8a12i6CJiauywXuAhnDN7yrt43I64w3Ujfg=; b=UHJuSfoZSpWyxpwHitwBNH2BPR
	vppgLgnw/h+b2L3pBNEkpY1ydgqWKfYlGVaq1pjwC+8Ee5hcR1Lr06xK6RFHt5gQLDEUkGYWPGa+K
	kOIGKzKegwG/78Latb984fvJX490xw4HwQrasDH2eAK872B62N8oiDgc6Uc8L1HnD5GMn5W/IfaM/
	+jnxTjdu/ku+1YBy4ynSuShDBLf5hsEYg2SxXjFA+FPthQQT/1u0jThVpfy38IFNMntgJltfs+TaT
	mWHV+QwOELfDNORUAh0KMauhQaoxhCdKEgoOs+uJRS61JfTjTeQ+QkuFVx6czpNiCq+wnGK7EiBQQ
	clrpwL1A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTDjZ-000NOS-1C;
	Tue, 17 Nov 2026 07:36:06 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Tue, 17 Nov 2026 15:35:49 +0800
Message-ID: <20261117073554.11557-1-emfox@debian.org>
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
intel-quickspi and intel-quicki2c, on top of the same core, and is based
on v7.4-rc3.

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

Link to v5: https://lore.kernel.org/r/20261114234242.177387-1-emfox@debian.org

Changes in v6:

  - The buffers are resized on every start instead of being allocated
    once. The controller re-reports its frame limits on each start, and a
    resume that reports more than the probe did would otherwise leave the
    engines writing past the end of the buffer.

  - The feature handshake is fail-stop. The request is sent once, and a
    timeout shuts the channel until the port restarts. Resets are
    counted, so a timeout caused by one can be told apart from a
    controller that never answered, though both shut the channel: the
    answer may still turn up. A send that fails is reported as such and
    shuts nothing, as the frame never reached the wire.

  - The frame size the controller reports is bounded by the receive ring,
    one page per PRD entry. A larger one used to end in sgl_alloc() with
    an allocation error; it is now refused with an explicit message.

  - A reset is published before the line is masked, and the thread masks
    again on entry: a sharer on the pin can queue a second run of the
    thread with no hardirq of ours in between. A port that is resetting
    or going away still gets the threaded handler, because the status it
    drains is where a transmit completion is delivered; only the ring is
    left unread.

  - The release from reset is a forced write, like the assert, and a send
    that finds no engine reports -ENODEV instead of -EAGAIN, so a
    descriptor request does not spend its tries on a reset that is not
    there. The descriptor flag is published with a release store.

  - Teardown refuses new requests and then waits for one that is already
    inside thc_dma_write(), but no longer holds the request lock across
    synchronize_irq(): the threaded handler can issue a request of its
    own from a HID callback, and the two would wait for each other. The
    DMA buffers are released even when the engine did not acknowledge the
    quiesce: they are not devm-managed, and thc_dma_unconfigure() clears
    the start bits on its way out.

  - The receive engines are stopped before the controller is released
    from reset. Firmware can leave them armed with a PRD base of its own,
    and the frames would then land in stale pages.

  - System sleep always tears the port down and rebuilds it. The variant
    that parked the engines for a port armed as a wakeup source is gone:
    nothing in this driver arms one, so it was only reachable through
    sysfs, where it was worse than a rebuild.

  - Rebased on v7.4-rc3. The PRD table gap a reset leaves behind is
    described as the core's responsibility, not worked around here.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: register the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           |  95 +-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 854 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 196 ++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 194 ++++
 6 files changed, 1356 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
