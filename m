Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671204;
	b=dGjc7zNVvEexui1/MTxhl26XXDz8VdZdB7Z1jNUlr7R2I9rBdN+dKkrWsn2RHcXxPVyx
	 7ADvx87MU8ekvmDl5RnickNCPcFlkqmGUDlOFCncjEdEu6iH+KY3lPa8eHws237hN1XM2
	 EgRj5U41H2wakOE8dt2sDLBdic5h8rhRQlC73alWb3TBtlEUkGzF8KMRxhC/zF5EH1cup
	 Y0/P5g2ERmGGIYCKvrs1jgSGEoyEGXCD+PPwkV88LovC3p5AAb0r04KO+pD4SqRg0FgSs
	 JX1UALKmBSSCEexwZRCT+V9GxdWMKuBioesO1ws25IEM5m5eafx3BntxjWeDDeh9lcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671204;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Debian-User;
	bh=bsSIhLFtIwm+QGg8QxOFgUSfbtqUvWOkR3NTye6LsS8=;
	b=wXX/16h9jKCjGTOQ1Ln8HvHALRwQXaiJen/lIBuVxypU9pQAxsPRf6QbvXYMqXnNsR2n
	 v+pZXhHdAqsCDQP+CUYpFPVYoZbMe/R4c7UmxOWu66I0CiP2z+xKxPER7JHkaJuQfdNS5
	 vI7dVg1XJUppRWYqhT438lvL5klAkBtGk1DYKv0VYynExzavPSb7OqQYOHZsUaXhkrwZL
	 BNA4/rOTn1V2mqn4+TpuEHp0RKVtnK5oO2MaNOj6EyWiQGy6Dl4VdKZTsLv0ZNVna1DN0
	 2JFnXig2TnUN+FaaROapuYEbrABMALKOZ3gIIYsrTEod4cui9mXsQsWIHiuoVg6wV+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=O0o1X4Cb;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19E606A323;
	Sat, 14 Nov 2026 15:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B19E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=O0o1X4Cb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bsSIhLFtIwm+QGg8QxOFgUSfbtqUvWOkR3NTye6LsS8=; b=O0o1X4Cb2EeKoyDD6vXb+m0oUf
	oYuby9UglmDAyLpff5+YqYIVr3ogYyJSzSMJCGLfbaGmJVyXy6zbgFE4/aM7P3wiszrrQ+BXZUM9W
	pSeAWqQCRUcvu8D7dtulWfB3MRS3zyomF28p2FD10CKO2ncy/n/gspdBDTdqBR1098HZdVelQR6lT
	L47NqzWozopnbmCalcHzv4nXAIlsUU4ydnq0LImc/BqiQclLQls+d8OAPgFYkRWjeHNIyuhiFTC38
	+KN7+qnh00PhXrNOAJpcOSUliX5phj8RVUxZg5QWQdM44MHQj+bIYJQOGkNbMkduSgcoMf3fagKqI
	k1gzL77Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSFxV-00FdZ6-2J;
	Sat, 14 Nov 2026 15:46:30 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] HID: intel-thc-hid: intel-ipts: support THC IPTS ports
Date: Sat, 14 Nov 2026 23:46:06 +0800
Message-ID: <20261114154611.1683519-1-emfox@debian.org>
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
HIDSPI has no driver today: this driver backs out with -ENODEV when the
$TIC tag never appears.

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


Emfox Zhou (5):
  HID: intel-thc-hid: intel-ipts: bring up the port
  HID: intel-thc-hid: intel-ipts: receive reports
  HID: intel-thc-hid: intel-ipts: expose the port as a HID device
  HID: intel-thc-hid: intel-ipts: handle system sleep
  HID: intel-thc-hid: intel-ipts: document the IPTS mode

 Documentation/hid/intel-thc-hid.rst           |  95 ++-
 drivers/hid/intel-thc-hid/Kconfig             |  14 +
 drivers/hid/intel-thc-hid/Makefile            |   4 +
 drivers/hid/intel-thc-hid/intel-ipts/ipts.c   | 681 ++++++++++++++++++
 drivers/hid/intel-thc-hid/intel-ipts/ipts.h   | 189 +++++
 .../hid/intel-thc-hid/intel-ipts/pci-ipts.c   | 197 +++++
 6 files changed, 1179 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.c
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/ipts.h
 create mode 100644 drivers/hid/intel-thc-hid/intel-ipts/pci-ipts.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
