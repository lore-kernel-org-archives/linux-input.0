Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128226;
	b=nU65268qeRV9R56JbMnwqMycFj7TtXMCoSuc+vUQ/OsmnT9ATFicARZuMR60ljN2UZPZ
	 UDIksZONWxSoV2ri/fy+CMIFkf9NbAT35/2EPt4lASou+6pPTjMF8mTfPY61W2RKKPQyg
	 L7NUhAG3BIga752pPMeGBjZjJmt56E/bcb9qDASDlTBa/IqlCUMNLNtX9gtFHYGWSItSf
	 r+hdOECBigGZ3wfrKEtZqCxO9y0j5MuC2rCHDWhF7N0Lu6xLwiFDKj3OoJNPCsnZg02kp
	 SG6rIQJL5eTDBLkwhmpsZ0DYFazmtP6a2McCbsRArNFbyPkzRsqfPIFahBCZnkjbR5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128226;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PHHlnaE71uDkSJbdNjjoQnzFUdj0q4+PexykW0Xofho=;
	b=tRGW4WHeQenm26ppMUq+5+cO0J5GCBwXwHf5yvHFIsBfI2QQElXH0zcp7F6hHpSmE0Zy
	 WPD4AL3uMqqQiU0WXKjASvW9C1givkXBxEPx47uB8DvkcpSTLYONp1CMX7T6LA5EYdhAL
	 qbTghgfJ3MJ2Vt9EcLFhbRlox7t4fGzspwZ8th7s/lOOVyi6nVhR9Kijss1zrV6ze/U3r
	 VHYD8atOySR6A4lDCjeG45bkMItjpUzbtDCH6taCk/3SjbYmwN0Bbh3RaY7lpLJVbH9+6
	 PJla51dnkdx/gqcW7DIIMbvd6SMT4DmbP5K1q7EbracgQdhoQVn56Z+nnqvohu8FwOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO4REfyw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9670606A31A;
	Tue, 27 Oct 2026 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO4REfyw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BE71F01825;
	Tue, 27 Oct 2026 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128225;
	bh=PHHlnaE71uDkSJbdNjjoQnzFUdj0q4+PexykW0Xofho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SO4REfywt12WSKclnbAIOhE6AQ8lvo+A9B2uRjAfuicmCaxA6o6al811KyCDZzkoX
	 tLWA5CVAhfEdJrvVyJTjoTqXD239BN0ryf2QLX2Wnclr7GA7ZTl6y+/5CHkk0nd0sm
	 ZY3OuvdXF4F7EVej9jp46B5ZlpEwwkxC/dx9HwuWtoJCjzSbOUq0uUQKPlauXsrNrS
	 tDD1CgT7B3IZleyeRl8+5Fb2RtDXhoffPkX7pBN/bHXhU+UE/gCb8ERTsyVY0nT83A
	 cLZnwKVZ+SFSBm7urnj6NU59pdweQql21I5lLiDYXc0sNZNcZu89hcQMS24xMQt3TL
	 kl6ClgDSNxjOA==
Date: Tue, 27 Oct 2026 14:10:21 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, tfiga@chromium.org,
	Mark Brown <broonie@kernel.org>, daleyo@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Dmitry Antipov <dmanti@microsoft.com>, linux-spi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jarrett Schultz <jaschultz@microsoft.com>,
	linux-doc@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	hbarnor@chromium.org, Steven Rostedt <rostedt@goodmis.org>,
	devicetree@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	fqwqf@fqwqf.xyz
Subject: Re: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <179312822066.314502.1597443859216398220.robh@kernel.org>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-8-abad13174b43@chromium.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024-send-upstream-v7-8-abad13174b43@chromium.org>


On Sat, 24 Oct 2026 00:51:42 +0000, Jingyuan Liang wrote:
> From: Dmitry Antipov <dmanti@microsoft.com>
> 
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
> 
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

