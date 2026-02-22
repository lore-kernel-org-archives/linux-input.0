Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7A35B65B
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771797405; cv=none; b=sOE5/gz1wHnCfa6BD1EKxouHoj1M3f8iQ667+jIYpP4C/z7cZCvAu3XP76KHYxRrYrMuFV4Rhg2BekwdYQsnBHyQKDvhEQH0vJvEcllysR8wXRX+uWIXjV0W0l/wmDNgfpo2wwt2tpPc+r6FYb5tcvGmnFVam19kMW7YL2InR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771797405; c=relaxed/simple;
	bh=k0DqYKl9vOmSoIzCsrhe177aCy5oNhzuWEVjxPgMDBY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Rr93bV5pq7I29qfuBMBRRgHEWrO3qEEG3EZ325NpKuw2Ie0YwYp7VJH9pmqmYdQJOp/TG17sltIYnwYbxcZh+v05FUgi4/7bQfMuyPbdJLpal3MTe4Rz9Cu0I8gWJYjfwgzRfazNDhJr0bUIShI2YEgFifbpomp3iWdNeV0u/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=AlI2IZ7g; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="AlI2IZ7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771797395; x=1772056595;
	bh=lIVwq497ZjA4Wb6r9LAuVMMa4W9rkXNUtscIuYO8KUg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AlI2IZ7gKGxKrHBrWQTuvFezlbAFaRPMqKyqWQroSK2CMJI3DO4JYbb90/w3tiXj+
	 ZgtkhT7E/ES4B9oIfAmQrqHywYKwkf80B54NwWskkukhpdZPZCs+1rfH+4pApJaOvS
	 G/qQwXejkm2wR4ajgSSDYx7BuY1CX5dzYnl5sPtkDoq1kPGj1OV4uIotCF35O/+jTS
	 qN2mQXA2zA0QU0AudakCBo36EYGIH4a4Uz3W3ytKS56/BxldFGmDFQbKUIQ94U2XDG
	 7552771cGmQCHw0RaYyfpq8fpLRnCNst60Lq0mP/aQs4WCp4iD9+0UzDl170z3llTk
	 CQzw74NVAYzvQ==
Date: Sun, 22 Feb 2026 21:56:29 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v6 0/2] Initial work for Rust abstraction for HID device driver development
Message-ID: <20260222215611.79760-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 6c7b6f366fd84ca545596a6255ea76fd175754ee
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi folks,

It has been a while since I last posted an updated. Had some big life chang=
es
that have kept me from working on this more actively, so I have not been ab=
le to
get on top of this till now. Hoping my pace going forward should be a lot
faster. Using the conversation from LPC as well as other refactors needed, =
I
have rebased the series on top of rust-next. My next steps are to get Razer=
Blade
controls working with a Rust HID driver.

Link: https://youtu.be/c8JAZm-QinY
Link: https://lore.kernel.org/rust-for-linux/wjfjzjc626n55zvhksiyldobwubr2i=
mbvfavqej333lvnka2wn@r4zfcjqtanvu/
Link: https://lore.kernel.org/rust-for-linux/175810473311.3076338.143091013=
39951114135.b4-ty@kernel.org/

Thanks,
Rahul Rameshbabu

Rahul Rameshbabu (2):
  rust: core abstractions for HID drivers
  rust: hid: Glorious PC Gaming Race Model O and O- mice reference
    driver

 MAINTAINERS                           |  14 +
 drivers/hid/Kconfig                   |   2 +
 drivers/hid/Makefile                  |   2 +
 drivers/hid/hid-glorious.c            |   2 +
 drivers/hid/hid_glorious_rust.rs      |  60 +++
 drivers/hid/rust/Kconfig              |  28 ++
 drivers/hid/rust/Makefile             |   6 +
 drivers/hid/rust/hid_glorious_rust.rs |  60 +++
 rust/bindings/bindings_helper.h       |   3 +
 rust/kernel/hid.rs                    | 530 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 11 files changed, 709 insertions(+)
 create mode 100644 drivers/hid/hid_glorious_rust.rs
 create mode 100644 drivers/hid/rust/Kconfig
 create mode 100644 drivers/hid/rust/Makefile
 create mode 100644 drivers/hid/rust/hid_glorious_rust.rs
 create mode 100644 rust/kernel/hid.rs

--=20
2.52.0


