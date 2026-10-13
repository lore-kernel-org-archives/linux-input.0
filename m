Received: from e234-51.smtp-out.ap-northeast-1.amazonses.com (e234-51.smtp-out.ap-northeast-1.amazonses.com [23.251.234.51])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A45C388396;
	Tue, 13 Oct 2026 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860094; cv=none; b=psjg4iafAcqXAA1/KEWGe0RVKKACbVVWSe9I2tuKwEE3BojvjJTZVwTmaO+oQlmT6oNc0Bg7QhsI04Jd/1AoIZ4nObiOzKtK5ruXmiLidq6jqgws9f6j3UMP42Ag31GlYJfkjqmxGTzoluMFPyD7MBoNAEdpXqPExdfJ+YKz3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860094; c=relaxed/simple;
	bh=DfN11+tymQuPv6Gfcmec9TYSNCRLNT2nyvxJmO/r+AM=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Ei2wjaD/O0ffppOe5KhlRvqgDN2eRW5Z5i/8OFvgx1ihmlyjwlL5Rx+AG3ClL9rP4HRdozrkj6DRt8lZtkbZawxKvPDxFp46Vfeqm8mwb2T28M+OsLvKvXlAJ8+34Tyu/gIGch3KA/ZJPd5CpSVdKb3HGln/uflRNrnWmvRfqQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=Q4ABj3JO; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=W6fKv79M; arc=none smtp.client-ip=23.251.234.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="Q4ABj3JO";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="W6fKv79M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791860092;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=DfN11+tymQuPv6Gfcmec9TYSNCRLNT2nyvxJmO/r+AM=;
	b=Q4ABj3JOgjKTfRmC5VxTOAeaWAGw1cHMB/lY3cvRQcltz8yRA6jwg015+a4wmm3X
	hjMn7mk9Bi/m9hpNK58og1aZzAzrlsIxaMcT3agTFcktYHMuEPxUnxfbOQVkzyxVo6M
	JKadfIZYEMabh3x+2cfOL7uC1y1lRZ+CcL0A0jOQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791860092;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=DfN11+tymQuPv6Gfcmec9TYSNCRLNT2nyvxJmO/r+AM=;
	b=W6fKv79MBtm+dm7GZH5JtH2sF/nj2cfLYCzXCA3JA0iFqbsJ3uyQNXulyvlODapM
	ZA25Oc7U/5Zy8XrTNutvLoBQ9aBEMNBENHl6HqpKGIZoAt18a+dNpBGXHWwzZWq7Dn7
	zym9Dg0xBzLChUzYI6BkN733OBnBVYpMcM6UIAAA=
In-Reply-To:
 <010601a126bfa3ae-858150e8-f0a7-4bae-9c37-d82180d8128e-000000@ap-northeast-1.amazonses.com>
References:
 <010601a126bfa3ae-858150e8-f0a7-4bae-9c37-d82180d8128e-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] HID: spi-hid: handle reset assertion and resume
 handshake failures
Message-ID: <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 02:54:52 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.13-23.251.234.51

Hi Jingyuan,

I applied the complete v5 series to its stated base and found=
 two
remaining error paths:

- Initialization continues after =
assert_reset() fails, powering up the
  device and enabling its IRQ while =
returning success.
- The resume reset wait only logs a missing device =
descriptor, so the
  HID reset_resume callback can run without a completed =
handshake.

Propagate the assertion error, and return -ETIMEDOUT from the =
reset wait
while scheduling the existing bounded recovery worker. Skip the =
HID
resume callback on that timeout, including the failed-suspend rollback
path, where the original suspend error remains the return value.
The PM core can therefore report an incomplete resume, while the worker
may still recover the device asynchronously.

The actual driver functions =
were exercised with mock firmware/IRQ/HID
interfaces under ASan/UBSan. The =
SL7 integration's SPI-HID core, OF and
ACPI objects compile with W=3D1 on =
ARM64. The full integration boots and
works in normal use on SL7. Logs from=
 two s2idle cycles show the touchpad
being re-enumerated and iptsd =
reconnecting automatically; the transport
and regulator error counters =
remain zero.

Based on your v5:
https://lore.kernel.=
org/all/20261009-send-upstream-v5-0-384af01da3ee@chromium.org/
Upstream base: ee9c669f9bf5fd2c24206746ded9382fe810df89.

Changes in v2:
- Explain how the reset assertion error propagates through probe.
- No code changes from v1.

v1: https://lore.kernel.=
org/all/010601a126bfa3ae-858150e8-f0a7-4bae-9c37-d82180d8128e-000000@ap-nor=
theast-1.amazonses.com/

Best regards,
Jizhou Tong

Jizhou Tong (2):
  HID: spi-hid: propagate reset assertion errors during initialization
  HID: spi-hid: report a missing reset handshake on resume

 drivers/hid/spi-hid/spi-hid-core.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)


base-commit: ee9c669f9bf5fd2c24206746ded9382fe810df89
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
--=20
2.53.0

