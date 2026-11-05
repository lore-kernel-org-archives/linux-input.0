Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906397;
	b=SXWZ+cGNsdMy5PXEhnrQD5xwQlNRWzbIdLdzgCcsDT/giDuqpplIeHf+9128bBWMAQyx
	 nLhhE4W4pWSRhWNfsEpmE/+nFF1hT+B7bMmvUl+kJxV8lQmsejnp+kRV7gH0/hlHl1mis
	 ZljzQO3FN0qioqit0w/4qHauWIsM4XPAJ82f+sq7be8YnoY3HWxylozmOvMejdacQGAfc
	 t7McMFYTJUpyp0smm66lLIQG5uIsb/aXM4LxS4uF/0UlSsggV2e0a72pw3cDUS4hkLd3u
	 A64zomFaoHdQnnPS8kjl3ycG1rPJGqBpgWPqxSSEwzonU96QtxDseWCCfwkbytiyPnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906397;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=vB0d6DmohhVJAem08KYrjHoymUOj9sWWuweWNR1UKLI=;
	b=2joSUbU0NDQQqoVT1lTh6tKr2VPp24GtvE0qc+QDSJF4wkUn88DAs6McDvqhBowyFvDf
	 M8cNTUquBNSUJnrf4dnPsGttkSU5hNnhGJy8eyXx/nn2pVKoctBEprutvscVOBevQ8A5z
	 km9+3HOWohCZfxISh1w6lLUUurCz1y0yPzKfjzVaPxDOLYfRFQ8VBXLhDpzXJK5bhnfov
	 wa9Pzft2PkINZvfiLKAc4L4EGuQ++52qMJJ8IYd/mXNogrvnNq8gzOFsy2whnY4v5Jk9D
	 DcvWowIXoY9gQINFs1L2okAbw4GF7zBNyxAV6hJYIzm6mg6s30Bqsj8fIVzC7tdq1WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b="qGfmCv8/";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=hH5ybj0K;
	arc=none smtp.remote-ip=23.251.234.56
Received: from e234-56.smtp-out.ap-northeast-1.amazonses.com (e234-56.smtp-out.ap-northeast-1.amazonses.com [23.251.234.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE5606A32E;
	Thu,  5 Nov 2026 19:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37DE5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=qGfmCv8/;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=hH5ybj0K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793906396;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=yjQSNr6bjN4bHRD2IZ60o3J6FxseY+q4irgzvY4ZTwU=;
	b=qGfmCv8/vET87ssChBFNsDidGVWbBHOwae0BOQ9aLz9uE/+Uetz+onKk0AoU7029
	ZrqIuaS5pbqviQ0TwnCYhUjQbm5xGo8yX4IcAAc/+bj0WlORYVJiliuvaozly5FXK/d
	zAKHSIEKCY8CtQDFb9aVudluG1C2PAyRkZP7zvaY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793906396;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=yjQSNr6bjN4bHRD2IZ60o3J6FxseY+q4irgzvY4ZTwU=;
	b=hH5ybj0K95yVSoOibYhSRDuaZwoUb4PqjsP56It0m5ChJcw4LyN9UZkHMEjk8zXf
	NPHXvvhOlD2ZArjjAsk6qESp0zAgVCrkqhLDYHY1iN24eBdlp6+oVl9g0A1eUIeQ3cT
	gcZMoHSiel6Z4sdyHrO36KTcBpN4d4ZSySkD9aOc=
In-Reply-To:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v3 0/5] HID: spi-hid: add quad-SPI support for
 Romulus13
Message-ID: <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:19:55 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.05-23.251.234.56

Hi Jingyuan, Dale,

This RFC adds quad-SPI support for the Surface Laptop 7=
 13.8-inch
(Romulus13) touchpad to Jingyuan's v7 driver [1], on top of the =
two reset
GPIO error fixes sent separately.

It adds aligned transport =
buffers, spi-mem 1-4-4 transfers, bounded input
fragment assembly, and =
Romulus match data. After a device reset, Romulus
recreates the HID device =
so iptsd reapplies the touchpad mode without
restarting iptsd. Single-lane =
devices retain their ordinary SPI transfers.

Following Conor's review [2],=
 the compatible and quad-width constraints
now extend hid-over-spi.yaml. =
There is no separate Romulus binding or
redundant declaration of the =
globally allowed pinctrl properties.

The final driver source matches the =
SPI-HID source in my tested downstream
SL7 kernel. Touchpad input and =
suspend/resume work there with the downstream
Qualcomm GENI/GPI QSPI =
controller and board changes. Those dependencies
are being prepared =
separately from this HID transport RFC.

The core, ACPI and OF modules =
build with W=3D1 against the prepared SL7
kernel build. Software tests =
cover header and fragment bounds, DMA buffer
alignment and allocation =
failures, SPI/QSPI transfer phases, reset errors,
and resume/re-probe =
ordering. The common binding passes schema validation
and compiled positive/negative examples, including both IRQ spellings.

Changes since v2:
- Rebase onto v7's compatible data, descriptor and PM =
handling.
- Drop the readiness/error-counter ABI; keep v7's removal of =
counters.
- Extend the common binding and remove redundant pinctrl =
declarations.
- Keep quad-only output framing checks out of the single-lane=
 path.

[1] https://lore.kernel.org/all/20261024-send-upstream-v7-0-abad131=
74b43@chromium.org/
[2] https://lore.kernel.org/all/20261028-punctured-flag=
pole-c7ec4cfc4609@spud/

Jizhou Tong (5):
  HID: spi-hid: isolate DMA =
transfers from protocol buffers
  HID: spi-hid: add spi-mem quad-SPI =
transfers
  HID: spi-hid: assemble bounded fragmented input reports
  dt-bindings: input: hid-over-spi: add the Surface Laptop 7 touchpad
  HID: spi-hid: support the Romulus13 QSPI touchpad

 .../bindings/input/hid-over-spi.yaml          |  40 ++++
 drivers/hid/spi-hid/Kconfig                   |   2 +-
 drivers/hid/spi-hid/spi-hid-acpi.c            |  26 +--
 drivers/hid/spi-hid/spi-hid-core.c            | 183 +++++++++++++++---
 drivers/hid/spi-hid/spi-hid-core.h            |   8 +
 drivers/hid/spi-hid/spi-hid-of.c              |  44 +++--
 drivers/hid/spi-hid/spi-hid.h                 |   8 +-
 7 files changed, 249 insertions(+), 62 deletions(-)


base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
prerequisite-patch-id: b401890d766019f0677a572f18bb389cd8827721
prerequisite-patch-id: beaf91cb29f3a735559a3251092ac0ac17810b10
prerequisite-patch-id: e7eba48cebafeee52eae204c950d7c4f8386f0bd
prerequisite-patch-id: 41ca1ba441d0246d5bf6a4befb26b1c65a596b95
prerequisite-patch-id: 84023dc857708fbb763a889ac060acc7d4387264
prerequisite-patch-id: f9b381e783ceb6b608c27e3b6299c591ac9be769
prerequisite-patch-id: ae5c9959b2923b37a5a650f04e93c662b9e10592
prerequisite-patch-id: 44a8965a58c0bfb0d5cf758790f407d136451956
prerequisite-patch-id: 207558a5e93c1074b4dc1b568d70d62a9ffe542b
prerequisite-patch-id: 59919db0f4e3fbaa1908a0b311fcd53837c5aac3
prerequisite-patch-id: b3706d31329e8a5829627fd0eb795c24aeb389cd
prerequisite-patch-id: 24df0c559e4b401af9acd4bc7bad99dd4b4724d4
prerequisite-patch-id: 3163173e775b674a9f6b8b5f683e0a522e2ea4a0
