Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C43CCFA3;
	Fri,  3 Apr 2026 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232752; cv=none; b=jKm+h9ANMoFJjVJVFng4HF8lgtU//q2DIA9czkCiK/+gHRopCNwqMEqx5DDaSoXukfbsqUGR6dGnMzBcuJB6WPzlJohhlDkRT5R+nRYYu2nuH5we8q1J4SRPtggPzu5ztEF528rppHl3Tllt3pr8zI6vwBpEawcxYoGNvjJjg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232752; c=relaxed/simple;
	bh=lQgim5ryR78mXLfukJojmJ4bOO6EYuiIVoNzfE2OKaw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lxNWPspm+4xxUpLoWHKQ9ytIeHF84sMZa2AQ23Tv0vOGzG4ohNUaHArpijinEVGkjUE7F1tK+n/dTGKzV6oWqzeJJfVKb95wZ4E+MBU+9ExWt512lSXFRNjMqULy5vYlU33EsWfLtKa5vR4YbxAd2aPYwVOQz6bL91RUoh+HSWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npnXFj8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npnXFj8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE3C4CEF7;
	Fri,  3 Apr 2026 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232752;
	bh=lQgim5ryR78mXLfukJojmJ4bOO6EYuiIVoNzfE2OKaw=;
	h=From:Subject:Date:To:Cc:From;
	b=npnXFj8Z4uOus8grmqjCWUFPahclseVvyetaZGx9SfMTi3/m/gguaO/8uiGJkqPyk
	 LgYf/NtkiEBeB8ED6zrWTzrbBUnSRKTT9o+PXU9vlt6lF75IuRtood8DKxT7jKg/QD
	 RETPt8P9qvJsKI642OIbzfEiPjaIeTw9fg2n/smU6fyAZQAlLLA/611rmjfloNM53K
	 4xgTlubW3ixvaYUH2cWzYizNXrUgvnoS/S8hlJ5GVCDQx3DCKUWMRtR3nbXZfZ04tQ
	 T0TmnqujxGPD0dRfldAzfMgoiAtICqpnBoZf6bU0JQn+UAPs8cWnh9Jm+/BixCnbT0
	 kttjsN4ibqo2A==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 0/8] HID: bpf: sync up programs with udev-hid-bpf
Date: Fri, 03 Apr 2026 18:12:18 +0200
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqDMBBG4VeRWftD1BChr1K60MlYZxNDQr0gv
 ruxy48D56QsSSXTqzopyapZl1DQ1BXxPISvQH0xtaZ1xpoOm0bkIzB+XlbM6jHGCU+GsehHlsF
 2rnHMVB4xyaT7///+XNcN38shOW8AAAA=
X-Change-ID: 20260403-wip-sync-udev-hid-bpf-2026-04-7bcea43616cc
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>, 
 muhammed Rishal <muhammedrishal7777777@gmail.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=1980;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=lQgim5ryR78mXLfukJojmJ4bOO6EYuiIVoNzfE2OKaw=;
 b=0xA/L/F7wh9R0qst2SteYm2ShEEc6lA5naGmTlvSL5XyVq0SFK5uc0QgI1PwqzFaW9/LVj8yp
 fnbz8QURXmPAcLXcBemUg85JvT7XHRF7+4eSQMLQpLkUMDLyHJKRvQA
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Not a full sync of udev-hid-bpf as the remaining .h syncs are not used
in merged HID-BPF progs (namely Logitech Bolt support).

I've tried to re-apply the header changes by merging the resulting code
and put references where I could.

We now gain support for:
- Huion KeyDial K20 over bluetooth
- Trust Philips SPK6327 keyboard
- A small helper to add a udev property to touchpads not running v6.18
  yet

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Benjamin Tissoires (8):
      HID: bpf: fix some signed vs unsigned compiler warnings
      HID: bpf: hid_bpf_helpers: provide a cleanup functions
      HID: bpf: add helper macros for LE/BE conversion
      HID: bpf: handle injected report descriptor in HID-BPF
      hid: bpf: hid_bpf_helpers: add helper for having read/write udev properties
      HID: bpf: add a BPF to get the touchpad type
      HID: bpf: Add support for the Huion KeyDial K20 over bluetooth
      bpf: Add fix for Trust Philips SPK6327 (145f:024b) modifier keys

 drivers/hid/bpf/progs/Generic__touchpad.bpf.c      |   90 +
 .../bpf/progs/Huion__KeydialK20-Bluetooth.bpf.c    |  492 ++++
 drivers/hid/bpf/progs/Huion__KeydialK20.bpf.c      |    3 +-
 .../hid/bpf/progs/IOGEAR__Kaliber-MMOmentum.bpf.c  |    2 +-
 drivers/hid/bpf/progs/Trust__Philips-SPK6327.bpf.c |   49 +
 drivers/hid/bpf/progs/Wacom__ArtPen.bpf.c          |    2 +-
 drivers/hid/bpf/progs/XPPen__DecoMini4.bpf.c       |    2 +-
 drivers/hid/bpf/progs/hid_bpf_async.h              |   36 +-
 drivers/hid/bpf/progs/hid_bpf_helpers.h            |  321 +++
 .../hid/bpf/progs/hid_report_descriptor_helpers.h  |   80 +
 drivers/hid/bpf/progs/hid_usages.h                 | 2810 ++++++++++++++++++++
 11 files changed, 3865 insertions(+), 22 deletions(-)
---
base-commit: 26639c5427d32a90301b31bc8ab82719629c1864
change-id: 20260403-wip-sync-udev-hid-bpf-2026-04-7bcea43616cc

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

