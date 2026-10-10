Received: from e234-58.smtp-out.ap-northeast-1.amazonses.com (e234-58.smtp-out.ap-northeast-1.amazonses.com [23.251.234.58])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A733C9EE5;
	Sat, 10 Oct 2026 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791651458; cv=none; b=DF/URsHjbuLH5wFsKTtYH5xPAqvqxZs/nL61kYfGz+92g65nMw5DZmI4AKSMyIiMXODZK1wrSWnyXlUJgr9W0KLHicJ3kBJkNF2weaWNu9lbaIbQQNXbZ0fZ1Z3AtMCOVxrRuqdXMm3tJkQdWtGW/IqcjaWjBwkwrNBOqlaeDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791651458; c=relaxed/simple;
	bh=kbXkac4jsWCkGWIevizgSpubemBBAlHy3w4chXA86Og=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=upcmcBunU1G/DabkGjBR6SVpg1PRq4HkoS4FVOv52nSEVoH3+celzqYN3JsXVR4Pg/KRxqRIru5XglyQVw0y+/0Iliy04AkPrV46VaJdmgX4iEQ6E1oEtNOHB7KA10LNAo2REiEQ/1EBS5fAY05hibAjjrdJsdsSNdtKk7RuaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=EtnktIIM; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=hmqNOgkS; arc=none smtp.client-ip=23.251.234.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="EtnktIIM";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="hmqNOgkS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1791651456;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=kbXkac4jsWCkGWIevizgSpubemBBAlHy3w4chXA86Og=;
	b=EtnktIIMP3yQodOK2UBkaVrsoiow2F6/tQJX5/TKYc1NsilNNg8dZU6y1cgu2J/c
	A13Abr5lBSHpYjXmNQ62Fomb3voqWXvz611VDokXpLfiZV8S5ijDBl2AJDqr7v/g3eV
	aF+61LIjAup/9qQ/lpnpN26XX72uduGmXfSQQJYY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1791651456;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=kbXkac4jsWCkGWIevizgSpubemBBAlHy3w4chXA86Og=;
	b=hmqNOgkSJ31+RyjSU1mz0br5Jfw4LqDO1tGWzC/3GfvgLuC2rW61Ox6rkSfjNKWO
	7wqfdVOpXxtSB30LjWLmO/NuMoKa3kBK46JU8/7/KJfEKa+Au0ivRoGwh6iDMfzUC68
	pKKMD+7gYPzDQF7G/8eW/tcRgmHKjNrxPTNhL4/I=
In-Reply-To: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
X-Mailer: git-send-email 2.53.0
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HID: spi-hid: handle reset assertion and resume
 handshake failures
Message-ID: <010601a126bfa3ae-858150e8-f0a7-4bae-9c37-d82180d8128e-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 16:57:35 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.10.10-23.251.234.58

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

Best regards,
Jizhou Tong

fQwQf (2):
  HID: spi-hid: propagate reset assertion errors =
during initialization
  HID: spi-hid: report a missing reset handshake on =
resume

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
