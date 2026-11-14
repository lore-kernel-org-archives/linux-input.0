Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699804;
	b=DR4LX187jrj02oIj8pwsURnIFQeWwhuS9wi3mV3EAP7jSeeLlB/8t/KntohS+wdjW3yU
	 SX4wgzhm093zUFllXZp0PBlG8AZA/IzLPYC+mlB1jk5aZi/ECcJ2yzyVqU4WeDySmTNJK
	 m0Rbnw3dLq1UXTKWr3RhGZ+cnin+IuN14uaxqTse7kMOVd0fapXaPtzLFMtzisnHnZNYJ
	 JQp4CkHfLMGzdL1yAm0FaaxHriOt44x+bK6R3HegOiytkrikjibpE70Qip6XDUBdqJr4t
	 M5Um/PsL0T37adFlCmw90YlqN2O0C6p5f3rPQyLiHIyw90CIxiiHrcUhoLtPapcc5IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699804;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=nHvcGLEPN+KJmAbgmVxEdpoj9yjLpharhHP3szST0sk=;
	b=NxzETiwkU0txrdfyBGHEoh26OGknEwwZyH86do2GWKMjo/kOR0ldFV1xKzOqQOWlkA7y
	 4A/2RP+yz+bdXE9ckNKFnFBJqeXkj/UHSscqfyRgMY3y4Mddb5rpNfRHwEL3/13NWCrcS
	 MoK8d4XGnoVEduUyT2tZx9Q2RxkEMvqf7ZkWrNad3dSEl+nFY/qTXgT/IwkBd5rDBzC5t
	 qCuBmPJmgMFRmGYxOWXJatzFYiDPuW7I6VnzWHGcq7GC5ZhZdEzXD7aUg1Nyar10t0Iys
	 HidGDL/6I5IpQJFsjvqfQXJmHSLc0qrpmmK9Lc8PQItTDN8a69p+PbwZIzZ8ffyk9JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VrZYV28P;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A475606A89C;
	Sat, 14 Nov 2026 23:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A475606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=VrZYV28P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nHvcGLEPN+KJmAbgmVxEdpoj9yjLpharhHP3szST0sk=; b=VrZYV28P5XFEWh86FGUtp8duzY
	DlOwg3wehY9JWuqKkCtBIdjdO+j6kmDsq6GgnIxy5iiCDdf0EuxdDY+39Yo/bae+mWoXMS1tVgBLk
	H2EGagjdhNN7aLacQZuEbDG8tnp2cmRAibmnCdNRtOP/TFla4MadcBFpqqi2rbs8XPNq3OqFD0DOZ
	Q6Xn5agctL7FKPb5Ix5ndUN6R0M99D6iZ4oPXjhmo1LEQfQ+UxJSB0hYF4k5JuH3JtNxlC7zizgR+
	MU+db5X3D3E5uxVqWO2/PlJ9kQ4yoIujY3C4oglkHtOD0j/EmvQQi41pGPhAXapsXUONwawwaBZod
	xrzaEYpg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSNOw-00FuGV-2r;
	Sat, 14 Nov 2026 23:43:19 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] HID: intel-thc-hid: intel-ipts: document the IPTS mode
Date: Sun, 15 Nov 2026 07:42:42 +0800
Message-ID: <20261114234242.177387-6-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114234242.177387-1-emfox@debian.org>
References: <20261114234242.177387-1-emfox@debian.org>
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

The THC documentation only covers HIDSPI and HIDI2C. Ports from before
Meteor Lake run in a third mode, and the intel-ipts driver is
written against behaviour that is not described anywhere in tree.

Record what the driver depends on: the layout of the configuration
block, the frame codes and header sizes, the bulk data window, and the
order in which quiesce, interrupt configuration and the DMA engines
have to be set up.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 Documentation/hid/intel-thc-hid.rst | 95 ++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/Documentation/hid/intel-thc-hid.rst b/Documentation/hid/intel-thc-hid.rst
index 8b378c57b..0f6328aae 100644
--- a/Documentation/hid/intel-thc-hid.rst
+++ b/Documentation/hid/intel-thc-hid.rst
@@ -590,7 +590,100 @@ To debug THC, event tracing mechanism is used. To enable debug logs::
   echo 1 > /sys/kernel/debug/tracing/events/intel_thc/enable
   cat /sys/kernel/debug/tracing/trace
 
-7. Reference
+7. IPTS Mode
+============
+
+THC also supports IPTS mode, the private Intel Precise Touch and Stylus
+protocol. The port drives the touch controller over plain SPI and moves the
+data through the same DMA engines, but the framing is private and the
+parameters come from the controller itself instead of ACPI. The
+``intel-ipts`` module handles ports in that mode, which is what Tiger Lake,
+Lakefield, Alder Lake and Raptor Lake hardware use.
+
+This section describes how the driver uses those ports. It is not a
+specification: everything below comes from observing the controller and is
+limited to what this driver relies on.
+
+7.1 Configuration Block
+-----------------------
+
+At SPI address 0 the controller exposes a 64 byte block. The driver reads it
+over the PIO path after releasing the controller from reset, and retries
+until the tag ``$TIC`` (``0x43495424``) appears, because the block is only
+partially filled while the controller is still starting.
+
+Fields the driver uses:
+
+======  ==========================================================
+Offset  Meaning
+======  ==========================================================
+0x00    pending interrupt causes
+0x08    buffer sizes, ``(size / 64) - 1``; Rx bits 13:0, Tx 23:14
+0x0c    touch engine control, writable
+0x14    controller tag, ``$TIC``
+0x18    SPI timing the controller asks for
+0x1c    vendor and product ID reported to HID
+0x20    product revision
+0x24    firmware version word
+======  ==========================================================
+
+The touch engine control word carries an enable bit, a bit asking for HID
+reports instead of raw data, and a three bit power state. The driver enables
+it with reports and full power, and clears it again when the port is shut
+down.
+
+7.2 Frames
+----------
+
+Both directions carry a code and a length in front of the payload. Frames
+from the controller use a 64 byte header, frames to it an 8 byte header, and
+only the latter has the payload padded to a four byte boundary.
+
+==== ========================== =======================
+Code Received from controller   Sent to controller
+==== ========================== =======================
+3    input report               set feature
+4    feature report             get feature
+5    report descriptor          output report
+7    reset request              get report descriptor
+==== ========================== =======================
+
+A report descriptor comes back with eight bytes of preamble that the driver
+skips.
+
+7.3 Data Window
+---------------
+
+Bulk transfers go through address ``0x1000`` of the controller, not through
+address 0. The DMA engines have to be pointed there explicitly, otherwise
+they write into the configuration block and the controller drops the frames
+without reporting an error. The input header address is zero: that is where
+the controller writes the interrupt cause word, at the start of the
+configuration block.
+
+7.4 Enabling and Flow Control
+-----------------------------
+
+The port has to be released from quiesce before the controller will send
+anything: quiescing gates the whole data path, not just the interrupt. The
+interrupt configuration programs the interrupt type field in the device to
+the invalid value, and starting the receive engine then replaces that field
+with the type it expects, so the two have to happen in that order.
+
+The controller starts streaming once user space asks for it, through a set
+feature request on report 5. The driver does not do that on its own; the
+daemon that opens hidraw sends it.
+
+7.5 What Is Left to User Space
+------------------------------
+
+The reports carry heatmap data, and turning that into contacts is a
+substantial image-processing job that already exists in user space. The
+driver therefore stops at the HID layer: the report descriptor comes from
+the controller and is not written by the driver, the report stream is
+available through hidraw, and ``iptsd`` decodes it into input events.
+
+8. Reference
 ============
 - HIDSPI: https://download.microsoft.com/download/c/a/0/ca07aef3-3e10-4022-b1e9-c98cea99465d/HidSpiProtocolSpec.pdf
 - HIDI2C: https://download.microsoft.com/download/7/d/d/7dd44bb7-2a7a-4505-ac1c-7227d3d96d5b/hid-over-i2c-protocol-spec-v1-0.docx
