Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699774;
	b=lXQRcxOWPdJywN7GAnSpt4Ai/vl8Xgj68tCpjcmvKQ4ogaHJbgEVvbM4rv58gPINnj5s
	 r3D7I/6WNAaNv2fXvwzWg3gM6F5LoUWrS+Z11WdCRdVHc7nIcEnMGz7GlNqsovQbgempB
	 xXCkkIUMD/D/yzbpp9qB0gs7upeJNjC2I817lGd+im2SEEvBKJ31+dHV3IcBIAkrrtPD0
	 J2QuxRWRNUSpCRNGSNV3acmLI4q1T8JAWkYV9v4R8wj61GwB4JTy7eBW78STeSdYCoiIK
	 FcJ1jiR09Yf5CTf+l6sDjEb64ko/3lXqe2hJ27A1SH9SzhBINZTIPpNK2DiJSTFVEPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699774;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=DMwjjvmYHcGvjsrpj8I7GbC8nvrHBooiUYnDkcVtlP4=;
	b=lEZ3sgyMgISSgUWJc/ZuQfEE/RNhqKH+GAjWYbArKrGom+oTfxj9L6odyswOb4dP9Smo
	 nW/KWKJLMvNjcNxPEoJtCkujf56utWt4TWELyTfGOsTZoFyXtWd89wG1s5Ud5p3w8vTp0
	 vWcjoYAn91wDMQAaILFIMCD8p896aKMZt0GgKsxLZt0IqRcxzsQZ1x+RDWdX14zQS2/f0
	 V2+nDd1yvX9fxuweCTlsMnwp09MBfMlw6xA6YC77U+jzb746fnmaQNxFk8gCmZjbKHnzK
	 JhaWLv0ZilrxGHA/30q0Ks8Qy5VtEp7QE11WdsEJJM9DYeA2PGw0Rc5BcFebzl/JAqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=TS8vN5Fn;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DE606A8A9;
	Sat, 14 Nov 2026 23:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A86DE606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=TS8vN5Fn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DMwjjvmYHcGvjsrpj8I7GbC8nvrHBooiUYnDkcVtlP4=; b=TS8vN5FnEcnflFB3Wc2OntC41t
	sorUfvecRAVE8SD03Kw2i1ttHoLFJdJx3i8CxyuI5wDRTnN49eNPdIJrGjHQCeKcGmuxYh3c45Fh/
	0Qrrj7oUzfL1kksO/VtP+KIfHUQT4IpFiQf44kSmDZp15sbxPftQJCcA2G91PwI+en0RwyspwB7J1
	nMxGfgheIWJH6WYKgBBOhyIwKrSwx6BUQwAnIIAhUo/t7752U6h9ej7Ko06LpGW6hkDgWozjy4EDm
	47Ko+JghuX48XBPgZNAK8ZEGhoNjd7k6Xkk81vt1FTt7zK3eyTMXIBz0eOnrx6pxevp9Vq4rBlKo+
	2bXn4gAQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSNOR-00FuFV-0z;
	Sat, 14 Nov 2026 23:42:48 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Sun, 15 Nov 2026 07:42:37 +0800
Message-ID: <20261114234242.177387-1-emfox@debian.org>
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

  - Runtime PM is not implemented, so LTR is not configured, and only the
    Tiger Lake ports were tested; Lakefield, Alder Lake and Raptor Lake
    share the code path but have not been run.

  - System sleep takes the HID device down and brings it back, so the
    daemon restarts and asks for the report stream again: the controller
    does not keep that state, and the touchscreen cannot wake the machine.

Link to v4:
https://lore.kernel.org/r/20261114214026.2809740-1-emfox@debian.org

Changes in v5:

  - A feature answer is no longer matched to its request by a serial
    number; the frame cannot carry one. A request is sent once, and a
    timeout closes the channel until the port is started again.

  - The recovery path masks the port before scheduling the work item; a
    handler that hit a transfer error left it open.

  - A reset leaves the PRD entries as the controller wrote them, so a
    frame nobody read can make the next one overrun. The fix belongs in
    the core; the other two backends share the gap.

Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: register the HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           |  95 ++-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 747 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 194 +++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 198 +++++
 6 files changed, 1251 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
