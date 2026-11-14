Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676083;
	b=H85nNVowp+4QGaEnJXE7ed0d4gfBZmX3TNZfUeJisZHhHed2+W+qfZi87w+1ssERy+jl
	 9vEUKPvr91HAE+13tx2mLTrFzr3Kr7zTlM/cgEVX2Z2BNM5dmHLcy5ybyxFLIVd4uVxi3
	 9b/I0iOoYDiPjR+Wci2wMVMJvU6aIj2cVUmOXL+pjn3dhOrMM6RrMVnxZgpr/5g/lxuQF
	 TameAOt+g70dw+2o0RQlSzfv79QjbdY/o8yJMbHWPlAp2uWdoutI/dt+xP7KHNh0WAsVc
	 nFgQHdVRuv/H7GfaNIkJWQKTiP1NvNrxRzjZk2Tr1kzB9G5UsxBwZXRkny4S145y31g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676083;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=M8UQAAYwxMPO/N35yFrmI3Jk91luWX5cEKDle2vhHtI=;
	b=mMog2EtixDBlfKLXJt9IC+BiwBpBey7do1MyiAsiMoD830ZBsoCjjY/ns5sKfgmsHNI9
	 Hy5v9x5r86LBI2d42HTepCE8CPZzWSX04Hn2CTH0qkA5CUqySitVGDaEvL4iq+nI2KxxF
	 KecWrlsJMavXs9Y9MFY013QFr5/38rHUdg7LRf32DFurXyBKN86OoeLkcHFzkUKbMUAzQ
	 9/HtZsUT6AHl1Cs8/ADqtLtARGSiL0LONdIfwluDK2BuxgSMEGRdBJVUKdH9Sta8EWdKr
	 e+iTZrhoBYeTAbPwPeq1NakWaIflMBg4FQjY6bHL2rtb77hUet+xBgdYdWGNsWvhgZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=AAV+duFV;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33D606A330;
	Sat, 14 Nov 2026 17:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD33D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=AAV+duFV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=M8UQAAYwxMPO/N35yFrmI3Jk91luWX5cEKDle2vhHtI=; b=AAV+duFVyzC7eApCpNvheUmw6y
	FK7IoNUgu+5zTKhc3K40MyQFQ2Ews9Y6D5vU7DOi2F6n8z1ZPNdF4ymUcDXRYk2r8YczFuJdoZLxg
	SQPgmDy68qeXbzjTJBhNek1jNhudyBLt/m2ziOBO4kif1v7pB63efoAyFfwwH4NdRLCRWiUsV4LPi
	IClPk2kAQ9IO3EdBswWlok9vnRZvTYldOooz+wY4i975i5xaKnO4tqeerQ4+GJQnP6jh5QmXU1d29
	XnrIO4Y+0o86dUF7AMtHo6BMgDnzvYoA4bUESKhFjIfQ5vFhN+O0W/UvX1d5CuGkWBiz438GvwfkU
	07+mWuxg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSHEK-00FgWX-0g;
	Sat, 14 Nov 2026 17:07:56 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Sun, 15 Nov 2026 01:07:35 +0800
Message-ID: <20261114170740.2068179-1-emfox@debian.org>
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
on v7.4-rc2, the first tag with the hid_safe_input_report() it uses.

Register, DMA and interrupt work goes through the exported intel-thc API,
except in four places where the core has no call for it: the reset,
port-supported and quiesce-state bits of THC_M_PRT_CONTROL are accessed
directly. Nothing outside the new directory changes except Kconfig and
Makefile.

The hardware facts - port IDs, configuration block layout, frame codes
and header sizes - come from the ithc driver linux-surface ships, at
https://github.com/quo/ithc-linux 6d53c9c (dual licensed GPL-2.0 /
BSD-2-Clause); no code is taken from it. The layout, the frame format and
the ordering between quiesce, interrupt configuration and the DMA engines
are the parts most likely to need scrutiny; each is argued in the commit
message that relies on it. All of it was confirmed on a Surface Pro 8 with
a 045e:0c37 controller.

The first four patches each leave a state that builds and loads: port
bring-up, DMA and interrupts, HID registration, system sleep. The fifth
documents the controller behaviour the driver relies on, none of which is
written down anywhere else.

On that machine the touchscreen and the pen work through hidraw and iptsd
after patch 3, and three suspend/resume cycles (pm_test=devices) bring
them back after patch 4, with the daemon restarting on its own.

The interrupt is the legacy pin: these ports put requester ID 01:05.0 in
their MSI messages, which is neither their own function nor expressible
as a DMA alias, so with interrupt remapping on the MSI is rejected and the
port stays silent. The pin is shared on the PCH, hence IRQF_SHARED; MSI
stays as a fallback where no pin is routed.

Ports are matched by PCI ID. These four generations are not in the HIDSPI
ID table, so nothing else claims them, and a port that firmware drives as
HIDSPI has no driver today: this driver gives up with -EIO when the $TIC
tag never appears.

Report handling stops at HID core on purpose: the controller is the one
declaring itself a HID device, so the descriptor comes from it, Windows
exposes the same port the same way, and turning the heatmap into contacts
is user space work that already exists.

Some concerns:

  - Runtime PM is not implemented, and only the Tiger Lake ports were
    tested; Lakefield, Alder Lake and Raptor Lake share the code path but
    have not been run. LTR configuration comes with runtime PM.

  - The SPI clock is one of ten gears the core can program, 7.8 to
    50 MHz, and the core rounds the request down. A controller that asks
    for less than the slowest gear is raised to 7.8 MHz, warned about
    once and carried on with.

  - System sleep takes the HID device down and brings it back, so the
    daemon restarts and asks for the report stream again: the controller
    does not keep that state, and replaying one set feature would not
    cover the several the daemon sends. It also means the touchscreen
    cannot wake the machine.


Link to v1:
https://lore.kernel.org/r/20261114154611.1683519-1-emfox@debian.org

Changes in v2, from the automated review of v1:

  - The recovery work item is initialised where it is introduced.
    Patch 2 used it and only patch 3 initialised it, which breaks the
    bisect.

  - A frame read that finds the ring empty no longer passes an
    uninitialised length to the frame decoder.

  - The port stays masked while the recovery item resets the engine,
    and the handler keeps draining the status registers after an error,
    so a queued transmit completion is acknowledged instead of timing
    out under the bus lock.

  - Teardown stops and quiesces the controller before the DMA memory is
    released, and takes req_lock around the release: a send already
    inside thc_dma_write finishes, later ones fail on ->stopping.

  - SET_REPORT returns the byte count, as hidraw expects; zero was
    returned before.

  - A late or empty report descriptor no longer overwrites the buffer
    being parsed, and an empty one is retried instead of registered.

  - Feature reports: empty answers are rejected, and the report ID in
    an answer is checked against the request. Verified on hardware,
    where GET_FEATURE for reports 5, 6, 9 and 17 echoes its own ID.

  - Unchanged: the shared interrupt is still claimed unconditionally.
    The cause can only be read from the threaded handler, and returning
    IRQ_NONE while this port is masked would let the spurious detector
    disable a line that other functions share.


Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: register the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           |  95 ++-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 740 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 191 +++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 198 +++++
 6 files changed, 1241 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
