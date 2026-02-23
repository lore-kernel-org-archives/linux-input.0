Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89671274B58;
	Mon, 23 Feb 2026 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771814307; cv=none; b=lo1yiEOlrBquIsfAQ3T/EJOY8kj7QnArDALRg6WM9v7/u6NgDOeA7cVFaq2mDBbR6chFm4Y0A2Fksk7IXEtiMYNnCKAkDe5wiLMKG8bbzj+Mh/qznIS4YRaJF5Mbg/ebbzOg+elH5oMCM1lj3+7OQ8DhCKTk+klzwDaeAWT49+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771814307; c=relaxed/simple;
	bh=GAl8USrB3AwyfnY3xPF8SgnWKFX/vMj1hn6v1XTgFWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7CcAZwHRXZHhLdth7OF8Mja2eslC7Mm6Mt852WYIAIaA1XIz6tL4eum+JIcaR/B673HttQMa4T2nCtJoA2L2xdcd1zD9DkE9iVViAsUCvkPAN6T4wsSbvGz8NLl+FuWNQku//L5l2/0NN+zK0mnVNBHt2vGifn4oa/bnL0+j8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xdi/+pU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xdi/+pU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2D5C19422;
	Mon, 23 Feb 2026 02:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771814307;
	bh=GAl8USrB3AwyfnY3xPF8SgnWKFX/vMj1hn6v1XTgFWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xdi/+pU08/57578c7pn9eldpEWmjGptNNFaARRKGxGMpgJgyg+/AHAnbovDGTTT54
	 hyTojjbGN7l6UJi6jkl6AriL85usPL7Kr80wgdsdXm61FFIERB/gy7lMPzeO4s0T9t
	 STAyY6VfpuTsLGDdxDE1wHpC8y4tfaHrGLVnyA5o=
Date: Mon, 23 Feb 2026 03:38:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, a.hindborg@kernel.org,
	alex.gaynor@gmail.com, aliceryhl@google.com,
	benjamin.tissoires@redhat.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	db48x@db48x.net, gary@garyguo.net, jikos@kernel.org,
	ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu
Subject: Re: [PATCH v6 2/2] rust: hid: Glorious PC Gaming Race Model O and O-
 mice reference driver
Message-ID: <2026022359-dental-jelly-cb6e@gregkh>
References: <20260222215611.79760-1-sergeantsagara@protonmail.com>
 <20260222215611.79760-3-sergeantsagara@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222215611.79760-3-sergeantsagara@protonmail.com>

On Sun, Feb 22, 2026 at 09:56:51PM +0000, Rahul Rameshbabu wrote:
>  MAINTAINERS                           |  6 +++
>  drivers/hid/hid-glorious.c            |  2 +
>  drivers/hid/hid_glorious_rust.rs      | 60 +++++++++++++++++++++++++++
>  drivers/hid/rust/Kconfig              | 16 +++++++
>  drivers/hid/rust/Makefile             |  6 +++
>  drivers/hid/rust/hid_glorious_rust.rs | 60 +++++++++++++++++++++++++++
>  6 files changed, 150 insertions(+)
>  create mode 100644 drivers/hid/hid_glorious_rust.rs
>  create mode 100644 drivers/hid/rust/Makefile
>  create mode 100644 drivers/hid/rust/hid_glorious_rust.rs

You seem to have the same file in here in two different locations :(

