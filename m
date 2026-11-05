Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905315;
	b=ElEw3UYVG/b111jIFUvxHXoC44nU9MuzxEKHHRfVMFIz1Hqeti9al1IT02W0gq927y5w
	 uQyP5nMPVhIdtQY9iEsicXp+SnFT8mYuIUynapg9H/oCNrIPt43yi8l2a4oiiWt9XV6jK
	 zVXAgRtPufhTMnw9+VUFuTonkMPXR++Jffob1MlfMAKjnwgYyMVzzr1M+Fv2H/In6CSdB
	 ToQMFUeFOJKfcLhHfEczEM8KG6QLYr5jWGk52rbbtepDWrzNUNbd0Kfh30OfJTYLgpbJH
	 aSlwO/fk7mPVf3IQnRAfOt/vU5ewQN8D++6IqZQvWqi5HoyIq299jg8Unr1kx2Ima0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905315;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=zr0qZi/qDyj7QT+3nzafcxbHmervpZRsWX4pAouit74=;
	b=moEEDBSrEFFp3h2EjtJ7g1tOUjZijBrYsMtsf10CKpxRP3osLaAyz3Lhoor7bWdCPBUs
	 HXjJjIUEJXx53rSVAUA7rkzpYpqiYw+S5CUy5Kq/A1Ll1UgOXVpzP1LW9abo+VfAZrt4Y
	 Al8i4xvAY0nIntv+DRGMDDsrazqGc1qXyivNDVS1S82w6JSO8RMDDiilvcY6TfIskvVgH
	 lYhO2dK3IwAN1XzJqAL0G5Nrkom5yQk4hlOyxFJlmFWbChVZIziR9fF1OS71Q+lW9Rjul
	 /JIskkRUkZTgCSvidzZJGszsuKqb+xekvsjRf8luTEFAqktNDhqbm3HVFyHzNVGn2Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=KvpJoNlQ;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=hFvKO7sS;
	arc=none smtp.remote-ip=23.251.234.55
Received: from e234-55.smtp-out.ap-northeast-1.amazonses.com (e234-55.smtp-out.ap-northeast-1.amazonses.com [23.251.234.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B1606A31B;
	Thu,  5 Nov 2026 19:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E9B1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=KvpJoNlQ;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=hFvKO7sS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1793905313;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=ukGQzQharUWFwPK8wh0HRrkt0bBNgilz1EgmhcDBOJA=;
	b=KvpJoNlQV1VqkZWpAAJf1Hg2nd5yINdFuKBPHAESdFytzJ6LCs/JsezWuLLxLkyL
	PUSIJJdjztZsJmhzYdtREOSAFGdugsQTAuKQsju5j3X+UIZPxM75igsv5NeDqg5Z2HQ
	NIuXhJ8JHYr3CQXlCytEDNrB9G2lO5dD7IfeSLiQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1793905313;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=ukGQzQharUWFwPK8wh0HRrkt0bBNgilz1EgmhcDBOJA=;
	b=hFvKO7sSmI8Tik46N0BounjkjNGTKvQa5sOXHf13HRHT+CujB+suLQ7hjtLOqwFG
	rSuA9bdA0g5R0I5bL9PUINgdzADYwV+LSCO5RaKx28PLgyJkdwfX4U2Qm9ldOxBY7GX
	UZgRLB0Z+8ZN9XRQY1lBjcPA+eByLEfw1Unuoo98=
In-Reply-To:
 <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
References:
 <010601a1332f2c56-c2ec71f6-0f13-485c-b0e3-ee7a59980147-000000@ap-northeast-1.amazonses.com>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: jikos@kernel.org, bentiss@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] HID: spi-hid: propagate reset GPIO errors
Message-ID: <010601a1ad16c6ff-c0275058-3f89-4341-81eb-ca26372f8d70-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 5 Nov 2026 19:01:53 +0000
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
X-SES-Outgoing: 2026.11.05-23.251.234.55

Hi Jingyuan,

These two fixes apply on top of your v7 series [1]. =
Initialization still
ignores a failed reset assertion. Resume also ignores =
assertion and
deassertion failures, so it can report success with the =
device held in
reset. Propagate these errors while preserving the IRQ =
balance and using
the existing recovery worker after a deassertion failure.

The resume handshake timeout fix from my v2 is already in v7 and is not
repeated here. The second patch now addresses only the remaining GPIO
error paths.

The driver is in the downstream SL7 kernel I have been using =
with working
touchpad input and suspend/resume. Fault injection covers =
initialization,
assertion and deassertion errors, IRQ balance, and recovery=
 scheduling.
The core, ACPI and OF modules build with W=3D1 against the =
prepared SL7
kernel build. Hardware testing used the complete downstream =
SL7 stack,
including the QSPI transport and controller changes.

Changes since v2:
- Rebase on v7 and drop the already-incorporated =
handshake fix.
- Check reset GPIO errors on resume and retain v7's recovery=
 behavior.

[1] https://lore.kernel.org/all/20261024-send-upstream-v7-0-aba=
d13174b43@chromium.org/

Jizhou Tong (2):
  HID: spi-hid: propagate reset =
assertion errors during initialization
  HID: spi-hid: propagate reset GPIO=
 errors from resume

 drivers/hid/spi-hid/spi-hid-core.c | 24 =
+++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)


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
