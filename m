Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.76.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504429;
	b=fBzWwsZ/b50HgMHEtxylXRXmlQl2xBPhtCTsTxcm3wIvPI83dFidTkvA7693zz6VUTJl
	 LG9/mszkfKn3q+aNJYp55hrjYr2+kQbsoP2etU8aJ3PYKXNdcK7gmDqVu9vs6818F2tvz
	 tRL+c/Dep1fvFDWq2HFJLg/QAAOPg0K7QPs9HalYkUUG3/nZFCJFoy6NzlH46By9PIc2e
	 LZsCzldC090M0yBK1AxiKoKHt0/UbD3RWidI88UXJcYdmWu8m14VmL7tqawY22ijj8lLw
	 oq1iJ+N6IMmwFdtAgZfzcuQJIfnxrmCBoa8XOCJAlgzVnTQHZrbXQNfRDvu5Xm9Y/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504429;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Info-Out:X-JNJ;
	bh=GYhzPzJ+niR5fwLT9fpKA2jNHCnHjWfyT1VOIah+Sog=;
	b=KKTKd0OnGLeT1GbsXnP+3099vILCPa/9okdvl9e84M/HHsNQCt9nDL0V6Ggxmt1pGBf5
	 PUztUpFwdNTFVmvZr0z8xhaj9IsRymhu4F4dUM8tI736mWW7inK60FdIuoDHEKeTgQyay
	 P9Co/F8u7K+6vMcL6ux8bpI0W8c5zjQvLsvKlbmIjrLmPuzjwZJYhZJ7ozQFRU/rKY1rW
	 2zQOM6ZJqkKhzdlA4yXPyGlImP+Va36nBwkmGrICN3K34sik8KQbJlC3f/JVtozYjClFA
	 pZwHkt925mQ+GX2TABEoKCOwr54EpPjXApBcc6fbcvp4btiEiQrLfWvAaoe8lHuh+UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tawheed.cc;
	spf=pass smtp.mailfrom=tawheed.cc;
	dkim=pass header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b="xY/RMbpj";
	arc=none smtp.remote-ip=57.103.76.178
Received: from outbound.st.icloud.com (st-2006a-snip4-7.eps.apple.com [57.103.76.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A6606A894
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 17:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC3A6606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tawheed.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tawheed.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tawheed.cc header.i=@tawheed.cc header.a=rsa-sha256 header.s=sig1 header.b=xY/RMbpj
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id BEC12180483C;
	Thu, 12 Nov 2026 17:27:04 +0000 (UTC)
X-ICL-RepId: 01a1d0cc-7ce5-780c-ae34-85d6deb50945
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tawheed.cc; s=sig1; t=1794504427; x=1826040427; bh=GYhzPzJ+niR5fwLT9fpKA2jNHCnHjWfyT1VOIah+Sog=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=xY/RMbpjwlMUjIEcIuQ6jH+i0+XZM+FgmPi67T1TDQBj0Uu2KfBJBoOZAn2WQAcNQ8ACwKnS7ovpzXvotzBHjW6qeV8LbH8Ym2kXQKkfiz/iZMTNGi0GdqbE/iuTUiI0xnkBNUwgiRPRMeogWPkPyzVPs4cU6CEaO7DxHqV4CP2Ct7cIp+W/8PVa8HrpliZxCgoLbbJ6BkqY36JCJybHJKi/JoW5KXqFbUbVUegGpcFsC435YVZlOI4h/JPXKQwAGEm400yceNtKqK5cBI1HZDEvFRoACzbedPBzeXqIdoDlnZHv4xRcpPWRRNeCkO0XqjdJC2rH3HHy3a2mAj0Cbw==
mail-alias-created-date: 1711150425226
Received: from DESKTOP-HUABEFD.localdomain (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id 8A84E1804822;
	Thu, 12 Nov 2026 17:27:03 +0000 (UTC)
From: Tawheed Makhdoomi <_@tawheed.cc>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jingyuan Liang <jingyliang@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] HID: spi-hid: support the pre-release protocol (Surface Pro X digitizer)
Date: Thu, 12 Nov 2026 12:26:38 -0500
Message-ID: <20261112172641.407-1-_@tawheed.cc>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: 7QVNLYoIUqxGItn_imZgZiJ4YX0naxar
X-Proofpoint-GUID: 7QVNLYoIUqxGItn_imZgZiJ4YX0naxar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2OSBTYWx0ZWRfX/a4AuOTKcwZ8
 2F6sML8m62ulMN8o9GeRvC9So/wdzxwa7xPRw4bvd6OYlOkUKfyHkv41eIJAC31CPoDN73E2LlI
 njl8qS5RxFLwTh9RLAkPIm/42gqS5SvPD2OhvId6LYtTy+lnpDZZ0HUu3haMaWdu3G3e4ZrO4tF
 X+y8htlPRMO6HArGkTqVe7zSeUeLcWtu8PwtgDXmq+M0nr+30pzRtoSmYGkPcoBln36MdaYZW/8
 syHk7yb4Dl3jiQSFZAMW3NuzwihEVFTTGobgK/Jqikw0xj89JQpQWg2aendjPQ8Yqon+sjsutx8
 ZKxuC5fozeMhekLkkX0OODHVmMzIrDJ4yNJdvE3wEOG//XFrGoIhLsbDVDIrqM=
X-Authority-Info-Out: v=2.4 cv=QPZlhwLL c=1 sm=1 tr=0 ts=6af5f6e9
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=VT7vhFcB3mNHmCdLKwgA:9
X-JNJ: AAAAAAABOmJ0Lw2TubZ8VMoJ5/JOsAKMeBTi46bsET319JztIicEnMJlxpRUpLtn/b6nMQ
 uecfKmtO3J7QSo2Uiors/hv+sdkrXAedM5bI1wfvbz6aOpszN/84o17CKtovX4B44APrsC
 h/x58p4b9cOvh3HZZDXziYsKDXrw8VXP/A3C69HITvYZEgw+0PDFiyXsmeiv44uqNPAjfc
 e+RtRxJQB/futCJPz2J6HzPGQTJ6G2VvbwRUeWQfQ0cR7uslGkVUBw4n+k47KzRN6XMwB/
 /wkZXA3o+PuxaQX+Lp3bYZu+GaxR3WDon1g2VfECqtBvZPJERmLEQrTwYLP5mjC4zMQLXz
 lehCKtCtEqOWt/Xmf2OEl/IGA4oUXgYfYTLb6Y+xjUOQ3BK/jB13KY98gJzznOVr4olmai
 IicsA5PjyPhnmlSZPsEyoP2KAlYQhQ60xN8Uou3Z2VIuO1xfwEwDoLl2m0fpd/W6gtfUGj
 WgqVwV8x+R9NOwESkzb96gdhD9eMcqtJ1oDC12GUqMKS54kFJpI6nQfkAdICXKa7GPwUOy
 d8NjTjM4IrdCBgPQoaVOZzcIQVbM6n5K/AcO5S6LNmzUxXd4oGNbfdSbtdXFVgW70yNjhu
 dS4zyMjy1PfPNfSVOaLGkva4bE+y2AWMJvdbwmPHSf/B1O1E8q0pvmoiB7q3FG5WUSoFNn
 HF+GSum/eqqMGgs3LDO17VCzotLvLDH8dXMEL2bzgFaAMREsbmv2zoCYk4ZVRIA+QGJmPy
 3FKGZsvPPQ80TK6zg8vcetTX7EBzK2ByoHkYKLNcnbAUVzkWrocUBZC6qA+0swqhgL2X0/
 pnndIVJFpb4pFI8COhoN1DZit09+CaXVELPVUPN3Sv5Mi0LOwkYWeTJqVPvIYgRixWjz2x
 dQGOgoUwaNKEpF553O42WZ10HA+KSIxne7Tl0/tJm6D0fi8TACvX/sWC9ZzKAAf1AFk050
 9TZ7kZcZaBUKDkFsApxPD2Cyo1YJnxRJteru4UIQRC4E5cWN+DQeFm8SSPoTYl5ByLjRH6
 YFoBE5T5pggog6R+vBMDeNCDOun52MmmnBRNhhSgkRpX8tnCe0Opxj1M3kpjhAeatJ3/de
 DJUq1iMSNzKt0v0n9DaLqlk6meMUTAFo+VrJ6nj/apdMUwGx4OIN8+dGCgj+uXNa1ObLF7
 oC+s8EFx9LHxASxjWapbnyPZHXvakRINMF2Elc+BBo61sJ5u22I09j3Bw8pEN7KPOFA2Gu
 idH5d+9zd6IpQnyHkWQuJXUjYsoAFnP2Ugq7eUlQb24ymV1mozxAGNEPTc2Bq/uKfMYyC5
 j6hZvxDJLTAWaeyJFj08nTtZA/IwmKnZLdYn+L4qNJlw==

This RFC series sits on top of Jingyuan's "[PATCH v7 00/11] Add spi-hid
transport driver" [1]. It adds support for digitizers that speak the
pre-release revision of the HID over SPI protocol, the one Microsoft's
original 2022 spi-hid driver targeted. The motivating device is the
Microsoft Surface Pro X (Qualcomm sc8180x), whose touch/pen digitizer
(045E:0996) ships this way.

With v7 as posted, the Pro X digitizer binds (via the g6 compatible), but
every input report is rejected with "Unknown input report version (v 0x2)".
The differences go beyond the version nibble:

 - input header: report type in the high nibble of byte 0, a fragment id,
   and a 12-bit length across bytes 1-2
 - input body: a 3-byte body header (length, content id), no report type
 - output: a 6-byte header (opcode, register address, version + 12-bit
   length) followed by a 4-byte body header (content type, length, id)
 - requests are addressed to per-function registers: device descriptor at
   a fixed register, report descriptor at wReportDescRegister,
   features/output reports at wOutputRegister
 - a 28-byte device descriptor carrying those registers, bcdVersion 0x0100
 - SET_FEATURE and output reports are not acknowledged

Patch 2 keeps all of this behind a per-device "protocol" field in
struct spi_hid_conf, in small helpers, so the v3 paths (g6, ACPI) are
unchanged. Patch 3 adds the Pro X match data. Patch 1 adds its compatible.

Tested on two Surface Pro X SQ1 (LTE) units on top of v7 (plus an
out-of-tree sc8180x DT): the device and report descriptors are accepted,
the HID device is created, iptsd's GET_FEATURE/SET_FEATURE succeed, and
multitouch works (5 simultaneous contacts, no driver errors).

Questions, which are why this is an RFC:
 - Would you take support for the pre-release protocol revision at all,
   given it's in shipping hardware? If so, is a per-device protocol field
   in spi_hid_conf the right shape, or would you prefer something else?
 - The compatible is named after the product
   ("microsoft,surface-pro-x-touch-digitizer"), since Microsoft publishes
   no part number or generation for this digitizer. Is that acceptable?

Known gaps / observations:
 - Fragmented input reports are not supported in the v2 path (fragment id
   ignored); I have not seen this device send fragments.
 - COMMAND (e.g. SET_POWER), output reports and suspend/resume are not
   exercised by my testing yet.
 - Once, on the first boot after installing a new kernel, the boot-time
   probe saw no interrupt at all (IRQ count stayed 0); unbind/bind fixed it
   and later boots were fine. That looks like a reset-response edge lost
   at probe. v7 has no timeout/retry for that case; I'm not sure yet
   whether it's specific to this device.
 - Around a rebind, one "Unknown input report version" from the power-up
   window can appear, because the version check runs before the
   reset-pending check. Harmless, but noisy.

The matching sc8180x DT change will go via the Surface Pro X DT work.

[1] https://lore.kernel.org/r/20261024-send-upstream-v7-0-abad13174b43@chromium.org

Tawheed Makhdoomi (3):
  dt-bindings: input: hid-over-spi: add the Surface Pro X touch
    digitizer
  HID: spi-hid: support the pre-release HID over SPI protocol revision
  HID: spi-hid-of: add the Surface Pro X touch digitizer

 .../bindings/input/hid-over-spi.yaml          |   1 +
 drivers/hid/spi-hid/spi-hid-core.c            | 327 +++++++++++++++---
 drivers/hid/spi-hid/spi-hid-core.h            |   4 +
 drivers/hid/spi-hid/spi-hid-of.c              |  26 ++
 drivers/hid/spi-hid/spi-hid.h                 |  27 +-
 5 files changed, 344 insertions(+), 41 deletions(-)


base-commit: 04fd628c5c27c93b623b5b6b88fd52d4444d5a7b
-- 
2.43.0

