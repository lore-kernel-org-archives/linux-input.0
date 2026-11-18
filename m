Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794980449;
	b=3GAZrFRk7cxjQe6oi2uCz5IudRZ8A7k4yJp6JX3qSeqk4wQsgjHeVGSTuJ3Xj7z/0/B1
	 KXtiIVnQQDjnAtQp9LrNBHsC3cUcVjMrF9K+2g14vpKV7dj9AS4DGEmLLh02rxJ3YjhtX
	 II/V8EqKqyN/nKN0mDiUVgPsUCPKemwMJnaUL0z4fM/9PQyX1F5oDPkGkW70tpkZIGkKB
	 zWol07CHOjuPZfsn7ctm1HO085rGIdqgJH/yesQ7MHiXhBpSng3RaxofM3bwmTwfHvAlk
	 niOG/8O5Lm/FR+NrzROgNahUd8gKwYLLg9uJr+gKu7ruWfIz+9QfCWof0uc6MBP79iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794980449;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=4tGFP33VkTrDJmEm8l02YsCNfXgeLphumCyL2ku8Avg=;
	b=QVR7vucjxH98q5jWqbE63O72BYWDTOn1+XH/uwYizBtmpkSVNHLOLP3fZOGfsSNurGUu
	 8Ocx/0OW5gLS6zVesJlmS/LRLQ0VuIM51/vQefm9YQJDfAYicFZv9AdGnJy9tAjl/NjU/
	 pZ7yPUXt6qu03Wen+IxIDj7d9fdt+8HpZkknzuetSNVfclQvu99WoGik41lC6EbzHhhRf
	 KcomU8GyOvEysJTUSuxeQnHuzEYssOc3TPPCBnj//VO0uT8LbaeHo4acz/q2Kj88g9nHj
	 erjae3THJBFEZhIjKI0y94nSndgwj0yfUPVDdQa6Ts02sKsDiOrKZvXfTD7kABsW6rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=PclmspPO;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C845606A32A;
	Wed, 18 Nov 2026 05:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C845606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=PclmspPO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4tGFP33VkTrDJmEm8l02YsCNfXgeLphumCyL2ku8Avg=; b=PclmspPOSxHVc9EGsnSKvBKYpU
	TRMexHLATIUCVgfNEKMBYwriDsXkvWd//LHhcSbEsoXAbhdnM44Gd0A2x/xCWdTopjGe6BBcS3auM
	OA20zMJ1drdt/m16D8MvpsIvV78ToasKFxqYcWtRWLCokdoEouEBjHMYITqc6sXK8OoYq2zd+G3Tr
	3DltSFb8hyuSlDKdM1deTZe7pB3rTldSdXtTwEp7pbKSZlFmycf8f1/oY1zead9/E6iwhKzD2vGaG
	AWZi7OWIod7tN7tVyTNe3e+qMWJHfHSK/f8aGkSwVzJXu/Qs/S4z2iGKxdrPADjAjyBq1BchxLu6p
	l1IBKdkA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYPU-0015Jt-1f;
	Wed, 18 Nov 2026 05:40:45 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/5] HID: intel-thc-hid: intel-ipts: document the IPTS mode
Date: Wed, 18 Nov 2026 13:40:04 +0800
Message-ID: <20261118054004.363766-6-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118054004.363766-1-emfox@debian.org>
References: <20261118054004.363766-1-emfox@debian.org>
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
index 8b378c57b..e6bdf30b6 100644
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
+into ``ipts.h``; a ``static_assert()`` on every offset makes a mismatch a
+build failure rather than a quiet misread.
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
