Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FA34BA21;
	Sat, 14 Mar 2026 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525389; cv=none; b=u+FZC+GX+4Y8Q0nF1y+PoB69ac39QbbWl75aDpEX/p+WGtl71SVwhOp/A4i+aG1J2xtetvUutZviEObf1j1jtZdECpyVWT1lFh5vlB+nCHkk9zl9CaAB+e0pNXjmRNixS4zn/fF+MCKT0VXvg+2b1qz6uxCLPNjmgQIeFDGQRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525389; c=relaxed/simple;
	bh=VcaiF00Kfm32eF0hjrSnFw7JOo1FkNkrts3dzW9XxZA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gYUSyES6lSOHKngcU1SFg6wF+2bmeSquwM/fjXhHrbVz/4LTsN7Z2VKLqfGiQFDgSLdfofUUR0Ismc0CdP9MSH59dK+o5t4d9/6gsRCLWUSfIwUZnA0Y04CaouPdXIPzUJWmHBN58xuvE3fr8LcdH9mcJP5K50rT999ejgTArtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OdG8mcoJ; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OdG8mcoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1773525379; x=1773784579;
	bh=XyPNSutxWUA1RzqSs7hh9obOrrmG3tdrqvUJR44Th+s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OdG8mcoJUzs2Og3W+hkfuyzyNPAXqC0uaTxiG8bnqtiBYFN1qjXR0p8M7dWwg/ksd
	 KsmVHce63IFmfC2FFqDWyWCj3s0hpwAMUKGT7nqwI9cDjURmeHvw5CBur0IMGu1KZT
	 JnatXYuYOzONlyzvIEhQMh2WxPzkIwsj2hKo3u8QY+SVPCULV6b9r8NS0RPyFU7kPt
	 Wa72R+L0hl0nk1sg/46opp4Ns82mP25uxbL5QRI2XbIjr1af3ykLNhtFKHRh4+ohwv
	 UgQ2uDvk60yNleco+NvvDt4kWviNiDuy1UQDYcfUZp/NoID3dXS7Bjftk4uVyza6UU
	 ONKaT4tVWSTGA==
Date: Sat, 14 Mar 2026 21:56:11 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu, linuxhid@cosmicgizmosystems.com, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v7 0/2] Initial work for Rust abstraction for HID device driver development
Message-ID: <20260314215527.57575-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: ab254c421184215fa37a55734f368916e514fde3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks Gary and others for the great review on v6. In parallel to v7, I am
working on a more complex driver for RazerBlade laptops that I am hoping wi=
ll be
interesting for review.

Link: https://lore.kernel.org/rust-for-linux/20260222215611.79760-1-sergean=
tsagara@protonmail.com/
Link: https://youtu.be/c8JAZm-QinY
Link: https://lore.kernel.org/rust-for-linux/wjfjzjc626n55zvhksiyldobwubr2i=
mbvfavqej333lvnka2wn@r4zfcjqtanvu/
Link: https://lore.kernel.org/rust-for-linux/175810473311.3076338.143091013=
39951114135.b4-ty@kernel.org/

Rahul Rameshbabu (2):
  rust: core abstractions for HID drivers
  rust: hid: Glorious PC Gaming Race Model O and O- mice reference
    driver

 MAINTAINERS                           |  14 +
 drivers/hid/Kconfig                   |   2 +
 drivers/hid/Makefile                  |   2 +
 drivers/hid/hid-glorious.c            |   2 +
 drivers/hid/rust/Kconfig              |  28 ++
 drivers/hid/rust/Makefile             |   6 +
 drivers/hid/rust/hid_glorious_rust.rs |  67 ++++
 rust/bindings/bindings_helper.h       |   3 +
 rust/kernel/hid.rs                    | 509 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 10 files changed, 635 insertions(+)
 create mode 100644 drivers/hid/rust/Kconfig
 create mode 100644 drivers/hid/rust/Makefile
 create mode 100644 drivers/hid/rust/hid_glorious_rust.rs
 create mode 100644 rust/kernel/hid.rs


base-commit: b3d161f22ba9b2dc16bb82aa2b8515d98c99624f
--=20
2.52.0


