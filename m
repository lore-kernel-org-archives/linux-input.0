Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794760;
	b=cKQsF8zNBRLDBwgrqAIxKqyUFMmYC5Q9p+oMCN5lIj6zgFAkgy+zx/SqVbXPK4JF4cce
	 ht2BgzHIquepI5tbiLe6cOWhxPbJMNwYSxZzZuBDG1XmJ0Wtkx0aEgKCEnaP/MmuhIJPG
	 2awerE5HKjGNJHDwr6Cmwu4B/70/jFnO4yVRKMTZen8n6gPmizz1NMOtpzhzvQCWd6wP1
	 UZSAmgCYOly/HJzU3UVDzLCztLvrPSKvgGm0f8ncYHcMgjGcYuKpshrN7wCNNPosFoO9k
	 qtzSZOhe9E3wDw3nTVlNWTxXBQp4CbCbrNLDotuNT8aMDR+O0mzBzw1Q3EuCC+3JCrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794760;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=NCvSdp/nnfOZK82fLF6Dz/vtI/HIzAU3oT1/epjJH2g=;
	b=tdvknArG7wlKGV+hE+FZPbKpOPbUiyd/mr0+jGN/CT55BSgvNxlV+hIj1PNt8oCaP3Xb
	 +vtYdg3NJ5M5kJam1/T5TSYXTD4ZRKBjMCFKDAheAkmr8Nkh47t75+cYZWJHqVn+0uxaa
	 58/jiJDPo/Ua73h/19z/lyTavD/XDJXvbwY0lZ9ZOLkOtgAIJRlpYgB5rHfW/JlQz71hn
	 ZPUNhJNbamSqScd0KuGEhlt4w+cOFGNTC/a4lq+VcX70ZmAcqFSPEmdYsHGNWL2QA/rNX
	 QK9MqtdBcYFO9fEwwY/tOIGdlSZ01+U6OyWGCyjQ0GbwhqezdtxipOcnSX7NbRWjKSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=HG4arIh6;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F99606A31C;
	Fri, 27 Nov 2026 15:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F99606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=HG4arIh6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NCvSdp/nnfOZK82fLF6Dz/vtI/HIzAU3oT1/epjJH2g=; b=HG4arIh6KUUgWNVf3P9tPeSgAE
	/AQzUJpRQyU2+NzpEZWbn0F2EWdl/ZBEUumVm7izB4EiCijz+EBvjLFF+6Vb6zn3CMcN3F1YgRbN8
	aiCXw6l0cWK0gOV5cOa923rQ/4ekXaoldxr+5V0QVSk6VIr8b08v5fykvt5RFIusZWLRlHPqyTIuS
	hGkF2kKdd5hYDaCJ9zOd6JpgDE70a660R/tlIjXGVjypxwPk6Vy+T9TzsTeOwXD/zjj+aV10Yavuu
	7tjCnBQAeoQamdMNMhxdTkyfVjJ9DvuHoUSObmzy16B34JXxdN4n9XM+2SueqGT/q71cPfFArHEJ1
	V2UdgSyw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWyFV-008RsY-0k;
	Fri, 27 Nov 2026 15:52:34 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 6/6] HID: intel-thc-hid: intel-ipts: document the IPTS mode
Date: Fri, 27 Nov 2026 23:51:40 +0800
Message-ID: <f63745db70a70be1c7872e507e907d7754f686a5.1795794049.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
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
 Documentation/hid/intel-thc-hid.rst | 109 +++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/Documentation/hid/intel-thc-hid.rst b/Documentation/hid/intel-thc-hid.rst
index 8b378c57b..3b81cc0bb 100644
--- a/Documentation/hid/intel-thc-hid.rst
+++ b/Documentation/hid/intel-thc-hid.rst
@@ -590,7 +590,114 @@ To debug THC, event tracing mechanism is used. To enable debug logs::
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
+Two steps come before that read: the DMA engines are unconfigured first, so
+engines the firmware left armed do not keep writing through the PRD base it
+had mapped, and the interrupt trigger is switched to edge, without which the
+first read is unreliable.
+
+Fields the driver uses:
+
+======  ==========================================================
+Offset  Meaning
+======  ==========================================================
+0x00    pending interrupt causes
+0x08    buffer sizes, ``(size / 64) - 1``; Rx bits 13:0, Tx 23:14
+0x0c    touch engine control: enable BIT(0), HID reports BIT(2),
+        power state GENMASK(5, 3)
+0x14    controller tag, ``$TIC``
+0x18    SPI timing: clock divisor GENMASK(3, 1), divide-by-8 and
+        dual/quad bits
+0x1c    vendor and product ID reported to HID
+0x20    product revision
+0x24    firmware version word
+======  ==========================================================
+
+The driver enables the touch engine with reports and full power, and clears
+it again when the port is shut down.
+
+The offsets above, the frame codes and the header sizes below are compiled
+into ``ipts.h``; a ``static_assert()`` on the offsets the driver reads makes
+a mismatch a build failure rather than a quiet misread.
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
+The port has to be released from quiesce before the driver enables the
+touch engine: quiescing holds back the device interrupt and the data path,
+not the configuration access, which is why the block above is read while the
+port is still quiesced. The interrupt configuration programs the interrupt
+type field in the device to the invalid value, and starting the receive
+engine then replaces that field with the type it expects, so the two have to
+happen in that order.
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
+System sleep tears the port down and brings it back, so the hidraw node is
+destroyed and re-created: a daemon has to reopen it after resume.
+
+8. Reference
 ============
 - HIDSPI: https://download.microsoft.com/download/c/a/0/ca07aef3-3e10-4022-b1e9-c98cea99465d/HidSpiProtocolSpec.pdf
 - HIDI2C: https://download.microsoft.com/download/7/d/d/7dd44bb7-2a7a-4505-ac1c-7227d3d96d5b/hid-over-i2c-protocol-spec-v1-0.docx
