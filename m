Received: from e234-54.smtp-out.ap-northeast-1.amazonses.com (e234-54.smtp-out.ap-northeast-1.amazonses.com [23.251.234.54])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031543F4B8;
	Tue, 13 Oct 2026 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791861235; cv=none; b=nQ6xApEwl5CEkG9eF6ghncyvcYY1hp9LyXpGArD+MfSn/m90b/yFhP1Dzi1d6MO137WGz4urMmLO+UrmqaxG50jkVjGDe7uPpu1RBR4IxhAjEWR1KGvVG9gx9uE2kE2uTI/vu9vE+NjCB5vzEXXlPHBddYnaNGNM6YxFSJQ4xFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791861235; c=relaxed/simple;
	bh=TUTqmkkvh7WxY821F+q48V6CF/i1cKj3s2m40QlvN2I=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ePPAKMUlB/j0bGKVBDhSw4S/4HBcJoE0rAZvGiR9ZN0wP7ET267RMEIaVfr7Qbk619nyc1Vam/0DEjUtUHWyxy/HXyAwS27Aj5XEF+gWs0W8ArOKzX826e3BEtsY8pEMOBve6dLOZMKQTOrqZRrN+yVDpQxwrAZXfNP8MvJjOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=TUepCVEZ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ZSiD9CSf; arc=none smtp.client-ip=23.251.234.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="TUepCVEZ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZSiD9CSf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791861233;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=TUTqmkkvh7WxY821F+q48V6CF/i1cKj3s2m40QlvN2I=;
	b=TUepCVEZV6hOecNyEHFFFmhYYI/DjU8m3EKQYCtB7tyfmAeSfX88u81rqAq7yaar
	WjthnjWnHlfNx1dVwPgK4ip+q7NHx5aJxER8S3e6poRGe+PncjEFPOvd+SZcoylgL/c
	pCSMxXuWLhooOmfKjyxC7RBJdLxjjLKJnyVkMca0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791861233;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=TUTqmkkvh7WxY821F+q48V6CF/i1cKj3s2m40QlvN2I=;
	b=ZSiD9CSfd/mlVEefDTWylTOOZh3MANU7e3FXUgK9McFC+kMNQle3DqrDX4JzELGI
	j3BxTixk4RG2HPwEOaj/nT/CxfjgJJ++nCB57ZzwoE5tzS4VdheUabgQpVG7AgO7pZi
	l900UvPg5qqajmy0SM+r+gQqBgNpb0CnxrnfwXsc=
In-Reply-To:
 <010601a126bfbf4d-27ca6d8c-0c4e-4191-a92d-6dc7d3fbac60-000000@ap-northeast-1.amazonses.com>
References:
 <010601a126bfbf4d-27ca6d8c-0c4e-4191-a92d-6dc7d3fbac60-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: [RFC PATCH v2 0/6] HID: spi-hid: add Romulus13 quad-SPI support on
 v5
Message-ID: <010601a1334094a9-1f793e14-c414-4780-98ff-f5acdac353a2-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 03:13:52 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.54

Hi Jingyuan and Dale,

This ports my Surface Laptop 7 (Romulus13) additions=
 onto the complete
v5 SPI-HID series, preserving v5's request serialization=
, response
matching and IRQ/PM model. It is based on the two error-handling=
 fixes
submitted separately.

The main addition is a spi-mem transport for =
the touchpad's 1-4-4 reads
and writes. Reads use eight dummy clocks; writes=
 supply the opcode and
address separately from the report data. Dedicated =
aligned TX/RX regions
keep streaming DMA away from protocol parsing buffers=
. The managed
allocation is overallocated, with its base kept separately =
from the
explicitly ARCH_DMA_MINALIGN-aligned view. Single-lane transfers =
retain
spi_sync()/spi_write(), including their existing short-write =
behavior.

Controllers without mem_ops remain supported; patch 2/6 =
describes the
fallback behavior and SPI_MEM dependency.

The series also adds bounded DATA fragmentation and the Romulus timing,
opcodes, binding and reset behavior. On this device, a reset loses the
heatmap mode selected by iptsd while leaving the report descriptor
unchanged. Recreating the HID device after descriptor refresh lets
hidraw consumers reconnect and select that mode again. Other devices
retain v5's CRC-based reuse behavior. Romulus still waits for the reset
handshake and schedules recovery on timeout; READY and the old HID resume
callback are deferred until re-probe, including failed-suspend rollback.

Software tests compile actual driver functions under ASan/UBSan,
covering transport phases/errors, 65,536 header lengths, 5,048 fragment
combinations and resume/descriptor-refresh paths, including missing
Romulus handshakes and failed-suspend rollback. Both RFC 3/6 and the
complete series compile with W=3D1 on ARM64 against the stated v5 base.
The allocator tests include five DMA alignments with storage aligned to
only eight bytes, resize failures and capacity rollback. Short writes
are accepted on single-lane SPI and rejected on quad SPI.

The previous revision of this v5 integration boots and works in normal
use on SL7. Across two logged s2idle cycles, the touchpad was re-enumerated
and iptsd reconnected automatically, with READY and zero transport or
regulator errors afterward. This revision's allocation, short-write and
Romulus handshake changes have build and software-test coverage.

The local test kernel retains the downstream GENI/GPI QSPI controller
and Romulus DT integration. Those dependencies are outside this HID
series. This RFC is for transport/interface review; in particular, I
would appreciate feedback on registering both frontends through
spi-mem (which adds a SPI_MEM dependency), and on the device-specific
HID rebind after reset.

Base: the v5 series plus the two error-handling =
fixes.
https://lore.kernel.org/all/20261009-send-upstream-v5-0-384af01da3ee=
@chromium.org/

Changes in v2:
- Use a designated initializer for the new =
Romulus SPI ID,
  following Uwe's review of the v5 OF frontend.
- No functional changes from v1.

v1: https://lore.kernel.=
org/all/010601a126bfbf4d-27ca6d8c-0c4e-4191-a92d-6dc7d3fbac60-000000@ap-nor=
theast-1.amazonses.com/

OF frontend review:
https://lore.kernel.=
org/all/aszWnnc6RR9d5SYw@monoceros/

Best regards,
Jizhou Tong

Jizhou Tong (6):
  HID: spi-hid: isolate DMA transfers from protocol =
buffers
  HID: spi-hid: add spi-mem quad-SPI transfers
  HID: spi-hid: assemble bounded fragmented input reports
  dt-bindings: input: describe the Romulus13 QSPI touchpad
  HID: spi-hid: support the Romulus13 QSPI touchpad
  HID: spi-hid: expose readiness for reset diagnostics

 .../ABI/testing/sysfs-bus-spi-devices-spi-hid |  30 +++
 .../input/microsoft,romulus13-touchpad.yaml   |  86 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/hid/spi-hid/Kconfig                   |   2 +-
 drivers/hid/spi-hid/spi-hid-acpi.c            |  28 +--
 drivers/hid/spi-hid/spi-hid-core.c            | 207 ++++++++++++++----
 drivers/hid/spi-hid/spi-hid-core.h            |   8 +
 drivers/hid/spi-hid/spi-hid-of.c              |  55 +++--
 drivers/hid/spi-hid/spi-hid.h                 |   8 +-
 9 files changed, 355 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-hid
 create mode 100644 Documentation/devicetree/bindings/input/microsoft,=
romulus13-touchpad.yaml


base-commit: ee9c669f9bf5fd2c24206746ded9382fe810=
df89
prerequisite-patch-id: b401890d766019f0677a572f18bb389cd8827721
prerequisite-patch-id: beaf91cb29f3a735559a3251092ac0ac17810b10
prerequisite-patch-id: 909ee816b83e0bc8bb4b560f8c7cc0c8109c4516
prerequisite-patch-id: 8b60145a9a853a32881af27181c26dff0e82a33e
prerequisite-patch-id: bcb36384a391e48222f0924b0c571fb0eac19ae7
prerequisite-patch-id: 816dfccf7d35ea041c0d7c08c7bfbe061a45c7dc
prerequisite-patch-id: 67a41d4cb6bfa41248d89a8f967d4414cff2da2e
prerequisite-patch-id: d0bf155ff4d70a3aeb88ec0232f04a4b2edb3598
prerequisite-patch-id: f18d9032e5ed5713beb37527dba225ec79589b31
prerequisite-patch-id: 854affdd16efb5696f9ed1d2a8cdb50dababe724
prerequisite-patch-id: 248c986cba937716c739b804039376ac3823f618
prerequisite-patch-id: 24df0c559e4b401af9acd4bc7bad99dd4b4724d4
prerequisite-patch-id: 2827fd11c245e7f91c73506b9c7c392b44f8d9f3
--=20
2.53.0

