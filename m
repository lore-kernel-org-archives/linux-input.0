Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C67470EAC;
	Mon, 12 Oct 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795653; cv=none; b=t6uStyFsC0tBmQttPWrU4SvPzSkDezI/Uzqc2HxPi9XBl88K+1kqxkax3kbvaaJ+J4yqdf2MjMxkrJy5y9L4+kJA6mNO9mZJeytxaFX+OgdCzi3pm3tTrPfC2Lm73xi/n+zO9yaMJicdKC+Eq+DGKf5lqYduvWf4+wg3vobk87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795653; c=relaxed/simple;
	bh=5tORLlB1NmnCaqZWcBRLT7mvTW384+vIIsUT1gxozvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cj6gqUupz/w0MGjB1PxC/XMIZK3zWeVFl9k0NNLNmF9OzlZetCxc65TRDrDrDBoh3wN2MLyU4UrdqfMzBvLoK45KsgPVJ7Erie7IrKJmLoMrBsRoVLIxPBwl6/aL0ZrjX2/Ap78IC9BfEjp3U8dvuRQsH9DqGTwKx5v4MGNtKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFa6ZKa7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFa6ZKa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF221F0089B;
	Mon, 12 Oct 2026 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795650;
	bh=IGVZIgY2Rf7RU1rp3siBeQNuADt+K6LsAK/yC2i51CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JFa6ZKa7RVjAgA96Z2EuAlegSmefCm8teFDcnY2Fsn1cQB/IiCEI9FixhNKIvTdPk
	 EhL2SJYQMW/xz5U09W6jDQIdhxRHzH5s31iT6Bz+F6Xm4pP/oZgGxXW3FTWliflPUF
	 WTJZtsExMVU8AxJe/1vuf/mYAhRNoIxOQr4K/yEw1wbUF4KZwc7j61YMhygdlf/9pY
	 9qOiyq1DhxYmkHJPpW/ZR1AWCAs3kDShlTZ/I69NFZ0HpFALacLKSTRwcIRC+5uJpF
	 2hIy6++JC9xNmRIKBa8oJZpm6bUj+wbhghTEPsiFv4sYv/9oYzB1BvA0eIpQAJrynE
	 9t5kk6KB02RvA==
Date: Mon, 12 Oct 2026 11:00:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "icenowy@aosc.io" <icenowy@aosc.io>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Nsiway
Message-ID: <20261012-gentle-nocturnal-tuatara-9dd2aa@quoll>
References: <20261009144729.85832-1-founder@crepuse.com>
 <20261011054223.93396-1-founder@crepuse.com>
 <20261011054223.93396-2-founder@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261011054223.93396-2-founder@crepuse.com>

On Sun, Oct 11, 2026 at 05:42:28AM +0000, Miotsuki Mizuno wrote:
> Nsiway manufactures the NS2009 I2C resistive touchscreen controller.
> Add its vendor prefix for the touchscreen binding.
> 
> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

And now I see more versions, all threaded in the same spot and repeating
same issue.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Best regards,
Krzysztof

