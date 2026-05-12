Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2C3C4171;
	Tue, 12 May 2026 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600859; cv=none; b=DcLp2gjYpE3pcNmKdzpYPMEXtkyAnCgKpGYkgwKW5F0+JY9ADsbnWj7Wsn/3/qaEBoKIm+okwam3oxXnVijuu0ghKW0g6hHok0mu4g5OgM60ofReuTcWHt/ZDX5HhM8oqU6CauZF7vT7iJS2jha4bi2oEtFZK753g6RJOv+SK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600859; c=relaxed/simple;
	bh=IOsakCQ+qk3eSp+Q4Jr6hE4lY3rxIYDpHQ08sUyxto8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CGfqL0wEanBqCQXcw+R5HP2NVuT28Y7cS1NrEAkiM8hWh2KNuP1N2Yk3OBhDul1avy0JTrqAw+du220rKlwcLbivYi7BUThpzVxVpUSVapVAQZQhOrFUVd0Is8bRS/XUeIWkscXTWy92XFHNyN1v1uJ4MO2yC46Xew4YFvTOS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx9g2jUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx9g2jUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B141C2BCB0;
	Tue, 12 May 2026 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600858;
	bh=IOsakCQ+qk3eSp+Q4Jr6hE4lY3rxIYDpHQ08sUyxto8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Mx9g2jUIsn94WPpB2pRJyZUdFSAT81QJ68MpEUyHQEThnmYgXo0uletOsySGNXX7D
	 sJJjIhuzJr5GXnitzTj8/jrDIosBxq8Ke2A6VbOYSXu252xKY7RgvMr9eRLst5EEii
	 bHs0K69W2fYijnblpTpIc+MDsJH/xNbOLktTArBjbHpjgTpSVjBvKKoA0faWYLleKf
	 FtY0yDIgHaQSrSPYQW7q/HhIPgKx8rrekVqT0D6svykSvsCbmCGNJf3zf64Iq8kQT3
	 CKn5dtX1nbhHUjOKJosvnSk6aZlBow8J+stZHVwSFFBqnXFodPC8L6+HPUcJkkDvvv
	 pTjTXEyJ5e4Fw==
Date: Tue, 12 May 2026 17:47:35 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benoit Sevens <bsevens@google.com>
cc: Rishi Gupta <gupt21@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: mcp2221: Fix heap buffer overflow in
 mcp2221_raw_event()
In-Reply-To: <20260415114752.1181079-1-bsevens@google.com>
Message-ID: <417rqoq0-1q2q-r96q-p258-240n74nr3n14@xreary.bet>
References: <20260415114752.1181079-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 15 Apr 2026, Benoit Sevens wrote:

> From: Beno=EEt Sevens <bsevens@google.com>
>=20
> A heap buffer overflow can occur in the mcp2221_raw_event() function
> when handling I2C read responses. The driver failed to check if the
> total incoming data length fits within the originally allocated buffer
> `mcp->rxbuf`.
>=20
> Fix this by introducing `rxbuf_len` to `struct mcp2221` to keep track
> of the allocated buffer size. Initialize it in `mcp_i2c_smbus_read()`
> and `mcp_smbus_xfer()`, and ensure the copied data length combined with
> the current index does not exceed this length in `mcp2221_raw_event()`.
>=20
> Signed-off-by: Beno=EEt Sevens <bsevens@google.com>

Unfortunately the patch seems to have been somehow mangled by your mail=20
client:

=09patching file drivers/hid/hid-mcp2221.c
=09Hunk #1 succeeded at 126 (offset 7 lines).
=09Hunk #2 FAILED at 324.
=09patch: **** malformed patch at line 173: u16 addr,

Fix for the same issue has later been submitted by Florian Pradines [1],=20
so I will be taking that one and adding you as Reported-by: or so, ok?

Thanks.

[1] https://lore.kernel.org/all/20260509094517.2691246-1-florian.pradines@g=
mail.com/

--=20
Jiri Kosina
SUSE Labs

