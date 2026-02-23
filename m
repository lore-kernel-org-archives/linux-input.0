Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DB31986C;
	Mon, 23 Feb 2026 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771815147; cv=none; b=cE/96fVp9nH3aS63zatKkBiYTANCKGNF2OZRY7oiQLQBIEaf6SJWVyq01pQDhaVI+pQUIYXpS+xYOop38TwcET7kyQ6S4uXY3Qi/MzKs1D/sh68pXQ0JDFMYbOHxaKZ37yumvN6ObLSWn+ZGy5vuEIykekytDH3ujeR4K9D5GwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771815147; c=relaxed/simple;
	bh=e4YewBLPMw0v1YuyZTqd39sNxdBfKeNh62Vlzpgf5m0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLXQdxk1FTFWrIqMDtuSTLP0/I8gobp+xi1hOwfD0lTkg1j7jDcQ3twVtYWMlzagrnl3WGitTjfrfgq6Ft/ctw1l7uN1hzZIVzY7rmM2zX2eHyjaEjKlZSTo9gYoa0Ip8tq7PKexeZXjtFRKdxzQWz7+lRJGPN+efFEFuuRMLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OHiC8qk9; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OHiC8qk9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1771815143; x=1772074343;
	bh=p4qP8RowapTx3AEMtHC7bblv7CIarjEfvoPPyX0pNps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OHiC8qk9dBd7Tp794S4VumK6QMozAdeG6m8E8Xjn4jjI9fGxQ4gAEG9qyCjW+BUSz
	 t9lbN7DVueXZuGNFYbKjvbGnoAgj+Zqdury6c5H/UwYwHQAqFDAXAKOnjUoKa4SKyC
	 9sKCthDxvXGX099zdwGM5WcGmhPFWxa7ckP6M8EzT/o33B8J+G8z2dRj87iD4usjYG
	 6fOLQIH37Vx6dBry74XpzY08xKYUehnw0bW4MnWA4gfAn4DDfcMEOUvekbZUKNpeYX
	 Ad/8lTJnntGr2pRmcAL62zaJh5UgygsB79s7gLCMDlpc8iI1lwFKlrvKI6nfkTiNy1
	 z1ZA8pusnyRXQ==
Date: Mon, 23 Feb 2026 02:52:16 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu
Subject: Re: [PATCH v6 2/2] rust: hid: Glorious PC Gaming Race Model O and O- mice reference driver
Message-ID: <87zf50p3xg.fsf@protonmail.com>
In-Reply-To: <2026022359-dental-jelly-cb6e@gregkh>
References: <20260222215611.79760-1-sergeantsagara@protonmail.com> <20260222215611.79760-3-sergeantsagara@protonmail.com> <2026022359-dental-jelly-cb6e@gregkh>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 4c2dd16f03b867843e389d4d259586973e088ac9
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb, 2026 03:38:23 +0100 "Greg KH" <gregkh@linuxfoundation.org> =
wrote:
> On Sun, Feb 22, 2026 at 09:56:51PM +0000, Rahul Rameshbabu wrote:
>>  MAINTAINERS                           |  6 +++
>>  drivers/hid/hid-glorious.c            |  2 +
>>  drivers/hid/hid_glorious_rust.rs      | 60 +++++++++++++++++++++++++++
>>  drivers/hid/rust/Kconfig              | 16 +++++++
>>  drivers/hid/rust/Makefile             |  6 +++
>>  drivers/hid/rust/hid_glorious_rust.rs | 60 +++++++++++++++++++++++++++
>>  6 files changed, 150 insertions(+)
>>  create mode 100644 drivers/hid/hid_glorious_rust.rs
>>  create mode 100644 drivers/hid/rust/Makefile
>>  create mode 100644 drivers/hid/rust/hid_glorious_rust.rs
>
> You seem to have the same file in here in two different locations :(

Yeah, I noticed this right after sending out the patches....
drivers/hid/hid_glorious_rust.rs was meant to be removed.

  https://lore.kernel.org/rust-for-linux/wjfjzjc626n55zvhksiyldobwubr2imbvf=
avqej333lvnka2wn@r4zfcjqtanvu/

I accidentally had a local copy in my work tree and managed to re-add
it. I will need a v7 of this series either way, but that was
unfortunate....

Thanks,
Rahul Rameshbabu

