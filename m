Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C9481B1
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 00:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247152; cv=none; b=ul93xzdEqowWHfEswCDVLeeNobx4QFG52xalDwSilrhhpR7u6m1uh63oLoXtXgZiAVS57VV5U+roGv5g1fAUEbAop252xIF1AaJ+tqqFWn9CKjxy377DvZs5vS6aaUJrFABT4KMt6zS1n39iXt+5Bfr3HW/rE+6dziGKoJHf4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247152; c=relaxed/simple;
	bh=+dWOwPZ/Be83xi5U02yAPHoO2Y8UP8uPLAUo8irzPSA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qDSvTytaOM+Wj2X9p+iZtNW9LrMAQJWEVF91mQ35ka/wiCv/VjjXvZ9QMkox1Oz/YNoqOcdVyYcHfZMP7CGDfJeagGBcQTZI3+rV1XmaVHA9S7sLVqSN1iQffADtfIsz4Ei55b5I/S3JJnusxy1bB2TC3OAWukGSW23LVkwEKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MjQ3sORe; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MjQ3sORe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791247139; x=1791506339;
	bh=qWEQiLGDFffui9yK7wcZwOi9jDWTSGaLWCkkpNHadPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MjQ3sOReJApwx9OqKBc9ifwiYJ7Nj4UAkTVAMxniVHLxt28B4QK7B2ubet8C4hiP/
	 7oAjLuuqFwasTCeukdzw3uyA6P/Isb/LVqoD7mzHHaBlnSwgP+k8jpQmjcWt21xI/O
	 qyGfBeuDickSNhl6mN4NjbGwpJbZWYpw4eQO0AyRRGCWOE3UWt640eKf4o79ZFsv0y
	 p6xrhKmi4F8Vi8Yj2g2/cCnY0JaKtb56qaUtbS5G1BVWRfWtjNmReIOvrQOq85h2Xi
	 eRK2XrZK8Ufcroq2bL9ABkjQ9O9uo0PApIVqGrA8MIFZQPZ049+Eid/Y72+x93iso8
	 IQCplAheRagcg==
Date: Tue, 06 Oct 2026 00:38:53 +0000
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
From: Bartosz Barc <bpbarc@proton.me>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?Q?Bartosz_Pawe=C5=82_Barc?= <bpbarc@proton.me>
Subject: [PATCH 0/2] HID: uclogic: Add XP-Pen Artist 12 (2nd Gen) support
Message-ID: <20261006003844.10839-1-bpbarc@proton.me>
Feedback-ID: 109962581:user:proton
X-Pm-Message-ID: e02ddb6b51df034d956989b918f2936663a8a64a
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Bartosz Pawe=C5=82 Barc <bpbarc@proton.me>

This series adds support for the XP-Pen Artist 12 (2nd Gen) (28bd:094a)
graphics tablet, which is currently not recognized by hid-uclogic and
handled by the generic driver.

It utilises the existing UGEE v2 initialization that is also used
by other similar tablets. The second patch also adds support for the
previously missing stylus invert detection. This affects the shared UGEE v2
pen report template array; while it only reclaims a previously ignored
padding bit and should not affect devices without this feature,
I don't have access to other UGEE v2 hardware and additional testing
would be appreciated.

The tablet & pen have been verified to be fully working with libinput
and libwacom, and the relevant .tablet file will be submitted to the
libwacom project.

Bartosz Pawe=C5=82 Barc (2):
  HID: uclogic: Add support for XP-Pen Artist 12 (2nd Gen)
  HID: uclogic: Report stylus invert state for UGEE v2 devices

 drivers/hid/hid-ids.h            | 1 +
 drivers/hid/hid-uclogic-core.c   | 2 ++
 drivers/hid/hid-uclogic-params.c | 2 ++
 drivers/hid/hid-uclogic-rdesc.c  | 7 ++++---
 4 files changed, 9 insertions(+), 3 deletions(-)

--=20
2.56.0


