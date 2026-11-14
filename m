Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794692448;
	b=4QSYSKHrZGaFA4hrFZ9y+jxItou7YEOGb2A7+nmpiHJ2zhVCxEduR5Iv1DJXGlCO5tCJ
	 YXATt2QMKO6EEEz1DsedQrGx7fwF6G9NJsd3vFFJUPDIob/m+d0dUB8iokgDaQz2TkUhT
	 th4E34nGf1pRSFA1WIr9IW71aUvNR6FpAeoK4brmhAtC4vL0vUyqvfEk9E2Lc+hBGc3oV
	 18V0rOKQ0+ph3F3HppIGKSrIOEDoLwOZeAFGFeCwMfciDtZgYIczHZp7cVanXBP6NIhKL
	 jg2mjHQs7AXAM8VhJeELO6xvDsrg+wtiH6M88P6YsgRnXJK0F2sL3xccJSDWvYx9GZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794692448;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=WzOEHQp6pXSmkbM4wrFRTn7eeYi3KB1etiYHl+Zg8e0=;
	b=cW4yP2+dmnZZieQy9+ppxlohZ01FjLeL+zpZ8Oyw2Vs0mDfzPyQTrFJbUk/Tk12bU6HG
	 d+7oDWrQd4l/OkFsMQEBH1crX5qqi8sWbwieRHG89GTcoPl0O6pKrhVGzIuj79CY8Ze91
	 Tu6bl2qdvjJ32UFTn9fe81nlxsOmf2DFShUYvP/r3yn3gWgMMl3oa3Sf+It9sDroGRQX8
	 LPdMsBDKPygf4GBDQ8aWIti8PPUIP7L3p5I1/8EjMfSvpmGZM5dBzM9d+VU4osyLc/L93
	 2SEmW+mjKqqPcSFelN7YA63bOgT/YcaZWaBrFWIxSJpeniqqzNqVbrduC3auAtbWafw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=mKIvYnLk;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A50606A323;
	Sat, 14 Nov 2026 21:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A50606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=mKIvYnLk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=WzOEHQp6pXSmkbM4wrFRTn7eeYi3KB1etiYHl+Zg8e0=; b=mKIvYnLkht4ew7n3TUu8m5jZSO
	arMObxQ9yP4O5Q018olMjCpplRe27IqOo+2bksxghqL6czSDBO4yxEceJpP9ePbJfU0BMVOpuEx32
	91k4d078J4DS4H/GiuOPUKTJfzIQN+fA4D52qjEd9eWeuWDrwNLko6isQLkxxzRhk8OoGa4XysAky
	RhboVTKaJeLqb3UVvaGHFEa91KfR1mqnOtrSYB80q5BLyrIXl1dP9D56zGCkYmxXkIkzkxfVgkENk
	ydajS6utHbC+byPJxta4YAGBITfaEC3PzsLZ/B1qUznpn1F2eNTpRo1FppXMuFIT3BiJLbzXjdUdB
	7Ew/Pn9Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSLUI-00Fq9l-02;
	Sat, 14 Nov 2026 21:40:42 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Sun, 15 Nov 2026 05:40:21 +0800
Message-ID: <20261114214026.2809740-1-emfox@debian.org>
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

Link to v3:
https://lore.kernel.org/r/20261114183624.2379573-1-emfox@debian.org

Changes in v4:

  - Divisor 3 asked for 41666666 Hz, 34 Hz below the 41 MHz gear the core
    compares against, so the controller was clocked from the 35 MHz gear
    instead; divisor 12 asked for 10416666 Hz, 42 Hz below the 10 MHz gear,
    and fell two gears to 7 MHz. The division is now rounded the way the
    core's table is.

  - A request that started during a recovery waited out its one second
    timeout on a masked port, holding the bus lock the reset needs. Such a
    request is refused now.

  - Teardown masks the line again once synchronize_irq() and
    cancel_work_sync() have returned: a handler that read ->stopping
    before it was set could unmask after the first mask.

  - An interrupt that arrives while a reset is in flight is reported as not
    handled. The port is masked at that point, so the interrupt belongs to
    another function on the line; claiming it also meant that a reset which
    failed would claim every interrupt on the shared pin from then on.

  - The recovery item masks the port before it resets the engine. A handler
    that was already running could have unmasked the port after the error,
    and the reset has to run with the engine quiet.

  - A feature answer is matched to its request by a serial number. The
    same report asked for twice in a row gave the second request nothing
    to tell a late answer of the first one from its own: the report ID
    matched, so the request could complete with the previous payload.
    The payload is copied out under the same lock now.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: register the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           |  95 ++-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 805 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 200 +++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 203 +++++
 6 files changed, 1320 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
