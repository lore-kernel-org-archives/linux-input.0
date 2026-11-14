Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681574;
	b=4aHivfd9rH+eJERy0hJ8/Zd+BmwzNLv1Xtv4KEBxW0yvBsLErR2QuXbrwhDvDLNHc6G9
	 LiaSbQ1uPEiPWkVAe0GDPWzYrla9QWIOzAG1Bo3cYIP7QLioyMCJYON+sKObMxNdXzayZ
	 twIi4ckbCy+DV2GXSFGC2V2et44QwhZB2JoZKCBexWEtNvT74sGweNsz2nXJw94Tf/fgk
	 ERhGGTGQPD55v+MKvOVSY9Ml9RersPopKgUAZpQHzp9cilGHtn0+jMAL2VVHmTvob37w3
	 Y3Tyzi9zhl7PHZ0253d1WIgslkP1LdHd6p1bcA2S6NViodoCuyINMDztLyuVr90585Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681574;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=0a7lhnldFz0T0GEwHuWehG3KpmUCgohOG9LPG15ZKyw=;
	b=1bG/aAp0DPe9pXZyYbOZ0oaPvj84Gh2P/vJlvKGkMqqLuFA8vFNeHa/djgybcfgmiyba
	 oAyzfdamYfj31BznBqsNtREcXOcpE25niWUYmq36duzSY7Wdl/E8nyRmn6zxq5CJVx0Hf
	 1UPBs17D3E+N48EgNZ95NAZ7jSkcjhBoqwTDkdgjOoLopl0bFadTmrSR1OTVUSAHh7ds8
	 LrfDNi2QTmzQJIEqms6BUPCpVmumwqah0fc90PC77W5EMYbPSDrxodpQ10DwuZH+8Y4iG
	 q7KC+JZoPsKDPxfZvtfVMqNMY7fXmLluExwI7Wr/dqlykNzExAkxjv02fu+9RE7JSbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=a2Trb5N5;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED6606A327;
	Sat, 14 Nov 2026 18:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DED6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=a2Trb5N5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0a7lhnldFz0T0GEwHuWehG3KpmUCgohOG9LPG15ZKyw=; b=a2Trb5N5I/QTtOd8+pyYiatNsG
	JrKV1w4JMFNnpDhvP75GcUeEoqyuf8aw8CL12CYkfcb5atdTjulX9ynMBSORYPhTNfNknjJ0ZTFX3
	ifcgW9CF1ibUMkwYJIVJqrUcviB+Q7CHECIrkAjwVFkqY/2QPAipPwImQyLfCzwtyhRr2R1TnXFep
	UjbcpWN3ZlhIODviLCjgRojeRgXm88s8vFz0bz+8LwBlsVpH9hcrQ57mPaK9QzwGbGFjZJqJPL8z7
	05dK5YPhcUkARe4TZ7wKa5hnGpo/6zc0IKBNoJNI+AX3wjaDFCvyVh9jf+mVaoCgSjxFtLXTnMSHj
	8U5sGkVQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSIet-00FkA3-1F;
	Sat, 14 Nov 2026 18:39:28 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Sun, 15 Nov 2026 02:36:19 +0800
Message-ID: <20261114183624.2379573-1-emfox@debian.org>
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
is the fallback where no pin is routed.

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

Link to v2:
https://lore.kernel.org/r/20261114170740.2068179-1-emfox@debian.org

Link to v1:
https://lore.kernel.org/r/20261114154611.1683519-1-emfox@debian.org


Changes in v3, from the automated review of v2:

  - The running flag is set where the touch engine is enabled, in the
    patch that enables it. Patch 1 read the flag on teardown but only
    patch 2 assigned it, so a bisect landed on a kernel that reset the
    controller with the touch engine still powered.

  - A recovery in flight is device state now, not a local variable in
    the threaded handler. An interrupt from another function on the
    shared line woke a second handler that read frames while the work
    item was rewriting the ring, and unmasked the port mid-reset.

  - The shared line is requested with IRQF_COND_ONESHOT instead of
    IRQF_ONESHOT. A shared line only accepts handlers that agree on
    oneshot, and the other functions on this pin do not use it, so the
    request failed with -EBUSY as soon as one of them had probed first.

  - An interrupt with no cause of ours is reported as not handled: from
    the thread when the status is empty, and from the hardirq while the
    port is stopping or has no DMA. Both only after the port has been
    masked, so the spurious detector cannot see a storm from here.

  - The drain loop stopped one pass short: thc_interrupt_handler()
    returns early on four causes and the data path is a fifth call, and a
    cause that arrives while frames are read adds one more. The bound is
    now a pass per cause plus the one that reports none.

  - The feature reply is taken under a lock shared with the sender. A
    request that timed out is dropped, and the sender may already be
    asking for another report: checking the flags and copying the answer
    has to be one step, or the new request completes with the old one.

  - Teardown takes req_lock before masking the line and resetting the
    controller. A request already inside thc_dma_write still needs the
    interrupt that completes it, and with the line masked first it waited
    out its timeout holding the bus lock.

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


Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: register the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           |  95 ++-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 776 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 196 +++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 203 +++++
 6 files changed, 1287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
